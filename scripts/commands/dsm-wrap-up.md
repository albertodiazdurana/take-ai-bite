Execute the DSM session wrap-up checklist autonomously. Run all steps without pausing for approval. $ARGUMENTS

## Git Awareness

At the start, run `git rev-parse --is-inside-work-tree 2>/dev/null`. Cache the result as `GIT_AVAILABLE` (true/false). If false (no git repo, e.g., private projects per BL-162):

- **README check (Step 1):** Skip entirely (no git diff available)
- **Governance storage commit (Step 8):** Skip entirely
- **Git commit + push (Step 9):** Skip entirely; do NOT delete `.claude/session-baseline.txt`
- All non-git steps (reasoning lessons, MEMORY.md, feedback push, bandwidth, contributor profile) run unchanged.

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
   **STAA recommendation:** After extracting, assess whether this session warrants deeper STAA analysis. Recommend STAA when the session involved complex multi-option decisions, entered unfamiliar territory (new domain, tool, or pattern), the auto extraction felt incomplete (rich reasoning that resists summarization), or a course correction occurred that may represent a recurring pattern. Output: "STAA recommended: [yes/no]. [1-sentence reason]."
   **Lesson push:** If new lessons were extracted this session, push a notification to DSM Central's inbox listing the new entries with scope classification. Use the inbox entry format from the Reasoning Lessons Protocol (DSM_0.2 Module A). Target: `{dsm-central-path}/_inbox/{this-project-name}.md`. If this IS DSM Central, add ecosystem/pattern lessons directly to `dsm-docs/reasoning-lessons-ecosystem.md` instead of self-notifying.
1. **README check:** Detect whether `README.md` changed this session. Extract the baseline commit SHA from `.claude/session-baseline.txt` (the line after `# HEAD commit`), then run `git diff <baseline-sha>..HEAD -- README.md`. If the baseline file is missing, fall back to `git diff HEAD -- README.md` (catches only uncommitted changes). If `README.md` has no diff, skip this step. If the diff is non-empty:
   a. **Apply relevance filter:** Evaluate the diff against the relevance filter in DSM_0.2 README Change Notification. Send if the change affects project description, scope, audience, external metrics, structure, license, or contact info. Skip if the change is only version bumps for internal protocols, date-only updates, or formatting fixes. Log the decision: "README changed: [externally relevant / internal-only]. [1-sentence reason]."
   b. If externally relevant: summarize what changed and send inbox entry to the portfolio using the Ecosystem Path Registry (logical name: `portfolio`). Target: `{portfolio-path}/_inbox/{this-project-name}.md`. If the `portfolio` path is not in the registry or does not exist on disk, warn: "Portfolio path not configured or not found. Skipping README change notification to portfolio." and skip this sub-step.
   c. If this is a spoke project (not DSM Central), also send to DSM Central: `{dsm-central-path}/_inbox/{this-project-name}.md`.
   d. If internal-only: log "Skipping README notification (internal-only change)" and skip sending.
2. **Bandwidth report:** Run `vnstat -h` and summarize today's usage
3. **Session summary:** MEMORY.md is already loaded via auto memory context. Do NOT re-read; update the version in the auto memory directory directly. Update:
   - Latest Session section: date, session number, brief description of what was done
   - Update any Pending Improvements or Open Developments that changed
   - Keep concise; MEMORY.md must stay under 200 lines
4. **Refresh backup:** If `.claude/memory/MEMORY.md` exists in the project, copy the live MEMORY.md there
5. **Contributor profile:** Check if `.claude/contributor-profile.md` needs updating (new skills exercised, proficiency changes). Skip if the file does not exist or nothing changed.
6. **Handoff:** Only create a handoff in `dsm-docs/handoffs/` if there is complex pending work that requires detailed context for the next session. Skip if MEMORY.md is sufficient.
7. **Feedback push:** Push ripe feedback to DSM Central. The DSM Central repo path is the parent directory of the `DSM_0.2_Custom_Instructions_v1.1.md` file referenced by the `@` import in this project's CLAUDE.md. Target: `{dsm-central-path}/_inbox/{this-project-name}.md`.
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
8. **Governance storage commit:** If the Ecosystem Path Registry declares a `contributions-docs` path pointing to a location **outside** the current repo, check whether any files there were modified this session. Run `git -C {contributions-docs-path} status --porcelain`; if the output is non-empty, commit and push:
   ```
   git -C {contributions-docs-path} add -A
   git -C {contributions-docs-path} commit -m "Session N: update governance artifacts for {project}"
   git -C {contributions-docs-path} push
   ```
   If the `contributions-docs` path is not in the registry, is inside the current repo, or has no changes, skip this step. If the push fails (no remote configured), warn and continue.
9. **Git (session-scoped):** Run `git status --porcelain` and compare against `.claude/session-baseline.txt` (saved by `/dsm-go` at session start). Identify session changes:
   - Files not in the baseline = new this session (stage them)
   - Files in the baseline whose content changed (compare `md5sum` against baseline checksums) = modified further this session (stage them)
   - Files in the baseline with unchanged checksums = pre-existing, not touched this session (skip them)
   - If `.claude/session-baseline.txt` does not exist (session started without `/dsm-go`), fall back to staging all changed files
   Then `git commit` and `git push` in sequence. If no session changes exist, skip the commit.
   After committing, delete `.claude/session-baseline.txt` (consumed).

## Notes

- Do NOT clear or overwrite `.claude/session-transcript.md`; `/dsm-go` handles the reset at next session start
- No co-author lines in commits
- If $ARGUMENTS is provided, use it as the session description in MEMORY.md
- All steps run autonomously; do not pause for confirmation between steps
- Only commit changes in the current project, except the governance storage repo (step 8) which has no session lifecycle of its own
- Commit message format: "Session N wrap-up: [brief description]"
- **Relationship to `/dsm-quick-wrap-up`:** Quick-wrap-up runs the same steps but omits all cross-repo writes (README notification, feedback push, governance storage commit) to achieve zero permission prompts. Changes to shared steps must be applied to both files.
- Follow .claude/CLAUDE.md conventions for this project
