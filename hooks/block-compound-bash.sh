#!/usr/bin/env bash
# PreToolUse(Bash) guard: deny needlessly-compound commands that force approval
# prompts. Reads the hook payload on stdin, emits a deny decision as JSON when
# the command uses cd-chaining, a pipe to head/tail/cat, or a stderr redirect.
cmd=$(jq -r '.tool_input.command')
if printf '%s' "$cmd" | grep -Eq 'cd[[:space:]].*&&|\|[[:space:]]*(head|tail|cat)([[:space:]]|$)|2>(&1|[[:space:]]*/dev/null)'; then
  printf '%s' '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"Command-style guard blocked this: it uses cd-chaining, a pipe to head/tail/cat, or a stderr redirect (2>/dev/null or 2>&1). Each of those is a separate segment the permission system cannot allowlist, so it forces a prompt. Rewrite as ONE command: use git -C <path> instead of cd && ; drop | head/tail/cat (tool output is already truncated, use a command'"'"'s own -m/-n limit if needed); drop the stderr redirect. For in-workspace lookups prefer the Grep/Read tools (no pipe needed)."}}'
fi
