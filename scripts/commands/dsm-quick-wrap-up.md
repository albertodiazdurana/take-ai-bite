Execute the DSM session wrap-up checklist without feedback push. Use this variant when you want a fully autonomous wrap-up with no cross-repo approval clicks. Feedback can be pushed later via `/dsm-align` or the full `/dsm-wrap-up`. $ARGUMENTS

## Steps

**Steps 0, 1, and 1.5 are independent and can run in parallel.**

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
   **Lesson push:** Deferred (no cross-repo writes in quick wrap-up). Classified lessons remain in `.claude/reasoning-lessons.md` for push via `/dsm-wrap-up` or `/dsm-align`.
1. **Session summary:** MEMORY.md is already loaded via auto memory context. Do NOT re-read; update the version in the auto memory directory directly. Update:
   - Latest Session section: date, session number, brief description of what was done
   - Update any Pending Improvements or Open Developments that changed
   - Keep concise; MEMORY.md must stay under 200 lines
   - **Do NOT write a "Pending next session" list.** Step 1.5 (Checkpoint) owns pending items.

1.5. **Checkpoint:** Create a minimal checkpoint in `dsm-docs/checkpoints/` recording the session state. This step is the primary owner of "pending next session" items — do not duplicate them in MEMORY.md (Step 1).

   **Filename:** `YYYY-MM-DD_sN_checkpoint.md` where N is the session number.

   **Content:**
   ```markdown
   # Session N Checkpoint
   **Date:** YYYY-MM-DD
   **Branch:** [git branch --show-current]
   **Last commit:** [git log --oneline -1]

   ## Work completed this session
   [1-3 line summary drawn from session transcript Output blocks and git log]

   ## Pending next session
   [items that require human decision or cannot be derived from backlog/inbox/git]

   ## Open branches
   [any open Level 3 branches not yet merged; "none" if clean]
   ```

   **If git is unavailable (GIT_AVAILABLE=false):** omit Branch and Last commit fields; write the content fields only.

   **Skip condition:** if `dsm-docs/checkpoints/` does not exist, skip silently and log "Checkpoint skipped: dsm-docs/checkpoints/ not found."

2. **Refresh backup:** If `.claude/memory/MEMORY.md` exists in the project, copy the live MEMORY.md there
3. **Contributor profile:** Check if `.claude/contributor-profile.md` needs updating (new skills exercised, proficiency changes). Skip if the file does not exist or nothing changed.
4. **Handoff:** Only create a handoff in `dsm-docs/handoffs/` if there is complex pending work that requires detailed context for the next session. Skip if MEMORY.md is sufficient.
5. **Governance storage commit:** If the Ecosystem Path Registry declares a `contributions-docs` path pointing to a location **outside** the current repo, check whether any files there were modified this session. Run `git -C {contributions-docs-path} status --porcelain`; if the output is non-empty, commit and push:
   ```
   git -C {contributions-docs-path} add -A
   git -C {contributions-docs-path} commit -m "Session N: update governance artifacts for {project}"
   git -C {contributions-docs-path} push
   ```
   If the `contributions-docs` path is not in the registry, is inside the current repo, or has no changes, skip this step. If the push fails (no remote configured), warn and continue.
6. **Version and mirror sync check:** Detect whether methodology files changed this
   session and whether a version bump or mirror sync is needed.
   a. Extract the baseline commit SHA from `.claude/session-baseline.txt` (the line
      after `# HEAD commit`). Run:
      `git diff <baseline-sha>..HEAD --name-only -- 'DSM_*.md' 'CHANGELOG.md' 'README.md' 'LICENSE*' 'TAKE_AI_BITE.md' 'scripts/commands/*.md'`
      If the baseline is missing, fall back to `git diff HEAD --name-only` with the
      same file patterns.
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
   d. **Mirror sync:** Deferred (no cross-repo writes in quick wrap-up). Report:
      "Mirror sync deferred. Run `/dsm-wrap-up` or manual sync to update mirrors."
6.5. **Humanizer check:** Detect whether any human-facing files were modified this
   session. Extract the baseline commit SHA from `.claude/session-baseline.txt`,
   then run:
   ```
   git diff <baseline-sha>..HEAD --name-only -- DSM_0.0*.md README.md TAKE_AI_BITE.md FEATURES.md CONTRIBUTING.md 'dsm-docs/blog/*.md'
   ```
   Also check `git diff --name-only` for uncommitted changes to the same files.
   Exclude `dsm-docs/blog/done/`. If any human-facing files changed, run
   `/humanizer` on each one and stage the resulting edits. If no human-facing
   files changed, skip this step silently.
7. **Git (session-scoped):** Run `git status --porcelain` and compare against `.claude/session-baseline.txt` (saved by `/dsm-go` at session start). Identify session changes:
   - Files not in the baseline = new this session (stage them)
   - Files in the baseline whose content changed (compare `md5sum` against baseline checksums) = modified further this session (stage them)
   - Files in the baseline with unchanged checksums = pre-existing, not touched this session (skip them)
   - If `.claude/session-baseline.txt` does not exist (session started without `/dsm-go`), fall back to staging all changed files

   **Mirror self-detection inbox guard:** If
   `scripts/take-ai-bite-sync.txt` does NOT exist in the current
   working tree, this repo is a mirror (not the hub). Exclude any
   `_inbox/*` path from the stage-set except `_inbox/README.md` and
   `_inbox/.gitkeep`. Log each excluded path: "Mirror inbox guard:
   skipped `_inbox/{file}` (mirror inbox guard)." Parity with `/dsm-wrap-up`
   Step 9.

   Then `git commit` and `git push` in sequence. If no session changes exist, skip the commit.
   After committing, delete `.claude/session-baseline.txt` (consumed).
7.5. **Parallel sessions registry cleanup:** Read `.claude/parallel-sessions.txt` if it exists.
   - If the file does not exist: skip silently.
   - If every section has `State: wrapped`: delete the file. Report:
     "Parallel sessions registry cleaned: {N} entries (all wrapped)."
   - If any section has `State: active`: warn the user with the section
     name(s) — "Parallel session(s) {section-name(s)} did not wrap (state=active).
     Investigate before proceeding. Skipping registry cleanup; file retained
     for inspection in the next session." This warning is NOT a hard stop;
     proceed to the next step.

8. **Write wrap-up type marker:** Write `.claude/last-wrap-up.txt` with the session number, date, and wrap-up type. This marker is read by `/dsm-go` and `/dsm-light-go` at next session start to guide the user toward the appropriate startup command.
    ```
    session: N
    date: YYYY-MM-DD
    type: quick
    ```

## Notes

- Do NOT clear or overwrite `.claude/session-transcript.md`; `/dsm-go` handles the reset at next session start
- No co-author lines in commits
- If $ARGUMENTS is provided, use it as the session description in MEMORY.md
- All steps run autonomously; do not pause for confirmation between steps
- Only commit changes in the current project, except the governance storage repo (step 5) which has no session lifecycle of its own
- Commit message format: "Session N wrap-up: [brief description]"
- **Relationship to `/dsm-wrap-up`:** This command runs the same steps but omits all cross-repo writes to achieve zero permission prompts. Changes to shared steps must be applied to both files.
- **Omitted steps (all involve cross-repo writes):**
  - README change notification (writes to portfolio and DSM Central inboxes)
  - Feedback push (writes to DSM Central inbox)
  - Mirror sync (writes to mirror repos)
  - Governance storage commit (writes to contributions-docs repo)
  Unpushed entries remain in local files for later push via `/dsm-align` or `/dsm-wrap-up`.
- Follow .claude/CLAUDE.md conventions for this project
