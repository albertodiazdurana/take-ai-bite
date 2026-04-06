Wrap up a parallel DSM session. Commit work on the shared session branch and clean up. $ARGUMENTS

This command ends the PARALLEL session only. It cleans up the baseline file
and commit lock. It does NOT merge branches, push to remote, update MEMORY.md,
or perform any main session lifecycle operation. For full session wrap-up,
use `/dsm-wrap-up` from the main session tab.

## Prerequisites

- Must have `.claude/parallel-session-baseline.txt` (written by `/dsm-parallel-session-go`)
- If baseline file is missing, stop: "No parallel session baseline found. This
  does not appear to be a parallel session."

## Steps (run autonomously, no pauses)

1. **Read session context:**
   - Read `.claude/parallel-session-baseline.txt` to get: type (QA/BL), task,
     scope, session branch, session number
   - Run `git branch --show-current` to verify we're on the expected session branch

2. **Scope verification:** Verify no files were modified outside the declared scope:
   - For QA sessions: verify no tracked files were modified (only `.claude/` writes)
   - For BL sessions: run `git diff --name-only` and compare against declared scope
   - **BL-lifecycle files are always in scope:** README files in `dsm-docs/plans/`,
     `plan/backlog/improvements/`, and `plan/roadmap.md`
   - If files outside scope were modified, warn the user and ask for confirmation

3. **BL lifecycle (BL type only):**
   - Update BL status to: `Implemented by parallel session #X.Y`
   - Add **Date Implemented:** with today's date
   - List all generated artifacts under **Generated Artifacts**
   - Do NOT move BL to `done/`; the main session validates and closes

4. **Commit via booking system:**
   a. Check `.claude/commit-lock`:
      - If absent or stale (>5 min): create with `{session-id}\n{ISO-timestamp}`
      - If present and fresh: wait 10s, retry (max 3), then warn
   b. Run `git branch --show-current` to verify correct branch
   c. Run `git pull --rebase` to pick up other sessions' commits
   d. Stage files:
      - QA: only `.claude/` files (findings, notes)
      - BL: files in declared scope + updated BL file
   e. Commit:
      ```bash
      git commit -m "Parallel session X.Y: {type} - {brief description}"
      ```
   f. Delete `.claude/commit-lock`

5. **Cleanup:**
   - Delete `.claude/parallel-session-baseline.txt`
   - Do NOT push (main session decides when to push)

6. **Report:**
   ```
   PARALLEL SESSION X.Y COMPLETE

   Type: {QA | BL-NNN}
   Session branch: {branch name} (shared, no branch to delete)
   Committed: {commit hash}
   Files modified: {count}
   BL status: {Implemented by parallel session #X.Y | N/A for QA}

   Main session: review committed artifacts and close BL when validated.
   ```

## Notes

- No co-author lines in commits
- No MEMORY.md updates (main session handles this)
- No session transcript entries
- No reasoning lessons extraction
- No feedback push
- No branch deletion or merging (shared branch model)
- Follow .claude/CLAUDE.md conventions for this project
