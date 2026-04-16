# Changelog

All notable changes to the Deliberate Systematic Methodology (DSM) will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.5.1] - 2026-04-16

### Added - Git-mv rename-staging warning hook (BL-370)

- **BL-370: `.claude/hooks/validate-rename-staging.sh` pre-commit warning hook.** New PreToolUse:Bash hook catches the recurring pattern where Edit-tool or `sed -i` content changes made before `git mv` get dropped from the commit because `git mv` does not auto-restage prior content deltas. Three sightings in DSM Central (S184 BL-349, S190 IronCalc inbox move, S191 `/dsm-light-go` checkpoint annotation) forced the "file a BL" threshold per MEMORY.md convention. The hook filters to `git commit` calls, parses `git diff --cached --name-status` for R-typed renames, and for each renamed new-path checks whether the working tree differs from the staged content. If yes, blocks with exit 2 and emits clear bypass instructions (`git add <path>` to stage the content, or `git commit --no-verify` for intentional rename-first workflows). Silent (exit 0) when no renames are staged or all content is staged. MEMORY pitfall entry updated to reference BL-370 as the enforcement mechanism.
  - **Spoke action:** Run `/dsm-align` on next `/dsm-go` to install the new hook (Step 10b copies the script to `.claude/hooks/` and merges the `PreToolUse:Bash` entry into `.claude/settings.json`). Cloned mirrors get it pre-wired via `.claude/settings.json.template`.

### Spawned

- None.

## [1.5.0] - 2026-04-16

### Added - Cloned-Mirror Kick-off Protocol (S191)

- **BL-372: Cloned-Mirror Kick-off Protocol (DSM_0.2.A §25) and `/dsm-go` Step 0.8 integration.** Fresh clones of public DSM mirrors (Take-AI-Bite and any downstream fork) now bootstrap into a functional session state automatically on first `/dsm-go`. New DSM_0.2.A §25 defines the 14-step Kick-off sequence with zero user prompts: all runtime values (`{REPO_ROOT}`, `{project_name}`, `{ISO_DATE}`) auto-derive from `pwd`/`basename`/`date`. Kick-off copies 5 shipped `.claude/*.template` files (CLAUDE.md, settings.json, dsm-ecosystem.md, reasoning-lessons.md, skills-registry.md) to runtime paths with placeholder substitution, self-registers the clone as `dsm-central` in its own ecosystem registry (so the clone is its own self-rooted hub), deploys slash commands via `sync-commands.sh --deploy`, `chmod +x`'s the hooks, and writes `.claude/kickoff-done.txt` to prevent re-running on subsequent sessions. Anti-requirements (§25.3) are symmetric: no personal-content **copy** and no personal-content **collection** (GitHub identity is already implicit via `git remote -v`; LinkedIn / author attribution is added manually post-Kick-off if desired). `/dsm-go` Step 0.8 (new step between 0.5 and 0) detects cloned-mirror state, invokes Kick-off, and passes through otherwise. Skip conditions prevent Kick-off from firing on Central (detection: `scripts/take-ai-bite-sync.txt` presence), spokes (detection: `dsm-central` points to DIFFERENT filesystem path), and already-Kick-off'd clones (marker check).
  - **Spoke action:** Run `/dsm-align` on next `/dsm-go` to pick up the §25 protocol and Step 0.8 integration via the `@` reference chain. Mirror clones of TAB on first `/dsm-go` after v1.5.0 will auto-bootstrap.
- **BL-372: `scripts/take-ai-bite-sync.txt` expanded from 15 to 69 entries.** Previously the sync list had decayed, omitting ~30 load-bearing files (DSM_0.2 + modules A/B/C/D, DSM_3.0 + modules A-F, DSM_6.1 + modules, all `scripts/commands/*.md`, `dsm-docs/guides/`, `FEATURES.md`, `README.md`, `.claude/hooks/*.sh`). Step 9 of `/dsm-version-update` syncs *existing* list entries but never *adds* new ones, so the list silently drifted as Central expanded. Expansion adds all missing methodology modules, all 18 slash commands, both per-turn transcript hooks, five new `.claude/*.template` files, `.gitignore`, `.gitattributes`, `_inbox/README.md`, and the scanner/deploy scripts.
  - **Spoke action:** None. This is a Central-only tooling change; TAB receives the expanded payload on next mirror sync.
- **BL-372: Change Propagation Protocol impact table (`.claude/CLAUDE.md`) extended with three rows** for `.claude/hooks/*.sh`, `.claude/*.template`, and repo-level scaffolding (`.gitignore`, `.gitattributes`, `_inbox/README.md`) mirror-sync propagation.
  - **Spoke action:** None. This is a Central-only documentation update.
- **BL-372: `scripts/commands/dsm-backlog.md` template author field replaced with `{author}` placeholder.** Removes scanner noise flagged in each future mirror sync (previously the command file hit `\balberto\b` on every sync run). Command files are templates used across projects and users; the author slot should be a placeholder substituted per-project, not a literal personal name.
  - **Spoke action:** None. Template output unchanged for users; scanner noise eliminated.
- **BL-372: `scripts/sync-take-ai-bite.sh` creates missing parent directories before `cp`.** Fix for sync failure when a target file's parent directory does not yet exist on the mirror (e.g., `.claude/hooks/` on a TAB without prior hook shipping). Idempotent.
  - **Spoke action:** None. Central-only tooling fix.
- **BL-372: `/dsm-align` Hub fast-path now runs Step 3 (canonical `dsm-docs/` folder scaffold).** Fixes the integration gap discovered during T7 behavioral verification where Kick-off §25.2 step 12 delegated folder scaffolding to `/dsm-align` Step 3, but `/dsm-align`'s Hub fast-path skipped Step 3 entirely. Since Kick-off'd clones are functionally hubs per §25.4, the hub fast-path fired and the scaffold was never created. Step 3 is idempotent, so no-op for existing hubs with complete scaffold and creates missing folders for fresh clones.
  - **Spoke action:** Run `/dsm-align` on next `/dsm-go` to pick up the updated hub fast-path behavior. Already-Kick-off'd clones with manual-intervention scaffolds need no action.

### Spawned

- **BACKLOG-373** (to be filed): Cloned-Mirror Kick-off follow-up findings from T7. Scope: F1 (`sync-commands.sh` should `mkdir -p $USER_TARGET` before existence check), F2 (ship `.claude/commands/*.md` tracked in mirror clones to eliminate bash dependency on first run), F3 (`/dsm-go` Step 0a session-number formula should consider remote `session-*` branches for mirror-with-prior-history cases).

## [1.4.18] - 2026-04-13

### Added - Infrastructure File Collaboration Protocol, "We Need to Talk" Principle, MEMORY.md Budget Optimization (S187)

- **BL-343: Infrastructure File Collaboration Protocol (DSM_0.2.B §8) and Skill File Structural Standard.** New protocol for collaboratively modifying infrastructure files (skills, hooks, settings.json, command files) with explicit review requirements. Addresses the Gate 2 auto-approve bypass gap for high-blast-radius files (S182 incident). Six subsections: scope definition, review requirements (one logical change per Edit, explain behavioral impact), allowed-tools governance, hook type selection criteria, skill-scoped hook interaction rules, structural standard reference. Companion guide at `dsm-docs/guides/skill-file-structural-standard.md` with SKILL.md template (12 frontmatter fields), command file format (legacy), hook script conventions, line budgets (~200 lines, 5K token compaction), and commands-to-skills migration path. Dispatch table updated in DSM_0.2 core §25.
  - **Spoke action:** Review DSM_0.2.B §8 for behavioral changes. The new protocol applies immediately via the `@` reference chain.
- **BL-346: "We Need to Talk" foundational principle (DSM_6.0 §1.10).** New principle establishing that the conversation defining work IS the collaboration, not a preamble to it. Presenting a pre-formed plan for yes/no approval reduces the human from collaborator to approver. Gate 0 (DSM_0.2 §8.0) is the operational implementation. Cross-reference added from §8.0 back to the principle. Protocol mapping row added to DSM_6.0 §2.1 Building table.
  - **Spoke action:** Review DSM_6.0 §1.10 for the new foundational principle. No template regeneration needed.
- **BL-356: MEMORY.md Budget Optimization in /dsm-wrap-up step 2.** Explicit exclusion list (inbox state, git-recoverable details, STAA flags, pre-session uncommitted). Pending list staleness check: items carried 3+ sessions get promoted to BL or dropped. Latest Session target ≤15 lines, Pending target ≤8 items.
  - **Spoke action:** Run `scripts/sync-commands.sh --deploy` to update the deployed `/dsm-wrap-up` skill file with the new MEMORY.md rules.

### Spawned

- BL-355 (Medium): Deep research on 6 external repos for DSM and Graph Explorer relevance. Executed by parallel session 187.1.

## [1.4.17] - 2026-04-12

### Added - DSM_0.2 §7 STAA Exception + Skill Rationale Clarification (S185)

- **BL-351: DSM_0.2 §7 authorized exception for `/dsm-staa` and `dsm-staa.md` recursion rationale clarification.** S185 ran `/dsm-staa` on the archived S184 transcript in a separate Claude Code conversation. The STAA agent quoted its own thinking to the user: "Appending analysis notes to S184 while I'm analyzing S184 would create exactly the kind of infinite recursion the skill is designed to prevent. The transcript I'm about to examine would be corrupted by my own notes about examining it." The STAA agent's final behavior (no transcript write) was correct but the stated rationale was wrong, archived subject and live reasoning log are two different files, and writes to the live log cannot corrupt the archived subject. Three bugs identified: (1) DSM_0.2 §7 unconditional-activation language did not acknowledge `/dsm-staa` as an authorized exception, so every STAA session had to re-derive the resolution from first principles, (2) `scripts/commands/dsm-staa.md` line 30 parenthetical "avoids infinite recursion of analyzing analysis transcripts" was compressed to the point of allowing the wrong (file-corruption) interpretation when the actual concern is meta-recursion of STAA sessions becoming future STAA subjects, (3) the `UserPromptSubmit` per-turn reminder hook fires in STAA sessions with no skill-awareness, forcing every STAA agent to argue against the hook. Bugs 1+2 fixed in this BL; Bug 3 deferred to BL-343 (Skill/Hook Collaboration Protocol). DSM_0.2 §7 gains an "Authorized exception: `/dsm-staa` (BL-351)" paragraph immediately after the BL-331 unconditional-activation paragraph, naming STAA as the sole exception, stating the meta-recursion rationale precisely, naming both files explicitly to prevent the subject-vs-live-log confusion, and forbidding any other skill from suppressing the protocol without an explicit §7 amendment. `scripts/commands/dsm-staa.md` gains a "Two files, do not confuse them" block after the IMPORTANT line (archived subject read-only vs live reasoning log not written for meta-recursion reasons) and a per-turn hook-reminder acknowledgment ("do not argue the hook into silence, acknowledge once, proceed"). Line 30 bullet rewritten to point at the IMPORTANT block instead of re-deriving the rationale.
  - **Spoke action:** Review DSM_0.2 §7 for behavioral changes. The new authorized-exception paragraph applies immediately via the `@` reference chain; no template regeneration needed.
  - **Spoke action:** Run `scripts/sync-commands.sh --deploy` to update the deployed `/dsm-staa` skill file with the new "Two files" block. External Contribution spokes pick up the new prose on next session start via the deployed command file.

### Spawned

- BL-352 (Medium): Preemptive Risk Definition required for all BLs. User request in S185 during BL-351 review: formalize "all BLs should include a Risks section" as a template rule. Filed with scope deliberately loose (rule home uncertain, minimal vs structured format undecided, enforcement level unset) and implementation deferred to a future session. First compliant example of the rule itself: BL-352 includes a Risks section covering 7 failure modes. BL-351 was retrofitted with a Risks section on the same branch before merge as a second compliant example.

## [1.4.16] - 2026-04-11

### Added - §22 Stop Condition + /dsm-go EC Inbox Resolution (S184)

- **BL-350: DSM_0.2 §22 stop-condition amendment for protocol violations.** §22 Protocol Violation Triage Response previously said the three-step response (Fix + Root-cause + Prevent) runs "before continuing other work". In blog-poster S19 that phrasing was soft enough that the agent acknowledged a CLAUDE.md violation mid-paragraph, flagged it as an inline disclaimer, and then continued presenting BL-010 angle rankings built on unread sources. The user had to escalate ("this is unacceptable") to halt the output. §22 now has three additions: (a) a bridging clause on the opening paragraph ("The current output-in-progress counts as other work; see the stop condition below"), (b) a new Stop Condition paragraph with four explicit actions (name the violation, halt without completing, propose corrective action, wait for user confirmation before resuming), and (c) a new Anti-pattern paragraph stating that acknowledging a violation as a footnote while continuing the same output is itself a §22 failure. Cross-reference to DSM_6.0 Earn Your Assertions as the source principle. Origin inline: blog-poster S19 incident. Flat structure preserved, no new subsections, cross-references stable.
  - **Spoke action:** Review DSM_0.2 §22 for behavioral changes. The stop condition applies immediately on next session start via the `@` reference chain, no template regeneration or command re-deploy needed.

- **BL-349: /dsm-go EC governance inbox check.** `/dsm-go` Step 2b previously *declared* that the External Contribution inbox lives at `contributions-docs/{project}/_inbox/` but gave no resolution or check instructions; the `ls` command and resolution path were both implicit. Result: inbox entries delivered to the EC governance folder (e.g., `~/dsm-external-contribution-storage/IronCalc/_inbox/`) were invisible to `/dsm-go`, the user had to manually point the agent at them each session. Dependency follow-up to BL-348 (S183 EC fast-path for `/dsm-align`). Step 2b now branches by project type with three resolution flows: hub/spoke (unchanged), EC (reads `contributions-docs` from the ecosystem registry cached in Step 2a.5, derives project name from `basename "$(pwd)"`, targets `{contributions-docs}/{project-name}/_inbox/`, checks with `ls`, and explicitly refuses to scan the upstream repo root per BL-348). Skip condition added for missing registry entry or non-existent target (warn and continue, do not halt). The shared processing paragraph (read source files, evaluate, propose) is preserved for all project types.
  - **Spoke action:** Run `scripts/sync-commands.sh --deploy` to update the deployed `/dsm-go` command file. External Contribution spokes (IronCalc et al.) pick up the new resolution logic automatically on next session start via the deployed command file.

### Spawned

None. Neither BL-349 nor BL-350 produced follow-up BLs this session.

## [1.4.15] - 2026-04-11

### Added - External Contribution Alignment Support (S183)

- **BL-347: Rename `dsm-collaboration-storage` → `dsm-external-contribution-storage`.** The governance folder for external contribution projects was named `dsm-collaboration-storage`, a vague label that did not communicate its purpose. DSM_3 §6.6 uses the term "External Contribution" for this project type, so the folder name now matches. Updated the physical folder (`mv`), Central ecosystem registry, IronCalc ecosystem registry (cross-repo write), MEMORY.md, and 3 research files. Historical references in done/ BLs, CHANGELOG entries, blog materials, and the EXP-002 graphml were preserved as records of what was true when written.

- **BL-348: `/dsm-align` External Contribution governance scaffold.** `/dsm-align` previously had no code path for External Contribution projects. When run inside an external repo (e.g., `~/IronCalc`), it either ran spoke scaffold checks against the external repo (wrong, would pollute upstream with `dsm-docs/`, the BL-114 incident pattern) or skipped them entirely via the hub fast-path. The governance folder at `{contributions-docs}/{project-name}/` was never audited or scaffolded. New EC fast-path: detection is two-tier, (a) read CLAUDE.md alignment section for "External Contribution" in EITHER the Project type line OR the Participation pattern line, (b) fall back to filesystem signals (README + LICENSE/CONTRIBUTING + `@` reference + absence of `dsm-docs/` and `scripts/commands/`) with user confirmation gate. New step 3-EC scaffolds the governance folder behind an explicit cross-repo write confirmation gate. Idempotent: subsequent runs pass through if the scaffold is already complete. The both-fields tier-1 check was added mid-session after an audit of IronCalc revealed that the original single-field detection would have missed its legitimate layered layout (Project type: Application, Participation pattern: External Contribution), potentially creating `dsm-docs/` in the upstream repo.
  - **Spoke action:** Run `sync-commands.sh --deploy` to update `/dsm-align`. External Contribution projects should restart their Claude Code window and re-run `/dsm-align` to exercise the new code path. IronCalc has a detailed audit inbox entry at `~/dsm-external-contribution-storage/IronCalc/_inbox/2026-04-11_dsm-central-s183_audit-recommendations.md` with 7 recommended actions including CLAUDE.md cleanup (F3-F5) and legacy folder migration.

### Spawned

- BL-349 (Medium): `/dsm-go` EC governance inbox check. `/dsm-go` currently checks `_inbox/` at the project root only, so EC governance inbox entries are invisible and require a manual prompt each session.

## [1.4.14] - 2026-04-10

### Added - Gate 0 Collaborative Definition + /dsm-safe-go + /dsm-go Cleanup (S182)

- **BL-341: Gate 0 Collaborative Definition Protocol (DSM_0.2 §8.0).** New gate in the Pre-Generation Brief Protocol that governs the collaborative dialog before any artifact is conceived. Three steps (confirm threads → analyze dependencies → package into units), each requiring explicit confirmation. Mandatory for multi-thread work, unclear scope, or agent infrastructure changes. The three-gate model becomes a four-gate model (§8.0 → §8.1 → §8.2 → §8.3). Updated §8.4 Gate Scope, §17.1 alignment template, and CLAUDE.md reinforcement blocks.
  - **Spoke action:** Run `/dsm-align` to update PGB reinforcement block ("Three-gate" → "Four-gate").

- **BL-338: /dsm-go redundancy cleanup and 2c version-check fix.** Removed three pure-duplicate steps from `/dsm-go` (1.7, 2a.7, 2b.5, all fully covered by `/dsm-align`). Collapsed four partial duplicates to their unique residuals (0.5, 2a.5, 2b). Fixed the 2c version-check ordering bug by moving spoke-action surfacing into `/dsm-align` Step 13 as a read-before-write operation (the old 2c read `last-align.txt` after Step 13 had already overwritten it). dsm-go.md: 299 → 276 lines.
  - **Spoke action:** Run `sync-commands.sh --deploy` to update `/dsm-go` and `/dsm-align` command files.

- **BL-340: /dsm-safe-go minimal troubleshooting boot skill.** New zero-dependency, read-only session entry point for diagnosing problems when `/dsm-go`, `/dsm-light-go`, or `/dsm-align` is broken. Transcript append is best-effort (skip if broken). No side effects, no session tracking, no branch operations. Boot hierarchy: `/dsm-safe-go` < `/dsm-light-go` < `/dsm-go`.
  - **Spoke action:** Run `sync-commands.sh --deploy` to install the new `/dsm-safe-go` command.

### Spawned

- BL-342 (High): Claude Code platform research, "How does Claude Code work?"
- BL-343 (High): Skill/Hook Collaboration Protocol and Structural Standard
- BL-344 (Medium): "Read the User's Manual" foundational principle for DSM_6.0
- BL-345 (Medium): AI Platform Section architecture, "How to Work with Claude"
- BL-346 (High): "We Need to Talk" foundational principle for DSM_6.0

## [1.4.13] - 2026-04-09

### Fixed - F-094 Functional Gap + .sh Executability Audit + /dsm-go Hardening (S180)

- **Fixes F-094 functional gap (BL-319 follow-up):** F-094 (per-turn transcript append enforcement) shipped in v1.4.9 with the hook scripts and BL-319 v1.4.12 added the delivery mechanism, but the feature was effectively non-functional in real spokes because `.claude/hooks/transcript-reminder.sh` and `.claude/hooks/validate-transcript-edit.sh` were stored in the git index at mode `100644`. `core.fileMode = false` on WSL hid the divergence from `git status`, so the bug was invisible to anyone inspecting the working tree. Every fresh clone of any DSM project got non-executable hooks, and Claude Code's `UserPromptSubmit` and `PreToolUse/Edit` hook subsystems silently dropped the per-turn reminder injection because the OS refused to execute the scripts as configured in `settings.json` (`command: ".claude/hooks/transcript-reminder.sh"`, no `bash` prefix). DSM Central S180 ran 15+ consecutive turns with zero transcript appends despite F-094 supposedly being active. The bug was caught by the user mid-session, root-caused via `git ls-files -s`, and fixed.
  - Layer 1 fix: `git update-index --chmod=+x .claude/hooks/transcript-reminder.sh .claude/hooks/validate-transcript-edit.sh` to set 100755 in the index explicitly, bypassing `core.fileMode`. Verified end-to-end: `chmod +x` on the working tree restored the hook subsystem within seconds (the next user prompt injected the REMINDER text into context, and `validate-transcript-edit.sh` shape hook fired and blocked a malformed Edit on first attempt).
  - Layer 2 fix: `scripts/commands/dsm-align.md` hub fast-path step list previously omitted step 10b. BL-319 spec says step 10b "applies to all project types, including DSM Central itself" but the hub fast-path ran only steps 1, 7, 7b, 8, 8b, 9, 10, 11, 12, 13. So even with the index mode fixed, any session that rewrote a hook script via Write/Edit (which do not preserve +x) would silently strip executability and `/dsm-align` would never re-apply it on Central. Hub fast-path now includes step 10b with an inline note explaining the S180 incident.
  - Layer 2 prevention: step 10b sub-step b previously skipped `chmod +x` when destination was byte-identical to source, leaving spokes vulnerable to the same Edit/Write +x stripping in their own hook copies. Now re-applies `chmod +x` on every run including byte-identical destinations, so spokes self-heal on the next `/dsm-align`.
  - **Spoke action:** Run `/dsm-align` in each spoke once to absorb the re-chmod-always logic. Spokes that already had stripped `+x` will self-heal automatically. Or wait for the next `/dsm-go`, which now triggers `/dsm-align` unconditionally (see below).

- **Audit `.sh` executability across repo:** After fixing the two hook scripts, audited all tracked `.sh` files via `git ls-files -s '*.sh'` and found 4 more victims of the same `core.fileMode=false` invisible-divergence pattern, all created via `Write` tool which does not preserve `+x`:
  - `scripts/check-mirror-sync-content.sh` (BL-335 personal-content scanner, would silently fail when called from the Change Propagation Protocol; observed during this session's mirror sync prep)
  - `scripts/sync-commands.sh` (worked accidentally on this machine because the local working tree had been chmod'd at some past point; every fresh clone got 644)
  - `scripts/sync-take-ai-bite.sh` (mirror sync helper, same pattern)
  - `data/experiments/EXP-003-bl-319-hook-delivery/run-check.sh` (SC1-SC7 automated checker, would have silently failed during EXP-003 execution)
  All four now stored at 100755 in the index. Without this audit, EXP-003 itself would have been the next casualty of the bug it was designed to verify.

- **`/dsm-go` Step 1.8: glue `/dsm-align` to `/dsm-go` unconditionally (BL-319 hardening):** `/dsm-go` Step 1.8 now ALWAYS invokes `/dsm-align` immediately after the `@` reference fix, with no marker checks, no version gates, no confirmation. The previous conditional logic (auto-run only on missing marker / critical result / version mismatch) was brittle and allowed at least four distinct failure modes to persist between sessions: (1) hook scripts at index mode 644 silently broke the per-turn reminder hook because no `chmod +x` was applied between sessions; (2) stale `.claude/last-align.txt` markers caused the version check to falsely pass; (3) Claude Code window cache loaded a pre-v1.4.12 `/dsm-go` that confirmation-gated `/dsm-align` and let the user say "not now"; (4) scaffold drift (missing folders, missing hooks, broken `@` reference, drifted CLAUDE.md alignment block) was not caught until the next manual `/dsm-align`. Unconditional auto-run on every `/dsm-go` collapses all four modes by guaranteeing every session starts from a known-aligned baseline. Cost is bounded (hub fast-path ~5s, full spoke run 10-30s) and the safety value is large. `/dsm-light-go` remains the explicit lightweight escape hatch for context-pressure continuation sessions; the asymmetry is intentional and documented inline.
  - **Spoke action:** Run `/dsm-go` in each spoke once to absorb the new unconditional Step 1.8 (one-time slowdown of ~10-30s expected, then the spoke is fully aligned and self-healing on every subsequent `/dsm-go`). Existing open Claude Code windows must be restarted to pick up the new deployed `/dsm-go.md`.

### Added - BACKLOG-337 (Spawned)

- **BACKLOG-337 (Medium):** TAB sub-hub spoke creation skill (location-agnostic, two-input). Filed during S180 EXP-003 prep. The experiment's pre-registered cohort included a TAB-downstream test spoke, but no mechanism exists to scaffold one with the correct `dsm-central` pointer to TAB. `/dsm-align` step 7 fallback hardcodes Central, so any fresh directory running `/dsm-go` + auto-`/dsm-align` silently becomes a Central spoke. BL-337 proposes a TAB-side skill (`/dsm-new-spoke`) that runs from inside TAB and guides the user through a two-input dialog (location + name), supporting both greenfield and adopt-existing entry paths. The dropped TAB-downstream cohort case from EXP-003 will be re-run as an EXP-003 follow-up after BL-337 is implemented.

### Spawned

- **BACKLOG-337** (Medium): TAB sub-hub spoke creation skill, location-agnostic, two-input dialog. Spawned by EXP-003 cohort design gap (no mechanism to scaffold a TAB-downstream spoke with correct hub pointer).

## [1.4.12] - 2026-04-09

### Added - BL-319 Hook Delivery Scaffold + /dsm-go Step 1.8 Hardening (S179 batch)

- **BACKLOG-319 (High):** Scaffold delivery for per-turn transcript hook. Closes the gap between DSM_0.2 §7 per-turn enforcement docs (shipped v1.4.9) and the hook mechanism that enforces them. Evidence: portfolio S69 ran six consecutive turns with zero transcript appends; dsm-blog-poster S17 produced a single entry in the entire session. Both had the same root cause, the hook was absent from `.claude/settings.json` and no committed template or delivery step existed to install one. Implementation (Option C, single source of truth):
  - NEW `scripts/templates/settings-hooks.json`: minimal JSON fragment with the two hook entries (`UserPromptSubmit` -> `transcript-reminder.sh`, `PreToolUse/Edit` -> `validate-transcript-edit.sh`). Does not inline script bodies; references `.claude/hooks/` by relative path so Central's tracked scripts remain canonical.
  - NEW `/dsm-align` step 10b: copies hook scripts from `{dsm-central}/.claude/hooks/*.sh` (resolved via the Ecosystem Path Registry) into each project's `.claude/hooks/`, then idempotently merges the template entries into `.claude/settings.json`. Merge matches by `command` field so repeat runs produce zero diff. Preserves all pre-existing permissions, custom hooks, and top-level keys. Runs on DSM Central itself as well as spokes. Smoke-tested on a seeded temp spoke (pre-existing permissions, custom hooks, myCustomKey) before commit; RUN1 installed=2 merged_any=True, RUN2 merged_any=False, all pre-existing content preserved.
  - NEW `data/experiments/EXP-003-bl-319-hook-delivery/`: pre-registered experiment with 8 success criteria across 3 cohort spokes (take-ai-bite, dsm-data-science-portfolio, dsm-blog-poster — one per DSM project type). `run-check.sh` automates SC1-SC7; SC8 is a manual fire-test in TAB. Execution deferred to next session (requires coordinated `/dsm-align` runs across separate Claude Code windows).
  - **Spoke action:** Run `/dsm-align` to install the hook scripts and wire `.claude/settings.json`. First run on a cold spoke creates `.claude/dsm-ecosystem.md` in step 10 and installs the hook in step 10b in the same pass.
  - **Spoke action:** Run `sync-commands.sh --deploy` to pick up the new step 10b in `/dsm-align`.

### Changed

- **`/dsm-go` Step 1.8 wording hardened.** Step 1.8 (auto-run `/dsm-align` on alignment gap) previously attached "Do not ask permission" only to the missing/critical branch; the version-mismatch branch read as narrative "Report: ... Then auto-run" which parses as sequential-conditional. An agent in S179 rationalized a y/n confirmation gate on version mismatch despite the step's intent. Fix: hoist a top-level unconditional rule above both branches ("do not ask, do not prompt y/n, do not defer") and repeat the no-confirmation clause on every auto-run branch. This closes the same ambiguity class BL-331 closed for DSM_0.2 §7.
  - **Spoke action:** Run `sync-commands.sh --deploy` for `dsm-go`.

### Spawned

- (none — this version's work did not spawn follow-up BLs. BL-320 audit of §7-style protocols already exists and gains one more data point from S179.)

---

## [1.4.11] - 2026-04-09

### Added - Light-go Switch-Flow Hardening, Post-Merge Branch Rule, Mirror Sync Personal Content Gate (S178 batch)

- **BACKLOG-331:** Light-go switch-flow recovery and DSM_0.2 §7 hardening (4 sub-items in one BL).
  - Switch-flow guarantee in `scripts/commands/dsm-light-go.md` Safety Gate handoff text + `scripts/commands/dsm-go.md` Step 6 no-skip rule for deferral entries. Closes the portfolio S69 failure mode (~6 turns with zero transcript appends after `/dsm-light-go` → `/dsm-go` switch dropped Step 6).
  - **Spoke action:** Run `sync-commands.sh --deploy` to update the runtime copies of `dsm-go` and `dsm-light-go`.
  - Unconditional activation rule in DSM_0.2 §7 + §17.1 base template + Central `.claude/CLAUDE.md`: "if `.claude/session-transcript.md` exists in the project, the protocol is active". Third independent enforcement layer alongside the per-turn hook (occurrence) and PreToolUse shape validator.
  - **Spoke action:** Run `/dsm-align` to propagate the unconditional activation bullet to spoke CLAUDE.md alignment blocks.
  - Heredoc anti-pattern in DSM_0.2 §7 Anti-Patterns + §17.1 + alignment block + inline warning in `dsm-go.md` Step 6: never use single-quoted heredoc (`<< 'EOF'`) when content contains `$(date +%H:%M)` or other shell expansions; capture timestamp into a variable and use unquoted heredoc, or prefer the Edit-tool append path.
  - **Spoke action:** Run `/dsm-align` to propagate the heredoc anti-pattern bullet to spokes.
  - Cadence gate interactive y/n prompt in `dsm-light-go.md` Branch Cadence Gate: replaces dead-end "options" output with auto-invocation of `/dsm-wrap-up` on `y`. Matches Safety Gate + `/dsm-go` Step 0d patterns.
  - **Spoke action:** Run `sync-commands.sh --deploy` for `dsm-light-go`.
  - Origins: portfolio S69 (transcript drift + cadence gate UX), dsm-blog-poster S17 (heredoc literal + transcript drift evidence).

- **BACKLOG-332:** Post-merge branch recreation rule. New DSM_0.2 §20.8 with the rule (create new branch before any further commit), the chain pattern (`gh pr merge ... && git checkout -b session-N/YYYY-MM-DD-{purpose}`), the soft `-{purpose}` naming convention for follow-on branches in the same calendar session, and the recovery sequence using `git update-ref refs/heads/main refs/remotes/origin/main` (since the harness blocks `git reset --hard`). Reinforced in `dsm-go.md` Step 0 docs and Central `.claude/CLAUDE.md` Branching Strategy block.
  - **Spoke action:** Review DSM_0.2 §20.8 for the post-merge branch recreation pattern. No template change; behavioral rule only.
  - Origin: dsm-blog-poster S17 hit this twice (commit landed on main after `gh pr merge --delete-branch`; recovery cost ~5 min and one extra PR per slip).

- **BACKLOG-335 (was BACKLOG-333):** Pre-mirror-sync personal content scanner. New `scripts/check-mirror-sync-content.sh` (executable, ~100 lines) greps a list of files for personal markers (name, PMP credential, LinkedIn URL, freelance/client framing, user-preference phrasing) and exits non-zero on hits. Supports `--confirmed` flag to bypass the gate for legitimate matches (author attribution in README, BL author fields). Wired into `scripts/commands/dsm-wrap-up.md` step 8d Mirror sync, plus the Change Propagation Protocol mirror step and Version Update Workflow step 9 in Central `.claude/CLAUDE.md`. Tested: 0 hits on DSM_0.2 + dsm-go + dsm-wrap-up; 3 legitimate hits on README, 1 on FEATURES, both expected and bypassable.
  - **Spoke action:** None directly (Central-only safety net). Spokes inherit the wrap-up step text via mirror sync of `dsm-wrap-up.md` and gain the gate the next time they wrap up after `sync-commands.sh --deploy`.
  - Renumbered from BL-333 because of an in-session collision with a pre-existing untracked `BACKLOG-333_audit-user-facing-docs-voice-and-tab-dsm-framing.md` file.

- **BACKLOG-336 (was BACKLOG-334):** Personal rules allowlist for DSM Central. New `.claude/personal-rules-allowlist.md` (Layer 2, gitignored via `.gitignore` line 72) cataloging the Layer 1 (auto-memory) / Layer 2 (truly gitignored) / Layer 2.5 (tracked but not in mirror impact table: `CLAUDE.md`, `contributor-profile`, `skills-registry`, `hooks/`, `memory/MEMORY.md`, `spoke-backups/`, `LOCAL_CHANGELOG`) / Layer 3 (mirrored methodology) split. Includes legitimate matches list for the BL-335 scanner (README PMP/author/LinkedIn, FEATURES github URL, BL author fields). Companion to BL-335.
  - **Spoke action:** None (Central-only reference document). Spokes can create their own allowlists if they have personal-rules churn.
  - Renumbered from BL-334 for collision-pair contiguity.
  - Implementation discovered that MEMORY.md was wrong about ".claude/ is gitignored". `.gitignore` lists individual files line by line; most `.claude/` files are tracked. MEMORY.md corrected in this wrap-up.

### Spawned

No new spawned BLs from v1.4.11. The version's work consumed the existing BL-331/332 (filed earlier in S178) plus the two new BL-335/336. BL-319 priority bumped Medium → High based on portfolio S69 + blog-poster S17 evidence; existing BL, no spawn.

## [1.4.10] - 2026-04-09

### Added - Persistent /dsm-align Report and Skill Self-Reference Protocol (S176+S177 batch)

- DSM_0.2 §8.6: new Skill Self-Reference Protocol requires reading the skill prompt file before claiming any skill behavior. Origin: efficientnet S8 false-claim incident about `/dsm-wrap-up` portfolio handling. (BL-327)
  **Spoke action:** Run `/dsm-align` to update reinforcement block.
- DSM_0.2 §17.1 base template Pre-Generation Brief block: new bullet for the what/why/how thinking-block rule before Gate 1, propagated from §8.5 to make spokes inherit it explicitly. (BL-325)
  **Spoke action:** Run `/dsm-align` to update reinforcement block.
- DSM_0.2 §17.1 base template Pre-Generation Brief block: new bullet for skill self-reference rule (mirrors §8.6). (BL-327)
  **Spoke action:** Run `/dsm-align` to update reinforcement block.

### Changed - Skill behavior

- `scripts/commands/dsm-align.md` step 12a: new persistent alignment report written to `.claude/last-align-report.md` on every run (post-change and check-only) with explicit warning/collision text, already-correct items, and skipped-step reasons. Step 12b modified to fire on check-only runs when warnings exist and to reference the persistent file instead of duplicating contents. (BL-329)
  **Spoke action:** Run `scripts/sync-commands.sh --deploy`.
- `scripts/commands/dsm-align.md` step 10: new scaffold for `.claude/reasoning-lessons.md` with a standard header template; `scripts/commands/dsm-go.md` Step 0.5 now includes the file in scaffold completeness so a missing file auto-triggers `/dsm-align`. Prevents the efficientnet failure mode of 11 sessions without the lessons file. (BL-328)
  **Spoke action:** Run `scripts/sync-commands.sh --deploy`.
- `scripts/commands/dsm-light-wrap-up.md` and `scripts/commands/dsm-light-go.md`: new Cadence Gate refusing to operate on a session branch whose date ≠ today (Option D, hard cadence rule). Catches the efficientnet 7-session failure mode where light cycles ran across multiple days on a stale session branch. Task branches (`bl-*`, `sprint-*`, `parallel/*`) exempt. (BL-326, S176)
  **Spoke action:** Run `scripts/sync-commands.sh --deploy`.
- DSM_0.2 §7 Turn-Boundary Transcript Append Self-Check: rewritten positively ("Every turn begins with a transcript append"); tool-call-count condition removed; pure-reasoning-turn failure mode example added; exemption replaced with content-based criterion (content-trivial turns only). §17.1 template bullet mirrored. (BL-330, S176)
  **Spoke action:** Run `/dsm-align` to update reinforcement block.

### Spawned

None this version.

## [1.4.9] - 2026-04-07

### Added - Per-Turn Transcript Enforcement and Process Narration (BL-318 Layer 2)

- DSM_0.2 §7: new "Per-Turn Transcript Append Enforcement Mechanism"
  subsection. Documents the `UserPromptSubmit` hook in
  `.claude/settings.json` as the enforcement layer for the Session
  Transcript Protocol. The hook fires every turn and enforces *occurrence*;
  the existing `validate-transcript-edit.sh` PreToolUse hook enforces
  *shape*. IDE monitoring and session-start behavioral activation are
  reframed as user affordances, not enforcement. Closes the failure mode
  observed in S171 (7 consecutive turns without transcript appends despite
  §7 + /dsm-go step 6).
  **Spoke action:** Review §7 for the new Per-Turn Transcript Append
  Enforcement Mechanism subsection.
- DSM_0.2 §7: new "Turn-Boundary Transcript Append Self-Check" subsection.
  Binary check the agent must run at the start of every turn ("was my
  first tool call this turn an append?"). Explicit exemption for turns
  with zero tool calls.
  **Spoke action:** Review §7 for the new Turn-Boundary Transcript Append
  Self-Check subsection.
- DSM_0.2 §7: new "[RETROACTIVE] Transcript Append Self-Detection Rule"
  subsection. Recovery format for missed appends, using current HH:MM
  (never backdate) and an explicit gap note. Recovery entries are evidence
  the protocol failed and recovered, not a workaround that hides the
  failure.
  **Spoke action:** Review §7 for the new [RETROACTIVE] Transcript Append
  Self-Detection Rule subsection.
- DSM_0.2 §7: new "Process Narration for Reasoning Efficiency Analysis"
  subsection. Thinking blocks must narrate reasoning as it unfolds (loops,
  doubts, reversals, considered-and-rejected paths) instead of presenting
  clean post-hoc summaries. Motivation: extended-thinking inefficiency
  patterns are the primary signal for reasoning-efficiency analysis, and
  clean summaries hide them. Origin: S172 user observation that the
  collapsed extended-thinking view contains loops the curated transcript
  does not.
  **Spoke action:** Review §7 for the new Process Narration for Reasoning
  Efficiency Analysis subsection.
- §17.1 base template Session Transcript reinforcement block: two new
  bullets propagating per-turn enforcement, turn-boundary self-check,
  and process narration to all spokes.
  **Spoke action:** Run `/dsm-align` to update the §17.1 reinforcement
  block.
- `.claude/settings.json` UserPromptSubmit hook reminder string tightened:
  now specifies the 4-step sequence (anchor read → thinking append → work
  → output append) and explicitly permits the anchor-read tool call as the
  only pre-append call. Closes ambiguity in the previous "FIRST tool call"
  wording, which was self-contradictory because the append literally
  requires reading the anchor first.
  **Spoke action:** Spoke `.claude/settings.json` does not yet receive the
  hook automatically; BL-319 tracks scaffold delivery.

### Changed - CHANGELOG Convention (Spawned BLs and Inline Spoke Actions)

- `.claude/CLAUDE.md` Version Update Workflow step 2: new sub-bullets
  documenting two CHANGELOG conventions surfaced during BL-318 review.
  Inline `**Spoke action:**` lines per affected bullet (instead of trailing
  footers) to preserve bullet→action mapping. New `### Spawned` subsection
  for BLs created by a version's work, listing only newly-spawned BLs (not
  pre-existing open ones), to document the causal link between a version
  and its descendants without duplicating the active backlog. Both
  conventions are applied retroactively to this v1.4.9 entry.

### Spawned

- BL-319 (Medium): Scaffold Delivery for Per-Turn Transcript Hook —
  install the hook into spoke `.claude/settings.json` via `/dsm-align`.
- BL-320 (Medium): Audit §7-Style Protocols for Require/Validate Gaps —
  inventory other DSM_0.2 protocols with the same "doc rule, no
  enforcement" shape and rank by blast radius.
- BL-321 (Medium): Streamline DSM Version Update Workflow — single-gate
  reviews, derived FEATURES.md and feature-trail rows, CHANGELOG template,
  trust the skill instead of pre-staging.

## [1.4.8] - 2026-04-07

### Added - Python Virtual Environment Protocol (BL-284)

- DSM_0.2 Module D §5.1: Python Virtual Environment Protocol. Required for
  any project containing `notebooks/`, `src/`, `scripts/`, `requirements*.txt`,
  `pyproject.toml`, `setup.py`, or `Pipfile`. Defines venv check, creation,
  activation, and pre-install verification steps. Closes a gap where the
  agent attempted to install packages into system Python.
- DSM_0.2 §25.2 dispatch table: new entry for the protocol.
- DSM_0.2.D §5 Applicability: fixed stale "Section 2.1" reference; now points
  to §5.1.
  **Spoke action:** Review §5.1 for behavioral changes; ensure existing
  Python projects have `.venv/` in `.gitignore`

## [1.4.7] - 2026-04-07

### Added - Skill Governance Runtime Register Context (BL-287)

- DSM_0.2 §23.4: Runtime Register Context Convention. Register-sensitive
  skills (e.g., humanizer) MUST receive a runtime context block describing
  audience, formality, domain, and constraints before invocation. Closes a
  gap where §23 covered install-time conflict detection but not runtime
  context.
- Skills registry template gains a `Register-sensitive` column (yes/no/partial).
- Humanizer skill registry entry annotated with the german-adversarial-prompting
  S8 incident and marked register-sensitive: yes.
  **Spoke action:** Review §23.4 for behavioral changes; update local
  skills-registry.md with Register-sensitive column

## [1.4.6] - 2026-04-07

### Added - Planning Pipeline Gate for Spoke Agents (BL-316)

- §17.1 template: new "Actionable Work Items" reinforcement section. Only
  items in `dsm-docs/plans/` (and legacy `plan/backlog/`) are actionable
  work items; material elsewhere (`_reference/`, `docs/`, README, inbox,
  sprint plan drafts) is INPUT to the planning pipeline, not a substitute
  for it. Operationalizes DSM_3 planning pipeline at the spoke behavioral
  surface. Origin: utility_conversational_ai S1 MO-1 (agent treated
  `_reference/sprint-plan.md` as actionable, skipping research → formalize
  → plan).
  **Spoke action:** Run `/dsm-align` to update reinforcement block

## [1.4.5] - 2026-04-06

### Added - Template Reinforcement and Sprint Intelligence (BL-315, BL-310)

- §17.1 template: new "Cross-Repo Write Safety" reinforcement section (BL-315,
  operationalizes Module C §2 Destructive Action Protocol for spoke agents)
  **Spoke action:** Run `/dsm-align` to update reinforcement block
- §17.1 template: "Read the relevant source before answering questions about it;
  do not answer from partial knowledge" added to Code Output Standards (BL-315,
  operationalizes DSM_6.0 §1.3 Earn Your Assertions)
  **Spoke action:** Run `/dsm-align` to update reinforcement block
- Module A §11.1: Sprint Retrospective Intelligence Protocol (BL-310 Phase 4).
  Data-driven analysis at sprint boundaries across 6 dimensions: Themes,
  Principles, Evolution, Collaboration, Learning, Maturity. Operationalizes
  DSM_6.0 §1.9 Think Ahead.

### Fixed

- `/dsm-align` step 13: explicit CHANGELOG version resolution path for spoke
  agents. Was ambiguous "CHANGELOG or DSM_0.0", now specifies: resolve
  dsm-central path, read CHANGELOG.md, extract from latest heading. Prevents
  version hallucination on spoke projects.

## [1.4.4] - 2026-04-06

### Added - Principle Operationalization and Session Lifecycle (BL-310, BL-313, BL-314)

- §17.1 template: "When uncertain, state the uncertainty; do not guess or fabricate"
  added to Code Output Standards (BL-310, operationalizes DSM_6.0 §1.3)
  **Spoke action:** Run `/dsm-align` to update reinforcement block
- DSM_0.2 §15: three-question delivery test made explicit (read/opinion/redirect)
  (BL-310, operationalizes DSM_6.0 §1.1)
  **Spoke action:** Review §15 for behavioral changes
- Module A §14: environmental awareness guidance (sufficient over maximal config)
  (BL-310, operationalizes DSM_6.0 §2.3)
- `/dsm-align` step 12: post-change vs check-only report distinction (BL-313)
  **Spoke action:** Run `sync-commands.sh --deploy`
- `/dsm-align` step 12b: inbox notification to project `_inbox/` when changes
  are applied (BL-313)
- `/dsm-align` step 11: checks both user-level and project-level command
  directories for drift (BL-313)
- Wrap-up type marker (`.claude/last-wrap-up.txt`) written by all wrap-up
  variants, read by `/dsm-go` and `/dsm-light-go` to guide startup command
  selection (BL-314)

### Changed - Session Start/End Guidance (BL-314)

- `/dsm-go` step 5.9: detects light wrap-up and suggests `/dsm-light-go`
- `/dsm-light-go` Safety Gate: detects non-light wrap-up and suggests `/dsm-go`
- Two guidance rules: light-go after non-light warns, full-go after light suggests switch

## [1.4.3] - 2026-04-05

### Added - Protocol Improvements from Spoke Feedback (BL-309, BL-312)

- Module A §24: Sprint Plan Cross-Reference Before Completion (BL-312)
  Agents must read and cross-reference the sprint plan before suggesting
  wrap-up. Prevents premature completion declarations.
  **Spoke action:** Review Module A §24 for behavioral changes
- Module B §4.2: Figure Validation After Cell Execution (BL-309)
  Cells that generate plots must save to `outputs/figures/`; agent reads
  the saved image via Read tool before proceeding.
  **Spoke action:** Review Module B §4.2 for behavioral changes
- §17.1 base template: sprint plan cross-reference line in Session Wrap-Up,
  figure validation line in Notebook Collaboration Protocol
  **Spoke action:** Run `/dsm-align` to update reinforcement block
- DSM_0.2 §17: scaffolding specification cross-reference (DSM_0.1 §10,
  DSM_3.0.E §6.7) (BL-290)

### Changed - Session-Start Efficiency (BL-311)

- `/dsm-align`: hub fast-path skips spoke-specific checks on DSM Central,
  improved path filter (excludes slash commands, globs, command invocations),
  `test -d` note for safe existence checks
  **Spoke action:** Run `sync-commands.sh --deploy` to update commands
- `/dsm-go` step 1.5: bounded reasoning lessons read (first 10 lines only)
  **Spoke action:** Run `sync-commands.sh --deploy` to update commands

## [1.4.2] - 2026-04-05

### Added - DSM_6.0 Principle Operationalization (BL-310)

- §17.1 base template: 5 new sections promoted from DSM Central CLAUDE.md
  - Code Output Standards (reinforces Earn Your Assertions §1.3)
  - Tool Output Restraint (reinforces Take a Bite §1.1)
  - Working Style (reinforces Take a Bite + Critical Thinking §1.4)
  - Plan Mode for Significant Changes (reinforces Earn Your Assertions §1.3)
  - Session Wrap-Up (reinforces Know Your Context §1.5)
  **Spoke action:** Run `/dsm-align` to update reinforcement block
- `/dsm-align` step 8b: CLAUDE.md redundancy scan against DSM_0.2 core and template
  **Spoke action:** Run `sync-commands.sh --deploy` to update /dsm-align command
- Phase 1 audit: 62 behavioral expectations mapped across 9 DSM_6.0 principles (31% gap rate)
- Phase 2 pipeline audit: CLAUDE.md generation chain mapped with 3 leakage points identified

### Changed - DSM_0.2 §17.2 Content Validation

- Removed "Code Output Standards (notebook-specific)" from Documentation project drift indicators (now universal in template)

### Fixed

- `/dsm-align` step 7b.c: enforce literal template copy to prevent heading paraphrase (generated "## DSM Alignment" instead of "## 1. DSM_0.2 Alignment")
  **Spoke action:** Run `sync-commands.sh --deploy` to update /dsm-align command

## [1.4.1] - 2026-04-01

### Added - CLAUDE.md Content Validation Protocol (BL-294)

- §17.2: cross-reference CLAUDE.md sections against project type to detect drift
- Insurance section exemption list for rarely-used but critical protocols
- `/dsm-go` step 2a.7: validation at session start
- `/dsm-align` step 8: validation scan after alignment regeneration

### Changed - DSM_0.2 Core Slimming (BL-299)

- §1-4 (session-start checks) and §11-12 (context/two-pass) moved to Module A §17-22
- Core sections replaced with one-line stubs preserving stable section numbers
- 65 cross-references unchanged, no ecosystem-wide renumbering needed
- Core: 1,317 → 1,032 lines (-22%)
  **Spoke action:** Run `/dsm-align` to update reinforcement block

### Changed - Session 161 Protocol Improvements (BL-292, BL-293, BL-296)

- §6 renamed to Session Transcript Delimiter Format, 3 universal typed delimiters (BL-292)
  **Spoke action:** Run `/dsm-align` to update reinforcement block
- Stale branch cleanup at session start: `/dsm-go` Step 0d, `/dsm-light-go` Step 1.6 (BL-293)
- CHANGELOG spoke action annotation convention §2.1, version check enhancement (BL-296)

## [1.4.0] - 2026-03-27

### Added - DSM_6.1: Systems Prompt Engineering (BL-258)

- New methodology chapter: DSM_6.1 Systems Prompt Engineering v1.0
- Core document (362 lines) + 3 modules: Operational Channels (A), Instruction Design Patterns (B), Evaluation and Evolution (C)
- Covers prompt lifecycle, context layering, behavioral triggers, and evaluation frameworks

### Added - BL-273: Project Finalization Skill

- `/dsm-finalize-project` skill for structured project closure
- Covers archival, documentation, and stakeholder notification

### Changed - Document Modularization (BL-268, BL-269, BL-270)

- DSM_1.0: Modularized into slim core + 4 modules (A: Core Workflow, B: Working Standards, C: Practices, D: Session Quality)
- DSM_2.0: Modularized into slim core + 4 modules (A: Planning Templates, B: Advanced Planning, C: Sprint Assessment, D: Quality Operations)
- DSM_3.0: Renamed from DSM_3, modularized into slim core + 5 modules (A: Templates, B: Hub-Spoke, C: External Contribution Guidelines, D: External Contribution Templates, E: Participation Patterns)
- DSM_4.0: Modularized into slim core + 2 modules (A: Development Quality, B: Project Planning Setup)

### Changed - Domain-Neutrality Audits (BL-201, BL-202, BL-203, BL-204, BL-254, BL-255, BL-256)

- All numbered DSM files audited for domain-specific language
- DSM_1.0: 7,421 → 7,087 lines (4.5% reduction)
- DSM_4.0: 995 → 790 lines (20.6% reduction)
- Removed data-science-specific examples, replaced with domain-neutral alternatives

### Changed - Licensing

- Dual-license structure: CC BY-SA 4.0 for methodology documentation, MIT for scripts/code
- LICENSE-DOCS.md added with Creative Commons terms

### Changed - Other Improvements

- DSM_0.0 (renamed from DSM_0): rewritten as gentle introduction (BL-263)
- TOC added to 8 methodology files (BL-264)
- Parallel session worktree isolation (BL-272)
- GitHub issue triage: 3-check system with research queue classification (BL-261)
- Canonical inbox location clarified as `_inbox/` at project root (BL-266)
- README unified: adopted Take AI Bite public-facing README as single source for both repos
- README and TAKE_A_BITE.md updated with Systems Prompt Engineering section and 9 principles (was 7)
- GitHub repo description updated to reflect current scope

## [1.3.70] - 2026-03-16

### Added - BL-212: Strategic Thinking Layer

- DSM_6.0 Principle 1.9 "Think Ahead": strategic thinking as fourth stage of collaboration maturity
- Four-layer progression model: operational → philosophical → learning → strategic
- Maturity indicators table (backlog self-generation, dependency clusters, audience expansion)
- 4 Evolution protocol mappings in DSM_6.0 Guidelines (Roadmap System, Phase-Gated Work, Backlog Scope Rule, Feature Branch Rule)

### Added - BL-211: Roadmap System

- `plan/roadmap.md`: strategic phasing document (4 phases, 10 clusters, dependency graph)
- GitHub Projects "DSM Roadmap" with 38 items, custom fields (Phase, Cluster, Priority)
- Simplified `improvements/` and `developments/` READMEs to index + priority format
- CLAUDE.md "Roadmap and Tracking" section with three-layer architecture guidance

### Added - Research

- `docs/research/2026-03-16_dsm-evolution-git-history-analysis.md`: 796 commits across 14 repos, unified timeline
- `docs/research/2026-03-16_dsm-feature-inventory.md`: 83 features across 11 capability domains

### Changed

- DSM_6.0 version history: v1.6 (Principle 1.9, 4 protocol mappings)
- DSM_0: nine principles (updated from eight)
- BL-206 marked implemented (consolidation complete)

## [1.3.69] - 2026-03-15

### Added - BL-176: Reasoning Lessons Propagation

- Scope classification for reasoning lessons: ecosystem, pattern, project labels
- Cross-project propagation protocol: mandatory push to DSM Central at session wrap-up
- Ecosystem aggregation file: `docs/reasoning-lessons-ecosystem.md`
- Updated dsm-staa, dsm-wrap-up, dsm-quick-wrap-up with scope classification and push steps

## [1.3.68] - 2026-03-15

### Changed - BL-200: Rebranding Documentation Audit (Phase 1)

- Replaced "Data Science Methodology" / "Agentic AI Data Science Methodology" with "Deliberate Systematic Methodology (DSM)" across README, DSM_0, DSM_0.1, DSM_0.2 header, Module A, DSM_3 Section 7 descriptions, CHANGELOG header, CODE_OF_CONDUCT
- DSM_3 Section 7 short/medium/full descriptions rewritten for domain-neutral framing
- Historical CHANGELOG entries and blog posts preserved

### Source

- BL-195 audit finding; Session 130

## [1.3.67] - 2026-03-15

### Changed - BL-195: Remove Personal Names from Documentation

- DSM_0.2 Inclusive Language: new "Personal names" rule (no names in methodology docs)
- DSM_1.0: replaced names in subtitle and case study examples with role-neutral references
- DSM_1.0 Appendices: risk owner changed to role reference
- DSM_3: DSM context description updated, also corrected "Data Science Methodology" to "Deliberate Systematic Methodology"

### Source

- User directive (2026-03-15); Session 130

## [1.3.66] - 2026-03-15

### Added - BL-194: Reasoning Lessons Promotion to Protocol

- Reasoning Lessons Protocol: new prune action "promote to protocol" for ecosystem-wide patterns that graduate to formal DSM sections, DSM 6.0 principles, or vocabulary entries
- Criteria: validated across 3+ sessions, applicable beyond originating project

### Source

- User idea (2026-03-15); Session 130

## [1.3.65] - 2026-03-15

### Changed - BL-190: Mandatory Ecosystem Pointers

- DSM_0.2 Ecosystem Path Registry: changed from optional to required for all project types
- `/dsm-align`: creates `.claude/dsm-ecosystem.md` with template when missing (step 9)
- `/dsm-go`: flags missing ecosystem registry as action item for all project types (step 2a.5)

### Source

- dsm-stress-tester S9 feedback; Session 130

## [1.3.64] - 2026-03-15

### Added - BL-167: Consumption Directory Enforcement (completion)

- `/dsm-align`: README templates for checkpoints, handoffs, plans, research directories
- `/dsm-go`: step 2b.5 canonical folder check (suggests /dsm-align if folders missing)
- File naming validation deferred to future scope

### Source

- Portfolio inbox feedback (S35), dsm-blog-poster S4, dsm-stress-tester S5; Session 130

## [1.3.63] - 2026-03-15

### Added - BL-192: Hybrid Branch Push Policy

- DSM_0.2 core: new "Branch Push Policy" section (local by default, push on light-wrap-up or large changes)
- CLAUDE.md Feature Branch Rule: hybrid push policy, agent behavior for light-wrap-up
- `/dsm-light-wrap-up`: new step 2, push unpushed feature branches to remote before wrapping up

### Source

- S130 workflow discussion; Session 130

## [1.3.62] - 2026-03-15

### Added - BL-191: Mirror Repo Sync After Central Changes

- Version Update Workflow step 9: mandatory sync of mirror repos after methodology file changes
- DSM_0.2 Ecosystem Path Registry: `mirror: true` flag for repos that receive automatic file sync
- Prevents public distribution repos (take-ai-bite) from falling out of sync with Central

### Source

- BL-090 implementation gap; Session 130

## [1.3.61] - 2026-03-15

### Changed - BL-090: DSM_0.2 Modularization

- Split `DSM_0.2_Custom_Instructions_v1.1.md` (2,625 lines) into slim core (577 lines) + 4 on-demand modules:
  - `DSM_0.2.A_Session_Lifecycle.md` (771 lines): inbox push, README notification, milestone notification, feedback tracking, technical progress, sprint cadence, delivery budget, mechanical vs decision edits, lightweight sessions, reasoning lessons, continuous learning, artifact lifecycle, session config recommendation
  - `DSM_0.2.B_Artifact_Creation.md` (360 lines): composition challenge, edit explanation stop, enabling file content, notebook collaboration, notebook-to-script, app development, revert safeguards
  - `DSM_0.2.C_Security_Safety.md` (242 lines): secret exposure, destructive action, untrusted input, query sanitization
  - `DSM_0.2.D_Research_Onboarding.md` (437 lines): breaking change notification, external DSM descriptions, step 0 situational assessment, phase 0.5 research, environment preflight, first session prompt, phase-to-DSM mapping, command file version tracking
- Core retains: project type detection, inbox check, version check, read-only access, reasoning delimiter, session transcript, pre-generation brief, context budget, inclusive language, CLAUDE.md configuration, AI collaboration principles, ecosystem path registry
- Module Dispatch Table maps 28 protocols to their modules with trigger conditions
- 78% reduction in always-loaded context (2,625 → 577 lines)

### Source

- S129 Phase 1 analysis; Session 130

## [1.3.56] - 2026-03-14

### Added - BL-159 Phase 1: Communication Channel Framework

- New `docs/guides/communication-channels.md`: 6 channel types (blog, LinkedIn, stakeholder report, conference abstract, portfolio entry, README update) with audience, format, tone, and length guidance; selection workflow; tone transformation examples
- Phases 2-3 (templates, implementation) remain as future scope

### Source

- S96 user idea; Session 128

## [1.3.55] - 2026-03-14

### Added - BL-171: DSM First-Time Setup and Adoption Guide

- DSM_3 Section 6.7.4 (DSM Adoption for Existing Projects): pre-existing artifact migration checklist, hierarchical project scoping rule, agent-created memory vs DSM MEMORY.md relationship

### Source

- Artz project cold-start (S114); Session 128

## [1.3.54] - 2026-03-14

### Added - BL-149: Step 0, Situational Assessment Phase

- DSM_0.2: new "Step 0: Situational Assessment" section before Phase 0.5; 5-point checklist (governance landscape, owner dynamics, contribution model, codebase orientation, governance boundaries); mandatory for external contributions, recommended for new spoke projects

### Source

- Reclaim Launcher retrospective (S87), stress-test feedback; Session 128

## [1.3.53] - 2026-03-14

### Added - BL-157: Project Initialization Quality Gate

- DSM_3 Section 6.2.1 (Preliminary Scope Template): time budget field for realistic scoping
- DSM_3 Section 6.7 (Spoke Initialization Checklist): README.md creation step (11), user convention inheritance step (12)
- DSM_3 Section 6.7.2 (CLAUDE.md Essentials): multi-deliverable scope validation, DSM_1 methodology knowledge transfer references (Sections 2.1, 2.2, 2.5)
- DSM_0.2 First Session Prompt: plan abstraction calibration guidance (plan at certainty level, not implementation detail)

### Source

- AI-in-Data-Science S1-S2 feedback (6 inbox entries); Session 128

## [1.3.52] - 2026-03-14

### Added - BL-163: Research Gate, Scale-Aware Planning Protocol

- DSM_0.2 Phase 0.5: scale-aware research (feature/sprint/epoch depth table), proactive suggestion when uncertainty detected, tiered research pattern (broad → decision → assessment gate → deep-dive if needed), uncertainty type examples
- DSM_2.0 Template 8 (Sprint Plan): Research Assessment section before deliverables; evaluate whether scope can be detailed enough for concrete task breakdown

### Source

- dsm-graph-explorer S22 + S107 feedback; Session 128

## [1.3.51] - 2026-03-14

### Added - BL-174: Experiment Template Enhancement (7-Element Framework)

- Appendix C.1.3: new "General 7-Element Framework" subsection at the start of Capability Experiment Template; domain-agnostic structure (hypothesis, baseline, method, variables, success criteria, results, decision) grounded in 6 established frameworks; existing RAG-specific content restructured as a subheading

### Source

- dsm-graph-explorer S25 research; Session 128

## [1.3.50] - 2026-03-14

### Added - BL-170 Part A: Git Auto-Initialization Pre-Step

- dsm-go: new Git Pre-Step before Git Awareness; detects absent git and auto-initializes (git init, branch rename to main, remote question, initial commit) before any other step
- dsm-align: same Git Pre-Step added before Step 1
- Rule: all DSM projects require a local git repository; no exceptions

### Source

- Artz cold-start (S114); Session 128

## [1.3.49] - 2026-03-14

### Added - BL-164: DSM Vocabulary, Formalized Term Registry

- New `docs/guides/dsm-vocabulary.md`: canonical registry of DSM-coined terms (10 formal principles, 5 emergent concepts, 2 guidelines), contribution path, entry guidelines
- DSM_6.0 Section 2.5 (The DSM Vocabulary): frames the vocabulary as the third layer of collaboration infrastructure (operational conventions, philosophical principles, linguistic vocabulary)
- BL-000 principle inventory tables replaced with reference to vocabulary file
- DSM_0 key sections listing updated for DSM_6.0

### Source

- S106-107 vocabulary accumulation; Session 128

## [1.3.48] - 2026-03-14

### Added - BL-173 Phases 1+2: Tool Dependency Analysis

- DSM_0: new "Tool Dependencies" section with 4-level dependency table (fundamental, Claude Code-specific, VS Code-specific, platform-specific), transferability assessment, and adaptation invitation
- Phase 3 (tool-agnostic DSM specification) remains as future scope

### Source

- Session 114 user reflection; Session 128

## [1.3.47] - 2026-03-14

### Added - BL-168: DSM Core Tools Registry

- New `docs/core-tools.md`: authoritative registry of ecosystem-enabler repos (5 initial entries), definition, characteristics, registration rule, distinction from case-study projects
- DSM_3 Project Registry: cross-reference to core-tools.md in DSM Tooling category

### Source

- Portfolio S35 feedback; Session 128

## [1.3.46] - 2026-03-14

### Added - BL-154: External Contribution Ecosystem Path Hardening

- DSM_3 Section 6.6.7 Phase 3 Step 13: explicit required entries (`dsm-central`, `portfolio`, `contributions-docs`) for ecosystem path registry during External Contribution onboarding
- DSM_0.2 Session-End Inbox Push: path validation step to prevent inbox routing to project's own governance inbox instead of DSM Central
- dsm-go Step 2a.5: missing ecosystem registry in External Contribution projects escalated from warning to action item

### Source

- Reclaim Launcher S5-S7 feedback; Session 128

## [1.3.45] - 2026-03-14

### Added - BL-177: Sprint Boundary Gate in /dsm-go

- dsm-go Step 3.6: verifies boundary artifacts (checkpoint, journal, feedback) exist for the most recently completed sprint before suggesting new sprint work; flags missing items for user action; skips for first sprint in a project

### Source

- dsm-graph-explorer S28 feedback (Entry 37, Proposal #32); Session 128

## [1.3.44] - 2026-03-14

### Added - BL-180 + BL-181: Sprint Alignment Review and Hub Notification

- DSM_0.2 Sprint Cadence: alignment review step (planned vs actual, deviations, unplanned additions, next sprint scope for user confirmation before proceeding)
- DSM_0.2 Sprint Cadence: hub/portfolio notification checklist item with structured sprint completion notification format for spoke projects via `_inbox/`

### Source

- dsm-graph-explorer S29-S30 feedback (Entry 39-40, Proposals #34-#35); Session 128

## [1.3.43] - 2026-03-14

### Added - BL-155: Debug Disambiguation and PR Description Maintenance

- DSM_4.0 Section 4.6 (Bug Disambiguation): re-verify symptoms before assuming same root cause when user reports issue persistence
- DSM_4.0 Section 4.7 (PR Description Maintenance): update PR title/body before next push when scope expands
- DSM_0 key sections listing updated for DSM_4.0

### Source

- Reclaim Launcher Session 5 process review; Session 128

## [1.3.42] - 2026-03-14

### Added - BL-185: Self-Terminating Actions Protocol

- DSM_0.2 Destructive Action Protocol: new "self-terminating actions" category covering operations that invalidate the agent's own session context (renaming working directory, moving .claude/, deleting CLAUDE.md, switching branches with stale context); requires confirmation + session-impact warning

### Source

- Stress-test project sessions (practice #8/#9, S4); Session 128

## [1.3.41] - 2026-03-14

### Added - BL-152: Testability Assessment at Validation Gates

- DSM_0.2 Pre-Generation Brief Protocol, Gate 3: testability assessment checklist (what can be automated, what requires manual testing, what tool limitations exist) before committing to a test strategy

### Source

- Reclaim Launcher Issue #4 retrospective (S87); Session 128

## [1.3.40] - 2026-03-14

### Added - BL-167 Partial + BL-179: dsm-align and Lightweight Chain Improvements

- dsm-align: `.gitattributes` canonical file check (step 8), creates `* text=auto eol=lf` if missing, warns if LF enforcement absent; template and report line added (BACKLOG-167 partial)
- dsm-light-go: checkpoint fallback in safety gate; if `mode: light` marker missing but lightweight checkpoint exists, proceeds with warning instead of forcing full `/dsm-go` (BACKLOG-179)
- dsm-light-wrap-up: commit before checkpoint (was: checkpoint before commit); checkpoint now reflects actual committed state; separate checkpoint commit as step 5 (BACKLOG-179)
- DSM_0.2 Lightweight Session Lifecycle: safety gate description updated to document checkpoint fallback

### Source

- Stress-test project feedback (practice S1-S6), Artz S2-S4; Session 128

## [1.3.39] - 2026-03-14

### Added - BL-184: Notebook Cell Output Validation

- DSM_0.2 Notebook Collaboration Protocol: every cell must produce output that validates its correctness; examples by cell type (imports with versions, data loading with shapes, feature engineering, model fitting, configuration); new anti-pattern for silent cells
- BL-185 (Self-Terminating Actions Protocol): proposed, tracks agent actions that destroy session context (renaming working directory, moving .claude/, deleting CLAUDE.md)
- Stress-test evidence annotated on BL-149, BL-163, BL-167, BL-179

### Source

- Stress-test project sessions (practice S1-S6); Session 128

## [1.3.38] - 2026-03-16

### Added - BL-156 Phase 3 Partial: Take AI Bite Spoke Configuration

- Take AI Bite `.claude/CLAUDE.md`: spoke project configuration with Documentation (DSM 5.0) / Standard Spoke pattern, Protocol Applicability table, content sync workflow, public-facing content rules (DSM acronym disambiguation), Session Transcript and Pre-Generation Brief reinforcement blocks
- DSM_3 Section 7 Project Registry: added Take AI Bite entry ("Public-facing framework distribution, curated DSM subset for external adoption")
- DSM_3 Section 7: Graph Explorer metrics refreshed (218 -> 471 tests, Sprint 11)
- 3 new backlog items from spoke feedback: BL-179 (Lightweight Chain Resilience), BL-180 (Sprint Alignment Review at Boundary), BL-181 (Sprint Boundary Hub/Portfolio Notification)

### Source

- BL-156 Phase 3 (Session 122); spoke feedback from Artz S2-S4 and Graph Explorer S29-S30

## [1.3.37] - 2026-03-10

### Added - Third-Party Asset Due Diligence (BACKLOG-166)

- DSM_6.0 Principle 1.8 (Know What You Own): checklist and guidance for verifying licensing before deploying any third-party asset (AI-generated images, stock photos, fonts, code snippets, API data); covers free-tier vs. paid-tier ownership distinctions, high-risk scenario flags, scope (public-facing vs. internal), timing (at creation, not deployment), and relationship to Principle 1.7 (Own Your Process); evidence from Recraft AI logo incident (dsm-blog-poster S4)
- DSM_6.0 Section 2.2 Gaps table: new row mapping third-party asset licensing gap to Principle 1.8
- DSM_0: updated DSM_6.0 description from seven to eight principles, added Know What You Own

### Source

- BL-166 (Session 112); evidence from dsm-blog-poster inbox (Recraft logo licensing incident, S4)

## [1.3.36] - 2026-03-10

### Added - Standard Spoke Pattern + Project Participation Pattern Detection (BACKLOG-169)

- DSM_3 Section 6.9 (Standard Spoke Pattern): unified entry point for the default DSM project type; covers core properties table, git configuration, CLAUDE.md template with Protocol Applicability table, canonical directory structure, bidirectional data flow architecture, communication protocol, and anti-patterns; references existing detailed sections (6.1-6.7) without duplication
- DSM_3 Section 6 intro: project participation pattern overview table comparing all three patterns (Standard Spoke, External Contribution, Private Project) across git tracking, registry visibility, inbox direction, feedback push, README notifications, cross-repo writes, and CLAUDE.md location; clarifies that the DSM track (Notebook/Application/Hybrid/Documentation) and participation pattern are orthogonal dimensions
- DSM_0.2 Participation Pattern Detection subsection: extends session-start Project Type Detection to identify both track and participation pattern; agent announces "This is a [track] project ([DSM version]) using the [pattern] pattern"; detection indicators for Standard Spoke, External Contribution, and Private Project; governs inbox behavior, feedback push, README notifications, and cross-repo write scope
- DSM_0: added Section 6.9 to DSM_3 content description

### Source

- BL-169 (Session 112); gap surfaced after formalizing Private Project Pattern in Section 6.8 (S111)

## [1.3.60] - 2026-03-10

### Added - Private Project Pattern + Enabling File Content Protocol (BACKLOG-162)

- DSM_3 Section 6.8 (Private Project Pattern): canonical template for privacy-sensitive projects using local git only (no remote); covers CLAUDE.md template with Protocol Applicability table, directory structure, data flow architecture, sanitized feedback protocol with minimal "feedback available" inbox notification, local README as project status dashboard, WSL2 path constraint, and initialization checklist override
- DSM_0.2 Enabling File Content Protocol: meta rule that enabling files (backlog items, checkpoints, decisions, plans, epochs, handoffs) are scope/tracking artifacts and never implementation targets; agent must flag any "document X in this file" pattern and surface it to the user
- DSM_0 listing: added Section 6.8 to DSM_3 content description
- BL-162 corrected: git tracking "No" changed to "Local only (no remote)"; implementation section now references DSM_3 Section 6.8 instead of self-documenting in the backlog item

### Source

- BL-162 promotion to DSM body (Session 111); field evidence from AMEX (Sessions 98-100) and Steuern (Session 110) private projects

## [1.3.59] - 2026-03-04

### Added - Fork Governance Isolation ("My Fork, My Rules")

- DSM_6 Principle 1.6 (Match the Room): replaced NOTE placeholder with governance boundary subsection; defines two dimensions of external contribution governance: outward (contribution matches upstream) and inward (contributor maintains governance sovereignty)
- DSM_3 Section 6.6.10 (Fork Governance Isolation): new operational guidance for maintaining governance sovereignty when upstream projects have AI governance artifacts; covers file handling (rename, not delete), governance layers, conflict resolution, and session-start awareness
- DSM_3 Section 6.6 Anti-Patterns: 3 new entries for governance isolation violations (following upstream AI governance as active instructions, deleting upstream governance files, letting upstream override contributor process)
- DSM_6 Section 2.1 Evolution table: new protocol mapping row for Fork Governance Isolation
- DSM_0: added Section 6.6.10 to the DSM_3 listing

### Source

- Architecture designed in Session 92; evidence from Reclaim Launcher external contribution (Sessions 82-89, all 3 PRs merged upstream)

## [1.3.58] - 2026-03-02

### Added - Lightweight Session Lifecycle (BACKLOG-151) + Per-Session Feedback (BACKLOG-153 Phase 1)

- DSM_0.2 Lightweight Session Lifecycle: new protocol section documenting the lightweight mode, safety gate, deferred-items pattern, and transcript behavior for continuation sessions with known tasks
- DSM_0.2 Session Transcript Protocol: updated lifecycle paragraph with lightweight mode exception (transcript persists, boundary marker appended instead of overwritten)
- DSM_0.2 Command File Version Tracking: added `dsm-light-go` and `dsm-light-wrap-up` to user-level command listing
- `/dsm-go` and `/dsm-light-go`: checkpoint consumption at session start (read, annotate, move to done/) prevents checkpoint accumulation
- `/dsm-wrap-up` and `/dsm-quick-wrap-up`: parallelism hints for independent startup steps, MEMORY.md context notes, cross-references between variants
- Moved 22 accumulated historical checkpoints to `docs/checkpoints/done/`
- DSM_0.2 DSM Feedback Tracking: rewritten for per-session files (`YYYY-MM-DD_sN_{type}.md`) with lifecycle (create -> notify -> process -> done/), feedback directory requirements, new anti-pattern
- DSM_0.2 Session-End Inbox Push: updated all references from append-only entries to per-session files, done/ convention replaces mark-or-remove
- DSM_0.2 Technical Progress Reporting: updated intro to distinguish append-only model from per-session, relationship table now includes Lifecycle column

### Source

- BACKLOG-151 (Lightweight Session Lifecycle Mode): implemented across S87-S89, validated with full chain test (S87 light wrap-up -> S88 light go -> S88 light wrap-up -> S89 light go)
- BACKLOG-153 Phase 1 (Per-Session Feedback Lifecycle): protocol design in DSM_0.2; command updates and spoke migration deferred to Phase 2-3

## [1.3.57] - 2026-03-01

### Added - Spoke Feedback Protocol Improvements

- DSM_0.2 Phase 0.5: ad-hoc research documentation trigger; when the agent conducts incidental research (web searches, reference analysis) during implementation, write findings to `docs/research/` as part of the process, with a threshold (>5 min to reconstruct) to avoid overhead for trivial lookups
- DSM_0.2 Feedback Tracking: filing completeness cross-reference; explicitly connects feedback filing to the Immediate push rule in Session-End Inbox Push, with new anti-pattern for filing without notification
- `/dsm-go` step 3.5: checkpoint auto-read at session start; reads latest checkpoint from `docs/checkpoints/` to supplement MEMORY.md with consolidated pending work details

### Source

- Three process gap feedback entries from Reclaim Launcher external contribution (Sessions 2-3): research artifact not auto-generated, feedback inbox notification skipped, checkpoint not read at session start. Common pattern: agent completes primary action but misses automatic follow-through.

## [1.3.56] - 2026-03-01

### Added - Artifact Lifecycle Management (BACKLOG-137)

- DSM_0.2 Artifact Lifecycle Management: new protocol section with transcript retirement rule (>10 sessions without STAA flag moves to done/), checkpoint supersession rule (newer checkpoint covers same scope + prior next steps acted on), and anti-patterns
- Sprint Boundary Checklist: added "superseded checkpoints moved to done/" step
- Project CLAUDE.md: backlog done/ yearly archival convention (DSM Central specific)
- Research document: `docs/research/2026-03-01_information-lifecycle-management.md` with audit metrics (125 done backlog items, 22 checkpoints without done/, 24 pending transcripts) and lifecycle design

## [1.3.55] - 2026-03-01

### Added - AI Collaboration Ethics (BACKLOG-124)

- DSM_6.0 Principle 1.7 "Own Your Process": new attribution/disclosure principle with decision framework (context-dependent disclosure levels for external contributions, published artifacts, internal work, exploratory work); guidance on what to disclose (tool, nature of involvement, human contribution) and what not to (prompts, token counts); relationship to Earn Your Assertions and external frameworks (EU AI Act, arXiv:2512.00867)
- DSM_6.0 Principle 1.3 accountability corollary: explicit statement that the human who submits work is the author of record regardless of tools used; responsibility for correctness, completeness, style, and impact is not diminished by AI output quality
- DSM_6.0 Guideline 2.3 "Environmental Awareness": awareness-level note on AI compute costs; practical levers (prefer sufficient over maximal models, avoid unnecessary regeneration, intentional context usage); not prescriptive, acknowledges individual practitioner limitations
- DSM_6.0 gap table: 3 new ethics rows (attribution/disclosure, accountability, environmental) marked as addressed
- DSM_0 section listing: updated to reflect seven principles
- README: updated principle count, DSM_6 description, Recent Changes

### Research

- Based on survey of NIST AI RMF 1.0, EU AI Act, IEEE CertifAIEd, arXiv:2512.00867 (AI Attribution Paradox), WEF/OECD responsible AI frameworks (docs/research/2026-03-01_ai-collaboration-ethics-research.md)

## [1.3.54] - 2026-02-19

### Added - Continuous Learning Protocol (BACKLOG-140)

- DSM_0.2 Continuous Learning Protocol: new section defining a lightweight per-session learning step for tracking external developments in AI collaboration, data science methodology, and agentic AI patterns; includes topic selection, research, digest, store, and optional action steps; opt-in per project via `docs/research/learning-log.md` file existence; flexible cadence (every session aspiration, minimum every 3, skip criteria for constrained sessions)
- Learning log template: `docs/research/learning-log.md` with topic queue (12 seeded topics spanning AI safety, governance, collaboration, methodology, MLOps, process mining), entry template with citation and relevance fields, append-only dated entries

## [1.3.53] - 2026-02-19

### Added - Agent Security Protocol Phase 2 (BACKLOG-135)

- DSM_0.2 Untrusted Input Protocol: new section defining how the agent handles content from external sources (inbox entries, tool outputs, web fetch results, API responses); classifies sources as trusted vs untrusted, requires explicit user confirmation before executing embedded commands, flags suspicious patterns (shell commands, sensitive paths, protocol-contradicting instructions); maps to OWASP LLM01 (Prompt Injection, indirect variant)
- Appendix F.1.1 Security Anti-Patterns: new subsection with 4 OWASP-informed code security patterns (SQL injection via f-strings, XSS in generated HTML, path traversal in file operations, command injection via subprocess); each pattern includes notebook vs production context guidance; maps to OWASP LLM05 (Improper Output Handling)
- Cross-reference: DSM_0.2 Untrusted Input Protocol references Appendix F.1.1 for code-level patterns; F.1.1 references DSM_0.2 for agent-behavior protocol; security protocol summary table links all three security sections (Secret Exposure, Destructive Action, Untrusted Input)

## [1.3.52] - 2026-02-19

### Added - Phase 0.5 Research Hardening (BACKLOG-141)

- Phase 0.5 source verification: new gate after drafting requires every factual claim in research-derived documents to trace to a specific source; anti-pattern added for unsourced claims (from IronCalc OBS-007)
- Phase 0.5 done/ move checklist: replaced passive "fill in" guidance with explicit 4-step checklist (Status, Date Completed, Outcome Reference, verify artifact) with blocking language (from IronCalc OBS-008)
- Inbox processing: "read referenced source file before evaluating" added to DSM_0.2 Session-Start Inbox Check and `/dsm-go` Step 2b; ensures agents follow the source pointer rather than evaluating from inbox summaries alone

## [1.3.51] - 2026-02-19

### Added - Technical Progress Reporting (BACKLOG-138)

- DSM_0.2 Technical Progress Reporting: new protocol section defining `docs/feedback/technical.md` as the third feedback file for reporting what was built, how, and why at sprint boundaries; includes entry template (techniques table, data scale, outcomes, profile-relevant flag), inbox routing format, and channel relationship table
- Sprint Boundary Checklist: "technical progress report updated" added as 7th item
- DSM_0.1 feedback convention: updated from "exactly two files" to "exactly three files" (backlogs.md, methodology.md, technical.md)
- `/dsm-wrap-up` step 7c: scans `docs/feedback/technical.md` for unpushed entries alongside backlogs and methodology files
- Inbox entry type: "Technical Progress Report" added to `_inbox/README.md` type enum

## [1.3.50] - 2026-02-18

### Added - Reasoning Lessons Protocol formalization

- DSM_0.2 Reasoning Lessons Protocol: new optional section formalizing the auto/STAA extraction system from BACKLOG-126 experiment; documents file format, extraction modes, maintenance rules (pruning cadence, promotion criteria, file size target), STAA guidance, and spoke opt-in mechanism
- Wrap-up STAA recommendation: `/dsm-wrap-up` and `/dsm-quick-wrap-up` Step 0 now outputs a targeted STAA recommendation after auto extraction, replacing the generic session-start reminder
- Post-experiment cleanup: removed "(BACKLOG-126 experiment)" labels from dsm-go (Steps 1.5, 6.5, 6.7), dsm-wrap-up, and dsm-quick-wrap-up command steps
- dsm-go Step 6.7: simplified from generic STAA reminder to conditional reminder based on previous session's wrap-up recommendation

## [1.3.49] - 2026-02-18

### Added - Agent Security Protocol Phase 1 (BACKLOG-134)

- DSM_0.2 Secret Exposure Prevention: agent-side pre-commit check against sensitive file patterns (`.env`, `*.key`, `*.pem`, `credentials.*`, etc.); refuses to stage matches without explicit user confirmation
- DSM_0.2 Destructive Action Protocol: extends destructive command protections to non-bash operations (cross-repo writes, substantive file deletion, methodology structural changes)
- Project CLAUDE.md: reinforcement of both new protocols; Destructive Command Protocol extended with non-bash operations list

## [1.3.48] - 2026-02-18

### Added - README Change Notification Filter (BACKLOG-132)

- DSM_0.2 README Change Notification: sender-side relevance filter with send/skip criteria; internal-only changes (version bumps for protocol additions, date-only updates, formatting fixes) no longer trigger portfolio notifications
- `/dsm-wrap-up` step 1: relevance filter evaluation before sending README notifications; logs decision with reason

### Changed - Command Source Consolidation, Phase B (BACKLOG-131)

- Consolidated all 12 DSM command files into `scripts/commands/` as single canonical source; 5 project-level commands moved from `.claude/commands/` (git-tracked) to `scripts/commands/` (git-tracked) with deploy-back via sync script
- `scripts/sync-commands.sh`: dual-target deploy, user-level to `~/.claude/commands/` and project-level to `.claude/commands/`; deployed project-level commands gitignored as artifacts
- `/dsm-wrap-up` step 1: relevance filter evaluation before sending README notifications; logs decision with reason

## [1.3.47] - 2026-02-18

### Changed - Contributions-docs Externalization (BACKLOG-129)

- Migrated `contributions-docs/` from DSM Central to external governance storage repo (`~/dsm-collaboration-storage`); instance-specific governance no longer tracked in DSM Central git history
- All literal `contributions-docs/` references in DSM_0.2 (6 locations), DSM_3 (~15 locations), and DSM_0.1 (1 location) replaced with `{contributions-docs-path}` template variable resolved from Ecosystem Path Registry
- `.gitignore`: blanket `contributions-docs/` entry replaces specific file entry
- `/dsm-wrap-up` and `/dsm-quick-wrap-up`: new governance storage commit step auto-commits external governance repo when modified; cross-repo commit note updated

## [1.3.46] - 2026-02-17

### Added - Command File Version Tracking, Phase A (BACKLOG-130)

- `scripts/commands/`: tracked canonical source for 7 user-level DSM command files (dsm-align, dsm-go, dsm-quick-wrap-up, dsm-refresh-all, dsm-refresh-memory, dsm-staa, dsm-wrap-up)
- `scripts/sync-commands.sh`: sync script with `--check` (drift detection) and `--deploy` (tracked -> runtime) modes
- DSM_0.2 Command File Version Tracking section: edit flow (edit tracked source, then sync), drift detection, anti-patterns
- `/dsm-align` step 9: command file drift detection (DSM Central only)
- Phase A scope: user-level commands only; project-level `.claude/commands/` already tracked

### Changed - README Change Notification detail requirement

- DSM_0.2 README Change Notification: entry format now requires specific "What changed" field with actual text added/modified/removed, replacing vague "Summary of changes" placeholder; receiver must be able to act without reading the full source README

## [1.3.45] - 2026-02-17

### Added - Revert Safeguards Protocol (BACKLOG-127)

- DSM_0.2 Revert Safeguards Protocol section: Pre-Implementation Snapshot, Backlog Item Revert Section, Feature Branch for Experimental Changes
- `/dsm-backlog` template updated: prompts for untracked files and includes Revert Procedure section
- BACKLOG-130 retroactive revert procedure added
- Snapshot format template for `plan/archive/` pre-edit snapshots

## [1.3.44] - 2026-02-17

### Added - Inbox Append Rule

- DSM_0.2 Session-End Inbox Push: new anti-pattern, do not overwrite existing inbox files; always append when unprocessed entries exist
- DSM_0.2 README Change Notification: explicit append rule with cross-reference to inbox push anti-patterns

## [1.3.43] - 2026-02-17

### Added - Ecosystem Path Registry (BACKLOG-128)

- Ecosystem Path Registry: `.claude/dsm-ecosystem.md` replaces hardcoded cross-repo paths with configurable logical name -> path mappings
- New DSM_0.2 section: Ecosystem Path Registry (consumption, logical names, fallback behavior, validation)
- `/dsm-go` Step 2a.5: reads and validates registry at session start; warns on missing paths
- `/dsm-go` Step 6.7: STAA reminder when session transcript is archived (BL-126 enhancement)
- `/dsm-wrap-up` Step 1b: uses registry for portfolio inbox path instead of hardcoded path
- DSM_0.2 README Change Notification: portfolio target uses `{portfolio-path}` from registry
- DSM_3: hub and governance references use registry instead of hardcoded absolute paths
- Revert safety: pre-edit snapshots in `plan/archive/BL-128_pre-edit-snapshots.md`

## [1.3.42] - 2026-02-16

### Added - Reasoning Lessons Experiment (BACKLOG-126)

- Reasoning Lessons extraction: `[auto]` tagged entries extracted at CA wrap-up, `[STAA]` tagged entries from dedicated analysis sessions
- `/dsm-staa` command: Session Transcript Analysis Agent for deep transcript review without creating its own transcript (avoids recursion)
- `/dsm-go` Step 1.5: reads `.claude/reasoning-lessons.md` at session start to prime with accumulated patterns
- `/dsm-go` Step 6.5: archives previous session transcript to `.claude/transcripts/{timestamp}-ST.md` before reset
- `/dsm-wrap-up` and `/dsm-quick-wrap-up` Step 0: scans transcript for notable reasoning patterns before other wrap-up steps
- 10-session experiment (Sessions 51-61) comparing lightweight automated extraction vs full STAA analysis

## [1.3.41] - 2026-02-15

### Added - Blog Publication Tracking (BACKLOG-071)

- Step 7 (Tracking) added to DSM_1.0 Section 2.5.6 Blog Process: update tracker after publication, move files to done/
- Sprint Boundary Checklist in DSM_2.0: added "Blog publication tracker updated" item (template and example)
- Publication Tracker subsection in DSM_0.1 Blog Artifacts: standard table format, status key, scope by project type (spoke, hub, external contribution)
- IronCalc contributions-docs scaffolding: added missing done/ subfolders to blog/, checkpoints/, handoffs/

## [1.3.40] - 2026-02-15

### Added - Citation Backfill Audit (BACKLOG-113)

- Inline citations added to DSM_0: Semantic Versioning (Preston-Werner, 2013), Architecture Decision Records (Nygard, 2011)
- Inline citations added to DSM_4.0: ADRs (Nygard, 2011), TDD (Beck, 2003)
- Hub-and-spoke pattern attribution added to DSM_3 (general distribution/organizational pattern)
- References sections added to DSM_0 and DSM_4.0
- Bare URLs in active backlog items (BACKLOG-050, 051, 052) converted to contextual citations
- Done/ research docs verified against citation standard

## [1.3.39] - 2026-02-15

### Added - IronCalc-Derived Protocols and Breaking Change Notification

- Breaking Change Notification Protocol in DSM_0.2 and DSM_3 Section 6.4.6 (BACKLOG-115): hub sends inbox entries to spokes on breaking changes, spoke updates Protocol Applicability table, agent enforces grace period
- Research Execution Methodology in DSM_0.2 Phase 0.5 (BACKLOG-117): 4-step pipeline (gather, cluster, synthesize, validate), full citation metadata requirement, external contribution tone calibration
- Reference File Size Protocol in DSM_0.1 (BACKLOG-119): ~500 line max, split-by-topic guidance, context budget warning for large files
- Mechanical vs Decision Edits in DSM_0.2 (BACKLOG-120): batch mechanical updates to reduce approval fatigue, never mix with decision edits
- Context Budget Protocol in DSM_0.2 (BACKLOG-121): large file read options, 40% threshold early warning, session planning estimation
- DSM_0 listing updated for Section 6.4.6
- README: contact email added, framework description repositioned (production > research > academic, "continuously refined")

## [1.3.38] - 2026-02-15

### Added - Take a Bite Delivery Principle (BACKLOG-122)

- Session Delivery Budget in DSM_0.2: 5-7 files / ~500 lines per session review capacity heuristic
- Research Phase Guard in DSM_0.2 Phase 0.5: gather-synthesize-checkpoint-go/no-go cycle to prevent unbounded exploration
- PR Size Guidance in DSM_3 Section 6.6.7: calibration table based on upstream merge history, anti-patterns
- DSM_6.0 Table 2.2 gap status: added Status column, 3 gaps marked as addressed, research guard row added
- BACKLOG-125 proposed: DSM_6.0 Novelty Analysis and Publication Research
- Research file: `docs/research/2026-02-15_dsm6-chatgpt-citations-and-analysis.md` (18 citations, academic mappings, publishability scores)

### Fixed

- /dsm-wrap-up README notification bug: now uses baseline commit SHA instead of working tree diff (was silently skipping all committed README changes)
- /dsm-go: now records HEAD commit SHA in session baseline for wrap-up comparison
- Overdue portfolio notification sent for README changes from Sessions 44-45

## [1.3.37] - 2026-02-15

### Added - Systematic Codebase Analysis

- Systematic Codebase Analysis template in DSM_3 Section 6.6.9 (BACKLOG-118): 7-dimension quantitative analysis template for external contributions (quantitative overview, function patterns, error handling, test patterns, module organization, formatting, dependencies)
- DSM_0 section listing updated for Section 6.6.9

### Fixed

- DSM_6.0 heading typo: removed stray 'b' character from document title

## [1.3.36] - 2026-02-15

### Added - AI Collaboration Principles, README Scope Update

**DSM_6.0 AI Collaboration Principles v1.0** (new document):
- Six foundational principles for human-AI collaboration: Take a Bite, The Human Brings the Spark, Earn Your Assertions, Understand/Review/Decide, Know Your Context, Match the Room
- 32 existing protocol mappings to principles across all DSM documents
- Inclusive Language guardrail in Match the Room: agent surfaces conflicts with external conventions, human decides
- Gap analysis identifying 3 areas requiring new protocols (BACKLOG-119, 121, 122)
- Cross-validated against full DSM documentation (BACKLOG-123)

**TAKE_A_BITE.md** (new document):
- Short version of the central principle with cookie metaphor
- Hints at Earn Your Assertions and the broader framework

**DSM_0 START HERE** updated:
- Added DSM 6.0 section with six principles and key sections
- Added TAKE_A_BITE.md cross-reference

**README.md** updated:
- Broadened scope: DSM is a human-AI collaboration framework, not just data science project management
- Replaced "battle-tested" with neutral language throughout
- Added DSM_6.0 and TAKE_A_BITE.md to System Components, Repository Structure, and document table
- Added Documentation Track (DSM 5.0) and Collaboration Principles (DSM 6.0) to System Architecture diagram
- Heading "Battle-Tested Case Studies" renamed to "Applied Across Projects"

**DSM_0.2** updated:
- Inclusive Language section: avoid violence, gender, political, religious, superiority-implying language
- External contribution guardrail: agent must surface inclusive language conflicts, human approves consciously

**Backlog:**
- BACKLOG-123 implemented (Cross-Validate DSM_6.0 Against DSM Documentation)

---

## [1.3.35] - 2026-02-13

### Added - External Contribution Protocol Hardening, README Notification

**DSM_0.2** updated (BACKLOG-114):
- External Contribution exception in Session-Start Inbox Check: agents must not create `_inbox/` in external repos
- Protocol precedence rule in CLAUDE.md Configuration: project-specific CLAUDE.md overrides generic DSM_0.2
- Validation gate before migration confirmation: verify governance scope before sending confirmation
- Inbox vs feedback file roles clarified in Immediate push protocol: feedback file is source of truth, inbox is notification
- README Change Notification: added notification targets table (spoke->portfolio+central, central->portfolio)

**`/dsm-go`** updated (BACKLOG-114):
- Step 2 rewritten with explicit dependency chain: 2a project type detection (gates 2b/2c) -> 2b inbox check -> 2c version check
- Step 1 documents fallback behavior when MEMORY.md fails to load
- Steps 6-7 document external contribution trade-off (Claude Code `.git/info/exclude` safety net)

**`/dsm-wrap-up`** updated:
- README check added as step 1: detects README changes, sends inbox to portfolio and DSM Central

**IronCalc feedback:**
- Full incident evidence transferred to `contributions-docs/IronCalc/feedback/methodology.md` (OBS-001, 11 problems, source audit with verbatim quotes)
- Proposed fixes registered in `contributions-docs/IronCalc/feedback/backlogs.md` (BACKLOG-114, 115)

**Backlog:**
- BACKLOG-114 implemented (External Contribution Protocol Hardening, 7 fixes)
- BACKLOG-115 proposed (Breaking Change Notification to Spokes)

---

## [1.3.34] - 2026-02-13

### Added - Operational Monitoring, Root File Policy, Self-Compliance Audit

**DSM_2.0** updated (BACKLOG-087):
- Operational Monitoring section: metric categories (7 rows), recommended tool stack (4 rows), integration points, reporting format template

**DSM_0.1** updated:
- Root File Policy: allowed/not-allowed tables for project root files
- Blog Workflow section: three-document pipeline (journal, blog-materials, blog/linkedin) (BACKLOG-105)

**DSM_3 Section 6.6.7** added (BACKLOG-072):
- Contribution Scope Planning: scope assessment matrix, risk levels, planning templates

**DSM_3 Section 6.6.8** added (BACKLOG-070):
- CLAUDE.md template, kickoff prompt, setup checklist for external contributions

**DSM_5.0** updated (BACKLOG-081):
- Hub exemption note for docs/feedback/ in Section 9.3
- Self-compliance audit: 38 pre-convention backlog items backfilled with Date Implemented

**DSM_0.2** updated:
- WARNING added to CLAUDE.md Configuration: `@` reference as discovery mechanism
- `/dsm-align` step 7: validates CLAUDE.md `@` reference to DSM_0.2

**Tooling:**
- `/dsm-refresh-memory` global skill created (BACKLOG-110): lightweight MEMORY.md reload
- `/dsm-refresh-all` global skill created (BACKLOG-110): full context reload without session infrastructure
- `/dsm-quick-wrap-up` global skill created: autonomous wrap-up without feedback push
- `/dsm-go` step 3 added: handoff lifecycle (moves consumed handoffs to done/)
- `/dsm-align` steps 4-6 added: feedback compliance, consumed handoffs, feedback push

**Backlog:**
- BACKLOG-070, 072, 081, 087, 105, 110 implemented

---

## [1.3.33] - 2026-02-13

### Added - External Contribution Governance, Citation Standards, /dsm-align

**DSM_3 Section 6.5** added (BACKLOG-096):
- AI Contribution Guidelines Template: reusable 6-section template for OSS projects
- Policy spectrum (5 positions from full embrace to full ban with real-world URLs)
- Adaptation process for DSM agents approaching external projects
- Legal context table by license type

**DSM_3 Section 6.6** added (BACKLOG-069):
- External Contribution Governance: governance for contributing to repos you don't own
- Governance artifact location pattern (contributions-docs/{project}/)
- Key differences from spoke projects (7-row comparison table)
- Mandatory checks (AI policy step zero, upstream precedence rule)
- CLAUDE.md pattern for external projects with protocol applicability table
- Feedback cadence tied to contribution milestones

**DSM_3 Section 6.6.7** added (BACKLOG-094):
- External Contribution Onboarding Lifecycle: 3-phase pattern (Research, Onboarding, Deepening)
- Phase transition validation criteria

**DSM_0.1** updated (BACKLOG-112):
- Citation Standards section: when to cite, format by source type, location by document type

**DSM_0.2** updated:
- Pre-Generation Brief: citations log reference points to DSM_0.1 Citation Standards
- References section added (Semantic Versioning, Diataxis), modeling its own recommendation
- Project Type Detection: External Contribution row added

**DSM_0** updated:
- Section 6.5 and 6.6 bullets added to DSM_3 listing

**Tooling:**
- `/dsm-align` global skill created (BACKLOG-109): idempotent structure alignment for spoke projects
- `/dsm-feedback` absorbed into `/dsm-align` and deleted
- `/dsm-go` updated to reference `/dsm-align` for structure checks

**Backlog:**
- BACKLOG-112, BACKLOG-113 created (citation standards and backfill audit)
- _inbox/ migration from docs/inbox/ to project root

---

## [1.3.32] - 2026-02-11

### Changed - Feedback Push, VRP Clarification, Experiment Types

**DSM_0.2** updated:
- Visible Reasoning Protocol: added anti-pattern clarifying VRP does not replace the Pre-Generation Brief
- Session-End Inbox Push: added "Immediate push" option for ripe entries with explicit file routing (methodology.md for observations, backlogs.md for proposals, both + inbox)
- Read-Only Access: renamed from "Scoped Read-Only Exploration" to unconditional "Read-Only Access Within Repository" (Session 31 change, first release)
- Version header bumped to v1.3.11

**DSM_4.0** updated:
- Section 4.4: added "Experiment types" note distinguishing tuning experiments (threshold selection, no learned weights) from model experiments (train/test splits, cross-validation required)

**Inbox** processed:
- Graph Explorer: 6 entries processed (3 implemented, 3 cleared)

---

## [1.3.31] - 2026-02-10

### Added - Visible Reasoning Protocol

**DSM_0.2** updated:
- Visible Reasoning Protocol section: agents output substantive reasoning as visible conversation text using delimiters, not hidden thinking blocks (workaround for VS Code extension collapsing thinking, microsoft/vscode#287658)
- Protocol Reinforcement table: added Visible Reasoning Protocol row (all projects)
- Version header bumped to v1.3.10

**Global command** `/dsm-go` updated:
- Inline thinking rule replaced with reference to DSM_0.2 Visible Reasoning Protocol

---

## [1.3.30] - 2026-02-10

### Added - Bidirectional Project Inbox Pattern (BACKLOG-092)

**DSM_3 Section 6.4** added:
- Inbox architecture: hub inbox (one file per spoke), spoke inbox (from-hub.md)
- Entry format with Type, Priority, Source fields
- Lifecycle: write, surface, process, remove (transit point, not archive)
- Spoke-to-hub flow with ripe criteria and push process
- Hub-to-spoke flow for action items and notifications
- Anti-patterns for inbox misuse

**DSM_3 Section 6** updated:
- Intro paragraph mentions inbox pattern
- Scaffolding checklist (6.2.2): docs/inbox/ added

**DSM_0.2** updated:
- Session-Start Inbox Check: spoke agents check docs/inbox/ at session start
- Inbox README template: spoke agents create README.md with entry template when initializing docs/inbox/
- Migration confirmation: spoke agents send confirmation entry to DSM Central inbox after migration
- Session-End Inbox Push: spoke agents push ripe feedback entries to hub inbox, with ripe criteria and anti-patterns
- Transition note: docs/backlog/ renamed to docs/inbox/, auto-rename on detection
- Version header bumped to v1.3.9

**DSM Central** `docs/inbox/` created:
- README.md with entry template, lifecycle explanation, and file conventions

**DSM_4.0** updated:
- docs/inbox/ added to both project structure trees (DSM 1.0 and DSM 4.0 patterns)

**DSM_0** updated:
- Implementation Guide listing includes inbox pattern reference

---

## [1.3.29] - 2026-02-10

### Added - Anti-Pattern Requirements and Research Lifecycle (BACKLOG-089, BACKLOG-093)

**DSM_0.2 Anti-Patterns** (BACKLOG-089):
- Pre-Generation Brief Protocol: anti-patterns for premature artifact generation and batch briefs
- Notebook Collaboration Protocol: anti-patterns for batch cell generation and skipping output validation
- DSM Feedback Tracking: anti-patterns for mixing project-local fixes with methodology proposals
- Sprint Cadence: anti-patterns for monolithic sprints, skipping boundary checklist, deferring feedback

**DSM_0.2 Phase 0.5 Research Lifecycle** (BACKLOG-093):
- Research file header template: Purpose/Question, Target Outcome, Status, dates, Outcome Reference
- Validation gate: three-question checklist before processing research into outcomes
- Archive convention: `docs/research/archive/` for consumed research with traceability fields
- Research-specific anti-patterns for undirected research, stale files, and skipped validation

---

## [1.3.28] - 2026-02-10

### Added - Blog Workflow Refinements and docs/guides/ Standard (BACKLOG-095, 097, 098, 101)

**DSM_0.1 Blog Artifacts** updated:
- Materials file role clarified: one per blog post, dual purpose (capture + structure), no separate journal file (BACKLOG-101)
- Blog post metadata header template: Date, Author, Status, Platform (BACKLOG-095)
- Mermaid diagram recommendation for architecture and flow diagrams (BACKLOG-098)

**DSM_1.0 Section 2.5.6** updated:
- Step 1 (Preparation) clarified: materials file is per-post with dual capture/structure role
- Mermaid reference added to technical details bullet
- Metadata header reference added to File Naming paragraph

**DSM_4.0 Section 2.2** updated:
- docs/ subfolder tree expanded from 4 to 8 subfolders (added feedback/, plans/, research/, guides/)
- Aligns with DSM_0 which already documented 7 subfolders (BACKLOG-097)

**DSM_0** updated:
- DSM 4.0 pattern tree: added docs/guides/ subfolder

---

## [1.3.27] - 2026-02-10

### Added - Spoke Update Propagation Mechanism (BACKLOG-088)

**DSM_0.2** updated:
- Version header moved to top of file (was buried at bottom, invisible via `@` reference)
- New "Session-Start Version Check" section: spoke agents compare DSM version against last handoff

**DSM_1.0 Section 6.1.2** updated:
- Handoff template now includes `DSM Version` field for version tracking across sessions

**DSM_3 Section 6.3** added:
- "DSM Version Propagation" section documenting the hybrid detection mechanism
- Immediate detection via version header + handoff-based version trail

**DSM_0** updated:
- Implementation Guide listing includes version propagation reference

---

## [1.3.26] - 2026-02-08

### Added - Documentation Project Adaptation (BACKLOG-079, BACKLOG-080)

**DSM_5.0_Documentation_Project_Adaptation_v1.0.md** (new document):
- Track adaptation for documentation-only projects, parallel to DSM_4.0
- 11 sections: project structure, file naming, metadata, cross-references, versioning, quality, session management, review cycle, integration with standard DSM
- Codifies DSM Central's implicit conventions for documentation projects

**DSM_0** updated:
- Documentation track section alongside DSM_4.0 listing
- Project Type Detection table includes Documentation row referencing DSM_5.0
- File listing and Central DSM Repository diagram updated

**DSM_0.2** updated:
- Documentation row now references DSM_5.0 (was DSM 2.0/Section 2.5)
- Agent initialization text updated

**Research:** `docs/research/2026-02-08_documentation-project-best-practices.md` mapping DSM conventions to Diataxis, docs-as-code, keepachangelog, and semantic versioning frameworks

---

## [1.3.25] - 2026-02-06

### Added - Hub-to-Spoke Project Kickoff (BACKLOG-068)

**DSM_3 Section 6** restructured to "Project Handover Protocols":
- Section 6.1: Spoke-to-Hub Feedback Handover (existing, renumbered 6.1.1-6.1.3)
- Section 6.2: Hub-to-Spoke Project Kickoff (new), with preliminary scope template (6.2.1), scaffolding checklist (6.2.2), and kickoff prompt template (6.2.3)

**DSM_0** workflow diagram updated with Hub Kickoff step before Sprint 1 Day 1

**DSM_1.0 Section 6.5.2**: Hub Kickoff Gate (pre-Gateway 1) note added

### Fixed
- Removed stale `blog.md` reference from DSM_3 spoke-to-hub handover prompt template (BACKLOG-066 consistency)

---

## [1.3.24] - 2026-02-06

### Added - Workflow Improvements Batch (BACKLOG-061, 062, 063, 064, 065, 067)

**PM Guidelines Template 8 Enhancements** (BACKLOG-061, 063, 064, 065)
- Execution mode field (`notebook | script | both`) and DSM references in phase definitions
- Phase Boundary Checklist for intra-sprint documentation at phase transitions
- Phase planning notes linking evaluation phases to Appendix C.1 experiment templates
- README update added to Sprint Boundary Checklist

**Custom Instructions Template** (BACKLOG-061, 064, 065)
- Phase-to-DSM-Section Mapping table connecting phase types to relevant DSM sections
- Notebook-to-Script Transition rule (when to extract code from notebooks)
- Sprint boundary checklist now includes README update
- Design decision documentation rule in Pre-Generation Brief Protocol
- IDE permission mode note for Claude Code in VS Code

**DSM_1.0 Section 6.4.1** (BACKLOG-063)
- Intra-sprint checkpoint guidance for multi-phase sprints

**Appendix C.1.3** (BACKLOG-062)
- Design Decisions template for implementation-level decisions within experiments
- References template with citation requirements for external tools, benchmarks, APIs

**DSM 4.0 Section 15** (BACKLOG-067)
- Claude Code permission mode configuration (`initialPermissionMode: default`)

**DSM_0** (BACKLOG-061)
- Appendix C.1.3 reference added to Advanced Practices listing for evaluation phases

---

## [1.3.23] - 2026-02-06

### Changed - Blog Workflow Refinements (BACKLOG-066)

**Section 6.4.5 - Blog/Feedback Separation**
- Reduced feedback system from 3 files to 2 (backlogs.md, methodology.md)
- Blog materials moved from `docs/feedback/blog.md` to `docs/blog/` as project deliverables
- Updated Gateway 1 and Gateway 3 references
- Updated `/dsm-feedback` command to reflect 2-file system

**Section 2.5.6 - Blog Naming Convention**
- Added `YYYY-MM-DD_{type}-{scope}.md` file naming reference to blog process

**Section 2.5.9 - Blog Style Guide (NEW)**
- Long-form conventions: byline, opening pattern, tone, citations, structure
- Short-form LinkedIn conventions: plain text only, link-in-comments, hashtags
- Style consistency step: read most recent post before drafting new one

**Section 2.5.10 - Renumbered**
- Presentation Preparation Checklist renumbered from 2.5.9 to 2.5.10

**BACKLOG-068 Created**
- Hub-to-spoke project kickoff handover process (Medium priority)
- Documents workflow: hub writes preliminary scope, handover, spoke does Phase 0.5 research

---

## [1.3.22] - 2026-02-06

### Added - Feedback Integration and Blog Workflow (BACKLOG-060, 066)

**DSM_3 - Section 6: Feedback Handover Process** (BACKLOG-060)
- Standardized handover prompt template for spoke-to-hub feedback integration
- Created `/dsm-review-feedback` slash command for automated triage
- Added handover process to DSM_1.0 Section 6.4.5
- Added Project Finalization step to DSM_0 workflow diagram

**DSM_0.1 - Blog Artifact Naming Convention** (BACKLOG-066, partial)
- Added `YYYY-MM-DD_{type}-{scope}.md` convention for blog files
- Covers materials, drafts, final posts, and LinkedIn posts
- Added Blog Artifacts section with pattern table and scope examples

**sql-query-agent Feedback Triage**
- Processed 14 proposals from first spoke project: 5 rejected (already addressed), 9 accepted
- Created BACKLOG-061 through BACKLOG-067 from accepted proposals

**First DSM Central Blog Post**
- "A Methodology That Listens" covering the feedback loop from sql-query-agent
- Materials, draft, and LinkedIn post in docs/blog/

**dsm-blog-poster Project Scaffolded** (BACKLOG-055)
- Hugo v0.142.0 extended site at ~/dsm-blog-poster
- CLAUDE.md with 7-post content migration catalog
- Renamed ~/nlp-and-llms to ~/dsm-disaster-tweets

---

## [1.3.21] - 2026-02-06

### Changed - DSM_0 Refactoring and Anti-Patterns Guide (BACKLOG-056, 058, 054, 047)

**DSM_0 - Renamed Custom Instructions to DSM_0.2** (BACKLOG-056)
- Renamed `DSM_Custom_Instructions_v1.1.md` to `DSM_0.2_Custom_Instructions_v1.1.md`
- Updated all @references across DSM repo and 3 spoke projects
- Migrated sql-query-agent from Windows to WSL path

**DSM_0 - Refactored to Concise Orientation Map** (BACKLOG-058)
- Reduced from 1,628 to 980 lines (40% reduction)
- Replaced duplicated content with cross-references to source documents
- Fixed 3 broken cross-references in DSM_2.0 and DSM_3

**DSM_1.0 - Section 3.2.6: Coding Anti-Patterns + Appendix F** (BACKLOG-054)
- Added 33 anti-patterns across 4 categories (Python, Data Science, ML Engineering, Agent Collaboration)
- Summary table in Section 3.2.6, detailed reference with code examples in Appendix F
- Each pattern includes Problem, Example, Fix, and DSM Reference

**DSM_0.2 - Protocol Reinforcement Guidance** (BACKLOG-047)
- Added WARNING about agents deprioritizing inherited protocols
- Table of critical protocols that must be reinforced in project-specific CLAUDE.md
- Example reinforcement block for notebook workflow

---

## [1.3.20] - 2026-02-06

### Added - Methodology Improvements and Repository Organization (BACKLOG-049, 053, 056, 057)

**DSM_4.0 - Section 4.4.1: Fixture Validation Principle** (BACKLOG-049)
- Validate synthetic test fixtures against real data before building test suites
- Four requirements: inspect real data first, extract don't invent, early capability experiment, format spot-check
- Sprint 1 timing guidance added to Appendix C.1.3

**DSM_1.0 - Section 6.5.6: DSM as Central Project Hub** (BACKLOG-053)
- Documents DSM's dual role as methodology framework and project management hub
- Hub-and-spoke ecosystem model for multi-project governance
- Backlog classification: developments (external repos) vs improvements (internal DSM)

**DSM_2.0 - Version Update Workflow Enhancement** (BACKLOG-056, partial)
- Expanded workflow to explicit root file validation chain (DSM_0, DSM_0.1, DSM_0.2, README, CHANGELOG)
- Added post-push audit step
- Added version bump cadence policy (batch per session, one bump per session)
- Backlog workflow now links to Version Update Workflow for implementation

**Repository Organization** (BACKLOG-057)
- Moved setup scripts to `scripts/` folder (clean root)
- Updated all references across 9 active documents
- Backlog reorganized into `developments/` and `improvements/` subfolders
- Classification documented in PM Guidelines

### Added - Backlog Items

- BACKLOG-050: Research Agent MCP Server (High, development)
- BACKLOG-051: Model Optimization Guide (Medium, development)
- BACKLOG-052: DSM Jupyter Book (Medium, development)
- BACKLOG-054: Coding Anti-Patterns Guide (Medium, improvement)
- BACKLOG-055: Personal Website with Blog and LinkedIn Automation (Medium, development)
- BACKLOG-058: Unified DSM Workflow in DSM_0 (High, improvement)
- BACKLOG-059: Setup Scripts Modernization (Low, improvement)

### Changed
- **DSM_Custom_Instructions:** Added Punctuation section
- **README:** Updated Graph Explorer stats (202 tests, 94% coverage)
- **DSM_0:** Updated section references for 4.4.1 and 6.5.6; script paths updated

---

## [1.3.19] - 2026-02-01

### Added - Cross-Project Governance and Development Protocols (BACKLOG-039 through BACKLOG-046)

**Custom Instructions Template (DSM_Custom_Instructions_v1.1.md):**

- **Pre-Generation Brief Protocol** (BACKLOG-043)
  - Structured 4-point brief (what, why, key decisions, structure) before every artifact
  - Formalizes existing "confirm before generating" guidance into actionable protocol
  - Cross-validated by dsm-graph-explorer project (highest-priority feedback item)

- **Notebook Collaboration Protocol** (BACKLOG-045)
  - Agent provides cells as code blocks in conversation, never writes .ipynb directly
  - Cell-by-cell interaction mechanics: provide, execute, validate, next
  - Cross-validated by sql-query-agent project (lowest scoring DSM section at 2.5/5)

- **Phase 0.5: Research and Grounding** (BACKLOG-039)
  - Optional research phase before sprint planning for novel techniques/domains
  - Trigger criteria (when to apply vs skip) and deliverable format
  - Cross-validated by both projects independently adding research phases

- **Sprint Cadence and Feedback Boundaries** (BACKLOG-040)
  - Short sprint guidance: prefer 1-3 focused sprints over monolithic sprints
  - Sprint boundary checklist (checkpoint, feedback, decisions, blog)
  - Cross-validated by dsm-graph-explorer restructuring into 4 short sprints

- **App Development Protocol** added to template (moved from project-specific CLAUDE.md)
- **CLAUDE.md Configuration** requirement: all projects must `@` reference Custom Instructions

**DSM_0 Complete Guide:**

- **Project Directory Structure** updated (BACKLOG-042)
  - Separate patterns for DSM 1.0 (data science) and DSM 4.0 (software engineering)
  - Complete docs/ subfolder structure: checkpoints/, decisions/, feedback/, handoffs/, plans/, research/, blog/
  - CLAUDE.md `@` reference requirement documented in setup section
  - Cross-validated by both projects discovering missing folders during execution

- **DSM Feedback Tracking** updated to reference 3-file system in docs/feedback/
- **PM Guidelines Template 8** listed in template inventory

**PM Guidelines (Template 8: Sprint Plan with Cadence Guidance)** (BACKLOG-044, BACKLOG-040)
  - Sprint-level planning template with MUST/SHOULD/COULD deliverables
  - Sprint phases, open design questions, and "how to resume" sections
  - Sprint boundary checklist aligned with feedback system
  - Cadence guidance integrated into template preamble

**Section 6.4.5: Project Feedback Deliverables** (BACKLOG-041)
  - Consolidated from 2-file to 3-file system: backlogs.md, methodology.md, blog.md
  - Files now live in docs/feedback/ (standardized location)
  - Integrated Validation Tracker scoring into methodology.md (per-section scores)
  - Appendix E.12 updated to note integration into feedback system

**Section 6.5: Gateway Review Protocol** (BACKLOG-046)
  - Hub-and-Spoke governance model for methodology-to-project feedback
  - Three gateway levels: Setup Complete, Sprint Boundary, Project Delivery
  - Gateway review process: checklist, alignment report, feedback, pass
  - Cross-project learning mechanisms based on SECI model
  - Anti-patterns to avoid (compliance theater, central bottleneck, over-governance)
  - Grounded in multi-agent governance research (docs/research/)

**Research:**
  - `docs/research/2026-02-01_multi-agent-governance-research.md` - Comprehensive survey of 6 domains
    (multi-agent systems, software engineering governance, quality gates,
    organizational learning, docs-as-code, AI agent frameworks)

### Changed
- **BACKLOG-039 through BACKLOG-046:** Status updated to Implemented, moved to done/
- **Appendix E.12:** Marked as integrated into feedback system (Section 6.4.5)
- **DSM_0 Section 3:** Project directory structure now has DSM 1.0 and DSM 4.0 patterns

### Purpose
Formalizes bidirectional feedback between DSM methodology and consuming projects.
Previously, feedback only flowed from projects to DSM (bottom-up via feedback files).
This release adds methodology-to-project guidance (top-down via gateway reviews),
standardized development protocols, and cross-project learning mechanisms. Grounded
in research across multi-agent systems, organizational learning theory, and software
engineering governance patterns. All changes cross-validated by two concurrent DSM
projects (dsm-graph-explorer, sql-query-agent-ollama).

---

## [1.3.18] - 2026-01-30

### Added - DSM 4.0 Project Structure Patterns (BACKLOG-038)

**DSM 4.0 v1.3 - Section 2: Project Structure Patterns**
- DSM 1.0 pattern (data science projects): Separate `_Project_Knowledge/` repository
  - Session handoffs, decisions, checkpoints in separate repo
  - Rationale: Separates analysis artifacts from meta-documentation
- DSM 4.0 pattern (software engineering projects): In-repo `docs/` folder
  - Session handoffs, decisions, checkpoints inside main repo
  - Rationale: Follows software engineering conventions, simpler for contributors
- When to use each pattern (project type decision table)
- Claude Projects context guidance for both patterns
- Migration guidance for existing and new projects

**Section renumbering:**
- New Section 2 inserted, all subsequent sections renumbered (old Section 2 → Section 3, etc.)
- TOC updated to reflect new structure (17 sections total)

### Changed
- **BACKLOG-038:** Status updated to Implemented
- **DSM 4.0:** Version updated to v1.3

### Purpose
Formalizes the project structure pattern difference between data science and software engineering projects. This clarifies when to use separate Project_Knowledge repos vs. in-repo docs/, preventing confusion when following DSM 4.0.

---

## [1.3.17] - 2026-01-30

### Added - Analysis Enhancements, Blog Process, PM Checklists (BACKLOG-023 through BACKLOG-035)

**Section 2.4 Analysis enhancements (BACKLOG-028, 029, 030, 031):**

- **Section 2.4.8: Human Performance Baseline** (BACKLOG-028)
  - When to establish human baseline (criteria by task type)
  - Methods by effort level (quick estimate, inter-annotator agreement, published benchmarks)
  - Reporting format for model comparison tables

- **Section 2.4.9: Model Complexity vs Explainability** (BACKLOG-029)
  - Decision framework table (performance gap, stakeholder needs, regulatory context)
  - Explainability assessment template for model selection reporting
  - Guidance on when small gains do not justify complexity

- **Section 2.4.10: Grouped Data Splitting** (BACKLOG-031)
  - Scenario table (users, patients, sensors, products, sessions)
  - Decision checklist before splitting data
  - GroupKFold and GroupShuffleSplit references

**Appendix D.2.7: Embedding Visualization (BACKLOG-030):**
  - When to visualize embeddings (comparison, debugging, communication)
  - Technique comparison table (PCA, t-SNE, UMAP)
  - Interpretation guidelines and comparison layout recommendation

**Section 2.5 Blog/Communication process (BACKLOG-023, 024, 025):**

- **Section 2.5.6: Blog/Communication Deliverable Process** (BACKLOG-023)
  - 6-step process: preparation, scoping, drafting, review, audit, publication
  - Materials document template, scoping questions, citation and jargon audit

- **Section 2.5.7: Publication Strategy** (BACKLOG-024)
  - Three-deliverable format (short post, article, follow-up comment)
  - Publication sequence and timing rationale
  - Short post structure, formatting notes for LinkedIn Articles

- **Section 2.5.8: Blog Post as Standard Deliverable** (BACKLOG-025)
  - Blog as standard Communication phase output
  - Expectations (length, audience, quality)
  - Skip conditions documented

- **Section 2.5.9: Presentation Preparation Checklist** (BACKLOG-035)
  - Common Q&A categories (baselines, alternatives, limitations, explainability)
  - 5-step preparation process

**PM Guidelines additions (BACKLOG-026, 032, 033):**

- **Visualization Quality Checklist** (BACKLOG-026)
  - Content, formatting, and output checks for figures
  - Context-specific notes (presentations, blogs, notebooks)

- **Debugging Log Template** (BACKLOG-032)
  - Structured template for multi-iteration debugging sequences
  - Fields: problem, attempts table, root cause, solution, prevention

- **Scope Review Checkpoint** (BACKLOG-033)
  - Trigger conditions for scope review (COULD items, timeline extension)
  - Review questions and lightweight documentation format

**Appendix A.10: External API Portability (BACKLOG-027):**
  - Prefer direct HTTP over CLI wrappers
  - Auth method documentation practice
  - Fallback logic for data paths
  - Common API portability issues table

**Section 6.4.6: Documentation Audit (BACKLOG-034):**
  - Audit checklist for project closure
  - When to audit and audit process

### Changed

- **BACKLOG-023 through BACKLOG-035:** Status updated to Implemented
- **DSM_0:** Core Content updated with new Section 2.4, 2.5 subsections; Appendix A.10, D.2.7
- **PM Guidelines description:** Updated with new checklists

### Purpose

Comprehensive implementation of NLP project feedback covering instructor feedback (human baselines, explainability, embedding visualization, grouped splitting), blog writing process standardization, and PM quality checklists. All items originated from the NLP & LLMs project Day 6-7 feedback and Final Closure review.

---

## [1.3.16] - 2026-01-30

### Added - Inclusive Language Guidance (BACKLOG-022)

**New section in main methodology:**

- **Section 3.5: Inclusive Language**
  - Terminology table with preferred alternatives (master/slave, whitelist/blacklist, etc.)
  - Gender-neutral language guidance
  - NLP-specific example alternatives (word embedding analogies)
  - General principle: neutral examples when equally effective

### Changed

- **BACKLOG-022:** Status updated to Implemented
- **DSM_0:** Core Content updated with Section 3.5

### Purpose

Technical writing should be welcoming to all readers. This brief guidance addresses terminology and examples identified during the NLP project (gendered word embedding analogies, imperial metaphors) without being exhaustive.

---

## [1.3.15] - 2026-01-30

### Added - VS Code IDE Configuration (BACKLOG-011)

**New subsection in DSM 4.0 Section 14 (GitHub Repository Setup):**

- **IDE Configuration (VS Code)** (BACKLOG-011)
  - `.vscode/settings.json` template with auto interpreter selection
  - pytest integration configuration
  - Cross-platform path note (Linux/Mac/Windows)
  - Optional `.vscode/extensions.json` for team collaboration

### Changed

- **BACKLOG-011:** Status updated to Implemented
- **DSM_0:** DSM 4.0 key sections updated with IDE Configuration

### Purpose

Eliminates the paper-cut issue of manually selecting Python interpreter in VS Code for every project. Auto-configures the virtual environment and testing framework.

---

## [1.3.14] - 2026-01-30

### Added - Notebook Standards (BACKLOG-015, BACKLOG-020)

**New subsections in PM Guidelines (Communication & Working Style):**

- **Notebook Cell Quality Checklist** (BACKLOG-015)
  - Before/after code cell checks (markdown descriptions, actual output values)
  - Section transition checks (summary cells, variables carried forward)
  - Per-notebook checks (title cell, final summary, Restart & Run All)

- **Notebook Portability Checklist** (BACKLOG-020)
  - Directory safety (`os.makedirs`, `pathlib.Path`)
  - Package management for cloud environments (`!pip install`, version pinning)
  - Data access fallbacks (local vs. API, environment variable authentication)
  - Runtime documentation (GPU/CPU requirements, expected runtime)
  - Environment detection pattern (`IN_COLAB`)

### Changed

- **BACKLOG-015, BACKLOG-020:** Status updated to Implemented
- **DSM_0:** PM Guidelines description updated with notebook checklists

### Purpose

Notebook quality and portability were recurring friction points in the NLP project. The cell checklist reinforces existing standards in a quick-reference format. The portability checklist addresses Colab compatibility issues that consumed an entire project day.

---

## [1.3.13] - 2026-01-30

### Added - Environment Setup Enhancements (BACKLOG-010, BACKLOG-013, BACKLOG-021)

**New subsections in Appendix A (Environment Setup Details):**

- **A.7: Environment Tool Selection Guide** (BACKLOG-010)
  - Two-phase setup approach (infrastructure first, project libraries after planning)
  - Tool comparison table (venv, pyenv, Poetry, Conda, uv)
  - Recommended defaults by project type (DSM 1.0, DSM 4.0, Production)

- **A.8: Model & Data Cache Management** (BACKLOG-013)
  - Common cache locations table (gensim, HuggingFace, NLTK, spaCy, PyTorch)
  - Size checking and cleanup commands
  - Best practices for documenting large downloads

- **A.9: WSL & Cross-Platform Setup** (BACKLOG-021)
  - WSL path mapping table (Windows to WSL)
  - Python conflict resolution in WSL
  - CLAUDE.md path guidance for Windows vs WSL contexts
  - Common WSL issues table with solutions

### Changed

- **BACKLOG-010, BACKLOG-013, BACKLOG-021:** Status updated to Implemented
- **DSM_0:** Appendix A description updated with A.7-A.9, version notes added

### Purpose

Environment setup was the most common friction point in the NLP project feedback. These three items address: choosing the right tool (A.7), managing large downloads (A.8), and cross-platform compatibility (A.9).

---

## [1.3.12] - 2026-01-30

### Added - Project Feedback Deliverables Standard

**New subsection in Section 6.4 (Checkpoint and Feedback Protocol):**

- **Section 6.4.5: Project Feedback Deliverables**
  - Two-file feedback standard for project completion
  - `dsm-feedback-backlogs.md`: Concrete improvement proposals that become BACKLOG items
  - `dsm-feedback-methodology.md`: Record of actual pipeline, tools, plan vs reality
  - Templates for both files with required sections
  - Relationship diagram showing how each file feeds back into DSM
  - Distinction: backlogs generate immediate action; methodology builds knowledge base

### Changed

- **Section 6.4.3:** Updated feedback loop diagram to show both deliverable paths
- **DSM_0:** Core Content updated with Section 6.4.5, version notes added

### Purpose

Formalizes the feedback deliverable pattern validated by the NLP Disaster Tweet Classification project. The two-file separation distinguishes actionable improvement proposals (backlogs) from informational methodology records (what was actually built). Both are global observations -- not limited to a project's domain.

---

## [1.3.11] - 2026-01-30

### Added - Analysis Templates (BACKLOG-018, BACKLOG-019)

**New subsections in Section 2.4 (Analysis):**

- **Section 2.4.6: Model Comparison Documentation** (BACKLOG-018)
  - Comparison setup template (objective, metrics, dataset)
  - Results table with baseline and relative improvement
  - Selection decision format with trade-offs and Decision Log cross-reference
  - Required Negative Results section for documenting underperformance

- **Section 2.4.7: Error Analysis Framework** (BACKLOG-019)
  - Error category table with counts, examples, and root causes
  - Pattern identification format
  - Actionable insights table (finding, fix, effort, impact)
  - Known limitations documentation
  - Domain-specific error categories (NLP, Tabular, Regression, Clustering)

### Changed

- **BACKLOG-018, BACKLOG-019:** Status updated to Implemented
- **DSM_0:** Core Content updated with Section 2.4.6-2.4.7, version notes added

### Purpose

Structured templates for the two most common analysis documentation needs: comparing multiple models and analyzing errors. Both emerged from the NLP project where 5+ models were compared ad-hoc and error analysis followed no standard format.

---

## [1.3.10] - 2026-01-30

### Added - NLP Domain Enhancement (BACKLOG-014, BACKLOG-016, BACKLOG-017)

**New subsections in Appendix D.2 (NLP Projects):**

- **D.2.4: NLP EDA Checklist** (BACKLOG-016)
  - Text-specific EDA table (class distribution, text length, vocabulary, special characters)
  - Classification-specific EDA (top N-grams per class, duplicates, label quality)
  - Preprocessing impact assessment guidance
  - Cross-references to Section 2.2 and Appendix B.2.4

- **D.2.5: NLP Preprocessing & Vectorization Guide** (BACKLOG-017)
  - Text cleaning pipeline with decision points (7-step ordered process)
  - TF-IDF parameter guide with typical ranges and starting values
  - Edge case handling table (empty strings, encoding, short texts)
  - Cross-reference to Section 2.3.7 (Data Leakage Prevention)

- **D.2.6: NLP Performance Expectations** (BACKLOG-014)
  - Method selection table by task characteristics (TF-IDF vs. Embeddings vs. Transformers)
  - When each method typically wins (with concrete examples)
  - Baseline performance expectations by task type (F1 ranges)
  - Key principle: start simple, add complexity when empirically justified

### Changed

- **BACKLOG-014, BACKLOG-016, BACKLOG-017:** Status updated to Implemented
- **DSM_0:** Appendix D description updated with D.2.4-D.2.6, version notes added

### Purpose

First grouped NLP domain enhancement from Disaster Tweet Classification project feedback. These three items address the gap between DSM's existing brief NLP guidance (D.2.1-D.2.3) and the practical needs encountered during a real NLP sprint: text-specific EDA patterns, preprocessing parameter guidance, and realistic performance expectations.

---

## [1.3.9] - 2026-01-30

### Added - Data Leakage Prevention Checklist (BACKLOG-012)

**New section in main methodology:**

- **Section 2.3.7: Data Leakage Prevention** (~75 lines)
  - Pre-modeling checklist (split first, fit on train only)
  - Common leakage patterns table (scaling, encoding, imputing, feature selection)
  - Domain-specific leakage risks (NLP, Time Series, Tabular)
  - Recommended pattern: Scikit-learn Pipeline
  - Leakage detection symptoms and verification steps

### Changed

- **BACKLOG-012:** Status updated to Implemented

### Purpose

Data leakage was caught during the NLP project when vectorizing before splitting. This checklist prevents the most common leakage patterns across all domains, with domain-specific guidance for NLP, time series, and tabular data.

---

## [1.3.8] - 2026-01-26

### Changed - Simplified CLAUDE.md Template

**Improved Quick Start Guide (Section 4, Step 3):**

- Reduced CLAUDE.md template from ~65 lines to ~10 lines
- Made `@path` import mechanism the clear focus
- Removed redundant protocol content (already in DSM_Custom_Instructions)
- Added "What gets imported automatically" summary
- Clearer path examples for Windows and Linux/Mac

### Purpose

Users were confused by the long template, not realizing that `@path` imports all protocols automatically. The simplified template makes it clear: import DSM instructions, add only project-specific context.

---

## [1.3.7] - 2026-01-26

### Added - Experiment Artifact Organization Standard (BACKLOG-009)

**New section in Appendix C (Advanced Practices):**

- **C.1.6: Experiment Artifact Organization** (~105 lines)
  - Folder structure: `data/experiments/s{SS}_d{DD}_exp{NNN}/`
  - Naming convention with sprint/day/experiment ID pattern
  - EXPERIMENTS_REGISTRY.md template for central index
  - Experiment README template for self-contained documentation
  - Relationship between `data/experiments/` (code) and `docs/experiments/` (documentation)
  - Cross-references to C.1.3-C.1.5 and DSM 4.0 Section 3.4

### Changed

- **BACKLOG-009:** Status updated to Implemented

### Purpose

Provides systematic organization for experiment artifacts (scripts, results, test data) that accumulated during projects. Sprint/day prefix pattern aligns with DSM file naming standards and shows experiment chronology at a glance.

---

## [1.3.6] - 2026-01-26

### Added - Tests vs Capability Experiments Clarification (BACKLOG-008)

**New section in DSM 4.0 Software Engineering Adaptation:**

- **Section 3.4: Tests vs Capability Experiments** (~40 lines)
  - Comparison table: purpose, scope, frequency, output, location
  - Guidelines for when to use each approach
  - Example showing complementary usage (Cross-Lingual Retrieval)
  - Key principle: Tests = "Does this function work?" vs Experiments = "Does this feature achieve its goal?"

### Changed

- **Version Update Workflow:** Added step 4 "Update DSM_0 document descriptions if new sections added"
- **BACKLOG-008:** Status updated to Implemented

### Purpose

Clarifies the distinction between pytest unit tests and capability experiments (C.1.3) to prevent redundancy or gaps in validation coverage. Emerged from practical implementation experience in RAG Document Assistant project.

---

## [1.3.5] - 2026-01-26

### Changed - Quick Start Guide Modernization

**Updated DSM_0_START_HERE_Complete_Guide.md to reflect current workflow:**

- **Section 4 (Quick Start Guide) restructured:**
  - Added Step 0: Assess Project Type & Requirements (Notebook/Application/Hybrid)
  - Updated Step 1: Separate environment setup for Data Science vs Application projects
  - Removed outdated "Create Project Knowledge Folder" step
  - Updated CLAUDE.md example to point to central DSM repository via `@path`
  - Projects now reference DSM centrally instead of copying files

- **New Project Checklist (Section 5):**
  - Updated to reflect 6-step process (Step 0-5)
  - Data Science projects: Use `setup_base_environment_minimal.py`
  - Application projects: Create custom `requirements.txt`

- **Document Relationship Map:**
  - Updated to show central DSM repository reference pattern
  - Clarified `@path` import syntax for CLAUDE.md

### Purpose

Modernizes onboarding to reflect current best practice: projects point to central DSM repository rather than copying DSM files locally. Adds guidance for Application projects that need custom library setups.

---

## [1.3.4] - 2026-01-26

### Added - AI Agent Project Initialization Protocol

**Enhanced onboarding for AI agents using DSM:**

- **DSM_0_START_HERE_Complete_Guide.md:**
  - Added "AI Agent Project Initialization" section
  - Project Type Detection table (Notebook/Application/Hybrid)
  - DSM Feedback Tracking activation instructions
  - Hybrid Projects guidance

- **DSM_Custom_Instructions_v1.1.md:**
  - Added "Project Type Detection" section at top
  - Added "DSM Feedback Tracking" section
  - Agent now states project type at session start

### Purpose

Ensures AI agents can:
1. Automatically identify whether a project uses DSM 1.0 (notebooks) or DSM 4.0 (applications)
2. Activate feedback tracking for continuous DSM improvement
3. Handle hybrid projects that combine both tracks

---

## [1.3.3] - 2026-01-26

### Added - Beyond DSM: Production & MLOps References (BACKLOG-007)

**New section in DSM 4.0 Software Engineering Adaptation:**

- **Section 15: Beyond DSM: Production & MLOps** (~35 lines)
  - MLOps Maturity Models (Google, Microsoft references)
  - Model & Data Documentation (Model Cards, Data Cards)
  - Deployment Patterns (Shadow, Canary, Blue/Green, Champion/Challenger)
  - Data Quality & Monitoring (Great Expectations, dbt, drift detection)

### Changed

- **DSM 4.0:** Version updated to 1.2, Version History renumbered to Section 16
- **BACKLOG-007:** Status updated to Implemented
- **BACKLOG-003, 004, 005:** Archived (would cause methodology bloat)

### Purpose

Provides lightweight pointers to established MLOps/production resources without bloating the methodology. Users completing DSM 4.0 projects now have clear next steps for production operations.

---

## [1.3.2] - 2026-01-26

### Added - Checkpoint, Feedback & Change Tracking Protocol (BACKLOG-006)

**New methodology sections for project tracking and continuous improvement:**

- **Section 6.4: Checkpoint and Feedback Protocol** (~70 lines)
  - 6.4.1: Milestone Checkpoints (triggers, documentation)
  - 6.4.2: Methodology Feedback Collection (Validation Tracker)
  - 6.4.3: Feedback Loop (continuous DSM improvement)
  - 6.4.4: Daily Checkpoint Template Addition

- **Appendix E.12: DSM Validation Tracker Template** (~130 lines)
  - Complete template for tracking DSM effectiveness
  - Sections Used table with scoring
  - Feedback Log format with evaluation criteria
  - Summary metrics by section and feedback type
  - Scoring guidelines (1-5 scale)

- **PM Guidelines: Project Change Tracking** (~100 lines)
  - Backlog System (structure, template, workflow)
  - Archive Pattern (completed/obsolete docs)
  - Changelog Maintenance (Keep a Changelog format)
  - Git Tagging Convention (release vs checkpoint)
  - Version Update Workflow (6 steps)
  - Backlog Priorities table

### Changed

- **BACKLOG-006:** Status updated to Implemented

### Purpose

Projects using DSM can now:
1. Track methodology effectiveness with quantifiable metrics
2. Provide structured feedback for DSM improvement
3. Manage project evolution with standardized backlog/changelog
4. Create clear version history with git tags

---

## [1.3.1] - 2026-01-26

### Added - Capability Experiment Template (BACKLOG-001)

**New sections in Appendix C for software/RAG project evaluation:**

- **C.1.3: Capability Experiment Template** (~185 lines)
  - Combined quantitative + qualitative evaluation framework
  - Internal evaluation: Retrieval, Generation, Capability metrics
  - External evaluation: Safety, Efficiency metrics
  - Complete example: RAG conflict detection experiment
  - Findings section template with limitation tracking

- **C.1.4: RAG Evaluation Metrics Reference** (~95 lines)
  - Framework overview: RAGAS, RAGBench, SafeRAG, FreshLLMs
  - Internal metrics: Traditional (Precision@K, ROUGE) + LLM-based (faithfulness)
  - External metrics: Robustness, Factuality, Adversarial, Privacy, Fairness, Efficiency
  - RAGAS quick reference code example
  - RAGBench TRACe metrics documentation
  - Best practice: Combined evaluation strategy

- **C.1.5: Limitation Discovery Protocol** (~110 lines)
  - Step-by-step limitation documentation
  - Disposition decision matrix (Fix Now / Accept MVP / Defer)
  - Severity-based decision guidance
  - README Known Limitations template
  - Future Improvements template with quantitative targets
  - Limitation tracking summary table

### Changed

- **DSM_4.0:** Added reference to C.1.3-C.1.5 for software/RAG projects
- **BACKLOG-001:** Status updated to Implemented, moved to `plan/backlog/done/`

### Added - Plan Folder Organization

- **Backlog system:** `plan/backlog/` for proposed enhancements, `plan/backlog/done/` for implemented items
- **BACKLOG-003:** Deployment Planning & MLOps (Priority: High)
- **BACKLOG-004:** Documentation Templates - Model Cards, Data Cards (Priority: Medium)
- **BACKLOG-005:** DataOps & Production Patterns (Priority: Medium)
- **Archive:** Moved obsolete planning documents to `plan/archive/`

### Archived (Historical Documents)

Moved to `plan/archive/`:
- `20251119_CONTENT_MAPPING_PLAN.md` - v1.1 reorganization (completed)
- `20251119_SESSION_CHECKPOINT_Methodology_Reorganization.md` - v1.1 session (completed)
- `20251119_CHECKPOINT_File_Consolidation_Discussion.md` - consolidation (completed)
- `EDA_Deepening_Analysis.md` - implemented in v1.3.0

### Retained (Active Reference)

Kept in `plan/` for future roadmap:
- `DSM_vs_CRISP-DM_Comparison_Analysis.md` - gap analysis for future enhancements
- `Data_Science_Frameworks_Standards_Overview.md` - framework survey for roadmap

### References

- Chen et al. (2025). "Retrieval Augmented Generation Evaluation in the Era of Large Language Models: A Comprehensive Survey." arXiv:2504.14891
- RAGAS Documentation: https://docs.ragas.io/en/stable/concepts/metrics/overview/

---

## [1.3.0] - 2026-01-22

### Added - Business Understanding & EDA Enhancement

**Major enhancement: DSM's differentiator for Phase 1 (Exploration)**

This release deepens DSM's approach to data exploration, making Business Understanding and EDA an iterative dialogue rather than sequential steps. This is DSM's original contribution to data science methodology.

**New in Main Methodology (DSM_1.0):**

- **Section 2.1.9: Business Understanding Foundation** (~70 lines)
  - Business Understanding ↔ EDA feedback loop concept
  - The Five Business Questions framework
  - Business Understanding Template (Decision, Success, Constraints, Domain Knowledge)
  - Business Understanding Checkpoint (pre-EDA gate)

- **Section 2.2.2: Three-Layer EDA Framework** (~70 lines)
  - Layer 1: Facts (Data Inventory) with question matrix
  - Layer 2: Patterns (Statistical Understanding) with technique mapping
  - Layer 3: Implications (Analysis Direction) with decision framework
  - Domain Validation During EDA protocol

- **Section 2.2.3: Enhanced Deliverables** (~55 lines)
  - Layer 1/2/3 Summary Templates
  - Updated Business Understanding (Post-EDA) template
  - Assumptions vs. Reality documentation

- **Section 2.2.4: EDA Exit Criteria** (~45 lines)
  - Layer-specific completion checklists
  - EDA Anti-Patterns table (Analysis Paralysis, Plot Overload, Perfectionism, Scope Creep)

**New in Appendices (DSM_1.0_Methodology_Appendices):**

- **Appendix B.2.4: EDA Techniques by Data Type** (~40 lines)
  - Numeric data techniques (5-number summary, histograms, Q-Q plots)
  - Categorical data techniques (value counts, crosstab, chi-square)
  - Temporal data techniques (rolling stats, seasonal decomposition, ACF/PACF)
  - Text data techniques (length distribution, word frequency, language detection)

- **Appendix B.2.5: Business Understanding Integration** (~30 lines)
  - Domain Briefing Template (Before EDA)
  - EDA Validation Checklist (After EDA)

- **Appendix B.2.6: References** (~15 lines)
  - Attribution to foundational frameworks (CRISP-DM, Tukey, DIKW)
  - Documentation of DSM-specific adaptations

### Changed - Line Count Updates

| Document | Before | After | Change |
|----------|--------|-------|--------|
| Main methodology | ~3,130 | ~3,400 | +270 lines |
| Appendices | ~3,920 | ~4,010 | +90 lines |
| **Total system** | **~8,100** | **~8,460** | **+360 lines** |

### References & Attributions

This release includes proper attribution for concepts adapted from established frameworks:

- **CRISP-DM (Chapman et al., 1999):** Business Understanding and Data Understanding phases - adapted as iterative dialogue
- **John Tukey (1977):** Exploratory Data Analysis philosophy - systematic questioning approach
- **DIKW Hierarchy (Ackoff, 1989):** Facts → Patterns → Implications framework inspiration
- **TDSP (Microsoft, 2016):** Structured templates concept
- **Toyota Production System:** Five Whys adapted as Five Business Questions

**Original DSM Contributions:**
- Business Understanding ↔ EDA Feedback Loop
- Three-Layer Summary Templates
- EDA Exit Criteria Checklist
- Updated Business Understanding (Post-EDA) Template
- Integration with AI Agent Collaboration workflow

---

## [1.2.0] - 2026-01-20

### Added - Software Engineering Adaptation & App Development Protocol

**Major new capability: DSM 4.0 Software Engineering Adaptation**

This release introduces a complete methodology track for ML application development, extending the framework beyond data science notebooks to production-ready software.

**New Documents:**

- **DSM_4.0_Software_Engineering_Adaptation_v1.0.md** (~625 lines)
  - Adapted phase structure (Data Pipeline → Core Modules → Integration → Application)
  - Module development protocol (replaces notebook protocol for SW projects)
  - Architectural decision log templates
  - Portfolio project checklist
  - Streamlit Cloud deployment checklist
  - Session state patterns for multi-tab apps
  - A/B testing UX guidelines
  - LLM cost tracking patterns
  - Sprint planning templates for SW projects
  - GitHub repository setup checklist

- **DSM_2.1_PM_ProdGuidelines_extension.md** (~415 lines)
  - Project governance and RACI matrix templates
  - Data versioning requirements (dataset naming, metadata templates)
  - Environment versioning guidelines
  - QA checklists and peer review process
  - Risk management framework (risk register, prioritization matrix)
  - Stakeholder communication matrix
  - Post-project review template

**App Development Protocol added to CLAUDE.md and DSM_Custom_Instructions:**

```
When building application code (packages, modules, scripts):
1. Guide step by step through the development process
2. Explain **why** before each action
3. Provide code segments for user to copy/paste
4. Wait for user confirmation before proceeding to next step
5. Generate no files directly - user creates all artifacts
6. Build modules incrementally: imports → constants → one function → test → next function
7. Use Test-Driven Development (TDD): write tests in `tests/` alongside code
```

**Project Knowledge Repository Pattern:**
- Session handoffs now stored in separate repository: `../{project-name}_Project_Knowledge/`
- Keeps framework documentation separate from project implementation code
- Updated Section 6.1 (Session Management) with new location guidance

### Changed - Cross-Reference Updates

**Files updated with DSM 4.0 references:**
- `DSM_0_START_HERE_Complete_Guide.md` - Added "Project Type Decision" section
- `DSM_1.0_Data_Science_Collaboration_Methodology_v1.1.md` - Added DSM 4.0 callouts in Sections 1.2 and 2
- `DSM_1.0_Methodology_Appendices.md` - Added DSM 4.0 reference in Appendix D header
- `DSM_3_Methodology_Implementation_Guide_v1.1.md` - Added Example 3 (DevFlow Analyzer - SW Engineering project)
- `.claude/CLAUDE.md` - Added Key Paths for new documents
- `README.md` - Updated System Components and When to Use tables

### Summary

| Change Type | Count |
|-------------|-------|
| New documents | 2 |
| Updated documents | 8 |
| New lines added | ~1,040 |
| Total system size | ~8,100 lines |

---

## [1.1.3] - 2025-12-14

### Added - Favorita Project Methodology Enhancements

**4 methodology modifications implemented from Favorita Demand Forecasting lessons learned:**

**HIGH Priority:**
- **MOD-20: Scale-Dependent Validation Protocol** - Added to Appendix B.4.3
  - Critical finding: Model selection at sample scale may not hold at production scale
  - 3-stage protocol (sample development, scale validation, comparison)
  - Decision log template for scale-dependent findings
  - Source: LSTM won on 300K sample, XGBoost won at 4.8M production scale

- **MOD-21: Hypothesis Testing with Rejection Protocol** - Added to Section 4.1.5
  - Pre-registration template for testable hypotheses
  - Explicit rejection criteria defined BEFORE testing
  - Negative result documentation as valuable findings
  - Example: DEC-015 rejection (106% worse RMSE) led to temporal consistency principle

**MEDIUM Priority:**
- **MOD-22: Decision Invalidation Arc Documentation** - Added to Appendix E.6.1
  - Track how decisions evolve over time
  - Template for documenting when earlier decisions are invalidated
  - Example: DEC-012 (include oil) -> DEC-014 (remove oil) arc
  - Decision status lifecycle (Proposed -> Active -> Superseded/Rejected/Completed)

**LOW Priority:**
- **MOD-23: Environment Transition Checklist** - Added to Appendix A.6
  - Guide for Windows to WSL2/Linux transitions
  - Cross-platform path handling with pathlib
  - GPU environment setup (WSL2 + CUDA)
  - Transition validation script
  - Best practices and documentation templates

### Changed - Line Count Updates

**Files updated to reflect MOD-20 through MOD-23:**
- Main methodology: ~3,000 -> ~3,130 lines (+130 lines)
- Appendices: ~3,565 -> ~3,920 lines (+355 lines)
- Total system: ~6,565 -> ~7,050 lines (+7% increase)

---

## [1.1.2] - 2025-12-13

### Added - Methodology Enhancements (MOD Implementations)

**16 methodology modifications implemented from TravelTide lessons learned:**

**CRITICAL Priority:**
- **MOD-15: Sprint-Based Structure** - Replaced all "Week 1/2/3/4" terminology with "Sprint 1/2/3/4"
  - File naming: `wYY_dXX` → `sYY_dXX`
  - Project plans: `Week1_Plan.md` → `Sprint1_Plan.md`
  - Added flexible sprint duration configuration (DSM_0 Section 1.5)

**HIGH Priority:**
- **MOD-18: Temporal Consistency Principle** - Added to Appendix D.1.4
  - Seasonal training period selection for time series forecasting
  - Complete examples and validation approaches
- **MOD-19: Feature Ablation Methodology** - Added to Appendix B.3.3
  - 3-stage validation process (Permutation Importance → Ablation Study → SHAP)
  - Code examples and interpretation guidelines

**MEDIUM Priority:**
- **MOD-01: Cell-by-Cell Execution Protocol** - Added to Section 6.2.5
  - Progressive execution standard for Jupyter notebooks
- **MOD-03: Factual Accuracy Requirement** - Added to Section 1.3.5
  - No guessing policy for data science precision
- **MOD-04: Daily Checkpoint Template** - Enhanced PM Guidelines Template 6
  - Added Appendix: Outputs Created section
- **MOD-05: Feature Dictionary Standard** - Added to Section 3.4.5
  - Standardized feature documentation format
- **MOD-06: Enhanced Decision Log Format** - Updated Appendix E.6
  - Full template with DEC-XXX identifiers
- **MOD-11: Verification Script Template** - Added to Appendix E.10.4
  - Sprint transition verification Python template
- **MOD-16: Correlation Aggregation Warning** - Added to Appendix D.1.5
  - Simpson's Paradox warning for aggregated correlations
- **MOD-17: NaN Strategy Documentation** - Added to Section 2.3.6
  - Missing value strategy for engineered features

**LOW Priority:**
- **MOD-02: Print Statement Standards** - Added to Section 3.2.5
  - Informative vs generic confirmation guidelines
- **MOD-09: Visualization Naming** - Verified in E.11 (already covered)
- **MOD-10: Visualization Quality Checklist** - Verified in E.10 (already covered)
- **MOD-12: Q&A Preparation Document** - Added PM Guidelines Template 11
- **MOD-13: Scope Limitations Log** - Added PM Guidelines Template 12

### Changed - Line Count Updates

**Files updated to reflect MOD implementations:**
- Main methodology: 2,576 → ~3,000 lines (+424 lines)
- Appendices: 2,464 → ~3,565 lines (+1,101 lines)
- PM Guidelines: 450 → ~1,220 lines (+770 lines)
- Total system: 5,040 → ~6,565 lines (+30% increase)

**Version references updated across:**
- DSM_0_START_HERE_Complete_Guide.md
- DSM_1.0_Data_Science_Collaboration_Methodology_v1.1.md (Section 8.4)
- DSM_Custom_Instructions_v1.1.md

### Added - Consistency Audit

**New documentation:**
- `docs/Methodology_Consistency_Audit.md` - Comprehensive consistency report
  - Terminology validation (Week vs Sprint)
  - Cross-reference accuracy checks
  - File naming convention verification
  - Future consistency checklist

---

## [1.1.1] - 2025-11-19

### Changed - File Consolidation

**Repository Optimization:**
- Reduced file count from 20 to 13 methodology files (-35% reduction)
- Improved maintainability while preserving all content

**Getting Started Consolidation (3→1):**
- Merged into `0_START_HERE_Complete_Guide.md` (comprehensive single guide):
  - `0_Integrated_System_Guide-START-HERE_v1.1.md`
  - `00_Final_System_Summary_v1.1.md`
  - `00_New_Project_Checklist_Quick-Start-Template_v1.1.md`
- New structure: Quick Start → System Overview → Document Map → File Inventory → New Project Checklist → Common Patterns → Tips → Troubleshooting
- All content preserved with improved organization

**Appendices Consolidation (5→1):**
- Merged into `1.0_Methodology_Appendices.md` (2,464 lines):
  - Appendix A: Environment Setup Details (583 lines)
  - Appendix B: Phase Deep Dives (643 lines)
  - Appendix C: Advanced Practices Detailed (500 lines)
  - Appendix D: Domain Adaptations (374 lines)
  - Appendix E: Quick Reference (327 lines)
- Section numbering unchanged (backward compatible)
- All cross-references preserved

**Updated Files:**
- `1.0_Data_Science_Collaboration_Methodology_v1.1.md` - Updated Section 8.4 (Appendix References) and version history
- `IMPROVED_Custom_Instructions_v1.1.md` - Updated to reference consolidated files
- `CHANGELOG.md` - Added v1.1.1 release notes

**Benefits:**
- Easier maintenance (fewer files to update)
- Better navigation (comprehensive guides vs. scattered files)
- Same content, better packaging
- Reduced context switching for users

### Added - File Naming Standards

**New Documentation:**
- **Appendix E.11:** File Naming Standards (~212 lines)
  - Core naming pattern: `wYY_dXX_PHASE_description.extension`
  - Phase codes (SETUP, EDA, FE, MODEL, REPORT)
  - File type conventions (notebooks, datasets, visualizations, documentation)
  - Directory structure recommendations
  - Week 4 consolidation process
  - Git integration patterns
  - Common mistakes and best practices
  - Quick examples by week

**Quick Reference Card:**
- `1.4_File_Naming_Quick_Reference.md` (118 lines)
  - Printable one-page reference card
  - Designed for daily use while coding
  - Quick rules checklist
  - Examples by file type and week
  - Directory structure overview

**Updated Files:**
- `1.0_Methodology_Appendices.md` - Added E.11 section (2,464 → 2,676 lines)
- `0_START_HERE_Complete_Guide.md` - Updated file inventory and totals

**Benefits:**
- Consistent file organization across all projects
- Scannable working files (week and day visible)
- Clear consolidation path (working → final)
- Professional repository structure
- Reduced naming confusion

**Repository Status:**
- File count: 13 → 14 (+1 practical reference)
- Total system: ~8,320 lines

## [1.1.0] - 2025-11-19

### Added - Initial Release

**Core Methodology Documents:**
- `1.0_Data_Science_Collaboration_Methodology.md` - Academic Edition v1.0 (2,206 lines)
  - 4-phase workflow (Exploration Ã¢â€ â€™ Features Ã¢â€ â€™ Analysis Ã¢â€ â€™ Communication)
  - Tier 1 practices integrated (Decision Log, Pivot Criteria, Stakeholder Communication)
  - Advanced Complexity section with 10 optional practices
  - Notebook standards (~400 lines, 5-6 sections)
  - Text conventions (WARNING/OK/ERROR)

**Project Management Guidelines:**
- `2.0_ProjectManagement_Guidelines_v2.md` - Standard Edition (400 lines)
  - 7 required sections for project plans
  - 5 plan structure templates
  - File naming standards
  - Quality assurance checklist
- `2.1_PM_ProdGuidelines_extension.md` - Production Extension (477 lines)
  - Governance and RACI matrix
  - Risk management framework
  - Quality assurance and peer review
  - Post-project review process

**System Integration:**
- `0_Integrated_System_Guide-START-HERE.md` - Master integration guide
  - System overview with 4-document relationship
  - Hybrid setup step-by-step
  - Decision table for document usage
  - Quality checklist
  - Troubleshooting guide
- `00_New_Project_Checklist_Quick-Start-Template.md` - 5-step initialization
- `00_Final_System_Summary.md` - Complete system summary

**Implementation & Support:**
- `3_Methodology_Implementation_Guide.md` - Setup instructions
  - Custom Instructions template
  - Domain-specific examples (Time Series, NLP)
  - Advanced practices selection guide
- `1.1_Domain_Specific_Package_Reference.md` - Package recommendations by domain
- `1.2_File_Naming_Standards_Comprehensive.md` - Detailed naming conventions
- `1.3_File_Naming_Quick_Reference.md` - Quick naming reference

**Environment Setup:**
- `setup_base_environment.py` - Full environment setup script
- `setup_base_environment_minimal.py` - Minimal setup for academic work

**Documentation:**
- `README.md` - Comprehensive repository overview
- `LICENSE` - MIT License
- `CONTRIBUTING.md` - Contribution guidelines
- `CHANGELOG.md` - This file

### Battle-Tested Foundation
- Methodology validated through TravelTide Customer Segmentation Project
- 5,765 customer cohort analysis
- 89+ engineered features
- K=3 clustering optimization
- Consolidation from 15 to 6 notebooks (60% reduction)
- Complete stakeholder presentations and reporting

### Key Features
- AI agent optimized (Project Knowledge, Custom Instructions, progressive execution)
- Academic-focused with production extensions
- Integrated decision logging and pivot criteria
- Quality assurance standards throughout
- Text conventions (no emojis): WARNING/OK/ERROR
- Progressive cell-by-cell development approach

## [1.1.0] - 2025-11-19

### Changed - Methodology Reorganization

**Major Restructure:**
- `1.0_Data_Science_Collaboration_Methodology.md` reorganized to v1.1
  - Reduced from 3,324 to 2,576 lines (22.5% reduction)
  - Implemented 4-level hierarchical numbering (# ## ### ####)
  - 8 main sections with clear topic-based grouping
  - Removed Table of Contents (self-documenting via numbering)
  - Enhanced navigation: easy section referencing (e.g., "See Section 4.1.2")

### Added - Detailed Appendices

**Five New Appendix Documents (1,552 additional lines):**

1. **`1.0_Appendix_A_Environment_Setup_Details.md`** (453 lines)
   - Package rationale and installation procedures
   - Platform-specific troubleshooting (Windows, Mac, Linux)
   - Domain-specific package extensions (Time Series, NLP, Deep Learning, Computer Vision)
   - Environment maintenance and verification

2. **`1.0_Appendix_B_Phase_Deep_Dives.md`** (584 lines)
   - Detailed implementation guidance for each phase
   - Phase 0: Setup script walkthrough, VS Code configuration
   - Phase 1: Data quality assessment techniques, cohort strategies
   - Phase 2: Feature generation patterns, propensity modeling
   - Phase 3: Algorithm selection, validation techniques
   - Phase 4: Notebook consolidation, report writing, presentation design

3. **`1.0_Appendix_C_Advanced_Practices_Detailed.md`** (573 lines)
   - Complete implementation for Tiers 2-4 practices
   - Experiment tracking (manual CSV, MLflow)
   - Hypothesis management and statistical testing
   - Ethics & bias auditing with fairness metrics
   - Testing strategies (data validation, unit tests)
   - Data versioning and lineage tracking
   - Technical debt register templates
   - Scalability planning and resource estimation
   - Literature review extraction templates
   - Risk management frameworks

4. **`1.0_Appendix_D_Domain_Adaptations.md`** (369 lines)
   - Time Series: Stationarity testing, seasonal decomposition
   - NLP: Text preprocessing, TF-IDF vectorization
   - Computer Vision: Image augmentation, transfer learning
   - Clustering: Optimal K selection, cluster profiling (TravelTide example)
   - Regression/Classification: Metrics and evaluation patterns
   - Domain-specific challenges and solutions

5. **`1.0_Appendix_E_Quick_Reference.md`** (321 lines)
   - Phase completion checklists
   - Command cheat sheets (environment, packages, git)
   - Text convention reference tables
   - File naming patterns quick lookup
   - Validation metrics summary
   - Troubleshooting quick guide
   - Quality checklists

### Improved

**Organization & Navigation:**
- Topic-based section grouping (Introduction â†’ Workflow â†’ Standards â†’ Practices)
- Progressive complexity flow (Essential â†’ Advanced)
- Clear separation of concerns (core vs. detailed content)
- Comprehensive cross-referencing system (main doc â†” appendices)
- Self-documenting structure (no TOC maintenance needed)

**Maintainability:**
- Easier section location via hierarchical numbering
- Modular appendices for targeted updates
- Clear boundaries between topics
- Better suited for team collaboration and reviews

**Content Enhancements:**
- TravelTide decision log example in main doc (Section 4.1.4)
- 32+ code examples across appendices
- Domain-specific techniques and patterns
- Platform-specific troubleshooting guidance
- Comprehensive quick reference tables

### Technical Details

**Total Content:**
- Main document: 2,576 lines
- Appendices: 2,300 lines (5 files)
- Combined: 4,876 lines (46% increase from v1.0)
- Original v1.0: 3,324 lines

**Structure Changes:**
- Main doc retains: Core workflow, essential practices, advanced practices overview
- Appendices contain: Detailed implementations, examples, domain adaptations, quick references
- All v1.0 content preserved and enhanced

**Standards Maintained:**
- Text conventions (WARNING/OK/ERROR) throughout
- No emojis in documentation
- Professional tone
- 4-level hierarchical numbering consistently applied

## [Unreleased]

### Planned
- Templates directory with project starter templates
- Examples directory with domain-specific case studies
- TravelTide complete case study
- Troubleshooting guide expansion
- FAQ document
- Video tutorials (consideration)

### Under Consideration
- Tool integration guides (MLflow, DVC, Weights & Biases)
- Additional domain templates (computer vision, reinforcement learning)
- Multi-language support (German, Spanish)
- AI agent comparison guide
- Jupyter notebook templates

---

## Version Numbering

This project follows [Semantic Versioning](https://semver.org/):
- **MAJOR** version: Incompatible methodology changes
- **MINOR** version: New features, backward-compatible
- **PATCH** version: Bug fixes, documentation updates

## Types of Changes

- **Added** - New features or documents
- **Changed** - Changes to existing functionality
- **Deprecated** - Soon-to-be removed features
- **Removed** - Removed features
- **Fixed** - Bug fixes
- **Security** - Vulnerability fixes

## How to Contribute

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on contributing to this project.

## Contact

For questions or suggestions, please open an issue on GitHub.
