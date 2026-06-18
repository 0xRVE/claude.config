## Shell command style (avoid permission prompts)
- Never use `cd`. Use tool-native flags for the working directory: `git -C <path>`, `make -C <path>`, `npm --prefix <path>`.
- Avoid pipes and `&&` chaining when a single command works. Each segment of a piped/chained command needs its own approval, so `git show … | head` and `find … | head` prompt even when the base command is allowed.
- Don't pipe to `head`/`tail`/`cat` for truncation — the tools already truncate output. Use a command's own limit flags instead (e.g. `grep -m`, `find -quit`).
- Prefer the native Glob/Grep/Read tools over `find`/`grep`/`cat` in the shell — they don't prompt for in-workspace work.
- Never run `find /` or other whole-disk scans. Scope to a known root: the workspace, or `~/.cargo/registry/src/` for Rust crate sources.

## Don't run code to "think"
- Never use `python3 -c`, `node -e`, `bash -c`, etc. just to print analysis, reasoning, or prose. Write that directly in the response.
- Only invoke an interpreter when there's an actual computation, transformation, or check to run whose result I can't produce by reasoning. If a one-liner would only echo strings I already wrote, skip it.
- Arbitrary-code one-liners always require approval by design — they're not allowlistable — so avoiding them removes the prompt entirely.



