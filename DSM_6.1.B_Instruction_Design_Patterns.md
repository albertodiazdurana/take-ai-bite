# DSM 6.1 Module B: Instruction Design Patterns

**Version:** 1.0
**Last Updated:** 2026-03-25
**Parent document:** DSM_6.1 Systems Prompt Engineering

Module A maps the operational infrastructure (channels and context management).
This module maps the design patterns: how instruction artifacts are structured,
layered, propagated, and iterated. These patterns are not theoretical; they
emerged from operational experience across 150+ sessions and multiple projects.
Each pattern solves a specific problem that practitioners encounter when
instruction systems grow beyond a single prompt.

## Contents

1. [Instruction Design as Engineering Discipline](#1-instruction-design-as-engineering-discipline)
2. [CLAUDE.md Architecture and Layering Patterns](#2-claudemd-architecture-and-layering-patterns)
3. [Command Files as Reusable Prompt Templates](#3-command-files-as-reusable-prompt-templates)
4. [Protocol Templates as Behavioral Specifications](#4-protocol-templates-as-behavioral-specifications)
5. [Hub-Spoke Feedback Loop as Instruction Iteration](#5-hub-spoke-feedback-loop-as-instruction-iteration)
6. [Instruction Versioning and Release Management](#6-instruction-versioning-and-release-management)
7. [References and Version History](#7-references-and-version-history)

---

## 1. Instruction Design as Engineering Discipline

A single prompt can be written ad hoc. An instruction system cannot. When
multiple documents must coordinate to produce consistent behavior across
sessions and projects, the design of those documents becomes an engineering
problem: how to structure them for maintainability, how to version them for
traceability, how to propagate changes without breaking dependent systems.

DSM's instruction artifacts exhibit the same design concerns as software:

| Software Concern | Instruction Equivalent | DSM Implementation |
|------------------|----------------------|-------------------|
| Modularity | Split large documents into focused units | DSM_0.2 core + 4 modules, DSM_1.0 core + 4 modules |
| Interface contracts | Stable references between documents | `@` reference chain, dispatch tables, section numbering |
| Configuration management | Environment-specific overrides | CLAUDE.md base template + project-specific sections |
| Deployment pipeline | Distributing changes to consumers | Mirror sync, command file sync (scripts/sync-commands.sh) |
| Regression testing | Verifying changes do not break behavior | Branch Testing Requirement, Graph Explorer CI |

The discipline is recognizing that instruction documents are not prose to
be written, but artifacts to be engineered.

---

## 2. CLAUDE.md Architecture and Layering Patterns

The CLAUDE.md file is the primary instruction artifact in every DSM project.
Its architecture follows a layering pattern that balances consistency across
projects with flexibility for project-specific needs.

### 2.1. The Three-Layer CLAUDE.md Structure

Every project CLAUDE.md has three layers, each serving a distinct function:

| Layer | Content | Managed By |
|-------|---------|-----------|
| Inherited protocols | DSM_0.2 core + modules, loaded via `@` reference | DSM Central; changes propagate automatically |
| Alignment block | Project-type-specific reinforcements (transcript, briefs, inbox) | /dsm-align; regenerated from templates |
| Project-specific | Domain configuration, workflow overrides, custom rules | Project maintainer; survives alignment updates |

The `@` reference is the discovery mechanism: without it, no inherited
protocols load. The alignment block reinforces critical protocols that agents
deprioritize when only present in inherited context. The project-specific
section provides overrides that take precedence over inherited rules.

### 2.2. The Reinforcement Problem and Solution

Inherited protocols load as background context. Agents may deprioritize them
when the project-specific section is silent on a topic. This is the
reinforcement problem: instructions that are technically present but
behaviorally inactive.

DSM solves this with explicit reinforcement blocks in the alignment section.
The Session Transcript Protocol, for example, must include the literal
delimiter syntax in the reinforcement block; referencing "Reasoning Delimiter
Format" by name is insufficient (observed in spoke project sessions where
agents defaulted to markdown heading style).

The /dsm-align command manages these blocks automatically: it detects the
project type, selects the appropriate template, and regenerates the alignment
section without touching project-specific content.

### 2.3. Protocol Precedence Rules

When instructions conflict, precedence follows the layer order:

1. **Project-specific rules** override inherited protocols (highest priority)
2. **Alignment reinforcements** override inherited defaults
3. **Inherited protocols** (DSM_0.2) provide the baseline (lowest priority)

This precedence is critical for External Contribution projects, where the
project CLAUDE.md defines governance boundaries that generic DSM_0.2
protocols are not aware of.

---

## 3. Command Files as Reusable Prompt Templates

DSM command files (scripts/commands/*.md) are prompt templates: structured
instructions that expand into full agent behavior when invoked via slash
commands. They are the reusable building blocks of the instruction system.

### 3.1. Command File Anatomy

Every command file follows a consistent structure:

| Element | Purpose | Example |
|---------|---------|---------|
| One-line description | Tells the agent what the command does | "Resume a DSM session in lightweight mode" |
| Prerequisites | Guards against invalid invocation | "Must be on a parallel/* branch" |
| Steps | Sequenced instructions with decision points | "1. Check baseline... 2. Read checkpoint..." |
| Notes | Behavioral constraints | "No co-author lines, no MEMORY.md updates" |

### 3.2. The Template-to-Runtime Deployment Pipeline

Command files live in two locations: the source repository (scripts/commands/)
and the global runtime (~/.claude/commands/). Changes to source files do not
take effect until deployed:

```
Edit in scripts/commands/    →    scripts/sync-commands.sh --deploy    →    ~/.claude/commands/
    (source of truth)                  (deployment step)                    (runtime location)
```

This separation prevents untested changes from affecting active sessions.
The deployment step is mandatory after any commit that modifies command files.
Stale global copies cause spoke projects to miss protocol updates.

### 3.3. Command Design Patterns

Effective command files share several design patterns:

- **Autonomous execution:** Steps run without pausing for approval unless a
  decision point requires user input. The agent follows the command, not the
  conversation.
- **Defensive guards:** Prerequisites check preconditions before executing.
  A parallel session wrap-up checks for a parallel branch; a version update
  checks for uncommitted changes.
- **Scope declaration:** Commands declare what they will and will not do.
  Parallel session wrap-up declares "no MEMORY.md updates, no transcript
  entries, no feedback push." This prevents scope creep during autonomous
  execution.
- **Recovery paths:** Commands include fallback behavior for common failures.
  If a merge fails, the command provides specific recovery instructions
  rather than stopping silently.

---

## 4. Protocol Templates as Behavioral Specifications

DSM protocols (Pre-Generation Brief, Session Transcript, Protocol Violation
Triage) are not guidelines; they are behavioral specifications. Each one
defines a precise interaction pattern that the agent must follow, with
explicit anti-patterns that identify common deviations.

### 4.1. Anatomy of a Behavioral Protocol

| Component | Purpose | Example from Pre-Generation Brief |
|-----------|---------|----------------------------------|
| Trigger | When the protocol activates | "Before creating any artifact" |
| Steps | Sequenced behavior with gates | "Gate 1: explain → Gate 2: implement → Gate 3: run" |
| Gate conditions | What constitutes approval | "Explicit 'y' from user" |
| Scope rules | What is and is not covered | "Each artifact gets its own gate cycle" |
| Anti-patterns | Common deviations to avoid | "Do not combine brief and file creation in one step" |

### 4.2. Anti-Patterns as Negative Instructions

Anti-patterns are as important as the positive instructions. They encode
lessons learned from observed failures: situations where the agent technically
followed the protocol but produced undesirable behavior. The "DO NOT" lists
in DSM_0.2 protocols are the result of operational experience, not theoretical
design.

This aligns with a broader principle validated by research in agent training
(Liu et al., 2026): systems that learn to evaluate what went wrong develop
more robust behavior than systems that only imitate what went right. DSM's
anti-patterns serve the same function at the instruction level: they teach
the agent what failure looks like, not just what success looks like.

### 4.3. Protocol Composition and Interaction

Protocols do not operate in isolation. They compose and interact:

- **Pre-Generation Brief + Session Transcript:** The brief is presented in
  conversation text (Gate 1); the reasoning behind the brief is in the
  transcript. Two channels, one protocol.
- **Protocol Violation Triage + Backlog System:** A triage identifies a root
  cause; the prevention step creates a BL. The triage protocol feeds the
  backlog system.
- **Experiment Execution + Pre-Generation Brief:** An experiment design
  requires Gate 1 approval before execution. The experiment protocol nests
  inside the brief protocol.

Understanding these interactions is essential for maintaining the instruction
system. A change to one protocol may affect others through composition.

---

## 5. Hub-Spoke Feedback Loop as Instruction Iteration

The hub-spoke architecture is not just a distribution mechanism; it is an
instruction iteration loop. Spoke projects generate operational data; that
data flows back to Central as methodology observations; Central evaluates
and incorporates them as protocol improvements; the improvements propagate
back to spokes. This is the empirical PE cycle (DSM_6.1 §6) in practice.

### 5.1. The Feedback Loop Stages

```
Spoke session          →  Deviation observed     →  Feedback file created
     ↓                                                    ↓
Feedback pushed        →  Central inbox receives  →  Triage: fix/root-cause/prevent
     ↓                                                    ↓
BL created             →  Protocol updated        →  Version released
     ↓                                                    ↓
Mirror sync            →  Spoke receives update   →  Next session applies new protocol
```

### 5.2. What Makes This Different from Ad-Hoc Improvement

Three properties distinguish this from informal prompt iteration:

1. **Structured capture:** Deviations are recorded in feedback files with
   specific format (observation, context, recommendation), not mentioned
   in passing and forgotten.
2. **Systematic triage:** Every deviation goes through the three-step
   response (fix, root-cause, prevent). Skipping steps 2 and 3 is explicitly
   identified as the failure mode the protocol prevents.
3. **Version-controlled propagation:** Improvements are versioned, tagged,
   and propagated via mirror sync. Every spoke receives the same update at
   the same version.

### 5.3. Feedback Volume as Maturity Indicator

The volume and nature of feedback signals ecosystem maturity:

- **Early stage:** High volume, fundamental issues (missing protocols,
  structural gaps)
- **Middle stage:** Moderate volume, refinement issues (edge cases,
  interaction effects between protocols)
- **Mature stage:** Low volume, sophisticated issues (optimization,
  cross-project consistency, ecosystem-level patterns)

DSM's current feedback patterns (150+ sessions) show middle-to-mature stage
characteristics: most feedback addresses edge cases and interaction effects,
not fundamental gaps.

---

## 6. Instruction Versioning and Release Management

DSM treats instruction changes with the same rigor as software releases.
Every methodology change follows the Version Update Workflow: version,
validate, tag, push, sync. This is a deployment pipeline for instruction
artifacts.

### 6.1. The Version Update Workflow as Deployment Pipeline

| Pipeline Stage | Software Equivalent | DSM Implementation |
|----------------|--------------------|--------------------|
| Build | Compile and package | Edit methodology files, update CHANGELOG |
| Test | Run test suite | Branch Testing Requirement, cross-reference validation |
| Version | Bump version number | Semantic versioning in DSM_0.0, CHANGELOG |
| Tag | Create release marker | Git tag (vX.Y.Z) |
| Deploy | Push to production | Git push + mirror sync to spoke repos |
| Verify | Smoke test in production | Spoke session validates updated protocols |

### 6.2. Semantic Versioning for Instruction Systems

DSM applies Semantic Versioning to its methodology documents:

- **Major (X):** Breaking changes to protocols that require spoke adaptation
- **Minor (Y):** New protocols, sections, or features that are backward-compatible
- **Patch (Z):** Fixes, clarifications, and editorial changes

The Breaking Change Notification Protocol (DSM_0.2 Module D) governs major
version changes: spokes must be notified, and adaptation guidance must be
provided. This is the instruction-system equivalent of a deprecation notice
in a software API.

### 6.3. The Mirror Sync as Continuous Deployment

Mirror sync ensures that public distribution repos stay current with Central.
After every version release, the agent copies changed methodology files to
each mirror repo (identified by `mirror: true` in the Ecosystem Path
Registry), commits, and pushes. This is continuous deployment for instruction
artifacts: every release automatically reaches all distribution channels.

---

## 7. References and Version History

Sources and change history for this module.

### 7.1. Internal References

- DSM_6.1: Systems Prompt Engineering (parent document)
- DSM_6.1 §6: The Empirical Prompt Engineering Cycle
- DSM_6.1 §7: Failure Mode Taxonomy for Instruction Systems
- DSM_0.2 §8: Pre-Generation Brief Protocol
- DSM_0.2 §17: CLAUDE.md Configuration
- DSM_0.2 §22: Protocol Violation Triage Response
- Document Structure Standard: `dsm-docs/guides/document-structure-standard.md`

### 7.2. External References

- Liu, W. et al. (2026). "Agentic Critical Training." arXiv:2603.08706.
  (Validates the evaluation-over-imitation principle at model training level)
- Preston-Werner, T. (2013). Semantic Versioning 2.0.0. semver.org.

### 7.3. Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-03-25 | Initial release: CLAUDE.md architecture, command files, protocol templates, hub-spoke feedback, versioning pipeline |
