Align a DSM spoke project's folder structure with the canonical standard and push unpushed feedback to DSM Central. Idempotent: safe to run on new or existing projects. Creates missing folders, adds missing done/ subfolders, installs template files, detects naming collisions, checks file lifecycle compliance, and pushes ripe feedback.

## Git Pre-Step: Ensure Git Initialized

Before starting alignment, check if git is initialized:

1. Run: `git rev-parse --is-inside-work-tree 2>/dev/null`
2. If **not** a git repo:
   a. Run: `git init`
   b. Run: `git branch -m main`
   c. Ask: "Remote repository? (GitHub URL or 'none' for local-only)"
   d. If URL provided: `git remote add origin {url}`
   e. Create initial commit: `git add .` then `git commit -m "Initialize DSM project"`
   f. Report: "Git initialized. All DSM projects require a local git repository."
3. Continue to Step 1 below.

## Steps

1. **Detect project type** using the table in **DSM_0.2.A §17** (Project Type
   Detection). Read §17 directly; do NOT rely on an inline copy of the table,
   which drifts (BL-379 broadened the Application signals; an inline cache
   here would go stale). Primary runtime markers per §17: `package.json`,
   `Cargo.toml`, `go.mod`, `pyproject.toml` with `[project]`, `setup.py`,
   `src/`+`tests/`, `app.py`. Supporting signals (scripts/bin/cmd with
   executables, CI workflows with build/deploy) count only alongside a
   primary. Documentation requires no primary runtime marker AND no build
   output directories (`dist/`, `build/`, `site/`, `_site/`, `public/`).
   External Contribution: `contributions-docs/{project}/` in DSM Central.
   State the detected type.

   **Classification-change reporting (§17):** if the detected type differs
   from the type recorded in the CLAUDE.md alignment section, REPORT the
   change before regenerating. Do not silently reclassify; the user may
   have an explicit reason to retain the recorded type.

   **Implementation note:** Use `test -d` for directory existence checks, not `ls -d` (which returns non-zero when paths don't exist, cancelling parallel tool calls).

   **Hub fast-path:** If the project is DSM Central (has `scripts/commands/` directory), skip steps 2, 4, 5, 6, and 8c. These steps check spoke scaffold structure and validate CLAUDE.md paths against the filesystem, both of which are redundant on the hub that defines the templates. Run steps 1, **3 (canonical dsm-docs/ folder scaffold, idempotent)**, 7, 7b, 8, 8b, 9, 10, 10b, 11, 12, 13. Step 3 is included in the hub fast-path because a Kick-off'd mirror clone is functionally a hub (per DSM_0.2.A §25.4) but arrives with an empty scaffold; Step 3's idempotent check-then-create is a no-op for Central (scaffold already exists) and the missing piece for fresh clones. Step 10b is mandatory on the hub because hub-self-installs the BL-319 hooks (transcript-reminder + validate-transcript-edit) and applies `chmod +x`. Omitting 10b on hub fast-path was the S180 root cause of a full session of zero transcript appends in DSM Central, the hooks were present on disk but not executable, so Claude Code's hook subsystem silently dropped the per-turn reminder injection.

   **External Contribution (EC) fast-path:** If the project is detected as an External Contribution, skip steps 2-6 (spoke scaffold in the current repo), 8c (path validation against spoke structure), and 11 (command sync). Instead, run steps 1, 7, 7b, 8, 8b, 9, 10, 10b, **EC scaffold step (step 3-EC)**, 12, 12a, 13. The EC scaffold step creates governance folders in the external governance repo, not in the current project.

   **EC detection (two-tier):**

   a. **Subsequent runs (alignment section exists):** Read `.claude/CLAUDE.md` alignment section. If EITHER the `**Project type:**` line OR the `**Participation pattern:**` line contains "External Contribution", use EC fast-path directly. Both fields are checked because EC projects may declare their nature in either field: pure EC layouts use Project type, while layered layouts (project IS an application but DSM PARTICIPATES as EC) use Participation pattern. The convention is not enforced; the detector reads both.

   b. **First run (no alignment section):** Use filesystem signals to propose EC type:
      - Has upstream project markers at root: `README.md` AND at least one of (`LICENSE*`, `CONTRIBUTING*`, `CODE_OF_CONDUCT*`)
      - Has `.claude/CLAUDE.md` with an `@` reference to `DSM_0.2_Custom_Instructions_v1.1.md`
      - Does NOT have `dsm-docs/` at project root
      - Does NOT have `scripts/commands/` at project root (not DSM Central)
      If all four conditions are met, propose to the user: "This looks like an External Contribution project (upstream repo with DSM overlay, no dsm-docs/). Confirm? (y/n)". If confirmed, proceed with EC fast-path. If rejected, fall through to standard spoke detection.

   **EC governance folder resolution:**
   1. Read `.claude/dsm-ecosystem.md` for `contributions-docs` path
   2. Derive project name from repo directory: `basename "$(pwd)"`
   3. Governance folder: `{contributions-docs}/{project-name}/`
   4. If `contributions-docs` is missing from ecosystem registry: warn "Cannot resolve governance folder. Add `contributions-docs` entry to `.claude/dsm-ecosystem.md`." and skip EC scaffold step.

   **Origin:** BL-348 (S183). /dsm-align had no EC code path; governance folders were never audited or scaffolded.

2. **Check and fix `_inbox/` at project root:**
   - If `dsm-docs/backlog/` exists: move to `_inbox/` at project root. Send migration confirmation to DSM Central's inbox (`~/dsm-agentic-ai-data-science-methodology/_inbox/{project-name}.md`).
   - If `_inbox/` does not exist: create it. The canonical location is always `_inbox/` at project root; no other path should be used.
   - If `_inbox/done/` does not exist: create it.
   - If `_inbox/README.md` does not exist: create it from the Inbox Template below.

3. **Check and fix each canonical dsm-docs/ folder.** For each folder in the table below:
   a. Check if it exists. If missing, create it.
   b. Check for name collisions (e.g., `plan/` when canonical is `dsm-docs/plans/`, or `docs/checkpoint/` when canonical is `dsm-docs/checkpoints/`). If collision found, **report to user** but do NOT auto-rename.
   c. If the folder should have `done/`: check `done/` exists inside it. Create if missing.
   d. If the folder should have a template file: check if it exists. Create from templates below if missing.

   | Folder | Has done/? | Template file(s) |
   |--------|-----------|-------------------|
   | `dsm-docs/blog/` | Yes | journal.md |
   | `dsm-docs/checkpoints/` | Yes | README.md |
   | `dsm-docs/decisions/` | No | None |
   | `dsm-docs/feedback-to-dsm/` | Yes | README.md |
   | `dsm-docs/guides/` | No | None |
   | `dsm-docs/handoffs/` | Yes | README.md |
   | `dsm-docs/plans/` | Yes | README.md |
   | `dsm-docs/research/` | Yes | README.md |

3a. **Sprint-plan structural audit (BL-378):**

   Audit sprint-plan files in `dsm-docs/plans/` (and `done/`) for DSM_2.0.C
   §1 Template 8 compliance. Detective only: report missing sections as
   warnings in the alignment report; do NOT auto-inject the template and
   do NOT block the alignment run on missing sections.

   **Candidate selection:** `.md` files in `dsm-docs/plans/` or
   `dsm-docs/plans/done/` whose first-line heading matches
   `^#\s+Sprint\s+\d+\b` (e.g., `# Sprint 1: Parser MVP`). Filename patterns
   are not sufficient; header match avoids false positives on BL files
   that happen to discuss sprint work.

   **Required sections per Template 8 (DSM_2.0.C §1):** each candidate
   plan must contain all of these section headings (match on `^##\s+`
   prefix, case-sensitive):

   - `Research Assessment` (or equivalent subsection if merged into
     prerequisites) , soft check; warn if missing but do not block
   - `Deliverables`
   - `Phases`
   - `Phase Boundary Checklist`
   - `Sprint Boundary Checklist` , **hardest to omit, most critical**

   **Soft-match for header-block fields:** `Duration`, `Goal`,
   `Prerequisites` live in the header block (before the first `##`). Check
   their presence by regex on bold labels (e.g., `\*\*Goal:\*\*`). Warn if
   missing.

   **Report format (warning, not error):**

   ```
   Sprint plan {file path} is missing Template 8 sections: {list}.
   See DSM_2.0.C §1 for the canonical structure.
   ```

   **Regex caveats:** sprint plans with non-canonical titles ("MVP Sprint",
   "Sprint Alpha", "Sprint-1") will NOT match the candidate regex. Document
   this limitation; if a project needs non-canonical titles audited, the
   workaround is to add a second heading matching `^#\s+Sprint\s+\d+\b` to
   the file or rename the plan.

   **False-positive guard:** if the candidate file matches the regex but is
   clearly not a sprint plan (e.g., a research file that happens to open
   with "# Sprint 1 retrospective ..."), the audit will still run. The warn
   is informational; users can ignore benign false positives.

   **Complements:** BL-378 pairs this detective audit with a hard gate in
   `/dsm-go` Step 3.6 (the Sprint Boundary Checklist check at session
   start). Together they cover creation-time and closure-time validation of
   plan structure, complementing BL-362/363/364 on the closure/verification
   side.

3-EC. **External Contribution governance scaffold** (EC fast-path only; skip for spokes and hub).

   This step scaffolds the governance folder at `{contributions-docs}/{project-name}/` instead of creating any folders in the external repo. The external repo (upstream) is never touched by this step; DSM artifacts only live in the governance folder.

   **Cross-repo write gate (mandatory):** Before creating any folders, pause and request explicit user confirmation:

   ```
   External Contribution scaffold for {project-name}
   Governance folder: {contributions-docs}/{project-name}/
   Will create (if missing):
     _inbox/ (with done/ and README.md)
     dsm-docs/feedback-to-dsm/ (with done/ and README.md)
     dsm-docs/handoffs/ (with done/ and README.md)
     dsm-docs/checkpoints/ (with done/ and README.md)
     dsm-docs/plans/ (with done/ and README.md)
     dsm-docs/research/ (with done/ and README.md)
     dsm-docs/decisions/
     dsm-docs/blog/ (with done/ and journal.md)
     dsm-docs/guides/

   Proceed? (y/n)
   ```

   Subsequent runs skip the gate if the governance folder already exists and all subfolders are present (idempotent pass-through, no writes).

   **Scaffold steps (after user confirms):**

   a. If governance folder `{contributions-docs}/{project-name}/` does not exist, create it.
   b. For each folder in the standard table above (reused from step 3), check and create inside the governance folder with the same done/ and template file rules. Do NOT create these folders in the external repo.
   c. Report folders created (absolute path prefix = governance folder, not project root).

   **What is NOT done by this step:**
   - No `dsm-docs/`, `_inbox/`, or `.gitattributes` in the external repo
   - No git commit in the governance repo (governance is a separate git repo; commits happen manually or via a future wrap-up protocol)
   - No feedback push (EC feedback lives in the governance folder, not routed back to DSM Central via inbox)

   **Skip conditions:**
   - `contributions-docs` entry is missing from ecosystem registry → warn and skip (reported in step 12)
   - User declines the cross-repo write gate → skip with note "User declined EC scaffold. Run /dsm-align again when ready."

4. **Check feedback file compliance:**
   - `dsm-docs/feedback-to-dsm/` should contain per-session files (`YYYY-MM-DD_sN_backlogs.md`, `YYYY-MM-DD_sN_methodology.md`), `technical.md`, `README.md`, and `done/`
   - If legacy `backlogs.md` or `methodology.md` exist (append-only format), **report as warning**: "Legacy feedback files found (`backlogs.md` / `methodology.md`). Consider migrating to per-session format: split entries into `YYYY-MM-DD_sN_{type}.md` files and move originals to `done/`."
   - If `dsm-docs/feedback-to-dsm/README.md` does not exist, create from Feedback README Template below
   - Do NOT auto-delete or auto-migrate legacy files; report for user action.

5. **Check for consumed handoffs:**
   - List files in `dsm-docs/handoffs/` (excluding `done/` and `.gitkeep`)
   - If any handoff files exist that are NOT from the current session, **report as warning**: "Consumed handoff(s) found outside done/. Run `/dsm-go` to move them, or move manually."
   - Do NOT auto-move; report for user action.

6. **Push unpushed feedback to DSM Central:**
   The DSM Central repo path is the parent directory of the `DSM_0.2_Custom_Instructions_v1.1.md` file referenced by the `@` import in this project's CLAUDE.md. Target: `{dsm-central-path}/_inbox/{this-project-name}.md`.
   a. **Per-session files:** Scan `dsm-docs/feedback-to-dsm/` for files matching `YYYY-MM-DD_sN_backlogs.md` or `YYYY-MM-DD_sN_methodology.md` that are NOT in `done/`. For each ripe file (see DSM_0.2 Session-End Inbox Push ripe criteria), append its content to the inbox file and move the source to `dsm-docs/feedback-to-dsm/done/`.
   b. **Legacy files:** If `dsm-docs/feedback-to-dsm/backlogs.md` or `dsm-docs/feedback-to-dsm/methodology.md` exist with unpushed entries, push using the old `**Pushed:**` marker model.
   c. **Technical progress:** Scan `dsm-docs/feedback-to-dsm/technical.md` for entries without a `**Pushed:**` date. Push using the `**Pushed:**` marker model.
   d. Group all entries under a single inbox entry header:
      ```
      ### [YYYY-MM-DD] Feedback from {project-name}

      **Type:** Methodology Observation
      **Priority:** Medium
      **Source:** {project-name}

      [backlog proposals + methodology scores, grouped by type]
      ```
   e. If no pushable entries exist, skip this step.
   f. Do NOT push entries that lack structure (no problem statement, no score).
   g. Report pushed count in the report.

7. **Validate and fix CLAUDE.md `@` reference:**
   - Read `.claude/CLAUDE.md` (if it exists)
   - Check for an `@` line referencing `DSM_0.2_Custom_Instructions_v1.1.md`
   - **Resolution:** If the `@` reference is missing, stale, or invalid (markdown link, wrong path), resolve the correct path:
     1. Check `.claude/dsm-ecosystem.md` for a `dsm-central` entry
     2. If not available, search common locations: `~/dsm-agentic-ai-data-science-methodology/`
     3. Verify `{dsm-central}/DSM_0.2_Custom_Instructions_v1.1.md` exists
   - **Auto-fix behavior:**
     - If missing entirely: insert `@{dsm-central}/DSM_0.2_Custom_Instructions_v1.1.md` as the first line of CLAUDE.md. Report: "Added `@` reference to DSM_0.2."
     - If present but invalid (markdown link like `[@..](path)`, stale path, Windows path on Linux): replace the invalid line with the correct `@` reference. Report: "Fixed `@` reference to DSM_0.2 (was: `{old line}`)."
     - If valid: report "CLAUDE.md `@` reference OK"
   - If dsm-central cannot be resolved at all: **report as critical warning** and skip alignment (step 7b)

7b. **Check CLAUDE.md alignment section:**
   Requires: Step 7 found a valid `@` reference. If Step 7 reported missing or stale `@`, skip this step.
   - Look for `<!-- BEGIN DSM_0.2 ALIGNMENT -->` and `<!-- END DSM_0.2 ALIGNMENT -->` in `.claude/CLAUDE.md`
   - **If delimiters are missing (first run / migration):**
     a. Detect project type from Step 1
     b. Read the CLAUDE.md Alignment Template System section in DSM_0.2 (follow the `@` reference to find it)
     c. Generate the aligned section from the base template + project-type-specific additions.
        **Critical:** Copy the template text EXACTLY as written in DSM_0.2 §17.1, including the numbered heading `## 1. DSM_0.2 Alignment (managed by /dsm-align)`. Do not paraphrase, shorten, or renumber headings.
     d. Identify where project-specific content starts in the current CLAUDE.md (first heading after the `@` reference line, or end of file)
     e. Insert the delimiters and aligned content between the `@` reference and the project-specific content
     f. Report: "CLAUDE.md alignment section added. [N] lines of managed content inserted."
     g. The user reviews and approves via the IDE permission window (Gate 2)
   - **If delimiters are present (subsequent runs):**
     a. Extract content between delimiters
     b. Generate the expected content from the current template for the detected project type
     c. Compare extracted vs expected
     d. If identical: report "CLAUDE.md alignment: OK (up to date)"
     e. If different: report drift with specific lines that differ. Offer: "Regenerate aligned section? (This preserves all content outside the delimiters.)"
     f. If user accepts: replace content between delimiters with current template
   - **Validation-only mode:** If the user invoked `/dsm-align` with a `--check` argument or equivalent, report drift without modifying files

8. **CLAUDE.md content validation (DSM_0.2 §17.2):**
   - Using the project type from step 1, scan the project-specific sections of `.claude/CLAUDE.md` (content outside the alignment delimiters) for type mismatches.
   - Flag sections referencing workflows the project does not use (e.g., Notebook Development Protocol in a Documentation project, App Development Protocol in a Data Science project).
   - Skip insurance sections: Destructive Command Protocol, Secret Exposure Prevention, Plan Mode Protocol, Branching Strategy.
   - Report mismatches as warnings: "CLAUDE.md contains [section] not typical for [project type]. Consider removing to save context budget."
   - Do not auto-remove; the user decides.

8b. **CLAUDE.md redundancy scan:**
   - Read the project-specific content of `.claude/CLAUDE.md` (content OUTSIDE the alignment delimiters)
   - For each project-specific section (identified by `##` or `###` headings):
     a. Compare its content against DSM_0.2 core sections (§5-25, loaded via `@` reference). Look for near-verbatim matches (3+ consecutive lines that match a DSM_0.2 section).
     b. Compare against the alignment template content (inside the delimiters). Look for sections that duplicate what the template already provides.
   - Report redundancies as warnings: "Section `[name]` appears redundant with DSM_0.2 §[N] ([section name]). The @ reference already loads this. Remove to save context budget?"
   - Skip insurance sections (Destructive Command Protocol, Secret Exposure Prevention, Branching Strategy) even if they duplicate DSM_0.2, these are intentional reinforcement.
   - Do NOT auto-remove; the user decides.
   - This scan catches: verbatim copies of DSM_0.2 protocols, project-specific sections made redundant by template promotions, and accumulated instructions that duplicate always-loaded content.

8c. **Validate CLAUDE.md path references:**
   - Read the project-specific content of `.claude/CLAUDE.md` (content OUTSIDE the `<!-- BEGIN/END DSM_0.2 ALIGNMENT -->` delimiters)
   - Extract all backtick-quoted strings that look like file or folder paths (contain `/`, do not contain `://`)
   - Skip paths inside fenced code blocks (``` or ~~~)
   - Skip DSM document references (e.g., `DSM_0.2 §17`)
   - Skip paths that are clearly template placeholders (contain `{` or `}`)
   - Skip strings starting with `/` followed by a lowercase letter (slash commands like `/dsm-go`)
   - Skip strings containing `*` (glob patterns like `*.md`, `dsm-docs/blog/*.md`)
   - Skip strings containing spaces (command invocations like `python scripts/...`, not file paths)
   - For each candidate path, check if it exists relative to the project root
   - Report stale paths as warnings: "CLAUDE.md references `{path}` which does not exist. Update or remove?"
   - Include the surrounding line for context so the user can decide
   - Do NOT auto-fix; paths may be intentional examples or refer to external locations

9. **Check `.gitattributes`:**
   - If `.gitattributes` does not exist at project root: create it with the template below.
   - If it exists: check that it contains `* text=auto eol=lf`. If missing, **report as warning**: "`.gitattributes` exists but does not enforce LF line endings. CRLF can break the Edit tool on WSL."
   - Report result in the summary.

10. **Check .claude/ files:**
   - If `.claude/session-transcript.md` does not exist: create it (empty file).
   - If `.claude/dsm-ecosystem.md` does not exist: create it from the Ecosystem Pointers Template below. Resolve `dsm-central` path from the `@` reference in `.claude/CLAUDE.md`. Then read DSM Central's ecosystem registry (`{dsm-central}/.claude/dsm-ecosystem.md`) and copy the `portfolio` path from it. If DSM Central's registry does not exist or has no portfolio entry, leave as placeholder. Report: "Created `.claude/dsm-ecosystem.md` with ecosystem pointers."
   - If `.claude/reasoning-lessons.md` does not exist: create it from the Reasoning Lessons Template below. Report: "Created `.claude/reasoning-lessons.md` (empty scaffold for per-session lessons)."
   - If `.claude/reasoning-lessons.md` exists but is empty (zero bytes) or missing the `# Reasoning Lessons` header on line 1: prepend the template header without touching any existing content below. Report: "Added missing header to `.claude/reasoning-lessons.md`."
   - Otherwise leave the file untouched.

10b. **Install session-transcript hooks (BL-319):**
   Deliver the per-turn transcript append hook and the append-only edit validator to the project's `.claude/hooks/` and wire them into `.claude/settings.json`. Single source of truth: Central's own `.claude/hooks/*.sh` scripts. The hook entries come from `{dsm-central}/scripts/templates/settings-hooks.json`.

   **Applies to all project types, including DSM Central itself** (Central's `.claude/settings.json` is gitignored and must stay aligned with the template it ships).

   Skip only if: (a) `dsm-central` path cannot be resolved (no `.claude/dsm-ecosystem.md` and fallback resolution failed), OR (b) the resolved `dsm-central` path does not contain `.claude/hooks/transcript-reminder.sh` (source missing — warn loudly and skip).

   **Sub-steps:**

   a. **Resolve Central path.** Read `dsm-central` from `.claude/dsm-ecosystem.md`. If the project IS Central, use `.` (the current project root).

   b. **Copy hook scripts.** For each file in `{dsm-central}/.claude/hooks/*.sh`:
      - Compute destination: `./.claude/hooks/{basename}`
      - Create `./.claude/hooks/` if missing
      - If destination missing OR byte-differs from source: copy with `cp`, then `chmod +x`
      - If destination exists and is byte-identical: skip the copy but **still apply `chmod +x`** to the destination. Edit/Write tools strip the executable bit when rewriting files, so re-chmod every run is the only reliable way to recover from past stripping. Per S180 root cause: hooks were present and byte-identical to source but not executable, and the OS silently refused to run them.
      - Track counters: `hooks_installed`, `hooks_updated`, `hooks_already_ok`
      - Self-copy guard: if source and destination resolve to the same file (Central running on itself), skip the copy but still count as `already_ok`

   c. **Read hooks template.** Read `{dsm-central}/scripts/templates/settings-hooks.json`. Parse as JSON. Extract the `hooks` object.

   d. **Read or create settings.json.** Read `./.claude/settings.json`. If missing, initialize as:
      ```json
      { "permissions": { "allow": [], "deny": [] }, "hooks": {} }
      ```
      If present but invalid JSON, warn and skip the merge (do not clobber a broken-but-possibly-recoverable file).

   e. **Merge hook entries idempotently.** For each top-level hook event in the template (`PreToolUse`, `UserPromptSubmit`, etc.):
      - Ensure `settings.hooks[event]` exists as a list
      - For each entry in `template.hooks[event]`:
        - Extract the set of `command` values from the entry's `hooks[*].command` field
        - Scan existing `settings.hooks[event][*].hooks[*].command` for any of those values
        - If ANY command from the template entry is already present in `settings.hooks[event]`, skip appending this entry (idempotency: match on command, not object equality)
        - Otherwise, append the entry as-is
      - Track: `settings_merged` (true if any entry was appended), `settings_already_ok` (true if all template entries were already present)
      - **Never** remove or modify entries that did not come from the template; preserve user-added hooks, permissions, and all other fields

   f. **Write settings.json.** If merge changed anything, write back pretty-printed (2-space indent). Otherwise leave the file untouched.

   g. **Report in step 12:** add one line under `CLAUDE.md paths`:
      `Transcript hooks: [hooks_installed installed / hooks_updated updated / hooks_already_ok ok] · settings.json: [merged | already ok | created | skipped: reason]`

   **Implementation note for the agent executing this step:** use Python for JSON manipulation (stdlib only, no jq dependency):
   ```bash
   python3 - << 'PY'
   import json, os, shutil, stat, sys
   # sub-steps b-f implemented as pure Python
   PY
   ```
   The step is idempotent by construction: the second run sees byte-identical hooks and matched commands, so it reports `already_ok` on everything with zero file writes.

   **Origin:** BL-319. Closes the gap between DSM_0.2 §7 per-turn enforcement docs (shipped v1.4.9) and the hook mechanism that enforces them (previously local-only in each Central instance). Evidence: portfolio S69 and blog-poster S17 both ran with zero transcript appends because the hook was absent.

11. **Check command file drift (DSM Central only):**
   - Skip this step if the project is not DSM Central (no `scripts/commands/` directory).
   - For each `.md` file in `scripts/commands/`:
     - Determine the expected runtime location: check both `~/.claude/commands/{filename}` (user-level) and `.claude/commands/{filename}` (project-level). A command is deployed if it exists in **either** location.
     - Compare the tracked source against each existing runtime copy using `diff -q`
     - If identical in at least one location: count as OK
     - If different in all locations where it exists: **report as warning**: "Command {name} has drifted from tracked source. Review and resolve: update tracked source or run `scripts/sync-commands.sh --deploy`."
     - If runtime copy missing from both locations: **report as warning**: "Command {name} exists in tracked source but not deployed. Run `scripts/sync-commands.sh --deploy` to install."
   - Report drift summary in the report.
   - Reference: BACKLOG-130 (Command File Version Tracking)

12. **Report** results in this format. The report header indicates whether changes were applied:
   - **Post-change report** (when any fixes were applied: folders created, `@` reference fixed, alignment section regenerated, files created): header reads `/dsm-align post-change report:` and all items reflect the **completed state**, not the pre-change assessment.
   - **Check-only report** (when no changes were needed, all items already correct): header reads `/dsm-align check-only report:`

   ```
   /dsm-align [post-change|check-only] report:
   - Project type: [detected type]
   - Created: [list of folders and files created, or "none"]
   - Already correct: [count of items that needed no changes]
   - Fixed: [list of repairs made, or "none"]
   - Collisions: [list of naming conflicts for user to resolve, or "none"]
   - Warnings: [feedback file violations, consumed handoffs, or "none"]
   - CLAUDE.md alignment: [OK | Added (N lines) | Drift detected (N lines differ) | Skipped (no @ reference)]
   - CLAUDE.md content: [OK | N mismatches found (list sections)]
   - CLAUDE.md redundancy: [OK | N redundant section(s) found (list)]
   - CLAUDE.md paths: [OK | N stale path(s) found (list)]
   - .gitattributes: [OK | Created | Warning: missing LF enforcement | N/A (EC fast-path)]
   - Command sync: [OK: N | Drifted: N | Missing: N, or "N/A (not DSM Central)"]
   - Feedback pushed: [count of entries pushed to DSM Central, or "none pending"]
   - EC governance scaffold: [N/A (not EC) | OK (all folders present) | Created (list) | Skipped (reason)]
   ```

12a. **Write persistent alignment report:** After printing the report to conversation, write the full report to `.claude/last-align-report.md` (gitignored, overwritten each run). This is the durable audit record so the user, or a future session, can read what the last alignment found without re-running the skill.

   The persistent file contains a header block followed by the verbatim step-12 report and explicit detail subsections:

   ```markdown
   # /dsm-align persistent report

   **Timestamp:** {ISO 8601 with timezone}
   **DSM version:** vX.Y.Z (from {dsm-central}/CHANGELOG.md latest heading)
   **Run mode:** post-change | check-only
   **Project:** {project name}
   **Project type:** {detected type}

   ---

   ## Report

   {verbatim copy of the step-12 report block printed to conversation}

   ## Warnings (full text)

   {For each warning surfaced during the run, the full warning text as it would have appeared in conversation. If none, write "None."}

   1. {warning 1 full text}
   2. {warning 2 full text}
   ...

   ## Collisions (full text)

   {For each collision, the full collision text. If none, write "None."}

   ## Already correct

   {Bulleted list of items that were checked and needed no action: folders present, template files present, `@` reference valid, alignment section in sync, .gitattributes correct, etc. This is the "what was checked" view so the user knows the run did not silently skip checks.}

   ## Steps skipped

   {Bulleted list of steps that were not executed and the reason. Examples:
   - Step 11 skipped: not DSM Central
   - Steps 2-6, 8c skipped: hub fast-path (DSM Central)
   - Step 7b skipped: no valid @ reference (Step 7 reported missing)}
   ```

   - Write on **every** run, both post-change and check-only. Idempotence: if nothing changed between runs, the report content (excluding the timestamp line) is identical.
   - The file is gitignored via the existing `.claude/` rule; no `.gitignore` change required.
   - This step is mandatory; it must not be skipped even when the conversation report is short.

12b. **Write inbox notification (post-change OR check-only with warnings):** Write an entry to the project's own `_inbox/` summarizing the alignment outcome. Trigger conditions:
   - **Post-change run** (any fixes were applied), OR
   - **Check-only run** with warnings or collisions present

   Skip only when the run was check-only AND no warnings AND no collisions (the truly clean case).
   - Target: `_inbox/{YYYY-MM-DD}_dsm-align-update.md`
   - Format:
     ```markdown
     ### [YYYY-MM-DD] /dsm-align: {alignment updated | warnings present}

     **Type:** Notification
     **Priority:** {Low for post-change, Medium if warnings/collisions present}
     **Source:** /dsm-align

     Run mode: {post-change | check-only}
     Full report: `.claude/last-align-report.md`

     Summary:
     - Created: [...]
     - Fixed: [...]
     - Warnings: [count] (see persistent report for full text)
     - Collisions: [count] (see persistent report for full text)
     ```
   - The notification references `.claude/last-align-report.md` rather than duplicating its contents; the persistent file is the source of truth for what was found.
   - If `_inbox/` does not exist (External Contribution projects), skip this step silently.

13. **Write status marker (with spoke-action surfacing):** Before writing, read the existing `.claude/last-align.txt` to capture the previous `dsm-version` value. Then resolve the current DSM version from `{dsm-central}/CHANGELOG.md` (latest `## [vX.Y.Z]` heading). Compare old vs new version:

   **If versions differ (or no previous marker exists):**
   1. Read CHANGELOG entries between the old and new versions
   2. Extract lines matching `**Spoke action:**`
   3. If spoke actions found, surface to user: "DSM updated from vX.Y.Z to vA.B.C. Spoke actions required: [list]"
   4. Auto-execute by annotation type:
      - `Run /dsm-align`: Already running (this is /dsm-align). Report: "Template change applied by this alignment run."
      - `Review [section]`: Surface as action item for the user.
      - `Update [file]`: Surface as action item for the user.
   5. If no spoke actions found, report the version change without action prompts

   **If versions match:** Skip spoke-action surfacing.

   **Then write** `.claude/last-align.txt` (gitignored, local state):
   ```
   # Last /dsm-align run
   date: YYYY-MM-DD
   dsm-version: vX.Y.Z
   result: pass | warnings | critical
   warnings: N
   critical: N
   ```
   - `result` is `pass` if no warnings or critical issues, `warnings` if only warnings, `critical` if any critical issues were found
   - `dsm-version`: CHANGELOG is the source of truth for version numbers; do not guess or use other files

   **Origin (BL-338):** Previously, spoke-action surfacing lived in `/dsm-go` Step 2c, which read `last-align.txt` after `/dsm-align` Step 13 had already overwritten it. The old version was lost, so 2c always saw "versions match" and never surfaced spoke actions. Moving surfacing into Step 13 (read-before-write) fixes the ordering bug.

## Templates

### Inbox Template (`_inbox/README.md`)

```markdown
# Project Inbox

Transit point for hub-spoke communication. Entries arrive, get processed, and
are removed. Reference: DSM_3 Section 6.4.

## Entry Template

### [YYYY-MM-DD] Entry title

**Type:** Backlog Proposal | Methodology Observation | Action Item | Notification
**Priority:** High | Medium | Low
**Source:** [project name or "DSM Central"]

[Description: problem statement, proposed solution, or action requested]
```

### Git Attributes Template (`.gitattributes`)

```
# Enforce LF line endings for all text files.
# Prevents CRLF issues on WSL that break the Edit tool.
* text=auto eol=lf
```

### Blog Journal Template (`dsm-docs/blog/journal.md`)

```markdown
# Blog Journal

Append-only capture file for blog-worthy observations. Entries accumulate
across sessions and are extracted into materials files at project/epoch end.
Reference: DSM_0.1 Blog Artifacts (three-document pipeline).

## Entry Template

### [YYYY-MM-DD] {Title}
{Observation, story, pattern, or insight}
```

### Feedback README Template (`dsm-docs/feedback-to-dsm/README.md`)

```markdown
# DSM Feedback

Per-session feedback files with a lifecycle. Each session creates its own
file(s); processed files move to `done/`.

## File Types

| File pattern | Content | Lifecycle |
|-------------|---------|-----------|
| `YYYY-MM-DD_sN_backlogs.md` | Backlog proposals for DSM | Per-session -> done/ |
| `YYYY-MM-DD_sN_methodology.md` | Methodology effectiveness scores | Per-session -> done/ |
| `technical.md` | Technical progress reports | Append-only + Pushed marker |

## Lifecycle

1. **Create:** Agent writes feedback during session
2. **Notify:** At wrap-up, inbox notification to DSM Central references the file
3. **Process:** DSM Central reads and acts on the feedback
4. **Done:** Processed file moves to `done/`

Only create a file when there is feedback to record. No empty files.
Reference: DSM_0.2 DSM Feedback Tracking.
```

### Checkpoints README Template (`dsm-docs/checkpoints/README.md`)

```markdown
# Checkpoints

Milestone snapshots with detailed context (rationale, session state, next steps).
Consumed at next session start and moved to `done/`.
Reference: DSM_0.2 (via /dsm-go Step 3.5).

## Naming

`YYYY-MM-DD_vX.Y.Z_release_checkpoint.md` or `YYYY-MM-DD_sN_{description}.md`
```

### Handoffs README Template (`dsm-docs/handoffs/README.md`)

```markdown
# Handoffs

Session-end resumption documents. Created when a session has complex pending
work that the next session needs to continue. Consumed at next session start
and moved to `done/`.
Reference: DSM_0.2 (via /dsm-go Step 3).

## Naming

`YYYY-MM-DD_{description}.md` or `YYYY-MM-DD_sN_{description}.md`
```

### Plans README Template (`dsm-docs/plans/README.md`)

```markdown
# DSM Backlog and Plans

Active backlog items and project plans. Completed items move to `done/`.

**Format:** `BACKLOG-###_short-description.md`
**Required fields:** Status, Priority (High/Medium/Low), Date Created, Origin, Author

| BL# | Title | Priority |
|-----|-------|----------|
```

### Research README Template (`dsm-docs/research/README.md`)

```markdown
# Research

Research files from Phase 0.5 and ad-hoc research. Processed research moves
to `done/` after findings are integrated into the target outcome.
Reference: DSM_0.2 Module D (Phase 0.5: Research and Grounding).

## Naming

`YYYY-MM-DD_{topic}_research.md`

## Lifecycle

1. Create during research phase with standard header (Purpose, Target Outcome, Status)
2. Integrate findings into sprint plan or deliverables
3. Move to `done/` with Status: Done and Date Completed
```

### Reasoning Lessons Template (`.claude/reasoning-lessons.md`)

```markdown
# Reasoning Lessons

Per-session lessons extracted from session transcripts. Appended by
the wrap-up skill at each session end. See DSM_0.2 Module A Reasoning
Lessons Protocol for the extraction rules.

Categories: [pattern], [ecosystem], [infrastructure], [skill], [methodology]
```

### Ecosystem Pointers Template (`.claude/dsm-ecosystem.md`)

```markdown
# DSM Ecosystem Path Registry

Local configuration mapping logical ecosystem names to filesystem paths.
This file is gitignored and instance-specific.

## Paths

| Name | Path | Description | Mirror |
|------|------|-------------|--------|
| dsm-central | {resolved from @ reference} | Hub repository | - |
| portfolio | {resolved from dsm-central registry, or UPDATE THIS PATH} | Portfolio project | - |
```

## Notes

- This skill is idempotent: running it multiple times produces the same result
- Name collisions are reported, not auto-fixed, because the user may have intentional naming
- The canonical folder list comes from DSM_0.1 (Canonical Spoke Folder Names section)
- This skill absorbs the former `/dsm-feedback` functionality (feedback template creation)
- Reference: DSM_0.1, DSM_0.2 Session-Start Inbox Check, DSM_3 Section 6.4
