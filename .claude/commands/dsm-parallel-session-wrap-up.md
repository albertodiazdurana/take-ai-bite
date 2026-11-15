Wrap up a parallel DSM session. Commit work on the shared session branch and clean up. $ARGUMENTS

This command ends the PARALLEL session only. It marks this session's entry
in the registry as `wrapped` and cleans up the commit lock. It does NOT
delete the registry file (that is a main-session responsibility), does NOT
merge branches, push to remote, update MEMORY.md, or perform any main
session lifecycle operation. For full session wrap-up, use `/dsm-wrap-up`
from the main session tab.

## Prerequisites

- Must have `.claude/parallel-sessions.txt` containing a section whose
  `CLAUDE_PID:` matches this Claude Code instance (written by
  `/dsm-parallel-session-go`).
- If the registry file is missing or no section matches the current PID,
  stop: "No parallel session registry entry found for this PID. This does
  not appear to be a parallel session, or the registry was deleted
  prematurely."

## Steps (run autonomously, no pauses)

1. **Read session context:**
   - Read `.claude/parallel-sessions.txt`, locate the section whose
     `CLAUDE_PID:` matches the current PID. From that section read: type
     (QA/BL), task, scope, session branch, parallel session number.
   - Run `git branch --show-current` to verify we're on the expected
     session branch.

2. **Scope verification:** Verify no files were modified outside the declared scope:
   - For QA sessions: verify no tracked files were modified (only `.claude/` writes)
   - For BL sessions: run `git diff --name-only` and compare against declared scope
   - **BL-lifecycle files are always in scope:** README files in `dsm-docs/plans/`,
     `plan/backlog/improvements/`, and `plan/roadmap.md`
   - If files outside scope were modified, warn the user and ask for confirmation

3. **BL lifecycle (BL type only):**
   - Update BL status to: `Implemented by parallel session #{N}.{M}`
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
      git commit -m "Parallel session {N}.{M}: {type} - {brief description}"
      ```
      where `{N}.{M}` is read from the section header of this PID's entry
      in the registry (e.g., `parallel-190.1/QA/...` → `190.1`).
   f. Delete `.claude/commit-lock`

5. **Mark this session as wrapped in the registry:**
   - Find the section in `.claude/parallel-sessions.txt` whose `CLAUDE_PID:`
     matches the current PID.
   - Update that section's `State:` line from `active` to `wrapped`. Do NOT
     touch other sections; do NOT delete the file.
   - **Verification:** after the update, re-read the section and confirm
     `State: wrapped` is present for this PID. If the verification fails,
     warn the user: "Registry update did not take effect; manually edit
     `.claude/parallel-sessions.txt` to set this PID's section State to
     wrapped before opening another parallel session."
   - Implementation hint: a minimal Edit-tool replace targeting the line
     `State: active` within this PID's section is the safest path. `sed`
     can also work with a section-anchored pattern, but Edit avoids quoting
     pitfalls.
   - Do NOT push (main session decides when to push). The registry file
     is gitignored and stays in the working tree until `/dsm-wrap-up`
     deletes it.

6. **Report:**
   ```
   PARALLEL SESSION {N}.{M} COMPLETE

   Type: {QA | BL-NNN}
   Session branch: {branch name} (shared, no branch to delete)
   Committed: {commit hash}
   Files modified: {count}
   BL status: {Implemented by parallel session #{N}.{M} | N/A for QA}
   Registry: .claude/parallel-sessions.txt → State: wrapped (file retained
             until main /dsm-wrap-up cleans it up).

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
