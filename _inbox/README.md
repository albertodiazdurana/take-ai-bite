# DSM Central Inbox

This directory receives entries from spoke projects. It is a **transit point**:
entries arrive, get processed, and are removed. Permanent records live in the
backlog system, CHANGELOG, and decision logs.

**Entries are brief notifications, not full file copies.** Each entry summarizes
what was observed and points to the source file for the complete record. Do not
copy full feedback files, methodology documents, or backlog lists into the inbox.

Reference: DSM_3 Section 6.4 (Bidirectional Project Inbox)

## Entry Template

All inbox entries must follow this format:

```markdown
### [YYYY-MM-DD] Entry title

**Type:** Backlog Proposal | Methodology Observation | Action Item | Notification | Technical Progress Report
**Priority:** High | Medium | Low
**Source:** [spoke project name]

[Description: problem statement, proposed solution, or action requested]
```

## How It Works

1. Spoke projects push ripe entries to `_inbox/{project-name}.md` in this repo
2. At DSM Central session start, the agent surfaces unprocessed entries
3. Each entry is processed: accept (create BACKLOG-XXX), reject (note reason), or defer
4. Processed entries are removed from the inbox file

## File Convention

- One file per spoke project: `{project-name}.md`
- File is created by the spoke agent when it first pushes an entry
- File is cleared (or deleted) after all entries are processed
