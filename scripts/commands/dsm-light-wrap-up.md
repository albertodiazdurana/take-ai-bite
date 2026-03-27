Execute a lightweight DSM session wrap-up for context-critical sessions where work continues next session. Keeps only essential state preservation; defers all non-essential steps. Use when context budget is low and the next session will continue the same work. $ARGUMENTS

## Git Awareness

At the start, run `git rev-parse --is-inside-work-tree 2>/dev/null`. Cache the result as `GIT_AVAILABLE` (true/false). If false (no git repo, e.g., private projects per BL-162):

- **Git commit + push (Step 4):** Skip entirely
- All non-git steps (MEMORY.md, checkpoint, baseline mode marker) run unchanged.

## Prerequisites

This command is only valid when the session will continue with `/dsm-light-go` next. It writes `mode: light` to the session baseline, which `/dsm-light-go` checks as a safety gate.

## Steps

1. **Minimal MEMORY.md update:** Find and update this project's MEMORY.md in the auto memory directory. Update ONLY:
   - Latest Session line: date, session number, 1-line summary
   - Add "(lightweight wrap-up, work continues)" to the summary
   - Do NOT update other sections (Pending, Open Developments, etc.)
2. **Feature branch safety push:** Before committing, check if the current branch is a feature branch (not main/master) with unpushed commits. If so, push the branch to remote (`git push -u origin {branch}`) to ensure remote backup before the session gap. Report: "Pushed feature branch {branch} to remote for safety."
3. **Git commit + push:** Stage all session changes, commit, and push. Commit message format: "Session N (light): [brief description]"
   This runs BEFORE the checkpoint so that the checkpoint reflects the actual committed state (commit hash, clean working tree).
4. **Checkpoint:** Create a minimal checkpoint in `dsm-docs/checkpoints/` with:
   - Current task state (what was done, what remains)
   - Branch and commit state (from the commit in step 3)
   - Deferred items list:
     ```
     **Deferred to next full session:**
     - [ ] Inbox check
     - [ ] Version check
     - [ ] Reasoning lessons extraction
     - [ ] Feedback push
     - [ ] Full MEMORY.md update
     - [ ] README change notification check
     - [ ] Contributor profile check
     ```
5. **Baseline mode marker:** Append `mode: light` to `.claude/session-baseline.txt` so that `/dsm-light-go` can verify the chain.
6. **Checkpoint commit + push:** Stage the checkpoint and baseline, commit ("Session N (light): checkpoint"), and push. This is a separate commit so the checkpoint accurately records step 3's commit hash.

## Notes

- Do NOT clear or overwrite `.claude/session-transcript.md`; it persists for the next lightweight session
- Do NOT extract reasoning lessons (deferred)
- Do NOT check README changes (deferred)
- Do NOT push feedback (deferred)
- Do NOT refresh memory backup (deferred)
- Do NOT check contributor profile (deferred)
- Do NOT delete `.claude/session-baseline.txt` (it carries the mode marker for the next session)
- No co-author lines in commits
- If $ARGUMENTS is provided, use it as the session description in MEMORY.md
- All steps run autonomously; do not pause for confirmation between steps
- Follow .claude/CLAUDE.md conventions for this project
