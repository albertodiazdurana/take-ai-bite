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
   **Provenance header update (per BL-510; canonical rule in DSM_0.2.A §8.1):** After the appends above have landed, update the live file's `**Last appended:**` line, and `**Last pruned:**` when entries were removed, with this run's identifier, date, counts and a one-line note. Four properties, all four required. **Chain, never replace:** move the superseded value behind `Prior:` (the form the file already uses) rather than overwriting it. **No-op when nothing changed:** if nothing was appended and nothing pruned, make no header change. **Same run, not the next one:** do it here, not in a later step or a later skill, because deferring is the structure that produced the gap. **Create when absent (property 4, BL-526):** where the `**Last appended:**` line does not exist, create it and state within the line that this run created it and that earlier appends predate the header, so its date is not misread as the file's first write. Absence is not a reason to skip; property 2 still governs, so a run that appended and pruned nothing makes no header change even when the line is missing. This step is NOT deferred the way the lesson push is: the header is a local write to a file this step already edits, so skipping it here leaves the staleness for a later skill to inherit rather than to fix.
   **Compact mirror regeneration (per DSM_0.2.A §8.1; transform per BL-447):** After the appends and the provenance-header update above have landed, regenerate `.claude/reasoning-lessons-compact.md` from the live `.claude/reasoning-lessons.md`. **Run the canonical regeneration transform defined in DSM_0.2.A §8.1 ("Canonical regeneration transform"), then run the two post-generation sanity checks specified there.** Do NOT re-inline a transform here: the canonical awk in §8.1 is the single source of truth, and re-inlining a divergent copy was the BL-447 drift bug that silently emptied the mirror on flat-structured spoke files. `/dsm-wrap-up` Step 0 and `/dsm-staa` Step 8 reference the same §8.1 block; this is the third. If the live file does not exist, skip this sub-step (protocol not active for this project). If nothing was appended this run, still skip , there is nothing to propagate, and the §8.1 no-op posture applies here for the same reason it applies to the provenance header. Report the measured size, the §8.1 bound and their ratio in EVERY case, so a breach and a pass produce different output rather than a pass producing silence , `mirror {measured} B / bound {§8.1 value} B / {ratio}x OVER` against `mirror {measured} B / bound {§8.1 value} B / within bound`. Read the bound's value from §8.1 at regeneration time; do NOT copy it into this file (per BL-491). On a breach add: "Consider pruning the live file or promoting older lessons to MEMORY.md before the next wrap-up." Advisory, not blocking: still write the file. **Advisory means non-blocking, never silent.**

   **Why this is here and not deferred (BL-514).** Quick wrap-up is chosen for speed, and this is the one sub-step that costs real work. It is included anyway because the alternative is not "no cost", it is the same regeneration paid by `/dsm-go` Step 1.5 at the next boot, whose staleness check detects the stale mirror and regenerates it inline before reading , at the moment context is scarcest. The gap this closes is therefore a *placement* defect rather than a data-loss one: no lesson was ever lost, because Step 1.5 recovers. What was wrong is that three sibling steps wrote the live file and only two maintained its mirror, with no stated reason for the asymmetry.
0.5. **Pre-confirm auto-memory target (BL-450):** Quick wrap-up's only cross-repo write is the auto-memory `MEMORY.md` (no feedback push). Pre-confirm just the auto-memory dir so the BL-391 hook (`validate-cross-repo-write.sh`) does not fire on the protocol-defined MEMORY.md update. The hook matches canonicalized path prefixes, so pre-confirm the directory. Session-scoped (`/dsm-go` Step 0f clears it). This is not a gate weakening: the gate still fires for any other cross-repo write.

   ```bash
   CONFIRM=.claude/cross-repo-writes-session.txt
   # Derive the auto-memory dir deterministically from the project path slug.
   # Claude Code maps BOTH `/` and `_` to `-` (BL-504), so a `/`-only
   # substitution yields a non-existent path and the `-d` guard below then
   # skips silently. Do NOT `find ... | head -1` either, which can return
   # another project's MEMORY.md.
   MEMDIR="$HOME/.claude/projects/$(pwd | sed 's#[/_]#-#g')/memory"
   if [ -d "$MEMDIR" ]; then
     C=$(realpath -m "$MEMDIR" 2>/dev/null || echo "$MEMDIR")
     grep -qxF "$C" "$CONFIRM" 2>/dev/null || echo "$C" >> "$CONFIRM"
   fi
   ```

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
   [items that require human decision or cannot be derived from backlog/inbox/git.
    Author each item causal-forward: what the continuation requires, why, what it
    depends on, what order the dependencies force, and what breaks if it is skipped.
    Not a flat task list.]

   ## Open branches
   [any open Level 3 branches not yet merged; "none" if clean]
   ```

   **Causal-forward authoring (Delegating face of Forward the Why, DSM_6.0 §1.13).**
   A checkpoint is a handoff across a session boundary: the closing session holds the
   state and the intent, the next session inherits only this document. A flat list
   forwards the "what" and strands the "why", so the receiver either re-derives the
   reasoning or re-opens a decision this session already settled, because nothing
   recorded that it was settled. Write each item so it can be acted on without that
   reconstruction:

   | Backward inventory (anti-pattern) | Causal-forward handoff |
   |---|---|
   | "Done: rules module. Next: schema change, endpoint, workflow." | "Resume at the schema change, because `create_all` will not ALTER, so the stack must be up and the table recreated first; the endpoint and workflow follow because both consume the new columns." |

   The causal-forward form is not longer for its own sake. It is longer by exactly
   the causal links the receiver would otherwise have to rebuild. If an item has no
   dependency, ordering constraint, or consequence-if-skipped, state it plainly and
   move on; padding a self-evident item with invented rationale is the failure mode
   this guidance guards against, not a way of satisfying it.

   The selection criterion above is unchanged: this section still holds only items
   that need human decision or cannot be derived from backlog/inbox/git. Causal-forward
   governs how a qualifying item is written, not which items qualify.

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
7. **Git (session-scoped):** Run `git status --porcelain -uall` and compare against `.claude/session-baseline.txt` (saved by `/dsm-go` at session start). **`-uall` is load-bearing (BL-512):** without it a wholly-untracked directory collapses to one entry ending in a slash, so no file beneath it can be matched against a baseline entry and the three-way classification below silently cannot run for that subtree. **Compare against the baseline's `# Checksums` block, never its `# Working tree` block (BL-523).** The baseline holds two records of untracked files and they disagree by construction. `/dsm-go` Step 5 writes `# Working tree` from a plain `git status --porcelain`, which collapses a wholly-untracked directory to a single entry, and writes the `# Checksums` lines with `-uall` on the untracked line, which enumerates it. Only the checksum block is a complete record, so only it is the comparison surface; `# Working tree` is a human-readable summary and collapsing is what makes it readable (see BL-512's note in `/dsm-go` Step 5 for why the flag is deliberately not uniform across those lines , do NOT "fix" it there). Measured on a baseline holding one loose file and one wholly-untracked directory containing two files at two depths: comparing against `# Working tree` classifies both nested files as new-this-session and stages them, while comparing against `# Checksums` classifies them as pre-existing and skips them. Opposite verdicts, same baseline, same files. The dangerous direction is the first, because it sweeps prior uncommitted work into this session's commit. Identify session changes:
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

9. **Remove session lockfile (BL-431):** Run `rm -f .claude/session.lock`. Per **DSM_0.2.A §26**, this is the locus of lockfile cleanup for quick wrap-up. The `-f` flag tolerates a missing file (e.g., a session that pre-dated BL-431).

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
  - Blog-poster FEATURES notification (writes to blog-poster inbox; per BL-424, sub-step (e) of /dsm-wrap-up Step 1)
  - Feedback push (writes to DSM Central inbox)
  - Mirror sync (writes to mirror repos)
  - Governance storage commit (writes to contributions-docs repo)
  Unpushed entries remain in local files for later push via `/dsm-align` or `/dsm-wrap-up`.
- Follow .claude/CLAUDE.md conventions for this project
