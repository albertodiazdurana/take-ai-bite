Re-read all DSM context sources without session-start overhead. Use when CLAUDE.md, DSM_0.2, or project artifacts were updated mid-session. Read-only: no files created or modified.

## Steps

1. **Re-read governance:** Read `.claude/CLAUDE.md` and follow the `@` reference to load DSM_0.2
2. **Re-read MEMORY.md:** Find and load this project's MEMORY.md from the auto memory directory
3. **Check inbox:** Read `_inbox/` for new entries; surface any pending to the user
4. **Read latest artifacts** (skip done/ subfolders, skip if folder is empty):
   a. Latest file in `docs/checkpoints/`
   b. Latest file in `docs/decisions/`
   c. Current plan in `docs/plans/`
5. **Report:** Summarize what was reloaded, what changed since last read, and any new inbox entries. If $ARGUMENTS is provided, focus the report on that topic.

## Explicitly Excluded (session infrastructure)

- No baseline creation (that is /dsm-go)
- No transcript reset (that is /dsm-go)
- No git status or bandwidth check
- No checkpoint creation (that is /dsm-checkpoint)
- No journal appending (that is /dsm-wrap-up)
- No "What would you like to work on?" prompt

## Notes

- This skill is strictly read-only; it reloads context without creating or modifying files
- Use `/dsm-refresh-memory` for a lighter refresh (MEMORY.md only)
- Use `/dsm-go` for a full session start with baseline, transcript reset, and session-start checks
- Follow .claude/CLAUDE.md conventions for this project
- Follow the Session Transcript Protocol from DSM_0.2 (append reasoning to .claude/session-transcript.md)
