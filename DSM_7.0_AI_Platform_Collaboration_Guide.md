# DSM 7.0: AI Platform Collaboration Guide

**Version:** 0.3 (§3 template filled + external cross-refs applied)
**Date:** 2026-04-20
**Purpose:** Centralize platform-specific collaboration knowledge for each AI platform DSM projects run on. Companion to DSM_6.0 (principles, platform-agnostic) and DSM_0.2 (operational protocols, mostly platform-agnostic but with Claude-specific naming embedded).

---

## Contents

1. [Purpose and Scope](#1-purpose-and-scope)
2. [Platform Inventory](#2-platform-inventory)
3. [Generalized "How to Work With [Platform]" Template](#3-generalized-how-to-work-with-platform-template)
4. [Boundary Rules , Methodology vs Platform](#4-boundary-rules--methodology-vs-platform)
5. [Incident Catalog](#5-incident-catalog)
6. [References](#6-references)
7. [Version History](#7-version-history)

---

## 1. Purpose and Scope

DSM_0 through DSM_6 are platform-agnostic methodology. The agent collaboration
layer DSM projects actually run on , slash commands, hook runtimes, settings
files, context windows, tool systems, IDE integrations , is platform-specific.
DSM_6.0 §1.11 Read the User's Manual establishes that understanding the
external tool is a prerequisite to collaboration design; this document is
where that understanding lives.

### What belongs here

- Platform-specific behavior: hook execution model, tool exact behaviors,
  permission-model resolution, context-window semantics, IDE integration
  specifics
- Platform-specific configuration: per-platform equivalents of `CLAUDE.md`,
  settings files, directory conventions (`~/.claude/`, `.claude/hooks/`,
  `.claude/commands/`, `.claude/skills/`)
- TAB/DSM patterns that depend on platform-specific mechanisms (per-turn
  transcript hook, parallel-session registry, Cloned-Mirror Kick-off,
  Gate 0-3 IDE permission window behavior)
- Incident history tied to platform misunderstandings (F-094, S180, BL-342
  evidence base)
- One section per supported platform, each following the §3 generalized
  template

### What stays in DSM_0-6

- Pre-Generation Brief protocol (§8), session transcript discipline (§7),
  inclusive language (§13), heading parsability (§14), and other rules
  whose semantics are platform-agnostic
- Principles: Take a Bite, Earn Your Assertions, Know Your Context, etc.
  (DSM_6.0)
- Planning, sprint cadence, ecosystem protocols (DSM_2, DSM_3)

### What sits on the boundary

See §4. Short list: filenames like `CLAUDE.md`, `@` reference syntax,
directory conventions (`.claude/`), hook event names (`UserPromptSubmit`,
`PreToolUse`). Phase 5 of the BL-345 scaffolding plan revisits whether any
of these should be extracted from DSM_0.2 into this document.

### Scope of this v0.1 scaffold

This is the Phase 1 scaffold. §2.1 Claude Code is a placeholder pointing to
a forthcoming Phase 4 filled instance (tracked under BL-400). §3 template is
empty pending Phase 2 research (BL-398) and Phase 5 generalization (BL-401).
§4 boundary rules contains Phase 1 inventory; Phase 5 applies resolutions.

---

## 2. Platform Inventory

Platforms supported or contemplated for DSM collaboration. Each gets its
own subsection following §3's template once filled.

### 2.1. Claude Code (Anthropic)

Filled instance of the §3 template. Capability tier: **Full Agent**.
Primary sources: BL-342 platform assessment (12 areas, 741 lines), BL-398
template structure research, BL-399 TAB/DSM-exclusive patterns audit
(16 patterns). Maintenance discipline lives in BL-353 Platform Alignment
Protocol.

#### 2.1.1. Overview

Claude Code is Anthropic's official CLI for Claude, delivered as a
terminal binary plus a VS Code extension (the extension is a thin UI
over the CLI, not a separate product). It is the agentic runtime DSM
Central and every current DSM spoke project uses. Its capability tier
is Full Agent: persistent per-conversation session, local tool
execution (file I/O, shell, web), event hooks, memory, sub-agents,
and IDE integration are all native.

What Claude Code is NOT: an Anthropic API client library (that is the
Anthropic SDK, a separate artifact), a web chat UI (that is claude.ai,
also separate), or a self-hosted runtime. DSM protocols assume the
Claude Code harness; running a DSM project under a different agentic
runtime is out of scope for this document.

#### 2.1.2. Installation and Authentication

Official install and auth instructions live at Anthropic's Claude Code
documentation; this document deliberately does not mirror them because
the install surface changes faster than DSM_7.0 cadence. The DSM
invariant: an installed Claude Code CLI must resolve `/dsm-go` from
`~/.claude/commands/dsm-go.md` (user-scope deployment) OR
`.claude/commands/dsm-go.md` (project-scope, inside a DSM repo). The
`scripts/sync-commands.sh --deploy` script in DSM Central writes both
scopes; new DSM hosts run it once after cloning Central, and each
version bump re-runs it via the CHANGELOG spoke-action annotation.

#### 2.1.3. Core Concepts

Seven concepts a DSM collaborator must hold. Each cites BL-342 for the
full Claude Code definition and names the DSM protocol that consumes
it.

1. **Session.** A single Claude Code conversation, bound to a working
   directory, not a git branch (BL-342 §11). Sessions survive compaction
   but not restart. DSM maps one session to one `session-N/YYYY-MM-DD`
   Level 2 branch via `/dsm-go` Step 0.
2. **Hook.** A shell command dispatched on an event (`UserPromptSubmit`,
   `PreToolUse`, `PostToolUse`, `Stop`, etc.). Exit code `2` blocks the
   triggering action and surfaces stderr to Claude; any other non-zero
   is a soft warning (BL-342 §2). DSM wires three hooks via
   `scripts/templates/settings-hooks.json`.
3. **Skill.** A Markdown prompt file in `.claude/skills/SKILL.md` (new
   format) or `.claude/commands/*.md` (legacy format DSM still uses).
   Skills load once at session start or first invocation and survive
   compaction up to a 5K-per-skill / 25K-combined token budget
   (BL-342 §6). All 18 DSM lifecycle skills (`/dsm-go`, `/dsm-align`,
   `/dsm-wrap-up`, etc.) are command-format skills.
4. **Tool.** A Claude Code built-in action (`Read`, `Write`, `Edit`,
   `Bash`, `Grep`, `Glob`, `Agent`, etc.). Bash runs each invocation
   as a fresh subprocess, so env vars do not persist across Bash calls
   (BL-342 §12). MCP servers add tools with the `mcp__server__tool`
   naming (BL-342 §8).
5. **`@` Reference.** Recursive Markdown import syntax, up to 5 hops
   (BL-342 §5). DSM_0.2 is loaded into every DSM project through one
   `@` import in the project `.claude/CLAUDE.md`; the dispatch table
   inside DSM_0.2 uses Markdown links, not nested `@` imports, to
   control context budget.
6. **Memory.** Two layers: `CLAUDE.md` (user-written, always loaded)
   and auto memory at `~/.claude/projects/.../memory/MEMORY.md`
   (Claude-written, first 200 lines or 25 KB loaded) (BL-342 §7).
   DSM uses both: CLAUDE.md for durable protocol anchors, auto memory
   for cross-session recall and user-preferences.
7. **Subagent.** An isolated sub-session spawned via the `Agent` tool
   with its own context window (BL-342 §9). DSM uses Sonnet subagents
   for reading-heavy pre-brief research so the main thread stays light
   (see DSM_0.2 §8.7).

#### 2.1.4. Platform Capability Surface

Y = native and stable; P = partial or plan-gated; N = not supported.

| Capability                              | Claude Code | Notes |
|-----------------------------------------|-------------|-------|
| Persistent per-conversation session     | Y | Bound to working directory; not to git branch |
| Local tool execution (file, shell, web) | Y | Via built-in tools and MCP |
| Event-driven automation (hooks)         | Y | 24+ events; DSM uses 2 |
| Durable memory across sessions          | Y | CLAUDE.md + auto memory; budget-capped |
| Multi-agent orchestration               | Y | Agent tool, worktree isolation; agent teams marked experimental |
| Local hardware access (shell, GPU)      | Y | Via Bash tool; sandbox off by default in most DSM setups |
| Model config and routing                | P | Effort / thinking / fast-mode knobs per session; no fine-tuning |
| Billing / usage tracking                | P | Subscription-side; see `~/.claude/claude-subscription.md` |
| Auto mode (unattended execution)        | P | Plan-gated: Team / Enterprise / API + Sonnet 4.6 only (BL-342 §4) |
| IDE integration                         | Y | VS Code extension is primary; JetBrains and web also supported |

#### 2.1.5. How to Work With Claude Code in a DSM Context

The densest subsection, because most DSM protocols depend on
Claude-specific mechanisms. Grouped by protocol.

**Session transcript and the UserPromptSubmit hook.**
`.claude/hooks/transcript-reminder.sh` (UserPromptSubmit) injects a
per-turn reminder that the agent must append thinking to
`.claude/session-transcript.md` before work (BL-399 P-01). A second
hook, `.claude/hooks/validate-transcript-edit.sh` (PreToolUse on
Edit), enforces append-only shape with three checks: anchor is the
last non-empty line of the file, new content is strictly appended,
and delimiters match the `<------------Start {Thinking|Output|User} /
HH:MM------------>` pattern (BL-399 P-02). These two hooks are the
only operational enforcement of DSM_0.2 §7; IDE monitoring and
session-start behavioral activation are user affordances, not
mechanisms. See §5 Incident Catalog F-094 and S180 for why the
mode-bit handling is load-bearing.

**Pre-Generation Brief Gate 2 and the IDE permission window.**
Gate 2 (implementation review) is realized by the VS Code extension's
file-write approval dialog, activated by
`claudeCode.initialPermissionMode: "default"` (BL-399 P-08).
Accepting the dialog is the explicit approval DSM_0.2 §8.2 requires.
Setting the mode to `acceptEdits` or `auto` breaks Gate 2 silently;
DSM recommends `default` for all projects unless the user has an
explicit reason to override.

**Parallel sessions and the PID-scoped registry.** Concurrent Claude
Code instances in the same workspace share a git working copy.
`/dsm-parallel-session-go` writes a provisional stub to
`.claude/parallel-sessions.txt` as its first tool call, before the
UserPromptSubmit hook can fire on turn 1 (BL-399 P-07, P-04). The
stub lets the hook route transcript behavior correctly
(main-session-only writes to the live transcript; parallel sessions
write to their own per-PID files). Commit booking via
`.claude/commit-lock` with 5-minute TTL prevents interleaved commits
(BL-399 P-15).

**Cloned-Mirror Kick-off and template promotion.** Freshly cloned
mirror repos arrive with `.claude/*.template` files instead of live
runtime files. `/dsm-go` Step 0.8 detects the un-kicked-off state
(no `.claude/kickoff-done.txt`, no self-as-central registry row) and
runs the 14-step Kick-off sequence: copy templates to runtime paths,
substitute `{REPO_ROOT}` / `{project_name}` / `{ISO_DATE}`,
self-register the clone as `dsm-central`, deploy commands, chmod
hooks, write the done marker (DSM_0.2.A §25). This is the mechanism
that turns a cloned mirror into a functional DSM hub.

**Three-Level Branching Strategy.** DSM's L1 (main) / L2 (session) /
L3 (task) branch model runs on Claude's sessions-are-per-directory
behavior (BL-342 §11). The agent's working copy stays on the same
branch across turns; explicit `git checkout` in a tool call is the
only way to move. Post-merge branch recreation (DSM_0.2 §20.8)
exists because `gh pr merge --delete-branch` leaves the working
copy on `main`; the next commit silently violates the strategy
without this rule.

**DSM boundary rules.** Claude Code absolute don'ts:

- Do NOT issue `rm -rf`, `git push --force`, `git reset --hard`,
  `git branch -D`, or `gh pr merge` against a PR based on `main`
  without explicit user request (DSM spoke CLAUDE.md
  Destructive Command Protocol).
- Do NOT skip the `PreToolUse` hook on transcript edits by
  appending via Bash heredoc. The `Edit` tool path is preferred; if
  Bash is used, the heredoc must be unquoted (`<< EOF`, not
  `<< 'EOF'`) to allow `$(date ...)` expansion (DSM_0.2 §7
  heredoc anti-pattern).
- Do NOT skip `/dsm-align` at session start. `/dsm-go` Step 1.8
  runs it unconditionally; the failure mode that justifies
  unconditional run (F-094, S180) is described in §5 and
  DSM_0.2.A §23.

#### 2.1.6. Configuration and Customization

Five files a DSM collaborator edits. Paths relative to project root
unless noted.

| Path                          | Role                                      | Scope     |
|-------------------------------|-------------------------------------------|-----------|
| `.claude/CLAUDE.md`           | Project agent config; `@`-imports DSM_0.2 | Project   |
| `.claude/settings.json`       | Permissions, hooks, env, autoMemory       | Project   |
| `.claude/hooks/*.sh`          | Hook scripts; DSM wires 3                 | Project   |
| `.claude/commands/*.md`       | Project-scope skills (legacy DSM format)  | Project   |
| `~/.claude/CLAUDE.md`         | User-global instructions                  | User      |
| `~/.claude/commands/*.md`     | User-scope skills (deployed DSM commands) | User      |

**Settings.json scope order** (BL-342 §3): managed > user > project >
local > CLI. `deny` rules at any level are absolute. DSM does not use
the managed scope; user and project scopes carry DSM's permission and
hook wiring.

**Hook wiring architecture** (BL-399 P-06). DSM's three hook slots:

- `UserPromptSubmit` → transcript-reminder.sh (occurrence enforcement)
- `PreToolUse` matching Edit → validate-transcript-edit.sh (shape
  enforcement)
- `PreToolUse` matching Bash with commit-like commands →
  validate-rename-staging.sh (git-mv staging safety, BL-399 P-03)

Because `settings.json` is gitignored per the `.claude/` blanket
rule, DSM delivers hook entries via
`scripts/templates/settings-hooks.json`; `/dsm-align` Step 10b merges
them idempotently, matching by command string (so user-added hooks
are preserved).

**`@` reference chain** (BL-342 §5, DSM_0.2 §17). Every DSM project's
`.claude/CLAUDE.md` starts with one `@` line pointing to DSM Central's
`DSM_0.2_Custom_Instructions_v1.1.md`. DSM_0.2 internally uses
Markdown links (not nested `@` imports) to lazy-load modules A-D on
demand; this is a deliberate context-budget choice, not a limitation.
Recursive `@` import to 5 hops is supported but not used by DSM's
architecture.

> **Verification note.** The 5-hop recursion depth (BL-342 §5) was
> flagged by BL-342 as "needs empirical verification" because DSM
> MEMORY previously held an incorrect "no recursion" claim. DSM
> architecture does not depend on recursion depth >1; future BLs that
> propose multi-hop `@` chains should verify the depth at commit time.

**Skill format.** DSM uses the legacy `.claude/commands/*.md` format
exclusively; the new `.claude/skills/SKILL.md` format with frontmatter
is available (BL-342 §1) but not adopted. Migration is a separate BL,
not a blocker.

**Compact instructions** (BL-342 §6). When context pressure triggers
auto-compaction, Claude Code preserves project-root CLAUDE.md and any
skill invoked in the session up to the 5K/25K budget. Long DSM
sessions that invoke many skills (`/dsm-go`, `/dsm-align`,
`/dsm-wrap-up`, `/dsm-staa`, `/dsm-backlog`, research skills) can
exceed the combined budget; early skill content is dropped silently.
Mitigation: keep CLAUDE.md tight (DSM_0.2 §17.2 content validation
enforces this), and use `/dsm-light-go` for continuation sessions
where full `/dsm-go` context is not needed.

#### 2.1.7. Integration with Other Platforms and Tools

- **GitHub CLI (`gh`).** The Bash tool invokes `gh` for PR
  management, issue triage, and default-branch verification
  (DSM_0.2.A §17 Step 2a.6). `gh` is a prerequisite, not a Claude
  Code built-in.
- **Git.** Claude Code sees branch state and uncommitted changes
  but sessions are tied to directory, not branch (BL-342 §11). DSM
  Three-Level Branching runs on top of this.
- **MCP servers.** DSM does not currently consume MCP tools in
  protocols. Projects may add them (Gmail, Drive, Calendar, etc.);
  tool names are `mcp__server__tool` (BL-342 §8). Tool definitions
  are deferred by default, accessed via ToolSearch on demand.
- **IDE integration.** VS Code is the primary DSM IDE. The built-in
  MCP server exposes `getDiagnostics` and `executeCode` (BL-342
  §10). JetBrains and web UIs work but the DSM Gate 2 permission
  model is best tuned for VS Code.

#### 2.1.8. Security and Permissions

**Permission modes** (BL-342 §4), six values:

| Mode                  | Behavior                                      | DSM Use |
|-----------------------|-----------------------------------------------|---------|
| `default`             | Prompt on every action not in allowlist       | Recommended |
| `acceptEdits`         | Auto-accept file edits                        | Avoid , breaks Gate 2 |
| `plan`                | Read-only exploration                         | Gate 1 research |
| `auto`                | Unattended execution, allowlist-bound         | Plan-gated (Team/Ent/API + Sonnet 4.6) |
| `dontAsk`             | Silent mode, allowlist-only                   | Avoid , removes enforcement visibility |
| `bypassPermissions`   | No prompts at all                             | Never in DSM |

> **Counter-evidence surfacing.** Auto mode is gated by plan
> (Team / Enterprise / API) AND by model (Sonnet 4.6 only) per BL-342
> §4. DSM users on personal or Pro plans cannot use auto mode; the
> fallback is `default` with a broad allowlist. BL-397
> (Auto-Mode Boundaries) tracks the auto-mode policy for DSM sessions
> that have access.

**Protected paths.** `.claude/` is protected by default EXCEPT for
`.claude/commands/`, `.claude/agents/`, `.claude/skills/`, and
`.claude/worktrees/` (BL-342 §4). DSM writes to
`.claude/session-transcript.md`, `.claude/last-align-report.md`,
`.claude/last-align.txt`, and `.claude/session-baseline.txt` under
the per-project auto-approved allowlist (set by `/dsm-align` via
the settings.json template).

**Secret exposure prevention.** Spoke-side protocol in DSM_0.2
Module C §5 plus project CLAUDE.md Destructive Command Protocol. The
pre-staging filename check (`.env`, `*.key`, `*.pem`, etc.) is agent
behavior, not a hook; DSM has no Claude-specific secret scanner
hook today. BL-335 `check-mirror-sync-content.sh` is a content-level
scanner invoked manually at mirror-sync time.

#### 2.1.9. Troubleshooting and Collaboration Incident Catalog

Claude-specific collaboration failures and their resolutions. Full
cross-document catalog lives in §5; this subsection curates the
§2.1-relevant entries.

- **F-094 , per-turn transcript hook silently broken (2026-01 to
  2026-04-07).** Hook script at index-mode 100644; WSL with
  `core.fileMode = false` hid the missing +x. Resolution: `/dsm-align`
  Step 10b sub-step (b) re-applies chmod every run (BL-319). See §5.
- **S180 +x bug (2026-04-07).** Same class, smaller scale. Same
  resolution.
- **BL-377 parallel-session turn-1 hook collision (2026-04-18).**
  UserPromptSubmit hook fired before parallel registry stub was
  written on turn 1; rogue transcript block ended up in the main
  transcript. Resolution: provisional-stub pattern
  (`/dsm-parallel-session-go` Step 0) writes registry before any
  other tool call (BL-399 P-07).
- **BL-342 mental-model gap (filed 2026-04-10).** Prior mental
  model of Claude Code was experiential, not docs-grounded. Resulted
  in three incorrect claims (including the `@` no-recursion claim
  above). Resolution: 741-line systematic assessment, ongoing
  alignment via BL-353 (Platform Alignment Protocol).
- **Heredoc quoting anti-pattern (portfolio S69).** Single-quoted
  heredoc (`<< 'EOF'`) suppresses `$(date ...)` expansion, writing
  literal strings into the transcript. Resolution: Edit-tool append
  path is preferred; Bash heredoc must be unquoted. Documented in
  DSM_0.2 §7 anti-patterns.

Failure modes inherent to Claude Code that DSM should watch:

- **Skill compaction overflow.** Long sessions with many skill
  invocations can silently drop early skill content beyond the
  25K combined budget. No error is raised. Detection is behavioral
  (agent forgets a rule that was in a loaded skill).
- **Hook dispatch timing on turn 1.** UserPromptSubmit fires before
  skill execution; any skill that needs to set up state for the
  hook must either run the setup as a sync pre-hook or use the
  provisional-stub pattern (BL-399 P-07).
- **Bash subprocess isolation.** Env vars do not persist across
  Bash calls (BL-342 §12). Tests that rely on an exported variable
  must set it in the same Bash invocation.

#### 2.1.10. Reference

DSM-relevant Claude Code commands and paths. This is a cheatsheet,
not a replacement for official docs.

| Action                              | Command / Path                                        |
|-------------------------------------|-------------------------------------------------------|
| Resume DSM session                  | `/dsm-go` (runs `/dsm-align` unconditionally)         |
| Deploy DSM commands to user scope   | `scripts/sync-commands.sh --deploy`                   |
| List installed skills (user)        | `ls ~/.claude/commands/`                              |
| Session transcript (live log)       | `.claude/session-transcript.md`                       |
| Archived transcripts                | `.claude/transcripts/{YYYY-MM-DDTHH:MM}-ST.md`        |
| Project agent config                | `.claude/CLAUDE.md`                                   |
| Settings (permissions, hooks)       | `.claude/settings.json`                               |
| Hook scripts                        | `.claude/hooks/{name}.sh`                             |
| Memory (auto)                       | `~/.claude/projects/.../memory/MEMORY.md`             |
| Run a subagent                      | Invoke `Agent` tool with `subagent_type`              |
| Check cached subscription info      | `~/.claude/claude-subscription.md`                    |

Official Claude Code documentation: <https://docs.claude.com/claude-code>.

#### 2.1.11. Production Readiness

Claude Code at DSM's usage pattern is not a production runtime in
the SaaS sense; each user runs an instance locally. Production-like
concerns that do apply:

- **Auto mode access.** Required for unattended CI-style DSM runs.
  Plan-gated as noted in §2.1.8. Personal/Pro users should not
  design DSM protocols that assume auto mode.
- **Model versioning.** DSM currently standardizes on Opus 4.7 for
  main threads and Sonnet 4.6 for subagents per
  `~/.claude/claude-subscription.md`. Model bumps are tracked in
  `.claude/claude-subscription.md` updates, not in DSM_0.2.
- **Hook latency.** UserPromptSubmit hooks run synchronously before
  the turn starts; a slow hook adds latency to every turn. DSM hooks
  are ~100 ms each; anything over 1 s should be moved async.
- **Mirror sync as release artifact.** Version bumps in DSM Central
  trigger mirror sync (DSM_0.2 §18 plus the Change Propagation
  Protocol in `.claude/CLAUDE.md`). This is DSM's "publish" step;
  it is not a Claude Code feature but depends on Claude Code's
  `@` reference chain to propagate.

Maintenance discipline: BL-353 Platform Alignment Protocol runs as
the continuous loop. When Claude Code ships a material change, BL-353
proposes the §2.1 update; §7 version history records the Phase N
increment.

### 2.2. (Future platforms)

Placeholder. Candidates include OpenAI API (agents / assistants), Ollama
(local LLM runtime), GitHub Copilot, custom-built platforms. Each gets its
own §2.N subsection filled against §3's template when DSM formally supports
it.

---

## 3. Generalized "How to Work With [Platform]" Template

Extracted from §2.1 Claude Code (BL-400) and BL-398 template-structure
research. Each supported platform gets its own §2.N subsection following
this template. Subsections §3.1 through §3.10 are required; §3.11
applies only to Full Agent tier platforms.

Platform-specific terms (filenames, directory paths, command syntax,
hook event names) belong in §2.N, never in §3. This template is
declaratively platform-agnostic: no `.claude/`, no `CLAUDE.md`, no `@`
imports, no hook or tool names.

### 3.1. Overview

**Purpose.** Name the platform, its vendor, its delivery form (CLI,
IDE extension, web app, SDK, or combination), and its **capability
tier**: *Full Agent* (persistent session + local tool execution +
hooks + memory), *Scripted Agent* (persistent session + tool execution
but no hooks), *Interactive Chat* (session only, no tools), or *API
Only* (no session state).

**What goes here.** One paragraph on what the platform IS and one
paragraph on what it is NOT. The "is not" paragraph is where scope
boundaries live (e.g., "this section does not cover X product from
the same vendor").

### 3.2. Installation and Authentication

**Purpose.** Ground readers in the install surface without mirroring
vendor documentation that changes faster than this guide.

**What goes here.** Pointer to official install docs + DSM-specific
invariants (paths that must resolve, auth modes DSM requires, any
host-level setup for DSM skills or hooks). Do NOT paste vendor install
instructions; link to them.

### 3.3. Core Concepts

**Purpose.** Name the 3-7 platform concepts a DSM collaborator must
understand to follow DSM protocols on the platform. Each concept gets
a cross-reference to the platform's own documentation and to the DSM
protocol that consumes it.

**What goes here.** Numbered list of concepts. Each concept: one-line
definition + DSM-protocol-consumer reference. Keep definitions short
(1-3 lines); the authoritative source is the vendor's docs.

### 3.4. Platform Capability Surface

**Purpose.** Structured comparison of what the platform supports so
DSM protocol authors know what they can assume.

**What goes here.** Three-column table: Capability | Support (Y / P /
N) | Notes. The required capability list (shared across all
platforms):

- Persistent per-conversation session
- Local tool execution (file, shell, web)
- Event-driven automation (hooks)
- Durable memory across sessions
- Multi-agent orchestration
- Local hardware access
- Model config and routing
- Billing / usage tracking
- Unattended execution mode
- IDE integration

Y = native and stable; P = partial or gated (by plan, model, or
version); N = not supported. Notes column carries gating details.

### 3.5. How to Work With [Platform] in a DSM Context

**Purpose.** The densest subsection. Map each DSM protocol that has
platform-specific realization to the platform mechanism that realizes
it.

**What goes here.** One subsection per DSM protocol that couples to
the platform. For each protocol: name the DSM protocol, name the
platform mechanism, give the one-line mapping, and reference any BL
or research file where the mapping is documented. Typical protocols
covered:

- Session transcript discipline (DSM_0.2 §7)
- Pre-Generation Brief gates, especially Gate 2 (DSM_0.2 §8)
- Parallel session coordination (DSM_0.2.A §7)
- Cloned-Mirror Kick-off (DSM_0.2.A §25)
- Three-Level Branching Strategy (DSM_0.2 §20)
- Any boundary rules specific to this platform (absolute don'ts,
  plan-gated features, unsupported patterns)

End this subsection with the platform's DSM boundary rules: the
platform-specific absolute don'ts, drawn from the project's agent-config
file Destructive Command Protocol or equivalent.

### 3.6. Configuration and Customization

**Purpose.** Enumerate the files a DSM collaborator edits on this
platform.

**What goes here.** Table of path + role + scope. Follow with
subsections on the platform's config scope order (if it has one),
hook wiring architecture (if hooks exist), skill or extension format,
and context-budget / compaction behavior (if relevant).

Any platform quirk that a DSM protocol depends on (e.g., recursive
import depth, context-window preservation rules, tool exec sandbox
behavior) gets its own note here with a verification caveat if the
claim has not been locally tested.

### 3.7. Integration with Other Platforms and Tools

**Purpose.** Document cross-platform tool invocations DSM protocols
rely on.

**What goes here.** Short list of external tools (CLIs, MCP servers,
IDEs) that DSM protocols call through this platform's tool surface.
Include prerequisite-vs-built-in distinction: tools DSM assumes are
installed alongside the platform, tools the platform ships with.

### 3.8. Security and Permissions

**Purpose.** Document the platform's permission model and how DSM
protocols constrain it.

**What goes here.**

- Permission modes (list + table) and DSM's recommended default.
- Protected paths or resources (what DSM is NOT allowed to write
  without explicit user consent).
- Secret-exposure prevention (pointer to the project's agent-config
  Secret Exposure Prevention section + any platform-specific scanner
  or hook).
- Any plan-gated or model-gated capability that affects security (e.g.,
  unattended mode availability); include a counter-evidence-style
  callout per DSM_0.2 §8.2.1 when a feature's availability is
  conditional.

### 3.9. Troubleshooting and Collaboration Incident Catalog

**Purpose.** Curate the §5 Incident Catalog entries that apply to this
platform, plus platform-native failure modes DSM should watch.

**What goes here.** Two sub-lists:

1. Historical incidents (cross-link to §5; don't duplicate the content,
   add platform-specific context if needed).
2. Known failure modes inherent to the platform (behaviors that are
   working as designed but can bite DSM protocols). Each failure mode:
   what happens, how to detect, how to mitigate.

### 3.10. Reference

**Purpose.** A cheatsheet for DSM-relevant platform commands and
paths.

**What goes here.** Action | Command / Path table. Scope is
DSM-relevant actions only, not a full command reference (link to
vendor docs for that).

### 3.11. Production Readiness (optional)

Include this section ONLY if the platform's capability tier is Full
Agent AND DSM projects run unattended / CI-style workloads on it.

**Purpose.** Document production-like concerns for unattended DSM
execution.

**What goes here.** Plan / subscription requirements, model versioning
discipline, hook latency budgets, and any "publish" step (mirror sync,
release tagging) that couples to platform features.

### 3.12. How to Instantiate This Template for a New Platform

Procedure for filing a new `§2.N [Platform]` subsection.

1. **File a BL** titled "DSM_7.0 §2.N [Platform] Filled Instance"
   with Phase-4-style scope (single-file edit to DSM_7.0, multi-source
   research inputs documented).
2. **Commission the research.** If the platform has not been
   systematically assessed, file a BL-342-style platform-assessment
   research item (N areas matching §3.3 concepts + §3.4 capability
   rows). Deliverable lands in `dsm-docs/research/`.
3. **Commission the patterns audit** (optional). If the platform has
   accumulated DSM-exclusive patterns that bend or extend DSM
   protocols, file a BL-399-style audit. Skip for first-time adoption
   platforms with no prior DSM use.
4. **Draft §2.N.** Follow §3 subsection-by-subsection. Cite research
   files for every non-obvious claim (per DSM_0.2 §8.2.1 counter-
   evidence and §10.1 validation depth).
5. **Apply cross-references.** Any DSM_0.2 section, DSM_6.0 principle,
   or reasoning-lessons category that couples to the new platform
   gets a "Relationship to DSM_7.0 §2.N" paragraph added (pattern per
   DSM_0.2 §8.6).
6. **Update §4 Boundary Rules.** Add a row to the inventory naming
   where the platform's specifics live in DSM_0-6 and the resolution
   chosen (Option 1 pointer, or Option 3 extraction).
7. **Update §5 Incident Catalog.** Seed with any platform-specific
   incidents already known.
8. **Update §7 Version History** with a new entry describing which
   §2.N landed.

BL-398 → BL-399 → BL-400 → BL-401 is the reference chain for the
first instance (Claude Code). Future platforms can reuse the chain
pattern or collapse phases when prior research is unnecessary.

---

## 4. Boundary Rules , Methodology vs Platform

This section documents where platform-specific content currently lives
inside platform-agnostic DSM documents, classifying each as naming-only or
semantic-also. Phase 1 inventory only; Phase 5 (BL-401) applies resolutions.

### Inventory (Phase 1)

| Location | Platform-specific content | Classification | Candidate resolution |
|----------|--------------------------|----------------|----------------------|
| DSM_0.2 §7 Session Transcript Protocol | `.claude/session-transcript.md` path; `UserPromptSubmit` hook name; PreToolUse validator | Naming-only (protocol shape is platform-agnostic) | Keep in §7 with a cross-reference footer pointing to DSM_7.0 §2.1 for the Claude execution layer |
| DSM_0.2 §17 CLAUDE.md Configuration | Entire section is Claude's agent-config system (filename `CLAUDE.md`, `@` import syntax, `.claude/` directory) | Semantic-also (the section describes Claude's config system) | Option 1 (recommended for now): leave §17 in place; add a cross-reference to DSM_7.0 §2.1. Option 3 (Phase 5 revisit): extract Claude-specific parts into DSM_7.0 §2.1; keep only the platform-agnostic "agents need a config file" spec in DSM_0.2 |
| DSM_0.2 §23 Third-Party Skill Governance | `~/.claude/skills/`, SKILL.md frontmatter, skill event matchers | Naming-only (registry pattern is platform-agnostic) + semantic-also (SKILL.md format) | Keep general registry concept in §23; move SKILL.md specifics to DSM_7.0 §2.1 |
| DSM_0.2.B Infrastructure File Collaboration | Skills, hooks, settings.json, command files | Naming-only with semantic-also leanings | Cross-reference to DSM_7.0 §2.1 |
| DSM_0.2.A §7 Parallel Session Protocol | Parallel Claude Code CLI instances, commit booking via `.claude/parallel-sessions.txt` | Semantic-also (mechanism requires multiple Claude Code instances in the same workspace) | Cross-reference to DSM_7.0 §2.1 for the Claude mechanism; protocol shape stays in §A.7 |
| DSM_0.2.A §25 Cloned-Mirror Kick-off | `.claude/*.template` runtime promotion, `/dsm-go` Step 0.8 detection | Semantic-also (Kick-off runs in Claude Code) | Cross-reference to DSM_7.0 §2.1 |
| DSM_0.2 §8.2 Gate 2 | IDE permission window | Naming-only (the gate model is platform-agnostic; the permission window is Claude Code / VS Code specific) | Cross-reference to DSM_7.0 §2.1 |

### Phase 5 resolution plan

BL-401 (template generalization + cross-references) applies Option 1 by
default: leave source-of-truth content where it is, add one-line
cross-references to DSM_7.0 §2.1. Revisit Option 3 (extract Claude
specifics) only if an external reviewer flags DSM_0.2 as Claude-coupled in a
way that blocks another platform's adoption.

### Cross-reference destinations (inventory for Phase 5)

From the Phase 1 Explore survey (BL-345 plan, 2026-04-19). Phase 5 (BL-401)
applies edits.

1. DSM_0.0 §7 Document Map , add DSM_7.0 entry (this scaffold already does
   it)
2. DSM_0.2 §7 Session Transcript , footer cross-reference to §2.1
3. DSM_0.2 §8 Pre-Generation Brief (Gate 2 permission window) ,
   cross-reference
4. DSM_0.2 §17 CLAUDE.md Configuration , cross-reference at section top
5. DSM_0.2 §23 Third-Party Skill Governance , cross-reference on SKILL.md
6. DSM_0.2.A §7 Parallel Session Protocol , cross-reference
7. DSM_0.2.A §25 Cloned-Mirror Kick-off , cross-reference
8. DSM_0.2.B Infrastructure File Collaboration , cross-reference
9. DSM_6.0 §1.11 Read the User's Manual , cross-reference to §2.1 as the
   primary instance of the principle
10. `.claude/reasoning-lessons.md` header , tag Claude-specific entries;
    link to DSM_7.0 §2.1

---

## 5. Incident Catalog

Claude-specific incidents whose root cause was platform-understanding gaps.
Each is a case study for DSM_6.0 §1.11 Read the User's Manual, and each
informs §2.1 Claude Code once filled.

| Incident | Date | Summary | Root cause | Resolution | Related BL |
|----------|------|---------|-----------|------------|------------|
| F-094 , per-turn transcript hook silently broken | ~2026-01 to 2026-04-07 | `.claude/hooks/transcript-reminder.sh` at index-mode `100644`; `core.fileMode = false` on WSL hid it; every fresh clone got non-executable hooks; 2.5 months of silent non-function | Mode-bit + WSL + clone interaction not understood at hook-design time | `git update-index --chmod=+x`; `/dsm-align` Step 10b sub-step b re-applies chmod every run | BL-319 |
| S180 +x bug | 2026-04-07 | Same class as F-094 at smaller scale; bytewise-correct hooks not executable on a specific instance | Claude Code hook dispatch requires executable bit; not captured in mental model | Same as F-094 | Related to BL-319, BL-342 |
| BL-342 filing (corrective mitigation) | 2026-04-10 (filed), 2026-04-12 (done) | Systematic read of Claude Code documentation across 12 areas | Prior mental model was experiential, not docs-grounded | 741-line research file in `dsm-docs/research/done/` | BL-342 |
| BL-343, BL-344, BL-345 filing (follow-ups) | 2026-04-10 | Secondary BLs spawned from BL-342 research: skill governance, DSM_6.0 §1.11 principle, this document | N/A | BL-343 open; BL-344 Implemented 2026-04-19; BL-345 this scaffold (Phase 1) | BL-343, BL-344, BL-345 |
| BL-377 parallel-session turn-1 hook collision | 2026-04-18 | Parallel-session agent emitted rogue transcript block on turn 1 because hook fired before registry stub was written | UserPromptSubmit hook dispatch timing vs skill execution order not fully mapped | `/dsm-parallel-session-go` Step 0 (provisional stub as first tool call) + top-of-file WARNING block | BL-377 |

Additional incidents will be added to §2.1 Claude Code's own history as BL-400
consumes them. This catalog is the cross-document view for the whole guide.

---

## 6. References

- `DSM_0.0_START_HERE_Complete_Guide.md` §7 Document Map , where this doc
  is listed
- `DSM_6.0_AI_Collaboration_Principles_v1.0.md` §1.11 Read the User's
  Manual , foundational principle this doc operationalizes for specific
  platforms
- `dsm-docs/research/done/2026-04-12_claude-code-platform-assessment.md` ,
  BL-342 research, primary source for §2.1 Claude Code
- `dsm-docs/plans/done/BACKLOG-345_ai-platform-section-architecture.md` ,
  this scaffold's origin BL
- `dsm-docs/plans/BACKLOG-398_*.md` , Phase 2 template-structure research
- `dsm-docs/plans/BACKLOG-399_*.md` , Phase 3 TAB/DSM-exclusive patterns
  audit
- `dsm-docs/plans/BACKLOG-400_*.md` , Phase 4 Claude filled instance
- `dsm-docs/plans/BACKLOG-401_*.md` , Phase 5 template generalization +
  cross-references

---

## 7. Version History

| Version | Date | Changes |
|---------|------|---------|
| 0.1 | 2026-04-19 | Initial scaffold (BL-345 Phase 1). Seven top-level sections with placeholder content in §2.1 (Claude Code, pending BL-400) and §3 (template, pending BL-398 + BL-401). §4 boundary inventory populated from BL-345 Phase 1 Explore survey. §5 incident catalog seeded with F-094, S180, BL-342, BL-343, BL-344, BL-345, BL-377. |
| 0.2 | 2026-04-20 | §2.1 Claude Code filled instance (BL-400, Phase 4). Consumes BL-398 template (10 + 1 subsections), BL-399 patterns (14 TAB/DSM-exclusive behaviors mapped), and BL-342 research (12 areas cited). §3 template remains empty pending BL-401 generalization. No DSM_0.2 edits in this phase; §4 boundary cross-references land in BL-401. |
| 0.3 | 2026-04-20 | §3 template filled (BL-401, Phase 5). 12 subsections: §3.1-§3.10 required, §3.11 Production Readiness optional (Full Agent tier), §3.12 How to Instantiate This Template for a New Platform (8-step procedure). Cross-references applied from DSM_0.2 §7, §8.2, §17, §23; DSM_0.2.A §7, §25; DSM_0.2.B §8; DSM_6.0 §1.11; and `.claude/reasoning-lessons.md` header. BL-345 rollout closed end-to-end. |
