# DSM 7.0: AI Platform Collaboration Guide

**Version:** 0.1 (scaffold)
**Date:** 2026-04-19
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

**Status:** Placeholder. The filled instance (per the §3 template) lands
via BL-400 in Phase 4.

**Source material ready to consume:**

- `dsm-docs/research/done/2026-04-12_claude-code-platform-assessment.md`
  (741 lines, 12 sections covering Skills, Hooks, Settings.json, Permission
  Model, `@` References, Context Window Management, Memory System, MCP
  Servers, Subagents, IDE Integration, Git Integration, Tool System). BL-342
  deliverable, Implemented 2026-04-12.
- `.claude/reasoning-lessons.md` entries tagged as Claude-specific (hook
  behavior, skill frontmatter fields, `@` reference resolution depth, etc.).
- TAB/DSM-exclusive Claude patterns audit output (BL-399, pending).

### 2.2. (Future platforms)

Placeholder. Candidates include OpenAI API (agents / assistants), Ollama
(local LLM runtime), GitHub Copilot, custom-built platforms. Each gets its
own §2.N subsection filled against §3's template when DSM formally supports
it.

---

## 3. Generalized "How to Work With [Platform]" Template

**Status:** Empty in v0.1. Filled in Phase 5 (BL-401) after the Claude
instance (§2.1) is drafted and the template structure research (BL-398)
returns.

### Expected template sections (tentative, pending Phase 2 research)

1. Platform identity and scope (what the platform is, what it is not)
2. Configuration surface (files, directories, schemas)
3. Capability map (skills / tools / hooks / agents / memory analogues)
4. Collaboration patterns (how DSM protocols map to platform mechanisms)
5. Known limitations (context window, permission model, rate limits)
6. Incident history and lessons
7. Maintenance discipline (how to keep the section current as the platform
   evolves)

The final section list is determined by BL-398 research and BL-400's
Claude-instance experience.

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
