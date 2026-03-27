Resume a DSM session. Read context and report current state. $ARGUMENTS

## Git Pre-Step: Ensure Git Initialized

Before caching GIT_AVAILABLE, check if git is initialized:

1. Run: `git rev-parse --is-inside-work-tree 2>/dev/null`
2. If **not** a git repo:
   a. Run: `git init`
   b. Run: `git branch -m main`
   c. Ask: "Remote repository? (GitHub URL or 'none' for local-only)"
   d. If URL provided: `git remote add origin {url}`
   e. Create initial commit: `git add .` then `git commit -m "Initialize DSM project"`
   f. Report: "Git initialized. All DSM projects require a local git repository."
3. Continue to Git Awareness below.

## Git Awareness

At the start, run `git rev-parse --is-inside-work-tree 2>/dev/null`. Cache the result as `GIT_AVAILABLE` (true/false). If false (no git repo, e.g., private projects per BL-162), the following adjustments apply throughout:

- **Checkpoint moves (Step 3, 3.5):** Use `mv` instead of `git mv`
- **Git status (Step 4):** Skip; report "No git repository"
- **Session baseline (Step 5):** Write only the timestamp line; skip `git rev-parse HEAD`, `git status --porcelain`, and checksums
- **Recent history (Step 7):** Skip; report "No git repository"
- All filesystem-only steps (MEMORY.md, transcript, inbox) run unchanged.
- **Session branch setup (Step 0):** Skip; no branch operations without git

## Step 0: Session Branch Setup

**Requires:** GIT_AVAILABLE = true. If false, skip this step entirely.

This step implements the Three-Level Branching Strategy (DSM_0.2) by ensuring
every session operates on a Level 2 session branch, never directly on main.

### 0a. Determine session number

Read MEMORY.md (from auto memory context) and extract the session number from
the "Latest Session" line. The new session number is the previous number + 1.
If MEMORY.md does not exist or has no session number, use 1.

### 0b. Check for open branches from previous sessions

Run `git branch --list 'session-*'` and `git branch --list 'bl-*'` and
`git branch --list 'sprint-*'` to check for open task or session branches.

Also check for remote branches not yet checked out:
`git branch -r --list 'origin/session-*' --list 'origin/bl-*'`

### 0c. Branch decision

**If an open Level 3 branch exists (bl-*, sprint-*):**
- Inform the user: "There is an open task branch `{branch-name}` from a
  previous session. The logical next step is to finalize this work before
  starting new work."
- Check it out: `git checkout {branch-name}`
- Proceed to Step 1

**If an open Level 2 session branch exists (session-*):**
- Inform the user: "Resuming open session branch `{branch-name}` from a
  previous session."
- Check it out: `git checkout {branch-name}`
- Proceed to Step 1

**If already on a session branch (current branch matches session-*):**
- Inform the user: "Already on session branch `{branch-name}`."
- Proceed to Step 1

**If on main/master with no open branches:**
- Create new session branch: `git checkout -b session-{N}/{YYYY-MM-DD}`
  where N is from Step 0a and YYYY-MM-DD is today's date
- Report: "Created session branch `session-{N}/{YYYY-MM-DD}`."
- Proceed to Step 1

**Priority order:** Level 3 branches take precedence over Level 2 branches.
If multiple branches exist at the same level, present the list and ask the
user which one to resume.

## Steps

1. **Read MEMORY.md:** Find and load this project's MEMORY.md from the auto memory directory to restore session context. **If MEMORY.md does not exist or fails to load**, continue to Step 2 but note that the agent is operating without prior session context, which increases the risk of applying generic rules to a project with specific overrides.
1.5. **Read reasoning lessons:** If `.claude/reasoning-lessons.md` exists, read it to prime the session with accumulated reasoning patterns. This is a lightweight file (under 50 lines). Report any lessons that are particularly relevant to the current project. If the file does not exist, skip this step silently.
2. **DSM_0.2 session-start checks (act, not just report):** Read the `@`-referenced DSM_0.2 file in `.claude/CLAUDE.md` for current protocols, then **perform** each session-start action **in the order listed** (each sub-step may depend on results from prior sub-steps):
   - **2a. Project type detection (MUST complete first; gates 2b and 2c):** Identify and state the project type. Read the project CLAUDE.md to determine governance boundaries. For External Contribution projects, note that governance artifacts route to DSM Central, not the repo root.
   - **2a.5. Ecosystem Path Registry:** Read `.claude/dsm-ecosystem.md` if it exists. Parse the Paths table and cache each Name -> Path mapping for the session. For each entry, verify the path exists on the filesystem:
     - If the path exists: note as validated
     - If the path does not exist: warn "Ecosystem path '{name}' points to '{path}' which does not exist. Cross-repo operations using this path will be skipped."
     If the file does not exist, present as an **action item** for all project types: "Missing `.claude/dsm-ecosystem.md`. Run `/dsm-align` to create it with required ecosystem pointers (`dsm-central`, `portfolio`)." Use fallback resolution (dsm-central from `@` reference) for the current session but flag the gap. Continue to 2b.
   - **2b. Inbox check (behavior depends on project type from 2a):** If this is an External Contribution, do NOT create `_inbox/` in the external repo (see DSM_0.2 External Contribution exception). For spoke projects, if `_inbox/` is missing or dsm-docs/ structure is incomplete, suggest running `/dsm-align`. **Inbox location by project type:**
     - **DSM hub (DSM Central):** `_inbox/` at repo root
     - **DSM spoke:** `_inbox/` at repo root
     - **External contribution:** `contributions-docs/{project}/_inbox/` in DSM Central (NOT in the external repo)
     **How to check:** Use `ls` on the inbox directory (not Glob with literal paths, which silently fails for `_inbox/` directories). Exclude `README.md` from results. If `ls` shows no entries besides `README.md`, confirm with a second method (`ls -la`) before concluding the inbox is empty.
     Process any pending inbox entries: when an entry references a source file (Full evidence, Full report), read the referenced file before evaluating; the inbox is a notification, the source file contains the full evidence. Then evaluate impact, propose action (implement, defer, or reject per DSM_3 Section 6.4.3), and ask the user how to proceed. Do not merely list entry titles.
   - **2b.5. Governance folder check:** First, check if the project uses `docs/` instead of `dsm-docs/`. If `docs/` exists but `dsm-docs/` does not, inform the user: "This project uses `docs/` instead of `dsm-docs/`. Rename to match the current DSM convention? Run `/dsm-align` to migrate." Then verify that all 9 canonical `dsm-docs/` subfolders exist (`blog`, `checkpoints`, `decisions`, `feedback-to-dsm`, `guides`, `handoffs`, `plans`, `research`, `inbox`). If any are missing, suggest: "Missing canonical folders: [list]. Run `/dsm-align` to fix." Do not create folders here; dsm-align handles creation with proper templates.
   - **2c. Version check:** Compare DSM version against last handoff, note changes.
   - **2d. Subscription file:** Read `~/.claude/claude-subscription.md` if it exists. Cache the plan type and configuration profiles for the session. If the file does not exist, note: "No subscription file found. To enable session configuration recommendations, provide your Claude plan details." Continue without recommendations until the file is created.
   - Any other session-start protocols added to DSM_0.2 in the future
3. **Handoff lifecycle:** Check `dsm-docs/handoffs/` for consumed handoffs. Any handoff file (not in `done/`) that predates this session has been consumed and should be moved:
   - Move the file to `dsm-docs/handoffs/done/`
   - Add `**Date Completed:** YYYY-MM-DD` and `**Outcome Reference:** Consumed at session N start` to the file header
   - Report each moved file in the session report
3.5. **Checkpoint check:** List `dsm-docs/checkpoints/` (excluding `done/`). If a checkpoint exists from the most recent session (matching the session number or date in MEMORY.md), read it in full; it contains consolidated state that supplements MEMORY.md (pending work details, branch state, decision context). Extract pending items and next steps from the checkpoint; these become **suggested work items** in the session report (Step 8). If no recent checkpoint exists, skip silently.
   **After reading, move the checkpoint to `done/`:**
   1. `sed -i '1i **Consumed at:** Session N start (YYYY-MM-DD)\n' dsm-docs/checkpoints/{filename}`
   2. `git mv dsm-docs/checkpoints/{filename} dsm-docs/checkpoints/done/{filename}`
   3. Report: "Checkpoint {filename} moved to done/"
   If multiple checkpoints exist in `dsm-docs/checkpoints/` (excluding `done/`), read the most recent for context, then move **all** of them to `done/` with the same annotation.
3.6. **Sprint boundary gate:** If MEMORY.md or the checkpoint references a recently completed sprint (e.g., "Sprint N complete"), verify that boundary artifacts exist before suggesting new sprint work:
   - Checkpoint for the completed sprint in `dsm-docs/checkpoints/done/` (or just consumed in 3.5)
   - Blog journal entry in `dsm-docs/blog/journal.md` with a matching date
   - Feedback files updated (per-session file in `dsm-docs/feedback-to-dsm/` or entry in `technical.md`)
   If any are missing, flag them: "Sprint N boundary incomplete: missing [items]. Complete these before starting Sprint N+1, or defer with confirmation."
   **Skip when:** First sprint in a project (no prior boundary to check), or when no sprint identifier is found in MEMORY.md/checkpoint.
4. **Git status:** Run `git status` to check for uncommitted changes
5. **Save session baseline:** Save a snapshot of the current working tree state to `.claude/session-baseline.txt` so that `/dsm-wrap-up` can identify which changes belong to this session. Run:
   ```
   echo "# Session baseline - $(date -Iseconds)" > .claude/session-baseline.txt
   echo "# Session branch" >> .claude/session-baseline.txt
   git branch --show-current >> .claude/session-baseline.txt
   echo "# HEAD commit" >> .claude/session-baseline.txt
   git rev-parse HEAD >> .claude/session-baseline.txt
   echo "# Working tree" >> .claude/session-baseline.txt
   git status --porcelain >> .claude/session-baseline.txt
   echo "# Checksums" >> .claude/session-baseline.txt
   git status --porcelain | grep -v '^\?' | awk '{print $2}' | xargs -r md5sum >> .claude/session-baseline.txt
   git status --porcelain | grep '^\?' | awk '{print $2}' | xargs -r md5sum >> .claude/session-baseline.txt
   ```
   **External Contribution note:** For External Contribution projects, session artifacts (baseline, transcript) are written to `.claude/` inside the external repo. These files are hidden from git by Claude Code's `.git/info/exclude` rule (which adds `.claude/`), not by DSM or the project's `.gitignore`. This is an acceptable trade-off: the files are invisible to `git status` and cannot leak into upstream PRs, but the safety net depends on Claude Code's infrastructure. If working with a different AI tool that does not exclude `.claude/`, these files would be visible.
5.5. **Archive previous transcript:** If `.claude/session-transcript.md` exists and contains content beyond a blank header, archive it before overwriting. Extract the timestamp from the `**Started:**` line in the transcript header, then move the file:
   ```bash
   # Extract timestamp from transcript header (format: YYYY-MM-DDTHH:MM:SS+TZ)
   STARTED=$(grep '^\*\*Started:\*\*' .claude/session-transcript.md | sed 's/\*\*Started:\*\* //' | head -1)
   # Convert to filename-safe format (YYYY-MM-DDTHH:MM)
   TS=$(echo "$STARTED" | sed 's/\([0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}T[0-9]\{2\}:[0-9]\{2\}\).*/\1/')
   if [ -n "$TS" ] && [ "$TS" != "" ]; then
     mkdir -p .claude/transcripts
     cp .claude/session-transcript.md ".claude/transcripts/${TS}-ST.md"
   fi
   ```
   If the transcript has no `**Started:**` line (corrupted or empty), skip archiving. Report the archived filename in the session report.
5.7. **STAA reminder:** If a transcript was archived in Step 5.5, check whether the previous session's wrap-up included a STAA recommendation. If the archived transcript's final entries contain "STAA recommended: yes", remind the user: "Previous session recommended STAA analysis. Consider running `/dsm-staa` to analyze the archived transcript." If no transcript was archived, or if the previous session recommended "STAA: no", skip this step silently.
5.8. **Incomplete wrap-up recovery:** Detect whether the previous session ended without a full wrap-up by comparing MEMORY.md's "Latest Session" number against the current branch session number (extracted from the branch name, e.g., `session-139/...` → 139). If the branch number > MEMORY number, the previous session had an incomplete wrap-up.
   **If detected:**
   1. Inform the user: "Session {N} ended without full wrap-up. Archived transcript available at `.claude/transcripts/{archived-filename}`."
   2. Offer content reconstruction: "Reconstruct MEMORY update and reasoning lessons from the archived transcript? (y/n)"
   3. **If accepted:**
      a. Read the archived transcript
      b. Parse for: BLs completed, key decisions, work summary (scan `**Output:**` blocks and thinking blocks)
      c. Supplement with `git log main..HEAD` to capture all commits from the incomplete session
      d. Update MEMORY.md "Latest Session" section with the reconstructed summary
      e. Extract reasoning lessons: scan thinking blocks for decision patterns, course corrections, efficiency observations. Append new entries to `.claude/reasoning-lessons.md` tagged as `[recovered]`
      f. Report what was reconstructed
   4. **Action suggestions (always shown, regardless of reconstruction choice):**
      a. Check if the previous session's branch should be merged to main. If all work is committed and no Level 3 branches remain open, suggest: "Session {N}'s branch is ready to merge to main. Merge now and create a new session branch? (y/n)". If the user accepts, merge to main, delete the old session branch, and create a new session branch (`session-{N+1}/YYYY-MM-DD`) for the current session before continuing to Step 6.
      b. Check `git status` and `git log main..HEAD` for uncommitted or unpushed work; suggest commit/push if needed
      c. Check if feedback files in `dsm-docs/feedback-to-dsm/` were created during the incomplete session but not pushed to spokes (compare file dates against last inbox push); suggest feedback push if pending
      d. Suggest contributor profile review if the reconstructed work involved new skill areas
      e. Present as a checklist: "Missing wrap-up actions from Session {N}: [ ] Merge session branch to main [ ] Push to remote [ ] Push feedback to spokes [ ] Review contributor profile"
   **If not detected (MEMORY is current):** Skip silently.
   **If no archived transcript exists:** Warn "Incomplete wrap-up detected but no archived transcript found. MEMORY update must be done manually." Still show action suggestions.
6. **Reset session transcript:** Overwrite `.claude/session-transcript.md` with a fresh session header (the file persists across sessions; do not delete and recreate it). Write exactly this content, replacing N, timestamp, and project name:
   ```bash
   cat > .claude/session-transcript.md << EOF
   # Session N Transcript
   **Started:** $(date -Iseconds)
   **Project:** [project name from MEMORY.md or directory name]

   ---
   EOF
   ```
   This file is the persistent reasoning log per the Session Transcript Protocol in DSM_0.2. The user keeps it open in VS Code to monitor agent thinking in real time.
   **Behavioral activation:** From this point forward, follow the Session Transcript Protocol (DSM_0.2): append thinking to `.claude/session-transcript.md` as the **first tool call** of every turn, before any other tool calls or file edits. Append output summary as the **last tool call** after completing work. Conversation text is for results, summaries, and questions only, never for reasoning. This is not a checklist item; it is a behavioral mode that remains active for the entire session.
7. **Recent history:** Run `git log --oneline -5` to show recent commits
8. **Report:** Summarize in this format:
   - Last session: [number, date, description from MEMORY.md]
   - Session branch: [branch name from Step 0, or "main (no git)" if GIT_AVAILABLE is false]
   - Uncommitted changes: [yes/no, brief list if any]
   - Baseline saved: [yes/path]
   - Suggested work items: [pending items from checkpoint (Step 3.5) and MEMORY.md, presented as actionable suggestions ordered by priority]
   - Session Transcript Protocol is now active. All reasoning goes to `.claude/session-transcript.md`.
9. **Ask:** "What would you like to work on?" (If suggested work items exist, present them as starting options rather than asking open-ended.)
10. **Configuration recommendation:** After the user answers Step 9 (or immediately for continuation sessions where scope is known from memory/checkpoint), display a configuration recommendation based on the planned work and `~/.claude/claude-subscription.md`. Format:
    ```
    Recommended config: [Profile] ([Model], [Effort] effort, Thinking [ON/OFF], Fast [ON/OFF])
    Reason: [1 sentence based on planned work scope]
    ```
    If the subscription file does not exist, skip this step. If $ARGUMENTS is provided, include the recommendation in the session report (Step 8) since the scope is already known.

## Notes

- If $ARGUMENTS is provided, skip the "What would you like to work on?" question and start working on that topic directly
- Follow .claude/CLAUDE.md conventions for this project
- Follow the Session Transcript Protocol from DSM_0.2 (append reasoning to .claude/session-transcript.md as the first tool call, not conversation text)
