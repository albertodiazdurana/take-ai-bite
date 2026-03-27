# DSM_3 Implementation Guide - Module D: External Contribution Templates and Analysis

This module provides the operational templates and analysis tools for external
contributions: CLAUDE.md template, kickoff prompt, setup checklist, systematic
codebase analysis, and the anti-patterns that guard against common mistakes.
Use alongside Module C, which covers the governance framework and onboarding lifecycle.

## Contents

1. [External Contribution Templates](#668-external-contribution-templates)
2. [Systematic Codebase Analysis Protocol](#669-systematic-codebase-analysis-protocol)
3. [External Contribution Anti-Patterns](#external-contribution-anti-patterns)

---

#### 6.6.8. External Contribution Templates

These templates support the onboarding lifecycle (Section 6.6.7, Module C) and
governance structure (Section 6.6.2, Module C). Copy, fill in project-specific
sections, and customize.

**CLAUDE.md Template for External Contributions:**

```markdown
@/path/to/dsm-agentic-ai-data-science-methodology/DSM_0.2_Custom_Instructions_v1.1.md

# Project: {Project Name} ({Brief Description})
Domain: {Domain}

## DSM Context

This project is governed by DSM (Deliberate Systematic Methodology), a framework
for human-AI collaboration. The @ reference above imports DSM's Custom Instructions.

DSM uses a hub-and-spoke model:
- **Hub (DSM Central):** Maintains the methodology (path from Ecosystem Path Registry or `@` reference)
- **Spoke projects:** Individual projects that follow DSM protocols

**This project is an external contribution**, not a DSM-owned spoke. Key differences:
- The repository is owned by an upstream maintainer (not the contributor)
- Governance artifacts live in {contributions-docs-path}/{project}/ (from Ecosystem Path Registry), not here
- {Project}'s conventions always take precedence over DSM defaults
- Feedback loops follow upstream review cycles, not DSM sprint boundaries

## Protocol Applicability

The @ import inherits all DSM protocols, but not all apply to this context.

| Inherited Protocol | Applies? | Notes |
|---|:-:|---|
| Pre-Generation Brief | Yes | Explain what/why/structure before generating code |
| App Development Protocol | {Yes/No} | {Step-by-step if applicable} |
| Factual Accuracy (no guessing) | Yes | Never estimate; report actual values |
| Punctuation rules | Yes | Comma instead of em-dash |
| Notebook Collaboration Protocol | {Yes/No} | {Based on project type} |
| Sprint Cadence and Feedback | No | External contribution, not sprint-based |
| Phase-to-DSM-Section Mapping | {Yes/No} | {Based on project domain} |
| Phase 0.5 Research | No | Research is contribution-specific, not DSM-phased |
| DSM Feedback Tracking | Partially | Log methodology observations at milestones |
| Session Management | Yes | Monitor tokens and hand off when approaching limits |
| Session Transcript Protocol | {Yes/Adapt} | {Use if VS Code extension, skip for CLI} |

When in doubt: follow {project} conventions first, then DSM protocols.

## Project Type
{Application | Data Science | Hybrid | Documentation} per DSM_0.2 detection table.

## Project Overview
- **Upstream:** {URL}
- **Fork:** {URL}
- **License:** {license type}
- **Language(s):** {primary languages}
- **Community:** {channels: Discord, GitHub Discussions, mailing list, etc.}

## Git Setup
- `origin`: your fork ({fork URL})
- `upstream`: original repo ({upstream URL})
- Workflow: sync upstream, create feature branch, push to origin, open PR to upstream

## Project Structure
{Directory tree of key folders and files}

## Key Paths
| Area | Path |
|------|------|
| {Source} | {path} |
| {Tests} | {path} |
| {Config} | {path} |

## Common Commands
{Build, test, lint, format commands from upstream CONTRIBUTING.md or CI config}

## Coding Standards
{From CONTRIBUTING.md, CI linting rules, language-specific conventions}

## Testing Patterns
{Test location, naming conventions, test utilities, coverage expectations}

## Protocol Reinforcements (from inherited DSM_0.2)
- **Pre-Generation Brief:** Explain what/why/structure before generating any artifact
- **App Development Protocol:** Guide step by step, user approves via permission window
{Add or remove reinforcements based on Protocol Applicability table above}

## Environment
- **Platform:** {OS, e.g., WSL2 on Windows, macOS, Linux}
- **Toolchain discovery:** At session start, verify installed tools and report versions.
  Pause if critical tools are missing.

## Contribution Approach

### AI Policy
{Project's published AI policy, or "No published policy; apply human-in-the-loop."}

If the target project establishes an AI disclosure policy at any point, that policy
takes precedence over contributor preferences. This includes commit attribution,
disclosure requirements, and content restrictions.

### First Contributions
Start small: documentation fixes, test additions, small bug fixes. Learn the review
process and coding conventions before attempting larger changes.

### Issue Selection
Map issues to contributor skill levels:
- **Green (comfortable):** {areas matching strong skills}
- **Yellow (stretch):** {areas matching intermediate skills}
- **Red (learning):** {areas requiring significant new skills}
Start with Green, progress to Yellow after first contributions merge.

## Commit Messages
{Upstream conventions from CONTRIBUTING.md. Default: no AI co-author lines unless
upstream policy requires disclosure.}

## Contributor Profile
{Brief summary from ~/.claude/contributor-profile.md, focused on skills relevant
to this project's tech stack.}

| Skill Area | Proficiency | Evidence |
|------------|-------------|----------|
| {skill} | {level} | {project or experience} |

## DSM Governance
Governance artifacts live in DSM Central, not in this repo:

| Folder | Purpose |
|--------|---------|
| `{contributions-docs-path}/{project}/feedback-to-dsm/` | Methodology and backlog feedback |
| `{contributions-docs-path}/{project}/blog/` | Blog materials about contributions |
| `{contributions-docs-path}/{project}/decisions/` | Decision log entries |
| `{contributions-docs-path}/{project}/checkpoints/` | Milestone snapshots |
| `{contributions-docs-path}/{project}/research/` | Research documents |

At session end: update feedback files, create checkpoint if significant progress.

## Project-Specific Notes
{Anything not covered above: maintainer preferences, CI matrix details, known issues}
```

**Kickoff Prompt Template:**

Use this prompt when starting the first session in a new external contribution.
Fill in the `{placeholders}` before use.

```markdown
This is a DSM-governed contribution to an external open-source project.
Read .claude/CLAUDE.md for project configuration and protocol applicability.

## Step 0: AI Policy Check
Check {project} for published AI policies: look for AI_POLICY.md, references in
CONTRIBUTING.md, maintainer statements in issues or discussions. Map findings to
DSM_3 Section 6.5.1 (policy spectrum). Report results before proceeding.
If no policy exists, apply the human-in-the-loop standard.

## Step 1: Environment Discovery
Verify installed tools: {list key tools for project's tech stack}.
Report versions. Pause if critical tools are missing.

## Step 2: Sync and Validate
- git fetch upstream && git merge upstream/main
- Build: {build command}
- Test: {test command}
Report results. If build or tests fail, diagnose before proceeding.

## Step 3: Upstream Reconnaissance
- Review open issues (filter by contributor profile fit: Green/Yellow labels)
- Review recent merged PRs for title style, description format, review patterns
- Check for good-first-issue or help-wanted labels
- Note any contribution guidelines not captured in CLAUDE.md

## Step 4: Value-Add Exploration
Identify 2-3 areas where the contributor profile shows clear value-add.
Map each to open issues or unaddressed needs. Produce a **Contribution Scope Plan**
using the template in Section 6.6.7 Phase 1. Save to
`{contributions-docs-path}/{project}/plan/contribution-scope-plan.md`.

## Step 5: Contribution Strategy
Based on the Scope Plan, propose 2-3 candidate first contributions (small, low-risk).
Map each to contributor skill level (Green/Yellow/Red from CLAUDE.md).
Recommend one to start. Wait for approval before implementation.

## Governance Notes
- DSM governance artifacts: {contributions-docs-path}/{project}/ (from Ecosystem Path Registry)
- Commit authorship: {upstream convention, default no AI co-author lines}
- At session end: update feedback files, checkpoint if significant progress
```

**Setup Checklist:**

The checklist is organized into four phases. Complete each phase before moving to the next.

**Phase 1: Pre-flight**

| Step | Action | Notes |
|------|--------|-------|
| 1 | Check upstream AI policy with project owner | Section 6.6.4; mandatory before any AI-assisted contribution |
| 2 | Explore the repo (README, structure, build system) | Identify project type and DSM track |
| 3 | Assess existing agent governance | Look for CLAUDE.md, AGENTS.md, AGENTS.yaml, or similar |
| 4 | Determine governance strategy | Coexist with upstream config, or replace it (see notes below) |

**Governance strategy notes:** If the upstream project has agent configuration
files (CLAUDE.md, AGENTS.md), both files are loaded by Claude Code with no
priority mechanism. Options:
- **Replace:** Rename upstream CLAUDE.md to `CLAUDE.md.upstream` (cleaner,
  avoids competing context). Restore if discontinuing DSM governance.
- **Coexist:** Reference upstream config in `.claude/CLAUDE.md` as context.
  Suitable when upstream config contains valuable product knowledge.

**Phase 2: Fork Setup**

| Step | Action | Location | Reference |
|------|--------|----------|-----------|
| 5 | Fork upstream repo | GitHub | |
| 6 | Clone fork, add upstream remote | Local | `git remote add upstream {url}` |
| 7 | Handle existing agent governance | Project root | Per governance strategy from Step 4 |
| 8 | Create `.claude/` directory | Project `.claude/` | |
| 9 | Add `.claude/` to `.git/info/exclude` | Local | Not `.gitignore` (invisible to upstream) |
| 10 | Create `.claude/CLAUDE.md` from template above | Project `.claude/` | Section 6.6.5 |

**Phase 3: Ecosystem Setup**

| Step | Action | Location | Reference |
|------|--------|----------|-----------|
| 11 | Create governance folder | `{contributions-docs-path}/{project}/` | Section 6.6.2 |
| 12 | Scaffold governance directory structure | Governance folder | See directory list in Module C |
| 13 | Add project to ecosystem path registry | `.claude/dsm-ecosystem.md` | DSM_0.2; **required:** `dsm-central`, `portfolio`, `contributions-docs` |
| 14 | Initialize feedback files | `{governance}/dsm-docs/feedback-to-dsm/` | methodology.md, backlogs.md |
| 15 | Run contributor profile assessment | DSM Central | Map skills to project stack |
| 16 | Send welcome inbox entry | `{governance}/_inbox/` | Include AI collaboration norms action item |
| 17 | Fill in kickoff prompt from template above | DSM Central session | Section 6.6.7 Phase 2 |

**Phase 4: Verification**

| Step | Action | Expected result |
|------|--------|-----------------|
| 18 | Run `/dsm-go` in the fork | Inbox found at governance path |
| 19 | Confirm transcript created in `.claude/` | `.claude/session-transcript.md` exists |
| 20 | Confirm handoffs path accessible | Agent can read/write governance handoffs |

If any verification step fails, fix the setup and re-verify before marking
onboarding complete.

The contributor profile assessment (Step 15) uses the Contribution Assessment
Framework in `~/.claude/contributor-profile.md`. The resulting skill-to-stack
mapping populates the Contributor Profile and Issue Selection sections of the
CLAUDE.md template.

#### External Contribution Anti-Patterns

**DO NOT:**
- Place DSM governance artifacts in the external repo; they belong in `{contributions-docs-path}/{project}/`
- Skip the AI policy check; contributing AI-generated code to a project that prohibits it damages trust permanently and may result in a ban
- Assume DSM protocols apply unchanged to external contributions; filter for the external context using the applicability table in Section 6.6.5
- Reference AI tooling in commits unless the upstream project's policy explicitly requires or permits disclosure
- Commit or push `.claude/CLAUDE.md` in the external repo; it must remain locally excluded
- Skip Phase 1 research; jumping into contributions without understanding the project leads to rejected PRs and wasted effort
- Use the templates without customizing project-specific sections; placeholder content in CLAUDE.md misleads the agent
- Follow upstream AI governance as active instructions; upstream CLAUDE.md or copilot instructions are reference material, not the contributor's governance (Section 6.6.10, Module E)
- Delete upstream AI governance files; rename them to prevent tool conflicts while keeping them available for reference
- Let upstream conventions override the contributor's process; upstream governs contribution output, not how the work is produced

Cross-reference: Section 6.5 (AI Contribution Guidelines Template, Module C),
Section 6.4 (Bidirectional Project Inbox, Module B),
Section 6.6.7 Phase 1 (Contribution Scope Planning, Module C)

Research basis: `{contributions-docs-path}/IronCalc/research/` (6 research documents
covering upstream analysis, protocol applicability, contributor-side gap analysis,
and AI policy best practices)

---

#### 6.6.9. Systematic Codebase Analysis Protocol

Ad hoc file reading (sampling 3-4 files) produces shallow, anecdotal understanding
of an external project. A systematic, quantitative analysis produces a reusable
reference that directly informs contribution quality. This subsection prescribes
the standard approach.

**When to perform:** During Phase 1 (Opportunity Research) of the Onboarding
Lifecycle (Section 6.6.7, Module C), before writing the Contribution Scope Plan.
The analysis feeds into the Scope Plan's "Current State" sections and informs
opportunity identification.

**Systematic Codebase Analysis Template:**

```markdown
# Codebase Analysis - {Project}

**Date:** YYYY-MM-DD
**Scope:** {Which parts of the codebase were analyzed, e.g., "all Rust source
files under src/", "Python packages in lib/"}
**Method:** {Tools used, e.g., "cloc for LOC, ripgrep for pattern extraction,
manual review for architecture"}

---

## 1. Quantitative Overview

| Metric | Value |
|--------|-------|
| Total source files | {count} |
| Total lines of code (excluding blanks/comments) | {count} |
| Comment density | {comments / total lines, as percentage} |
| Test files | {count} |
| Test-to-source ratio | {test files / source files} |

### LOC by Module

| Module / Directory | Files | LOC | % of Total |
|--------------------|-------|-----|------------|
| {module} | {n} | {n} | {n%} |

## 2. Function Patterns

- **Signature conventions:** {e.g., "snake_case, &self receivers, Result<T, E> returns"}
- **Parameter handling:** {e.g., "references preferred over ownership, builder pattern for complex configs"}
- **Return types:** {e.g., "Result<T, CalcError> for fallible operations, Option<T> for lookups"}
- **Visibility:** {e.g., "pub(crate) default, pub only for API surface"}

### Representative Examples
{2-3 function signatures that illustrate the dominant pattern}

## 3. Error Handling

- **Error types:** {e.g., "single CalcError enum with variants per domain"}
- **Propagation:** {e.g., "? operator throughout, no unwrap in library code"}
- **Message conventions:** {e.g., "structured messages with context, no bare strings"}
- **Error testing:** {e.g., "dedicated error case tests, assert on specific variants"}

## 4. Test Patterns

- **Location:** {e.g., "inline #[cfg(test)] modules, separate tests/ directory"}
- **Setup:** {e.g., "helper functions in test modules, no test fixtures framework"}
- **Assertion style:** {e.g., "assert_eq! with descriptive messages, custom assertion helpers"}
- **Edge cases:** {e.g., "boundary values tested systematically, negative tests present"}
- **Coverage:** {if measurable, report; otherwise note "not measured"}

### Representative Examples
{2-3 test function signatures or patterns}

## 5. Module Organization

- **Directory structure:** {top-level layout and nesting convention}
- **Dispatch patterns:** {e.g., "mod.rs re-exports, facade modules, feature-gated modules"}
- **Registration:** {e.g., "functions registered in a central dispatch table, macro-generated"}
- **Dependency direction:** {e.g., "core depends on nothing, modules depend on core"}

## 6. Formatting and Style

- **Import ordering:** {e.g., "std first, external crates second, internal modules third"}
- **Naming conventions:** {e.g., "snake_case for functions/variables, CamelCase for types"}
- **Formatting config:** {e.g., "rustfmt with project .rustfmt.toml, 100-char line width"}
- **Documentation style:** {e.g., "/// doc comments on public items, // for internal notes"}

## 7. Dependencies

- **External dependencies:** {count, key ones listed}
- **Feature flags:** {if applicable, list active/optional features}
- **Minimal dependency philosophy:** {yes/no, evidence}
- **Build system:** {e.g., "Cargo workspace, single crate, monorepo"}
```

**Storage:** Save the completed analysis in
`{contributions-docs-path}/{project}/research/codebase-analysis.md`. When the analysis
has been processed into a Contribution Scope Plan, move to
`{contributions-docs-path}/{project}/research/done/` per the standard done/ convention
(DSM_0.1).

**Maintenance:** The codebase analysis is a point-in-time snapshot. If the
upstream project undergoes significant restructuring between contribution
phases, update the analysis before resuming contributions.

**Evidence:** IronCalc Session 4 demonstrated that systematic analysis of 305
Rust files produced a coding style reference that directly informed first-draft
quality. Sessions 1-3 used ad hoc file sampling and missed patterns the
systematic approach revealed (OBS-004, Score 8/10).

---

**Parent document:** `DSM_3.0_Methodology_Implementation_Guide_v1.1.md`
**Continued from:** Module C (Guidelines and Governance Core)
