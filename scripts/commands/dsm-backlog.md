Create a new DSM backlog item.

## Steps

1. Find the highest existing BACKLOG number by listing files in `plan/backlog/developments/`, `plan/backlog/improvements/`, and `plan/backlog/done/`
2. Ask the user for:
   - **Title:** Short description
   - **Priority:** High / Medium / Low
   - **Type:** Development (external repo) or Improvement (internal DSM)
   - **Problem:** What problem does this solve?
   - **Untracked files:** Will this change modify files outside git tracking?
     (user-level commands in `~/.claude/commands/`, gitignored files in `.claude/`,
     cross-repo artifacts). If yes, the backlog item MUST include a Revert Procedure
     section per the Revert Safeguards Protocol in DSM_0.2.
3. Generate the next BACKLOG number (highest + 1)
4. Create the file at `plan/backlog/{developments|improvements}/BACKLOG-XXX_short-description.md`

## Backlog Template

```markdown
# BACKLOG-XXX: [Title]

**Status:** Proposed
**Priority:** [High/Medium/Low]
**Date Created:** YYYY-MM-DD
**Origin:** [Where the idea came from]
**Author:** {author}

---

## Problem Statement

[User's problem description]

## Proposed Solution

[Outline the approach]

## Success Criteria

- [ ] [Criterion 1]
- [ ] [Criterion 2]

## Test Plan

<!-- Required for BLs that use a feature branch.
     Exempt for direct-to-main commits (mechanical updates, session artifacts).
     Write at BL creation time, not at implementation time. -->

Conditions that must pass before the implementing branch merges to main:

- [ ] [Specific, verifiable condition 1]
- [ ] [Specific, verifiable condition 2]

## Revert Procedure

<!-- Include this section if the change touches untracked files.
     Remove if all changes are git-tracked. See DSM_0.2 Revert Safeguards Protocol. -->

**Pre-edit snapshots:** `plan/archive/BL-XXX_pre-edit-snapshots.md`

1. [Step to undo change 1]
2. [Step to undo change 2]

**Verification:** [How to confirm the revert is clean]

---

**Author:** {author} (with AI assistance)
```

5. Update the README in the target directory (`plan/backlog/{developments|improvements}/README.md`):
   - Add a new row to the **Active Items** table with the BL#, title, priority, status ("Proposed"), and today's date
   - Insert the row in priority order (High before Medium before Low), then by date within the same priority
6. Confirm the file was created, show the path, and note the README was updated
