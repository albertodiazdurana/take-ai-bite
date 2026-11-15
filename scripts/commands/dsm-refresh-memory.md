Re-read MEMORY.md to refresh session context. Use when MEMORY.md was updated externally (by another session or manual edit). Read-only: no files created or modified.

## Steps

1. **Read MEMORY.md:** Find and load this project's MEMORY.md from the auto memory directory
2. **Report changes:** Summarize what was reloaded. If $ARGUMENTS is provided, focus the report on that topic.

## Notes

- This skill is strictly read-only; it reloads context without creating or modifying files
- Use `/dsm-refresh-all` for a full context reload (CLAUDE.md, DSM_0.2, inbox, artifacts)
- Follow .claude/CLAUDE.md conventions for this project
- Follow the Session Transcript Protocol from DSM_0.2 (append reasoning to .claude/session-transcript.md)
