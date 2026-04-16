Execute the DSM session wrap-up checklist autonomously. Run all steps without pausing for approval. $ARGUMENTS

## Git Awareness

At the start, run `git rev-parse --is-inside-work-tree 2>/dev/null`. Cache the result as `GIT_AVAILABLE` (true/false). If false (no git repo, e.g., private projects per BL-162):

- **README check (Step 1):** Skip entirely (no git diff available)
- **Governance storage commit (Step 7):** Skip entirely
- **Git commit + push (Step 8):** Skip entirely; do NOT delete `.claude/session-baseline.txt`
- All non-git steps (reasoning lessons, MEMORY.md, feedback push, contributor profile) run unchanged.

## Steps

**Steps 0, 1, and 2 are independent and can run in parallel.**

0. **Extract reasoning lessons:** Scan `.claude/session-transcript.md` for notable reasoning patterns from this session. For each notable entry, append a 1-2 line summary to `.claude/reasoning-lessons.md` under the appropriate category, tagged `[auto]`. Notable entries include:
   - Mistakes caught mid-reasoning (course corrections)
   - Decision heuristics that worked or failed
   - Efficiency observations (ordering, batching, parallelism)
   - Pitfalls not already captured in MEMORY.md
   - Patterns that recur across sessions
   If no notable entries exist, skip the extraction. If `.claude/reasoning-lessons.md` does not exist, skip this step entirely (protocol not active for this project).
   **Format:** `- [auto] S{N} [{scope}]: {lesson text}` (where N is the session number)
   **Scope classification:** For each extracted lesson, assign a scope label per the Reasoning Lessons Protocol (DSM_0.2 Module A): `ecosystem`, `pattern`, or `project`. The agent assigns scope based on whether the lesson is domain-specific or generalizable.
   **STAA recommendation:** After extracting, assess whether this session warrants deeper STAA analysis. Recommend STAA when the session involved complex multi-option decisions, entered unfamiliar territory (new domain, tool, or pattern), the auto extraction felt incomplete (rich reasoning that resists summarization), or a course correction occurred that may represent a recurring pattern. Output: "STAA recommended: [yes/no]. [1-sentence reason]." **Invocation:** STAA must be run in a separate Claude Code conversation. Do not wrap it in `/dsm-go` or `/dsm-parallel-session-go`. Enter `/dsm-staa` directly.
   **Lesson push:** If new lessons were extracted this session, push a notification to DSM Central's inbox listing the new entries with scope classification. Use the inbox entry format from the Reasoning Lessons Protocol (DSM_0.2 Module A). Target: `{dsm-central-path}/_inbox/{this-project-name}.md`. If this IS DSM Central, add ecosystem/pattern lessons directly to `dsm-docs/reasoning-lessons-ecosystem.md` instead of self-notifying.
1. **README and FEATURES.md check:** Detect whether `README.md` or `FEATURES.md` changed this session. Extract the baseline commit SHA from `.claude/session-baseline.txt` (the line after `# HEAD commit`), then run `git diff <baseline-sha>..HEAD -- README.md FEATURES.md`. If the baseline file is missing, fall back to `git diff HEAD -- README.md FEATURES.md` (catches only uncommitted changes). If neither file has a diff, skip this step. If the diff is non-empty:
   a. **Apply relevance filter:** Evaluate the diff against the relevance filter in DSM_0.2 README Change Notification. Send if the change affects project description, scope, audience, external metrics, structure, license, or contact info. Skip if the change is only version bumps for internal protocols, date-only updates, or formatting fixes. Log the decision: "README changed: [externally relevant / internal-only]. [1-sentence reason]."
   b. If externally relevant: summarize what changed and send inbox entry to the portfolio using the Ecosystem Path Registry (logical name: `portfolio`). Target: `{portfolio-path}/_inbox/{this-project-name}.md`. If the `portfolio` path is not in the registry or does not exist on disk, warn: "Portfolio path not configured or not found. Skipping README change notification to portfolio." and skip this sub-step.
   c. If this is a spoke project (not DSM Central), also send to DSM Central: `{dsm-central-path}/_inbox/{this-project-name}.md`.
   d. If internal-only: log "Skipping README notification (internal-only change)" and skip sending.
2. **Session summary:** MEMORY.md is already loaded via auto memory context. Do NOT re-read; update the version in the auto memory directory directly. Update:
   - **Latest Session section** (target: ≤ 15 lines): date, session number, brief description of what was done. For each BL completed or filed, write BL# + one line. Do not expand implementation details, commit hashes, or file metrics; these are recoverable from `git log` and the BL file itself.
   - **Pending for next session** (target: ≤ 8 items): Only include items that require human decision or cannot be derived from the backlog, inbox, or git status. Each item gets one line.
   - **Previous Session section:** Compress the outgoing Latest Session to ≤ 3 lines before writing the new Latest.
   - Keep concise; MEMORY.md must stay under 200 lines.

   **MEMORY.md exclusion list (do NOT write these to MEMORY):**
   - Inbox state (e.g., "IronCalc inbox entry not processed"). /dsm-go scans the inbox directly.
   - Git-recoverable details: commit hashes, file line counts, diff summaries, branch base commits.
   - Pre-session uncommitted file lists. /dsm-go captures these in the session baseline.
   - STAA recommendation flags. /dsm-go step 5.7 reads these from the archived transcript.
   - Detailed BL implementation descriptions. The BL file and git log are the source of truth.
   - Items that duplicate CLAUDE.md content (patterns, conventions, pitfalls already documented there).

   **Pending list hygiene:** Before writing the new Pending list, review each carried-forward item:
   - If the item has been carried forward 3+ sessions without action: either promote it to a formal BL (create in `dsm-docs/plans/`) or drop it with a note in the output summary explaining why.
   - If the item is a housekeeping task with no BL (stray files, uncommitted changes in other repos): include only if it requires human decision. Mechanical cleanup that the agent can do autonomously should be done during the session, not deferred indefinitely.
3. **Refresh backup:** If `.claude/memory/MEMORY.md` exists in the project, copy the live MEMORY.md there
4. **Contributor profile:** Check if `.claude/contributor-profile.md` needs updating (new skills exercised, proficiency changes). Skip if the file does not exist or nothing changed.
5. **Handoff:** Only create a handoff in `dsm-docs/handoffs/` if there is complex pending work that requires detailed context for the next session. Skip if MEMORY.md is sufficient.
6. **Feedback push:** Push ripe feedback to DSM Central. The DSM Central repo path is the parent directory of the `DSM_0.2_Custom_Instructions_v1.1.md` file referenced by the `@` import in this project's CLAUDE.md. Target: `{dsm-central-path}/_inbox/{this-project-name}.md`.
   a. **Per-session files (backlogs and methodology):** Scan `dsm-docs/feedback-to-dsm/` for files matching `YYYY-MM-DD_sN_backlogs.md` or `YYYY-MM-DD_sN_methodology.md` that are NOT in `done/`. For each file, check ripe criteria (see DSM_0.2 Session-End Inbox Push). If ripe, append its content to the inbox file and move the source to `dsm-docs/feedback-to-dsm/done/`. If not ripe, leave in place for further drafting.
   b. **Technical progress:** Scan `dsm-docs/feedback-to-dsm/technical.md` for entries without a `**Pushed:**` date. For each unpushed entry, append a Technical Progress Report inbox entry (see DSM_0.2 Technical Progress Reporting for format) and mark it with `**Pushed:** YYYY-MM-DD` in the source.
   c. **Legacy files:** If `dsm-docs/feedback-to-dsm/backlogs.md` or `dsm-docs/feedback-to-dsm/methodology.md` exist with unpushed entries, push them using the old `**Pushed:**` marker model. Report: "Legacy feedback files found; consider migrating to per-session format."
   d. **Format:** Group all entries under a single inbox entry header:
      ```
      ### [YYYY-MM-DD] Session feedback from {project-name}

      **Type:** Methodology Observation
      **Priority:** Medium
      **Source:** {project-name}

      [backlog proposals + methodology scores, grouped by type]
      ```
   e. If no pushable entries exist, skip this step.
   f. Do NOT push entries that lack structure (no problem statement, no score). Leave them for further drafting.
7. **Governance storage commit:** If the Ecosystem Path Registry declares a `contributions-docs` path pointing to a location **outside** the current repo, check whether any files there were modified this session. Run `git -C {contributions-docs-path} status --porcelain`; if the output is non-empty, commit and push:
   ```
   git -C {contributions-docs-path} add -A
   git -C {contributions-docs-path} commit -m "Session N: update governance artifacts for {project}"
   git -C {contributions-docs-path} push
   ```
   If the `contributions-docs` path is not in the registry, is inside the current repo, or has no changes, skip this step. If the push fails (no remote configured), warn and continue.
8. **Version and mirror sync check:** Detect whether methodology files changed this
   session and whether a version bump or mirror sync is needed.
   a. Extract the baseline commit SHA from `.claude/session-baseline.txt` (the line
      after `# HEAD commit`). Run:
      `git diff <baseline-sha>..HEAD --name-only -- 'DSM_*.md' 'CHANGELOG.md' 'README.md' 'LICENSE*' 'TAKE_A_BITE.md' 'scripts/commands/*.md'`
      If the baseline is missing, fall back to `git diff HEAD --name-only` with the
      same file patterns (catches only uncommitted changes).
   b. If no methodology files changed, skip this step entirely.
   c. If methodology files changed, consult the Version Bump Cadence (DSM_2.0.D §7.4):
      - 3+ BL improvements in this session → patch bump warranted
      - New DSM section or methodology track → minor bump warranted
      - Breaking structural change → major bump warranted
      - Repository organization or housekeeping → patch bump optional
      Present the assessment: "Methodology files changed this session: [list].
      Version bump assessment: [warranted/not warranted]. [reason]."
      If a bump is warranted, suggest running `/dsm-version-update` before
      continuing. If the user declines, proceed without bumping.
      **Spoke action reminder:** If a version bump happens and CHANGELOG entries
      are added, assess whether any changes affect spoke projects (template
      updates in §17.1, protocol changes, command file modifications). If yes,
      remind: "Add `**Spoke action:** [action]` to the relevant CHANGELOG entry
      so spokes are notified at their next session start (DSM_0.2 §2.1)."
   d. **Mirror sync (runs regardless of version bump):** Check the Ecosystem Path
      Registry for entries with `mirror: true`. For each mirror repo, copy the
      changed methodology files to the mirror, commit with
      "Sync session {N} methodology changes from Central", and push. If push fails
      (branch protection), use the protected-branch sub-protocol from the Version
      Update Workflow (create sync branch, PR, merge). If `mirror: true` entries
      do not exist, skip.

      **Personal content gate (BL-335):** Before copying any file to a mirror
      repo, run the personal content scanner on the changed methodology file
      list:

      ```bash
      scripts/check-mirror-sync-content.sh <changed-methodology-files>
      ```

      The scanner greps for personal markers (names, credentials, contact
      info, user-preference phrasing) and exits non-zero on a hit. If it
      exits non-zero:

      1. Read each reported file:line. Decide whether the match is a leak
         (personal content that should not propagate) or a legitimate
         occurrence (author attribution in README, BL author field, content
         describing methodology features).
      2. **If leak:** stop the mirror sync. Move the personal content to
         `.claude/` (gitignored, local) or to auto-memory at
         `~/.claude/projects/<encoded>/memory/`. Re-run the scanner.
      3. **If legitimate:** re-run with `--confirmed` to bypass the gate.
         Document the reason in the commit message or wrap-up report.

      The scanner is a safety net, not a content classifier. The
      authoritative split rule is in `.claude/personal-rules-allowlist.md`
      (BL-336) and Layer 1/2/3 model documented in feedback memory.
8.5. **Humanizer check:** Detect whether any human-facing files were modified this
   session. Extract the baseline commit SHA from `.claude/session-baseline.txt`,
   then run:
   ```
   git diff <baseline-sha>..HEAD --name-only -- DSM_0.0*.md README.md TAKE_A_BITE.md FEATURES.md CONTRIBUTING.md 'dsm-docs/blog/*.md'
   ```
   Also check `git diff --name-only` for uncommitted changes to the same files.
   Exclude `dsm-docs/blog/done/`. If any human-facing files changed, run
   `/humanizer` on each one and stage the resulting edits. If no human-facing
   files changed, skip this step silently.
9. **Git (session-scoped):** Run `git status --porcelain` and compare against `.claude/session-baseline.txt` (saved by `/dsm-go` at session start). Identify session changes:
   - Files not in the baseline = new this session (stage them)
   - Files in the baseline whose content changed (compare `md5sum` against baseline checksums) = modified further this session (stage them)
   - Files in the baseline with unchanged checksums = pre-existing, not touched this session (skip them)
   - If `.claude/session-baseline.txt` does not exist (session started without `/dsm-go`), fall back to staging all changed files
   Then `git commit` and `git push` in sequence. If no session changes exist, skip the commit.
   After committing, delete `.claude/session-baseline.txt` (consumed).
10. **Merge session branch to main via PR:** If the current branch is a session branch (not main/master), merge it to main using a pull request. This is required because branch protection prevents direct pushes to main.
   a. Ensure the session branch is pushed: `git push -u origin {session-branch}` (may already be pushed from step 8)
   b. Create PR: `gh pr create --title "Session N: [brief summary]" --body "Session wrap-up merge." --base main --head {session-branch}`
   c. Merge PR: `gh pr merge --merge --delete-branch`
   d. Update local: `git checkout main && git pull`
   e. If `gh` is not available or the PR fails, warn: "Branch protection is active. Cannot merge to main without a PR. The session branch `{session-branch}` has been pushed to remote. Merge manually via GitHub." and stop.
   f. If already on main (no session branch), skip this step.
11. **Mirror sync PR safety net:** Check the Ecosystem Path Registry for entries with `mirror: true`. For each mirror repo, check for open PRs created by mirror sync:
   a. Run: `cd {mirror-repo-path} && gh pr list --state open --head "sync/" --json number,title 2>/dev/null`
   b. For each open sync PR: attempt `gh pr merge {number} --merge --delete-branch`
   c. If merge succeeds: report "Merged mirror sync PR #{number} on {repo}"
   d. If merge fails or `gh` unavailable: warn "Open mirror sync PR on {repo}: #{number} ({title}). Merge manually."
   e. If no open sync PRs exist, skip silently.
11.5. **Parallel sessions registry cleanup:** Read `.claude/parallel-sessions.txt` if it exists.
   - If the file does not exist: skip silently.
   - If every section has `State: wrapped`: delete the file. Report:
     "Parallel sessions registry cleaned: {N} entries (all wrapped)."
   - If any section has `State: active`: warn the user with the section
     name(s) — "Parallel session(s) {section-name(s)} did not wrap (state=active).
     Investigate before proceeding. Skipping registry cleanup; file retained
     for inspection in the next session." This warning is NOT a hard stop;
     proceed to the next step. The file persists into the next session so
     the active entry can be investigated.

12. **Write wrap-up type marker:** Write `.claude/last-wrap-up.txt` with the session number, date, and wrap-up type. This marker is read by `/dsm-go` and `/dsm-light-go` at next session start to guide the user toward the appropriate startup command.
    ```
    session: N
    date: YYYY-MM-DD
    type: full
    ```

## Notes

- Do NOT clear or overwrite `.claude/session-transcript.md`; `/dsm-go` handles the reset at next session start
- No co-author lines in commits
- If $ARGUMENTS is provided, use it as the session description in MEMORY.md
- All steps run autonomously; do not pause for confirmation between steps
- Only commit changes in the current project, except the governance storage repo (step 7) which has no session lifecycle of its own
- Commit message format: "Session N wrap-up: [brief description]"
- **Relationship to `/dsm-quick-wrap-up`:** Quick-wrap-up runs the same steps but omits all cross-repo writes (README notification, feedback push, mirror sync, governance storage commit) to achieve zero permission prompts. Changes to shared steps must be applied to both files.
- Follow .claude/CLAUDE.md conventions for this project
