# DSM 2.0 Module D: Quality Checklists and Operational Tracking

**Parent document:** DSM_2.0_ProjectManagement_Guidelines_v2_v1.1.md
**Scope:** Code and artifact quality checklists, debugging log template, scope
review checkpoint, operational monitoring, and project change tracking (backlog,
changelog, git tagging, version workflow).

This module contains the quality assurance checklists used during code and
artifact development, the operational monitoring framework for resource tracking,
and the project change tracking system for backlog management, versioning, and
release workflow.

## Contents

| § | Section | Description |
|---|---------|-------------|
| 1 | [Code Artifact Quality Checklist](#1-code-artifact-quality-checklist) | Quick reference for incremental code development |
| 2 | [Artifact Portability Checklist](#2-artifact-portability-checklist) | Multi-environment compatibility checks |
| 3 | [Visualization Quality Checklist](#3-visualization-quality-checklist) | Standards for figures in deliverables |
| 4 | [Debugging Log Template](#4-debugging-log-template) | Structured capture of multi-attempt issue resolution |
| 5 | [Scope Review Checkpoint](#5-scope-review-checkpoint) | Lightweight scope expansion review |
| 6 | [Operational Monitoring and Metrics](#6-operational-monitoring-and-metrics) | Infrastructure resource tracking during AI-assisted work |
| 7 | [Project Change Tracking System](#7-project-change-tracking-system) | Backlog, archive, changelog, git tagging, and version workflow |

---

## 1. Code Artifact Quality Checklist

Quick reference for incremental development (notebooks, scripts, modules). Apply
these checks at every stage of code development to maintain consistent quality.

**Before each code unit (cell, function, section):**
- [ ] Description explaining WHAT this unit does and WHY
- [ ] Unit identifier (e.g., `# Cell 3`, function docstring, section comment)

**After each code unit:**
- [ ] Output shows actual values (shapes, counts, metrics, samples)
- [ ] No generic confirmations ("Success!", "Done!", "Complete!")

**At section transitions:**
- [ ] Summary with key findings or state changes from the section
- [ ] Variables and state carried forward are noted

**Per artifact:**
- [ ] Title/header with artifact purpose and context
- [ ] Final summary with key outputs and next steps
- [ ] All units run in sequence without errors (notebook: Kernel > Restart & Run
  All; script: full run; module: test suite)

---

## 2. Artifact Portability Checklist

When artifacts must run in multiple environments (local, cloud, CI/CD, shared
compute), verify these portability requirements before delivery.

**Directory Safety:**
- [ ] Use `os.makedirs(path, exist_ok=True)` or equivalent instead of assuming
  directories exist
- [ ] Use cross-platform path handling (e.g., `pathlib.Path` in Python)

**Dependency Management:**
- [ ] Include setup/install step for target environments
- [ ] Guard against missing optional dependencies gracefully
- [ ] Pin versions for reproducibility (e.g., `pandas==2.3.3`, `"lodash": "4.17.21"`)

**External Access:**
- [ ] Provide fallback for data/resource access (local path vs. remote download)
- [ ] Handle authentication via environment variables, not hardcoded credentials
- [ ] Document any external API or service dependencies

**Runtime:**
- [ ] Document compute requirements (CPU/GPU/memory) in artifact header
- [ ] Note expected runtime per section for long operations
- [ ] Test in target environment before delivery

**Environment Detection (Python example):**
```python
import sys
IN_COLAB = 'google.colab' in sys.modules
```

Cross-reference: DSM_1.0 Appendix A.7 (Environment Tool Selection), Appendix
A.9 (WSL and Cross-Platform)

---

## 3. Visualization Quality Checklist

Before including any figure in a deliverable (report, notebook, blog,
presentation), verify these quality standards.

**Content:**
- [ ] Descriptive title present
- [ ] Both axes labeled with units where applicable
- [ ] Legend present if multiple series or categories shown
- [ ] Annotations or callouts for key data points where helpful

**Formatting:**
- [ ] Font size readable at target medium (report, slide, blog image)
- [ ] Color scheme consistent across all project figures
- [ ] Colorblind-friendly palette used (avoid red-green only distinctions)
- [ ] Resolution sufficient: 150+ DPI for web, 300+ DPI for print/slides

**Output:**
- [ ] Figure saved to `outputs/figures/` with descriptive filename
- [ ] Source data indicated in caption or annotation
- [ ] Figure referenced in accompanying text (report, notebook markdown, documentation)

**Context-Specific:**
- For presentations: ensure readability at projected size (larger fonts, simpler layouts)
- For blog posts: ensure figures work as standalone images (include context in title/caption)
- For inline figures (notebooks, reports): balance detail with readability

Cross-reference: DSM_1.0 Section 2.5 (Communication), Section 2.5.6 (Blog Process)

---

## 4. Debugging Log Template

When a technical issue requires 3 or more attempts to resolve, capture the
debugging sequence using this template. This creates a reference for future
projects encountering the same issue.

```markdown
## Debugging Log: [Issue Title]

**Date:** YYYY-MM-DD
**Impact:** [Blocked progress / Degraded performance / Minor inconvenience]
**Iterations:** [Number of approaches tried]

### Problem
[What was expected vs what happened]

### Attempts

| # | Approach | Result | Why It Failed |
|---|----------|--------|---------------|
| 1 | [First attempt] | Failed | [Root cause] |
| 2 | [Second attempt] | Failed | [Root cause] |
| 3 | [Final attempt] | Success | -- |

### Root Cause
[Underlying issue that caused the problem]

### Solution
[What worked and why]

### Prevention
[How to avoid this in future projects]
```

**When to use:** Any issue requiring 3+ attempts to resolve, especially
environment or dependency issues that block progress. Include in checkpoint
documents or as a standalone entry in the project docs folder.

Cross-reference: DSM_1.0 Section 6.4 (Checkpoint Protocol), DSM_1.0 Section 6.1
(Session Management)

---

## 5. Scope Review Checkpoint

When project scope expands beyond the original plan, conduct a lightweight scope
review to acknowledge and approve the change.

**Trigger Conditions (any of these):**
- COULD items are being worked on before all MUST and SHOULD items are complete
- Timeline extends beyond original plan
- New deliverables are added (e.g., blog post not in original plan)
- Significant unplanned work emerges (e.g., data leakage fix, API debugging)

**Review Questions:**

| Question | Purpose |
|----------|---------|
| Are all MUST items complete or on track? | Ensure core deliverables are not at risk |
| What COULD items are being added? | Document scope expansion |
| What is the timeline impact? | Acknowledge extension |
| Is the expansion justified? | Learning value, portfolio value, stakeholder request |
| Should any items be deferred? | Prevent unbounded scope creep |

**Documentation:** Add a one-line entry to the daily checkpoint:
```
Scope review: [COULD items X, Y added | Timeline extended to Day N | Justified because...]
```

Cross-reference: Template 7 (MUST/SHOULD/COULD Priority Framework, Module B),
Template 12 (Scope Limitations Log, Module C)

---

## 6. Operational Monitoring and Metrics

Track infrastructure resources consumed during AI-assisted work. This formalizes
resource tracking as a project management practice, providing consistent metrics
across projects and sessions.

### 6.1. Metric Categories for Resource Tracking

| Category | Examples | Collection Method |
|----------|----------|-------------------|
| Network traffic | Bandwidth per hour/session | vnstat (daemon, persistent logging) |
| Network diagnosis | Per-process bandwidth | nethogs (real-time, on-demand) |
| API consumption | Tokens used, API calls made | Provider dashboards, session logs |
| Session efficiency | Duration, tool calls, iterations | Agent session metadata |
| Data transfer | Dataset/model download sizes | pip/conda logs, git transfer stats |
| Compute | CPU/GPU hours, memory peaks | /proc, nvidia-smi, time command |
| Storage | Repo sizes, artifact growth | du, git count-objects |

### 6.2. Recommended Tool Stack for Monitoring

| Tool | Purpose | Install | Persistent? |
|------|---------|---------|-------------|
| vnstat | Hourly/daily bandwidth logging | `sudo apt install vnstat` | Yes (daemon) |
| nethogs | Per-process bandwidth (diagnosis) | `sudo apt install nethogs` | No (real-time) |
| /proc, ps | CPU/memory snapshots | Built-in | No |
| du, git count-objects | Storage tracking | Built-in | No |

### 6.3. Integration Points for Metrics

- **Session close-out:** Optional `vnstat -h` snapshot in handoff metadata. See
  DSM_0.2 Session Management for the bandwidth reporting convention.
- **Checkpoints (dsm-docs/checkpoints/):** Resource summary alongside milestone context.
- **Sprint boundaries:** Cumulative resource report for the sprint, comparing
  planned vs actual.
- **Project retrospectives:** Cost analysis across sessions, identifying
  resource-intensive phases.

### 6.4. Reporting Format for Operational Metrics

Append this block to handoffs or checkpoints when resource tracking is active:

```markdown
## Operational Metrics

- **Session duration:** X hours
- **Bandwidth:** X MB received / X MB sent (vnstat)
- **API tokens:** X tokens consumed
- **Notable transfers:** [large downloads, model pulls, dataset fetches]
```

Not all fields are required every session. Include what is available and relevant.

---

## 7. Project Change Tracking System

This section covers the backlog system, archive pattern, changelog maintenance,
git tagging, version update workflow, and backlog priorities. These operational
protocols ensure consistent change management across all DSM projects.

### 7.1. Backlog System for Project Management

Track proposed enhancements, project definitions, and ideas. Active BLs go in
`dsm-docs/plans/`; legacy items remain in `plan/backlog/` until completed:

```
project/
└── plan/
    └── backlog/
        ├── developments/                     # External project definitions
        │   ├── BACKLOG-001_project-name.md
        │   └── BACKLOG-002_tool-name.md
        ├── improvements/                     # Internal DSM enhancements
        │   ├── BACKLOG-003_new-section.md
        │   └── BACKLOG-004_enhancement.md
        └── done/
            └── BACKLOG-000_completed.md
```

**Classification:**
- **Developments:** External project definitions, new repositories/tools that
  follow DSM, contribute feedback, and extend the ecosystem
- **Improvements:** Internal enhancements to methodology documents, new sections,
  templates, standards

**Backlog Item Template:**
```markdown
# BACKLOG-###: [Title]

**Status:** Proposed | In Progress | Implemented
**Priority:** High | Medium | Low
**Date Created:** YYYY-MM-DD
**Origin:** [Where this idea came from]

## Problem Statement
[What gap or need does this address]

## Proposed Solution
[How to address it]

## Expected Outcome
[What success looks like]
```

**Workflow:**
- Create backlog items when ideas arise
- Prioritize during sprint planning
- When implementing: follow Version Update Workflow (update CHANGELOG, README,
  relevant docs)
- Move to `done/` folder when implemented
- Update Status to "Implemented" with Date Implemented

### 7.2. Archive Pattern for Planning Documents

Store completed/obsolete planning documents in `plan/archive/`:
- Planning docs for completed work
- Superseded analyses
- Old session checkpoints

Keep in `plan/` root: Active reference docs (gap analyses, roadmaps)

### 7.3. Changelog Maintenance Standards

Maintain `CHANGELOG.md` in project root using
[Keep a Changelog](https://keepachangelog.com/) format:

```markdown
## [X.Y.Z] - YYYY-MM-DD

### Added
- [New feature] (BACKLOG-###)

### Changed
- [Modification]

### Fixed
- [Bug fix]
```

Update changelog with each release, referencing backlog items.

### 7.4. Git Tagging Convention and Versioning

| Tag Type | Format | When to Use |
|----------|--------|-------------|
| Release | `vX.Y.Z` | Feature/content releases |
| Checkpoint | `vX.Y.Z-checkpoint` | Post-release cleanup, docs fixes |

**Semantic Versioning:**
- MAJOR (X): Breaking changes or major redesign
- MINOR (Y): New features, backward compatible
- PATCH (Z): Bug fixes, documentation updates

**Version Bump Cadence:**

| Trigger | Version Bump | Tag Required? |
|---------|-------------|---------------|
| 3+ backlog improvements in a session | Patch (x.y.Z) | Yes |
| Repository organization or housekeeping | Patch (x.y.Z) | Optional |
| New DSM section or methodology track | Minor (x.Y.0) | Yes |
| Breaking change to methodology structure | Major (X.0.0) | Yes |

**Rules:**
- Batch backlog implementations per session; one version bump per session
- Always update CHANGELOG before tagging
- Always create a git tag for content releases
- Do not create one version per backlog item; group related changes

### 7.5. Version Update Workflow Steps

1. Make changes to methodology files (DSM_0 through DSM_6)
2. Validate alignment across root documents:
   - DSM_0: Update section descriptions and version references
   - DSM_0.1: Update if naming conventions changed
   - DSM_0.2 (Custom Instructions): Update if workflows, protocols, or
     instructions changed
   - README.md: Update version info and relevant sections
   - CHANGELOG.md: Add version entry with backlog references (BACKLOG-###)
3. Update line counts if significant additions
4. Run `python scripts/document_structure_metrics.py --update` to record
   structural snapshot
5. Commit with descriptive message
6. Create git tag: `git tag -a vX.Y.Z -m "Description"`
7. Push commits and tags: `git push && git push --tags`
8. Post-push audit: verify all root files are consistent with changes

### 7.6. Backlog Priorities Reference

| Priority | When to Use | Action Timeline |
|----------|-------------|-----------------|
| High | Addresses significant gap, blocks other work | Next sprint |
| Medium | Valuable enhancement, can wait | When capacity allows |
| Low | Nice to have, future consideration | Backlog review |
