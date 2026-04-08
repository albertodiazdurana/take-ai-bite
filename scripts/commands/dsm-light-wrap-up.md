Execute a lightweight DSM session wrap-up for context-critical sessions where work continues next session. Keeps only essential state preservation; defers all non-essential steps. Use when context budget is low and the next session will continue the same work. $ARGUMENTS

## Git Awareness

At the start, run `git rev-parse --is-inside-work-tree 2>/dev/null`. Cache the result as `GIT_AVAILABLE` (true/false). If false (no git repo, e.g., private projects per BL-162):

- **Git commit + push (Step 4):** Skip entirely
- All non-git steps (MEMORY.md, checkpoint, baseline mode marker) run unchanged.

## Prerequisites

This command is only valid when the session will continue with `/dsm-light-go` next. It writes `mode: light` to the session baseline, which `/dsm-light-go` checks as a safety gate.

## Cadence Gate (Origin: BACKLOG-326)

Light wrap-up is for **same-day continuation only**. If the current session branch was created on a prior calendar day, refuse to run and instruct the user to use `/dsm-wrap-up` (full) instead.

**Check (before Step 1):**

1. Extract the date from the current branch name. Session branches follow the `session-N/YYYY-MM-DD` convention; parse the date segment. For task branches (`bl-*`, `sprint-*`, `parallel/*`), skip this check and continue to Step 1 (task branches have their own merge lifecycle).
2. Compare against today's date (`date +%Y-%m-%d`).
3. **If the dates match:** Continue to Step 1 normally.
4. **If the branch date is earlier than today:** STOP and warn:
   > "Session branch `{branch-name}` was created on {branch-date}, today is {today}. Light wrap-up is for same-day continuation only; multi-day branch accumulation is the exact failure mode BACKLOG-326 closes (efficientnet project ran 7 sessions on one branch because consecutive light wrap-ups never merged). Run `/dsm-wrap-up` (full) to merge this branch to main, then start the next session with `/dsm-go`."
5. Do not offer a bypass. The user can still run `/dsm-wrap-up` directly to finish the branch cleanly.

**Why this is a hard gate, not a warning:** The efficientnet failure was 7 consecutive light wrap-ups with no intervention, each one looking normal in isolation. A soft warning would have been dismissed. Only a hard refusal forces the merge cadence.

**Fallback when branch name has no parseable date:** If the branch name does not match the `session-N/YYYY-MM-DD` pattern (e.g., a user-renamed branch), fall back to checking `.claude/session-baseline.txt` for the `# Session baseline - {ISO timestamp}` line and compare its date component to today. If neither source yields a usable date, warn "Cannot determine session branch age, assuming same-day" and continue to Step 1.

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
7. **Write wrap-up type marker:** Write `.claude/last-wrap-up.txt` with the session number, date, and wrap-up type. This marker is read by `/dsm-go` and `/dsm-light-go` at next session start to guide the user toward the appropriate startup command.
    ```
    session: N
    date: YYYY-MM-DD
    type: light
    ```

## Notes

- Do NOT clear or overwrite `.claude/session-transcript.md`; it persists for the next lightweight session
- Do NOT extract reasoning lessons (deferred)
- Do NOT check README changes (deferred)
- Do NOT push feedback (deferred)
- Do NOT refresh memory backup (deferred)
- Do NOT check contributor profile (deferred)
- Do NOT delete `.claude/session-baseline.txt` (it carries the mode marker for the next session)
- Light wrap-up is for **same-day continuation only**. Work that spans multiple calendar days must use full `/dsm-wrap-up` at the end of each day (see Cadence Gate above). This prevents multi-session branch accumulation (BACKLOG-326, efficientnet project incident).
- No co-author lines in commits
- If $ARGUMENTS is provided, use it as the session description in MEMORY.md
- All steps run autonomously; do not pause for confirmation between steps
- **Thinking-before-acting is mandatory during wrap-up.** Time pressure at session end is the highest-risk moment for skipping reasoning; append thinking to the transcript before each wrap-up step, not after
- Follow .claude/CLAUDE.md conventions for this project
