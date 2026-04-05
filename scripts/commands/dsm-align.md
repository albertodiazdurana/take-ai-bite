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

1. **Detect project type** using DSM_0.2 Project Type Detection table:
   - `notebooks/` only, no `src/` → Data Science (DSM 1.0)
   - `src/`, `tests/`, `app.py` → Application (DSM 4.0)
   - Both `notebooks/` and `src/` → Hybrid
   - `dsm-docs/`, markdown-only, no `notebooks/` or `src/` → Documentation (DSM 5.0)
   - `contributions-docs/{project}/` in DSM Central → External Contribution (DSM_3 Section 6.6)
   State the detected type.

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

11. **Check command file drift (DSM Central only):**
   - Skip this step if the project is not DSM Central (no `scripts/commands/` directory).
   - For each `.md` file in `scripts/commands/`:
     - Compare against `~/.claude/commands/{same filename}` using `diff -q`
     - If identical: count as OK
     - If different: **report as warning**: "Command {name} has drifted from tracked source. Review and resolve: update tracked source or run `scripts/sync-commands.sh --deploy`."
     - If runtime copy missing: **report as warning**: "Command {name} exists in tracked source but not in ~/.claude/commands/. Run `scripts/sync-commands.sh --deploy` to install."
   - Report drift summary in the report.
   - Reference: BACKLOG-130 (Command File Version Tracking)

12. **Report** results in this format:
   ```
   /dsm-align report:
   - Project type: [detected type]
   - Created: [list of folders and files created]
   - Already correct: [count of items that needed no changes]
   - Fixed: [list of repairs made]
   - Collisions: [list of naming conflicts for user to resolve, or "none"]
   - Warnings: [feedback file violations, consumed handoffs, or "none"]
   - CLAUDE.md alignment: [OK | Added (N lines) | Drift detected (N lines differ) | Skipped (no @ reference)]
   - CLAUDE.md content: [OK | N mismatches found (list sections)]
   - CLAUDE.md redundancy: [OK | N redundant section(s) found (list)]
   - CLAUDE.md paths: [OK | N stale path(s) found (list)]
   - .gitattributes: [OK | Created | Warning: missing LF enforcement]
   - Command sync: [OK: N | Drifted: N | Missing: N, or "N/A (not DSM Central)"]
   - Feedback pushed: [count of entries pushed to DSM Central, or "none pending"]
   ```

13. **Write status marker:** Write `.claude/last-align.txt` (gitignored, local state) with the alignment result. This replaces the previous persist-to-decisions approach; the full report is shown in conversation text and does not need a durable file.
   ```
   # Last /dsm-align run
   date: YYYY-MM-DD
   dsm-version: vX.Y.Z
   result: pass | warnings | critical
   warnings: N
   critical: N
   ```
   - `result` is `pass` if no warnings or critical issues, `warnings` if only warnings, `critical` if any critical issues were found
   - `dsm-version` is read from DSM Central's CHANGELOG or DSM_0.0 header (the version at the time of alignment)
   - `/dsm-go` reads this marker to detect stale alignment (version mismatch or missing marker)

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
