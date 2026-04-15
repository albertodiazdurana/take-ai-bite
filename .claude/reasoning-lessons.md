# Reasoning Lessons

Project-specific reasoning patterns, course corrections, and efficiency observations accumulated across sessions.

## Lessons

- [auto] S1 [pattern]: When a skill file has dependencies on external repos that don't exist in the current project (e.g., `/dsm-align`'s assumption of an external DSM Central), prefer pragmatic inline scaffolding over recursive read-and-execute of the dependent skill. Document the deviation in feedback.
- [auto] S1 [ecosystem]: Windows + bash environments do not inherit the Windows `PATH` for git/coreutils. Prepending `/c/Program Files/Git/cmd:/c/Program Files/Git/usr/bin:/c/Program Files/Git/bin:$PATH` to every Bash call is required. Skill files should not assume `git` resolves on bare bash on Windows.
- [auto] S1 [pattern]: When two skill files document overlapping canonical lists (e.g., `dsm-go` Step 0.5 and `dsm-align` Step 3 both list `dsm-docs/` folders), they will drift. Cross-check both before acting on either. The user caught a `dsm-docs/inbox/` mistake I made by trusting `dsm-go.md`'s 9-folder list when `dsm-align.md`'s 8-folder list and `_inbox/` rule were the correct authority.
- [auto] S1 [pattern]: For first-time clone scenarios, capture all friction points to a live feedback document under `dsm-docs/feedback-to-dsm/` from the very first finding, rather than batching at the end. Keeps the session transcript and feedback in sync and avoids losing details to recall.
- [auto] S1 [ecosystem]: Newly deployed Claude Code slash commands (via `scripts/sync-commands.sh --deploy`) become available at next session start, not mid-conversation. Plan accordingly when probing skills mid-session.
- [auto] S2 [windows-path]: On Windows bash, `which X` returning not-found does NOT mean tool X is absent — GUI-installer tools (git, gh, python, node, etc.) install to `C:\Program Files\{X}\...` and are often missing from the bash PATH. Before reporting "X not installed", also check the install paths directly (e.g., `ls "/c/Program Files/GitHub CLI/gh.exe"`) or prepend the expected install path and re-run. Misdiagnosed once in S2 (claimed gh was not installed; user corrected , it was, just PATH-hidden).
