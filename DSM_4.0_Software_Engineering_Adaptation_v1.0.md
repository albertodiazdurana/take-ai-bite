# DSM 4.0: Software Engineering Adaptation

**Version:** 1.5
**Date:** March 2026
**Purpose:** Extend DSM methodology for ML/software engineering projects where the primary deliverable is a working application, not analytical insights.

This document is the core of the Software Engineering Adaptation. It covers
project identification, structure patterns, adapted phases, and the development
protocol. On-demand content (testing, verification, decision logs, sprint
planning, repository setup) is in modules loaded via the dispatch table.

## Contents

1. [When to Use This Software Engineering Adaptation](#1-when-to-use-this-software-engineering-adaptation)
2. [Project Structure Patterns and Layouts](#2-project-structure-patterns-and-layouts)
3. [Adapted Phase Structure for Software Projects](#3-adapted-phase-structure-for-software-projects)
4. [Development Protocol for Application Code](#4-development-protocol-for-application-code)
5. [Integration with Standard DSM Sections](#5-integration-with-standard-dsm-sections)
6. [Module Dispatch Table](#6-module-dispatch-table)
7. [Version History](#7-version-history)
8. [References](#8-references)

## Document Structure Index

| § | Section | Description |
|---|---------|-------------|
| 1 | When to Use This Software Engineering Adaptation | Criteria for choosing DSM 4.0 over standard DSM |
| 2 | Project Structure Patterns and Layouts | Directory layouts for DSM 1.0 and 4.0 projects |
| 3 | Adapted Phase Structure for Software Projects | Phase mapping from data science to software engineering |
| 4 | Development Protocol for Application Code | Module development, notebooks, code organization |
| 5 | Integration with Standard DSM Sections | Which standard DSM sections to keep, replace, or reference |
| 6 | Module Dispatch Table | On-demand modules for testing, planning, and setup |
| 7 | Version History | Changelog for this document |
| 8 | References | Academic and industry citations |

---

## 1. When to Use This Software Engineering Adaptation

This section defines the criteria for choosing DSM 4.0 over the standard
data science workflow (DSM 1.0).

**Use this adaptation when:**
- Building a software application that uses ML components
- Primary deliverable is code/package, not insights/recommendations
- Output is a tool others will use, not a report stakeholders will read
- Project requires software architecture decisions, not analytical decisions

**Examples:**
- ML-powered applications (recommendation engines, classifiers, agents)
- Data pipelines and tools
- Data processing applications
- API services with analytical backends

**Continue using standard DSM (Sections 1-3) when:**
- Primary goal is data analysis and insights
- Deliverables are notebooks, presentations, reports
- Stakeholder communication of findings is the end goal

---

## 2. Project Structure Patterns and Layouts

Both DSM 1.0 and 4.0 projects keep documentation in-repo under `dsm-docs/`. The CLAUDE.md `@` reference imports methodology content from DSM Central.

### 2.1. DSM 1.0 Pattern for Data Science Projects

This pattern organizes notebook-based analytical work with DSM governance
artifacts alongside the analysis.

**Project Structure:**
```
my-analysis/
├── _inbox/                         # Hub-spoke communication (DSM_3 Section 6.4)
├── notebooks/
├── data/
├── dsm-docs/
│   ├── handoffs/                   # Session continuity documents
│   ├── checkpoints/                # Progress checkpoints
│   ├── feedback-to-dsm/            # Methodology feedback (optional)
│   └── research/                   # Research artifacts (if Phase 0.5)
├── outputs/
└── .claude/CLAUDE.md               # Points to central DSM via @ reference
```

**Rationale:**
- All project artifacts in one repository, accessible via git history
- CLAUDE.md `@` reference imports DSM methodology for automatic context
- Session handoffs alongside the code they document

### 2.2. DSM 4.0 Pattern for Software Engineering Projects

This pattern follows software engineering conventions with standard directory
structure for source code, tests, and documentation.

**Project Structure:**
```
my-application/                     # Single repo for everything
├── .claude/
│   └── CLAUDE.md                   # Points to central DSM via @path
├── .github/
│   └── workflows/                  # CI/CD pipelines
├── _inbox/                         # Hub-spoke communication (DSM_3 Section 6.4)
├── src/                            # Source code
│   ├── __init__.py
│   └── module/
├── tests/                          # Test suite
│   └── test_module.py
├── docs/                           # Project documentation (in-repo)
│   ├── handoffs/                   # Session continuity
│   ├── decisions/                  # Architectural Decision Records (ADRs; Nygard, 2011)
│   ├── checkpoints/                # Development milestones
│   ├── feedback/                   # DSM methodology feedback
│   ├── plans/                      # Sprint plans, roadmaps
│   ├── research/                   # State-of-art surveys (if Phase 0.5)
│   ├── blog/                       # Blog materials (if applicable)
│   └── guides/                     # User-facing documentation (if applicable)
├── data/
│   └── experiments/                # Capability experiments (Section 4.4)
├── outputs/                        # Artifacts, reports
├── README.md
├── pyproject.toml                  # Python project config
└── .gitignore
```

**Rationale:**
- Follows software engineering conventions (standard practice)
- Simpler for contributors (single clone, everything together)
- CI/CD integration (workflows can reference docs easily)
- GitHub/GitLab features work better in-repo (Issues, Projects, Wikis)
- Standard for open-source Python projects

### 2.3. When to Use Each Project Structure Pattern

| Project Type | Deliverables | Pattern | Examples |
|--------------|--------------|---------|----------|
| **Data Science** | Notebooks, analysis, insights | In-repo `dsm-docs/` | Customer segmentation, demand forecasting, text classification |
| **ML Application** | Python packages, APIs, services | In-repo `dsm-docs/` | Recommendation engine, prediction API, search system |
| **Documentation Tool** | CLI tools, parsers, validators | In-repo `dsm-docs/` | Graph Explorer, markdown processors |
| **Hybrid** | Notebooks + production code | In-repo `dsm-docs/` | Research → production pipeline |

### 2.4. Agent Context and CLAUDE.md Reference

The `@` reference in CLAUDE.md is the mechanism that connects a project to DSM
methodology.

- Create `.claude/CLAUDE.md` with `@/path/to/DSM_0.2_Custom_Instructions_v1.1.md`
- The `@` reference imports methodology content automatically
- Project-specific instructions follow after the `@` reference
- Session handoffs in `dsm-docs/handoffs/` provide continuity between sessions

### 2.5. Migration Guidance for Legacy Projects

**Projects with separate `_Project_Knowledge/` repos:** Migrate session artifacts into the main project's `dsm-docs/` folder:
- `session_handoffs/` → `dsm-docs/handoffs/`
- `decisions/` → tracked via backlog items or `dsm-docs/decisions/`
- `checkpoints/` → `dsm-docs/checkpoints/`

---

## 3. Adapted Phase Structure for Software Projects

This section maps the standard DSM data science phases to software engineering
equivalents, showing how each phase's focus shifts when the deliverable is an
application rather than an analysis.

### 3.1. Standard DSM Phases for Data Science Projects
```
Phase 0: Environment Setup
Phase 1: Exploration (EDA, cohort definition)
Phase 2: Feature Engineering
Phase 3: Analysis/Modeling
Phase 4: Communication (reports, presentations)
```

### 3.2. Adapted Phases for Software Engineering Projects
```
Phase 0: Environment Setup (unchanged)
Phase 1: Data Pipeline (load, validate, transform)
Phase 2: Core Modules (models, services, providers)
Phase 3: Integration & Evaluation (agents, testing, metrics)
Phase 4: Application & Documentation (UI, README, demos)
```

### 3.3. Phase Mapping and Deliverables Table

| Adapted Phase | Focus | Key Activities | Deliverables |
|---------------|-------|----------------|--------------|
| **Phase 0** | Environment | venv, requirements, project structure | Working dev environment |
| **Phase 1** | Data Pipeline | Data loading, validation, transformation | `data_loader.py`, sample data |
| **Phase 2** | Core Modules | Data models, service classes, business logic | `models.py`, `service.py`, `provider.py` |
| **Phase 3** | Integration | End-to-end orchestration, evaluation pipeline, testing | Integration module, experiment tracking, tests |
| **Phase 4** | Application | Application interface, documentation, demo | `app.py`, README, architecture docs |

---

## 4. Development Protocol for Application Code

This section defines the development workflow for building application modules.
Testing, verification, and quality protocols are in
[Module A](DSM_4.0.A_Development_Quality.md).

### 4.1. Module Development Loop (replaces Notebook Protocol)

When building application modules, follow the **File Creation Loop** defined in
DSM_0.2 (Custom Instructions). The loop enforces a predictable stop-review-continue
rhythm for each file:

1. Show todo list (current file marked in_progress)
2. Show description, stop
3. Ask to proceed (Y/N as plain text), stop
4. If yes, create file via Write/Edit, stop (user reviews diff)
5. Show updated todo list, repeat from step 2

**Build order:** imports → constants → one function → test → next function.
**TDD (Beck, 2003):** Write tests in `tests/` alongside code.

**Anti-Patterns:** Do not batch-generate files, do not use AskUserQuestion for
approvals, do not skip todo list updates between files. See DSM_0.2 for full list.

### 4.2. When to Use Notebooks in SW Projects

Notebooks are appropriate for exploration and prototyping, but not for production
code.

**Appropriate uses:**
- **Exploration:** Understanding data structure, testing library functions
- **Demos:** `notebooks/01_demo.ipynb` showing end-to-end flow
- **Prototyping:** Quick experiments before committing to module design

**Not appropriate for:**
- Production code (use `src/` modules)
- Core application logic
- Code that will be imported elsewhere

### 4.3. Code Organization and Project Layout

This subsection defines the standard directory structure for application source
code and related artifacts.

```
project/
├── src/
│   ├── __init__.py
│   ├── models.py          # Data classes, Pydantic models
│   ├── data_loader.py     # Data ingestion and validation
│   ├── service.py         # Core business logic
│   ├── provider.py        # External service integration
│   └── pipeline.py        # Orchestration (if applicable)
├── tests/
│   ├── test_models.py
│   ├── test_data_loader.py
│   └── test_service.py
├── prompts/
│   └── *.txt              # Prompt templates
├── notebooks/
│   └── 01_demo.ipynb      # Demo/exploration only
├── data/
│   ├── sample/            # Sample datasets
│   └── experiments/       # Capability experiments (C.1.3)
├── app.py                 # Application entry point
├── requirements.txt
└── README.md
```

#### 4.3.1. Branching Strategy for Development Workflow

All DSM software projects follow the Three-Level Branching Strategy defined in
DSM_0.2:

- **Level 1 (main):** production line, receives only session branch merges
- **Level 2 (session branch):** created at session start, merges to main at wrap-up
- **Level 3 (task branches):** BL branches, sprint branches, or parallel-session
  branches, each with specific merge conditions

For sprint-based projects, each sprint creates a Level 3 sprint branch off the
session branch. BL implementations create Level 3 BL branches. See DSM_0.2
Three-Level Branching Strategy for naming conventions, push policy, and
resumption protocol.

---

## 5. Integration with Standard DSM Sections

This adaptation **extends** DSM, it doesn't replace it. This section maps which
standard DSM sections apply unchanged, which are replaced, and which serve as
references.

**Continue using from standard DSM:**
- Section 1.3: Core Philosophy (communication style, factual accuracy)
- Section 3: Communication & Working Style
- Section 6: Tools & Best Practices (where applicable)
- Appendix A: Environment Setup Details
- Appendix E: Quick Reference (file naming, commands)

**Replace with this adaptation:**
- Section 2: Core Workflow (use adapted phases)
- Section 4.1: Decision Log (use architectural template from Module A)
- Section 2.5: Communication phase (use documentation focus)

**Reference as needed:**
- PM Guidelines: For sprint planning structure
- Appendix C: Advanced practices (experiment tracking, testing)
- Appendix C.1.3-C.1.5: Capability experiments, evaluation metrics, limitation discovery

---

## 6. Module Dispatch Table

DSM 4.0 content is split into this core file (always loaded when the project
type is Application or Hybrid) and two on-demand modules. When a task requires
content from this table, read the corresponding module file.

All module files are in the same directory as this core file.

### 6.1. Core Sections (this file)

| § | Section |
|---|---------|
| 1 | When to Use This Software Engineering Adaptation |
| 2 | Project Structure Patterns and Layouts |
| 3 | Adapted Phase Structure for Software Projects |
| 4 | Development Protocol for Application Code |
| 5 | Integration with Standard DSM Sections |

### 6.2. Module Sections (on-demand)

| Section | Trigger | Module |
|---------|---------|--------|
| Tests and Capability Experiments Distinction | Writing tests, defining experiments | [A](DSM_4.0.A_Development_Quality.md) |
| Fixture Validation Principle for Tests | Creating test fixtures | [A](DSM_4.0.A_Development_Quality.md) |
| Post-Experiment Upstream Contribution Assessment | Experiment completed on external library | [A](DSM_4.0.A_Development_Quality.md) |
| Package Verification Protocol for Dependencies | Installing dependencies | [A](DSM_4.0.A_Development_Quality.md) |
| Bug Disambiguation Protocol for Recurring Issues | Debugging reported issues | [A](DSM_4.0.A_Development_Quality.md) |
| PR Description Maintenance Protocol | PR scope expands | [A](DSM_4.0.A_Development_Quality.md) |
| Decision Log Adaptation for Software Projects | Recording architectural decisions | [A](DSM_4.0.A_Development_Quality.md) |
| Success Criteria Adaptation for Software Projects | Defining project completion criteria | [A](DSM_4.0.A_Development_Quality.md) |
| Portfolio Project Showcase Checklist | Preparing project for showcase | [B](DSM_4.0.B_Project_Planning_Setup.md) |
| Sprint Planning for SW Projects | Planning development sprints | [B](DSM_4.0.B_Project_Planning_Setup.md) |
| Sprint Planning Document Template | Creating sprint plan documents | [B](DSM_4.0.B_Project_Planning_Setup.md) |
| GitHub Repository Setup Checklist | Setting up new repositories | [B](DSM_4.0.B_Project_Planning_Setup.md) |
| Beyond DSM: Production and MLOps | Deploying to production | [B](DSM_4.0.B_Project_Planning_Setup.md) |

---

## 7. Version History

This section tracks changes to DSM 4.0 across releases.

**v1.5 (March 2026):**
- Modularized into core + 2 modules (BACKLOG-270): core (always loaded), Module A (development quality), Module B (project planning and setup)
- All files follow Document Structure Standard: TOC, numbered headings, intro paragraphs

**v1.4 (March 2026):**
- Domain-neutrality audit (BACKLOG-256): stripped framework-specific sections (Streamlit, LLM cost tracking, A/B testing UX, session state patterns), genericized examples, removed non-public spoke references
- Renumbered sections 10-13 (previously 14-17)

**v1.3 (January 2026):**
- Added Section 2: Project Structure Patterns (BACKLOG-038)
  - Unified in-repo `dsm-docs/` pattern for both DSM 1.0 and 4.0
  - CLAUDE.md `@` reference for methodology context
  - Migration guidance for legacy `_Project_Knowledge/` repos
  - Renumbered all subsequent sections (old Section 2 → Section 3, etc.)

**v1.2 (January 2026):**
- Added Beyond DSM: Production & MLOps section, lightweight references to MLOps resources

**v1.1 (January 2026):**
- Added sprint planning templates
- Added GitHub repository setup checklist

**v1.0 (January 2026):**
- Initial release
- Adapted from DSM 1.1 for software engineering context

---

## 8. References

This section lists academic and industry sources cited in DSM 4.0 and its modules.

- Beck, K. (2003). *Test-Driven Development: By Example*. Addison-Wesley.
- Nygard, M. (2011). [Documenting Architecture Decisions](https://www.cognitect.com/blog/2011/11/15/documenting-architecture-decisions). Cognitect Blog.
