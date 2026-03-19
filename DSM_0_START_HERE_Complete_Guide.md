# Deliberate Systematic Methodology (DSM) - Complete Getting Started Guide
**Your complete guide to setting up and executing projects with an AI agent**

**Version:** 1.3.37
**Last Updated:** 2026-03-10

---

## Quick Start (5 Minutes)

**New to this system? Start here:**

1. **Read this document** (5 minutes) - Understand how everything connects
2. **Run environment setup** (10 minutes) - Install required packages
3. **Create `.claude/` folder** - Set up AI code assistant configuration
4. **Configure CLAUDE.md** - Import methodology documents via `@path` syntax
5. **Create Custom Instructions file** - Project-specific settings

**Then:** Start working with AI code assistant following the patterns in Section 5.

---

## Project Type Decision

**Before proceeding, determine which methodology track applies to your project:**

### Use Standard DSM (Sections 1-3) when:
- Primary goal is **data analysis and insights**
- Deliverables are **notebooks, presentations, reports**
- Stakeholder communication of findings is the end goal
- Output is analysis that others will read/interpret

**Examples:** Customer segmentation, demand forecasting, A/B test analysis, exploratory data analysis

### Use DSM 4.0 Software Engineering Adaptation when:
- Building a **software application** that uses ML components
- Primary deliverable is **code/package**, not insights/recommendations
- Output is a **tool others will use**, not a report stakeholders will read
- Project requires **software architecture decisions**, not analytical decisions

**Examples:** LLM-powered applications (chatbots, report generators, agents), ML pipelines and tools, data processing applications, API services with ML backends

**Document:** `DSM_4.0_Software_Engineering_Adaptation_v1.0.md`

**Key sections:** Section 2: Project Structure Patterns (NEW in v1.3.18), Adapted phases for ML apps, App Development Protocol, Section 4.4: Tests vs Capability Experiments (v1.3.6), Section 4.4.1: Fixture Validation Principle (BACKLOG-049), Section 4.4.2: Post-Experiment Contribution Assessment (BACKLOG-217), Section 4.6: Bug Disambiguation (v1.3.42), Section 4.7: PR Description Maintenance (v1.3.42), IDE Configuration for VS Code (v1.3.15), Architectural Decision templates, Section 16: Beyond DSM (MLOps/production references)

### Integration Note
DSM 4.0 **extends** the standard methodology, it does not replace it. Continue using:
- Section 1.3: Core Philosophy (communication style, factual accuracy)
- Section 3: Communication & Working Style
- Appendix A: Environment Setup Details
- Appendix E: Quick Reference

Replace with DSM 4.0 guidance:
- Section 2: Core Workflow (use adapted phases)
- Section 4.1: Decision Log (use architectural template)
- Section 2.5: Communication phase (use documentation focus)

### Hybrid Projects
Some projects combine both tracks:
- **Example:** RAG application with evaluation notebooks
- **Approach:** Use DSM 4.0 for `src/` modules, DSM 1.0 for `notebooks/` analysis
- **Agent behavior:** Identify which track applies to each task

### Use DSM 5.0 Documentation Project Adaptation when:
- Primary deliverable is **written documentation**, not code or analysis
- Project contains `docs/`, markdown files, and configuration, but no `notebooks/` or `src/`
- Version control tracks **content changes**, not code changes

**Examples:** Methodology repositories (DSM Central), professional portfolios, blog sites, knowledge bases, technical writing projects

**Document:** `DSM_5.0_Documentation_Project_Adaptation_v1.0.md`

**Key sections:** Section 2: Project Structure Patterns (hub vs spoke), Section 3: File Naming Conventions, Section 6: Versioning Workflow (semantic versioning (Preston-Werner, 2013) for content), Section 7: Content Quality Standards, Section 10: Integration with Standard DSM

### Use DSM 6.0 AI Collaboration Principles across all projects:
- Defines the **foundational principles** for human-AI collaboration in DSM
- Applies to every project type: Data Science, Application, Hybrid, Documentation, External Contribution
- Nine principles: Take a Bite, The Human Brings the Spark, Earn Your Assertions (with accountability corollary), Critical Thinking (Understand/Review/Decide + Challenge Myself to Reason), Know Your Context, Match the Room, Own Your Process (attribution/disclosure), Know What You Own (third-party asset licensing), Think Ahead (strategic thinking as collaboration maturity)

**Document:** `DSM_6.0_AI_Collaboration_Principles_v1.0.md`

**Key sections:** Section 1: Principles (the reasoning behind DSM's interaction patterns, including ethics of AI attribution and human accountability), Section 2: Guidelines (maps principles to existing protocols, identifies gaps, environmental awareness), Section 2.5: The DSM Vocabulary (coined terms as collaboration infrastructure, canonical registry reference)

**See also:** `TAKE_A_BITE.md` for the short version of the central principle.

### Integration Note
DSM 5.0 **extends** the standard methodology for documentation contexts. Continue using:
- DSM 2.0: Sprint planning, checkpoint protocol, deliverable tracking
- Section 2.5: Communication standards, writing conventions
- Section 6.1: Session management (handoffs, checkpoints)

Does NOT apply:
- Section 2.1-2.4: Environment setup, EDA, feature engineering, modeling
- Appendices A-D: Phase-specific technical guidance

---

### Tool Dependencies

DSM has been designed and validated with Claude Code + VS Code on Linux/WSL2. The
methodology aspires to be tool-agnostic, but not all layers transfer equally to
other environments.

| Level | Dependency | Examples | Transferability |
|-------|-----------|----------|----------------|
| **1. Fundamental** | Capable AI agent with multi-turn context, file access, instruction following, session isolation | Any sufficiently capable agent | High: core to DSM's design, not vendor-specific |
| **2. Claude Code-specific** | CLAUDE.md config, slash commands, auto-memory, permission window, tool types (Read, Edit, Bash, Agent) | Claude Code CLI/extension | Medium: other agents need equivalent config and tool access |
| **3. VS Code-specific** | Session transcript real-time view, IDE file links, permission mode setting | VS Code extension | Low impact: UX conveniences, not methodology requirements |
| **4. Platform-specific** | File paths (`~/dsm-*`), shell (bash), git behavior, line endings | Linux/WSL2 | Low impact: path conventions need OS-specific documentation |

**What transfers to any environment:** Core methodology (session lifecycle,
documentation standards, governance principles, feedback loops, sprint cadence),
all DSM documents (DSM_0 through DSM_6), project structure conventions.

**What needs adaptation:** Session start/end commands, configuration file format
and location, real-time reasoning display mechanism, approval workflow UX.

If you adapt DSM to a different tool or platform, contributions documenting the
experience are welcome.

---

### AI Agent Initialization

At session start, the agent examines the project structure to determine which track applies:

| Indicator                    | Project Type | DSM Track                                 |
| ---------------------------- | ------------ | ----------------------------------------- |
| `notebooks/` only, no `src/` | Data Science    | DSM 1.0 (Sections 2.1-2.5)                |
| `src/`, `tests/`, `app.py`   | Application     | DSM 4.0                                   |
| Both `notebooks/` and `src/` | Hybrid          | DSM 1.0 for analysis, DSM 4.0 for modules |
| `docs/`, markdown-only, no `notebooks/` or `src/` | Documentation | DSM 5.0              |

The agent states the identified type and confirms which track it will follow. See **DSM_0.2_Custom_Instructions** for the full Project Type Detection protocol.

**Optional: DSM Feedback Tracking** - Create two feedback files in `docs/feedback-to-dsm/` (backlogs.md, methodology.md) to contribute improvements back to DSM. Blog materials live in `docs/blog/` as project deliverables. See **Section 6.4** (Checkpoint and Feedback Protocol).

---

## 1. System Overview

### Four Core Documents, Four Purposes

This methodology system consists of four complementary documents that work together:

#### 1.1. Project Reference Documentation
**File:** `ProjectReference_Documentation.md` (you create per project)  
**Purpose:** Project-specific context and references

**Contains:**
- Business context and stakeholder profiles
- Data sources and schema documentation
- Domain-specific terminology and glossary
- Technical environment specifications
- Key assumptions and design decisions

**Use when:** Describing project domain, context, or technical specifications

#### 1.2. Collaboration Methodology (Execution Framework)
**Files:** Main document + consolidated appendices (v1.3.0)
- `DSM_1.0_Data_Science_Collaboration_Methodology_v1.1.md` (~4,450 lines)
- `DSM_1.0_Methodology_Appendices.md` (~5,960 lines, Appendices A-F)

**Purpose:** Framework for HOW to execute work with the agent

**Core Content:**
- 4-phase workflow (Exploration → Features → Analysis → Communication)
- Notebook standards, Decision Log, Pivot Criteria, Text conventions (WARNING/OK/ERROR)
- 10 optional advanced practices (experiment tracking, testing, ethics, etc.)

**Use when:** Executing work (building notebooks, making decisions, running analysis)

#### 1.3. Project Management Guidelines (Planning Framework)
**File:** `DSM_2.0_ProjectManagement_Guidelines_v2_v1.1.md` (core, always use)
**Optional Extension:** `DSM_2.1_PM_ProdGuidelines_extension.md` (for production projects)

**Purpose:** Templates and standards for WRITING project plans

**Core Content:** 7 required sections, 9 templates (4 base + 5 v2.0 enhancements), quality checklists. Production Extension adds governance, risk management, QA standards.

**Use when:** Writing sprint/daily project plans, planning complex multi-day phases

#### 1.4. Implementation Guide (System Setup)
**File:** `3_Methodology_Implementation_Guide_v1.1.md`

**Purpose:** Instructions for SETTING UP new projects

**Contains:**
- How to configure `.claude/CLAUDE.md` with imports
- Custom Instructions template (DSM_0.2_Custom_Instructions)
- Quick start checklist
- Examples for different domains (Time Series, NLP)

**Use when:** Starting new project, configuring AI code assistant setup

### Document Relationship Map

```
Project Start
    ↓
[.claude/CLAUDE.md] ← configure this FIRST
    ↓
    ├──> Import via @path syntax:
    │   ├─ @/path/to/agentic-ai-data-science-methodology/DSM_0.2_Custom_Instructions_v1.1.md
    │   ├─ @../Project_Custom_Instructions.md (project-specific, optional)
    │   └─ Quick reference section (key paths, commands)
    │
    ├──> Central DSM Repository (referenced, not copied):
    │   ├─ DSM_0_START_HERE_Complete_Guide.md
    │   ├─ DSM_1.0_Data_Science_Collaboration_Methodology_v1.1.md
    │   ├─ DSM_1.0_Methodology_Appendices.md
    │   ├─ DSM_2.0_ProjectManagement_Guidelines_v2_v1.1.md
    │   ├─ DSM_4.0_Software_Engineering_Adaptation_v1.0.md
    │   ├─ DSM_5.0_Documentation_Project_Adaptation_v1.0.md
    │   ├─ DSM_6.0_AI_Collaboration_Principles_v1.0.md
    │   └─ DSM_3_Methodology_Implementation_Guide_v1.1.md
    │
    └──> Optional: .claude/settings.json
        └─ Permissions (allow/deny rules for tools)
    ↓
Hub Kickoff (DSM_3 Section 6.2)
    ↓
    - Preliminary scope defined
    - Directory scaffolding created
    - CLAUDE.md with @reference and protocol reinforcement
    - Feedback files initialized
    ↓
Sprint 1 Day 1: Create Project Plan
    ↓
[PM Guidelines] ← Reference for STRUCTURE
    ↓
    Create: docs/plan/ProjectName_Sprint1_Plan.md
    ↓
Sprint 1-4: Execute Work
    ↓
[Collaboration Methodology] ← Reference for EXECUTION
    ↓
    - Follow 4-phase workflow
    - Use notebook standards
    - Log decisions
    - Apply quality checks
    ↓
Project Finalization
    ↓
    - Documentation Audit (Section 6.4.6)
    - Finalize feedback files: methodology.md, backlogs.md
    - Hand off feedback to DSM Central (DSM_3 Section 6)
    ↓
Project Complete
```

---

**Sprint Configuration:** For detailed sprint timeline guidance (duration tables, configuration templates, examples by project type), see **DSM_2.0 Project Management Guidelines, Template 8: Sprint Plan with Cadence Guidance**.

---

## 2. Document Map

### Priority 0: Getting Started Documents

#### This Document: Complete Getting Started Guide
**File:** `DSM_0_START_HERE_Complete_Guide.md`  
**Purpose:** Master map - HOW everything connects  
**Read:** First, before using any other document  

**Contains:**
- Quick start (5 minutes)
- System overview with document relationships
- Complete file inventory
- Quick start step-by-step
- New project checklist with patterns
- Troubleshooting guide

---

### Priority 1: Collaboration Methodology v1.3.0 (Execution Framework)

#### Main Document: Data Science Collaboration Methodology
**File:** `DSM_1.0_Data_Science_Collaboration_Methodology_v1.1.md` (~3,400 lines)
**Purpose:** Core execution workflow - HOW to work with the agent

**Structure:**
- Section 1: Introduction & Philosophy
- Section 2: The Four-Phase Workflow
  - 2.1 Phase 0: Environment Setup
    - 2.1.9 Business Understanding Foundation (NEW in v1.3.0)
  - 2.2 Phase 1: Exploration (enhanced with Three-Layer EDA Framework)
  - 2.3 Phase 2: Feature Engineering
  - 2.4 Phase 3: Analysis
    - 2.4.8 Human Performance Baseline (NEW in v1.3.17)
    - 2.4.9 Model Complexity vs Explainability (NEW in v1.3.17)
    - 2.4.10 Grouped Data Splitting (NEW in v1.3.17)
  - 2.5 Phase 4: Communication & Deliverables
    - 2.5.6 Blog/Communication Deliverable Process (NEW in v1.3.17)
    - 2.5.7 Publication Strategy (NEW in v1.3.17)
    - 2.5.8 Blog Post as Standard Deliverable (NEW in v1.3.17)
    - 2.5.9 Blog Style Guide (NEW in v1.3.23)
    - 2.5.10 Presentation Preparation Checklist (NEW in v1.3.17)
- Section 3: Communication & Working Style
- Section 4: Project Management Integration
- Section 5: Advanced Complexity Practices (10 optional practices)
- Section 6: Tools & Best Practices
  - 6.4.5 Project Feedback Deliverables (2-file system, updated in v1.3.23)
  - 6.4.6 Breaking Change Notification (NEW in v1.3.39)
  - 6.5 Gateway Review Protocol (NEW in v1.3.19)
  - 6.5.6 DSM as Central Project Hub (BACKLOG-053)
- Section 7: Domain-Specific Considerations
- Section 8: Success Patterns & Anti-Patterns

**Tier 1 Practices (integrated into core workflow):**
- Decision Log Framework
- Pivot Criteria & Failure Modes
- Stakeholder Communication Cadence

**Advanced Practices (optional, activate as needed):**
- Experiment Tracking, Hypothesis Management (Appendix C.1.3 for evaluation phases)
- Performance Baseline & Benchmarking
- Ethics & Bias Considerations
- Testing Strategy, Data Versioning & Lineage
- Technical Debt Register, Scalability Considerations
- Literature Review Phase, Risk Management

#### Appendix A: Environment Setup Details
**File:** `DSM_1.0_Methodology_Appendices.md` (Section A)
**Purpose:** Detailed package specifications and troubleshooting

**Contains:**
- Complete package versions and dependencies
- Setup script explanations (minimal vs. production)
- VS Code configuration details
- Common installation issues and solutions
- Environment validation procedures
- Domain-specific package extensions
- A.7: Environment Tool Selection Guide (two-phase setup, tool comparison) - NEW in v1.3.13
- A.8: Model & Data Cache Management (cache locations, cleanup) - NEW in v1.3.13
- A.9: WSL & Cross-Platform Setup (path mapping, Python conflicts) - NEW in v1.3.13
- A.10: External API Portability (HTTP over CLI, auth documentation, fallback logic) - NEW in v1.3.17

#### Appendix B: Phase Deep Dives
**File:** `DSM_1.0_Methodology_Appendices.md` (Section B)
**Purpose:** Detailed guidance for each phase with examples

**Contains:**
- Phase 1 (Exploration): Data quality, profiling patterns, validation
  - B.2.4: EDA Techniques by Data Type (numeric, categorical, temporal, text) - NEW in v1.3.0
  - B.2.5: Business Understanding Integration templates - NEW in v1.3.0
  - B.2.6: References and attributions - NEW in v1.3.0
- Phase 2 (Feature Engineering): Aggregations, transformations, encoding
- Phase 3 (Analysis): Model selection, validation, interpretation
- Phase 4 (Communication): Presentations, reports, documentation
- Real examples from TravelTide project
- Code templates and patterns

#### Appendix C: Advanced Practices Detailed
**File:** `DSM_1.0_Methodology_Appendices.md` (Section C)
**Purpose:** Implementation details for all 10 advanced practices

**Contains:**
- Complete implementation guides for each practice
- Templates and frameworks
- Integration patterns with core workflow
- When to activate each practice
- Example implementations
- Tool recommendations
- C.1.3: Capability Experiment Template (quantitative + qualitative evaluation) - NEW in v1.3.1
- C.1.4: RAG Evaluation Metrics Reference (RAGAS, RAGBench, SafeRAG) - NEW in v1.3.1
- C.1.5: Limitation Discovery Protocol (disposition matrix) - NEW in v1.3.1
- C.1.6: Experiment Artifact Organization (folder structure, registry) - NEW in v1.3.7

#### Appendix D: Domain Adaptations
**File:** `DSM_1.0_Methodology_Appendices.md` (Section D)
**Purpose:** Domain-specific guidance and considerations

**Contains:**
- Time Series Forecasting (ARIMA, Prophet, seasonal patterns)
- NLP & Text Analysis (preprocessing, embeddings, transformers, EDA checklist, performance expectations, embedding visualization) - D.2.4-D.2.7 NEW/UPDATED in v1.3.10/v1.3.17
- Computer Vision (image preprocessing, CNNs, transfer learning)
- Clustering & Segmentation (K-means, hierarchical, DBSCAN)
- Recommendation Systems
- Anomaly Detection

#### Appendix E: Quick Reference
**File:** `DSM_1.0_Methodology_Appendices.md` (Section E)
**Purpose:** Checklists, commands, and quick lookup

**Contains:**
- Phase transition checklists
- Common bash/Python commands
- Git workflow patterns
- Quality check lists
- Notebook structure template
- Decision log template
- Communication templates
- E.12: DSM Validation Tracker Template (effectiveness tracking) - NEW in v1.3.2

#### Appendix F: Coding Anti-Patterns
**File:** `DSM_1.0_Methodology_Appendices.md` (Section F)
**Purpose:** Reference of common defective coding patterns with examples and fixes

**Contains:**
- F.1: Python Anti-Patterns (8 patterns: mutable defaults, bare except, wildcard imports, etc.)
- F.2: Data Science Anti-Patterns (9 patterns: god notebook, shape blindness, magic numbers, etc.)
- F.3: ML Engineering Anti-Patterns (8 patterns: feature leakage, training-serving skew, etc.)
- F.4: Agent Collaboration Anti-Patterns (8 patterns: blind acceptance, session amnesia, etc.)
- NEW in v1.3.21

---

### Priority 2: Project Management Guidelines (Planning Framework)

#### Core: PM Guidelines v2
**File:** `DSM_2_0_ProjectManagement_Guidelines_v2_v1.1.md` (~1,220 lines)
**Purpose:** Core project plan structure for ALL data science projects

**Core Content:**
- 7 required sections (Purpose, Inputs, Timeline, Deliverables, Readiness, Success Criteria, Documentation)
- **4 Base Plan Structure Templates:**
  1. Daily Task Breakdown Format
  2. Phase Summary Format
  3. Expected Outcomes Table Format
  4. Phase Prerequisites Format
- **Optional: 5 v2.0 Enhancement Templates** (add when needed):
  5. Daily Checkpoint Framework
  6. Progressive Expected Outcomes Table
  7. MUST/SHOULD/COULD Priority Framework
  8. Sprint Plan with Cadence Guidance (NEW in v1.3.19)
  9. End-of-Day Checkpoint Questions

**Versions:**
- **v1.0 (Standard):** Templates 1-4 only, straightforward planning
- **v2.0 (Enhanced):** Templates 1-8, includes daily checkpoints and progressive tracking

**Also includes:**
- Notebook Cell Quality Checklist (cell-by-cell development standards) - NEW in v1.3.14
- Notebook Portability Checklist (Colab compatibility, environment detection) - NEW in v1.3.14
- Visualization Quality Checklist (content, formatting, output checks) - NEW in v1.3.17
- Debugging Log Template (structured multi-iteration debugging) - NEW in v1.3.17
- Scope Review Checkpoint (trigger conditions, review questions) - NEW in v1.3.17
- Operational Monitoring (resource tracking, tool stack, reporting format)
- Project Change Tracking (backlog, changelog, git tags)

**Use when:**
- Writing sprint/daily project plans (all projects)
- Planning complex multi-day phases
- First-time execution of uncertain work

#### Optional Extension: PM Production Guidelines
**File:** `DSM_2.1_PM_ProdGuidelines_extension.md` (260 lines + TOC)  
**Purpose:** Production-specific additions for enterprise projects

**Extends:** `DSM_2.0_ProjectManagement_Guidelines_v2.md`

**Production-Only Content:**
- Project Governance & Roles (RACI matrix)
- Data Management & Versioning (audit trails, compliance)
- Quality Assurance & Peer Review (formal QA checklist)
- Risk Management framework (risk register, prioritization)
- Communication & Reporting Standards (stakeholder matrix, reports)
- Post-Project Review process (retrospective template, archival)

**Use when:**
- Enterprise/production projects with formal governance
- Multi-person teams requiring role clarity
- Regulatory compliance (GDPR, SOX, etc.)
- Formal QA and peer review processes

**How to use together:**
1. Use Guidelines_v2 for core planning structure
2. Add Extension sections for production requirements
3. Reference Extension templates (RACI, QA, Risk) as needed

---

### Priority 3: Implementation & Setup

#### Implementation Guide
**File:** `DSM_3_Methodology_Implementation_Guide_v1.1.md` (~500 lines)
**Purpose:** Setup instructions with complete examples

**Core Content:**
- CLAUDE.md setup with `@` reference to central Custom Instructions
- **Consolidated Custom Instructions Template**
- 2 Complete domain examples:
  - Time Series Forecasting
  - NLP Sentiment Analysis
- Canonical external description (short, medium, full versions) with project registry
- DSM version propagation mechanism (Section 6.3): how spoke projects detect DSM updates
- Bidirectional project inbox pattern (Section 6.4): ongoing hub-spoke communication
- AI contribution guidelines template (Section 6.5): reusable template for external projects
- External contribution governance (Section 6.6): governance for contributing to repos you don't own
- Contribution scope planning (Section 6.6.7 Phase 1): Scope Plan template, portfolio-to-opportunity mapping, value-add identification
- External contribution templates (Section 6.6.8): CLAUDE.md template, kickoff prompt, setup checklist
- Systematic codebase analysis (Section 6.6.9): 7-dimension quantitative analysis template for external projects
- Fork governance isolation (Section 6.6.10): maintaining governance sovereignty when upstream has AI governance artifacts
- Spoke project initialization checklist (Section 6.7): mechanical steps for setting up a new spoke project, including AI collaboration norms
- Private project pattern (Section 6.8): DSM methodology for privacy-sensitive projects with local git only, data isolation, and sanitized feedback flow
- Standard spoke pattern (Section 6.9): unified entry point for the default DSM project type with full ecosystem participation
- Tips for success
- Setup patterns

**Use when:** Starting new project, writing Custom Instructions

---

## 3. File Inventory

### Project Directory Structure (New Projects)

When starting a new project, create this structure based on project type:

#### DSM 1.0 Pattern (Data Science / Notebook Projects)

```
project/
├── .claude/                              # AI code assistant configuration
│   ├── CLAUDE.md                         # MUST @reference DSM_0.2_Custom_Instructions
│   └── settings.json                     # Optional permissions
├── data/
│   ├── raw/
│   ├── processed/
│   └── results/
├── notebooks/
├── _inbox/                               # Hub-spoke communication transit (DSM_3 Section 6.4)
├── docs/                                 # See DSM_0.1 for canonical names + done/ convention
│   ├── blog/                             # Blog materials and journal
│   ├── checkpoints/                      # Sprint/milestone checkpoints
│   ├── decisions/                        # Decision records (permanent)
│   ├── feedback-to-dsm/                  # DSM feedback files (append-only)
│   ├── handoffs/                         # Session continuity documents
│   ├── plans/                            # Sprint plans, roadmaps
│   ├── reports/                          # Analysis reports
│   └── research/                         # State-of-art surveys (if Phase 0.5)
├── outputs/
│   └── figures/
└── requirements_*.txt
```

#### DSM 4.0 Pattern (Software Engineering / Application Projects)

```
project/
├── .claude/                              # AI code assistant configuration
│   ├── CLAUDE.md                         # MUST @reference DSM_0.2_Custom_Instructions
│   └── settings.json                     # Optional permissions
├── src/                                  # Source code
├── tests/                                # Test suite
│   └── fixtures/                         # Test data
├── _inbox/                               # Hub-spoke communication transit (DSM_3 Section 6.4)
├── docs/                                 # See DSM_0.1 for canonical names + done/ convention
│   ├── blog/                             # Blog materials
│   ├── checkpoints/                      # Sprint/milestone checkpoints
│   ├── decisions/                        # Architecture Decision Records (Nygard, 2011) (permanent)
│   ├── feedback-to-dsm/                  # DSM feedback files (append-only)
│   ├── guides/                           # User-facing documentation (if applicable)
│   ├── handoffs/                         # Session continuity documents
│   ├── plans/                            # Sprint plans, roadmaps
│   └── research/                         # State-of-art surveys (if Phase 0.5)
├── outputs/
│   └── reports/
├── README.md
└── pyproject.toml (or requirements_*.txt)
```

**Both DSM 1.0 and 4.0** keep documentation in-repo under `docs/`. Session handoffs, checkpoints, and research artifacts live alongside the project code. The CLAUDE.md `@` reference imports methodology content from DSM Central.

#### CLAUDE.md Setup Requirement

Every project CLAUDE.md **must** include an `@` reference to the central DSM Custom Instructions template:

```markdown
@/path/to/agentic-ai-data-science-methodology/DSM_0.2_Custom_Instructions_v1.1.md

# Project: [Project Name]
Domain: [domain]

## Project-Specific Instructions
[content here]
```

This ensures consistent human-agent interaction patterns (pre-generation briefs, notebook collaboration protocol, feedback tracking) across all DSM projects.

### Complete Repository Structure

```
├── README.md, LICENSE, CONTRIBUTING.md, CODE_OF_CONDUCT.md, CHANGELOG.md, SECURITY.md
├── DSM_0_START_HERE_Complete_Guide.md                      # This document (Priority 0)
├── DSM_0.1_File_Naming_Quick_Reference.md                  # Printable file naming card
├── DSM_0.2_Custom_Instructions_v1.1.md                     # Custom Instructions (slim core, ~580 lines)
├── DSM_0.2.A_Session_Lifecycle.md                          # Module A: session lifecycle protocols
├── DSM_0.2.B_Artifact_Creation.md                          # Module B: artifact creation protocols
├── DSM_0.2.C_Security_Safety.md                            # Module C: security and safety protocols
├── DSM_0.2.D_Research_Onboarding.md                        # Module D: research and onboarding protocols
├── DSM_1.0_Data_Science_Collaboration_Methodology_v1.1.md  # Main methodology (~4,450 lines)
├── DSM_1.0_Methodology_Appendices.md                       # Appendices A-F (~5,820 lines)
├── DSM_2.0_ProjectManagement_Guidelines_v2_v1.1.md         # PM Guidelines (Priority 2)
├── DSM_2.1_PM_ProdGuidelines_extension.md                  # Optional production extension
├── DSM_3_Methodology_Implementation_Guide_v1.1.md          # Setup instructions (Priority 3)
├── DSM_4.0_Software_Engineering_Adaptation_v1.0.md         # ML app track
├── DSM_5.0_Documentation_Project_Adaptation_v1.0.md        # Documentation track
├── DSM_6.0_AI_Collaboration_Principles_v1.0.md             # AI collaboration principles (all projects)
├── TAKE_A_BITE.md                                          # Core principle: deliver only what the reviewer can chew
├── scripts/                                                # Environment setup scripts
│   ├── setup_base_environment_minimal.py                   # Academic/exploratory
│   └── setup_base_environment_prod.py                      # Production (+ code quality)
└── plan/                                                    # Planning, backlog, and roadmap
```

### Total System Size

| Component             | Files  | Lines       | Purpose                  |
| --------------------- | ------ | ----------- | ------------------------ |
| Getting Started       | 1      | ~980        | Quick start & system map |
| Methodology v1.3.0    | 2      | ~10,270     | Execution framework      |
| PM Guidelines         | 2      | ~1,635      | Planning framework       |
| SW Engineering (4.0)  | 1      | ~625        | ML application track     |
| Implementation        | 1      | ~500        | Setup instructions       |
| Quick Reference Cards | 1      | ~120        | Printable file naming    |
| Custom Instructions   | 5      | ~2,390      | Core (580) + 4 modules   |
| Environment Scripts   | 2      | ~400        | Automated setup          |
| **Total Core System** | **15** | **~16,940** | **Complete framework**   |

---

## 4. Quick Start Guide

For **complete step-by-step setup instructions** (environment, CLAUDE.md configuration, first chat message, domain-specific packages), see **DSM_3_Methodology_Implementation_Guide_v1.1.md**.

**Summary of steps:**
1. Assess project type (Notebook / Application / Hybrid)
2. Set up environment (`scripts/setup_base_environment_minimal.py` for Data Science, custom `requirements.txt` for Applications)
3. Create `.claude/CLAUDE.md` with `@` reference to DSM_0.2_Custom_Instructions
4. Send first chat message (agent identifies project type, helps create sprint plan)

**Environment troubleshooting:** See **Appendix A** in DSM_1.0_Methodology_Appendices.md

---

## 5. New Project Checklist

For the **complete setup sequence** (environment, CLAUDE.md, directory structure, domain packages), see **DSM_3_Methodology_Implementation_Guide_v1.1.md, Sections 3-4**.

For **domain-specific package lists**, see **Appendix A.3** in DSM_1.0_Methodology_Appendices.md.

---

## 6. Common Patterns

### Pattern 1: Daily Workflow

```
Morning:
1. Check project plan (PM Guidelines structure)
2. Review previous day's checkpoint (docs/checkpoints/sYY_dXX_checkpoint.md)
3. Identify today's deliverable
4. Reference methodology for execution approach

During Work:
5. Work in notebooks following methodology standards
6. Add Notebook Summary Cell after completing each notebook (Section 6.1.4)

End of Day (5 min):
7. Create daily checkpoint file (docs/checkpoints/sYY_dXX_checkpoint.md)
8. Update decision log if major choices made (DEC-XXX format)
9. Commit to git and push to remote
10. Note tomorrow's first priority

Reference: Section 6.1.4 Daily Documentation Protocol, Section 6.1.5 Session Close-Out
```

### Pattern 1b: End of Notebook

```
Before closing any notebook:

1. Verify all cells execute (Kernel > Restart & Run All)
2. Add Notebook Summary Cell as final cell:

   # ============================================================
   # NOTEBOOK SUMMARY
   # ============================================================
   # Completed: [Brief description]
   # Key Outputs: [files created with paths]
   # Decisions Made: DEC-XXX (if any)
   # Next Steps: [next notebook or task]
   # ============================================================

3. Save processed data with naming convention (sYY_dXX_PHASE_description.pkl)
4. Validate outputs (shape, nulls, value ranges)

Reference: Section 6.1.4 End of Notebook Checklist
```

### Pattern 2: Sprint Transition

```
End of Sprint:
1. Review sprint's deliverables against PM Guidelines checklist
2. Create next sprint's plan (PM Guidelines structure)
3. Update risk register if applicable
4. Stakeholder update following methodology communication standards
5. Archive sprint's outputs
```

### Pattern 3: Decision Making

```
When making major decisions:
1. Use methodology's Decision Log Framework (see Appendix E)
2. Document in decision_log.md file
3. Reference in project plan
4. Update Custom Instructions if approach changes
```

### Pattern 4: Context Transfer (New Chat in Same Project)

```
"New chat continuation. Review methodology + custom instructions + 
previous chat summary, then let's continue with [next task]."
```

### Common Task Reference Table

| I need to...                | Use this document          | Prompt example                                              |
| --------------------------- | -------------------------- | ----------------------------------------------------------- |
| Start new project           | Implementation Guide       | "Help me set up new project following implementation guide" |
| Write sprint plan           | PM Guidelines              | "Create Sprint 2 plan following PM Guidelines structure"    |
| Build notebook              | Collaboration Methodology  | "Create Phase 1 notebook following methodology standards"   |
| Make major decision         | Methodology + Appendix E   | "Document this decision using methodology decision log"     |
| Manage risks                | PM Guidelines (Production) | "Update risk register per PM Guidelines"                    |
| Communicate to stakeholders | Methodology Section 2.5    | "Draft update using methodology communication template"     |
| Quality check               | Both PM + Methodology      | "QA check against both PM Guidelines and methodology"       |
| Phase transition            | Methodology + Appendix E   | "Complete Phase 1 checklist from Appendix E"                |
| Advanced practice setup     | Appendix C                 | "Implement experiment tracking per Appendix C"              |
| Domain-specific guidance    | Appendix D                 | "Review time series guidance in Appendix D"                 |
| Project retrospective       | PM Guidelines (Production) | "Create post-project review per PM Guidelines"              |

### Notebook Naming Convention

- **Sprints 1-3 (development):** `sXX_dYY_PHASE_description.ipynb`
  - Example: `s02_d03_FE_aggregations.ipynb`
- **Sprint 4 (final deliverables):** `XX_PHASE_description.ipynb`
  - Example: `03_FE_core_features.ipynb`

---

## 7. Tips for Success

### Tip 1: Start Simple
- Don't activate all advanced practices immediately
- Begin with core 4-phase workflow
- Add complexity only when justified
- Check advanced practice boxes in Custom Instructions as needed

### Tip 2: Reference, Don't Repeat
```
OK: "Follow methodology's Section 2.3 structure for time series"
BAD: [Copy-pasting entire Phase 2 section into CLAUDE.md]
```

**Why:**
- Keep CLAUDE.md focused on project-specific context
- AI code assistant can read methodology files directly when needed
- Avoid duplication and maintenance burden

### Tip 3: Update Custom Instructions Throughout Project
- Add constraints when discovered
- Check/uncheck advanced practices as needed
- Note project-specific decisions
- Update timeline when it changes
- Keep stakeholder info current

### Tip 4: Use Methodology Search Triggers

**The agent will search automatically when you mention:**
- Phase transitions ("Starting Phase 2...")
- Decision documentation ("Document this decision...")
- Quality checks ("Run Phase 1 quality checklist...")
- Specific practices ("experiment tracking", "pivot criteria", etc.)

**You can also explicitly request:**
```
"Search methodology for guidance on [specific topic]"
"Review Appendix D for NLP-specific considerations"
"Check Appendix E for phase transition checklist"
```

### Tip 5: Leverage Appendices

**When to use each appendix:**
- **Appendix A:** Environment issues, package conflicts, setup troubleshooting
- **Appendix B:** Detailed phase guidance, code examples, real project patterns
- **Appendix C:** Implementing advanced practices (experiment tracking, testing, etc.)
- **Appendix D:** Domain-specific considerations (time series, NLP, CV, clustering)
- **Appendix E:** Quick checklists, templates, command reference

### Tip 6: Maintain Decision Log

**Create:** `docs/decision_log.md` at project start

**Update when:**
- Choosing between multiple approaches
- Major pivots or strategy changes
- Deviating from standard practices
- Making business vs. technical tradeoffs

**Template:** See Appendix E for decision log format

### Tip 7: Monitor Token Usage

**Watch for 90% capacity:**
- Current chat approaching ~171K tokens
- The agent will alert you
- Create session handoff document
- Start fresh chat with handoff

**Session handoff template:** See Methodology Section 6.1

---

## 8. Troubleshooting

### Issue: Agent not following standards

**Symptoms:**
- Notebooks don't match methodology structure
- Plan doesn't follow PM Guidelines format
- Text conventions not applied (emojis instead of WARNING/OK)

**Solution:**
- Verify `.claude/CLAUDE.md` exists and imports DSM_0.2_Custom_Instructions
- Check that methodology files are in the project directory
- Explicitly prompt:
  - "Reference PM Guidelines for structure"
  - "Follow methodology standards from Section X"
  - "Use text conventions from methodology (WARNING/OK/ERROR)"

### Issue: Confusion about which document to use

**Rule of thumb:**
- **Planning** = PM Guidelines
- **Executing** = Collaboration Methodology
- **Setting up** = Implementation Guide
- **Quick lookup** = Appendix E

**When in doubt:**
```
"Which document should I reference for [task]?"
```

### Issue: Too many documents to track

**Solution:** The AI code assistant reads files directly from the project directory. Use `.claude/CLAUDE.md` imports for always-loaded context, reference specific files when needed. The "When to Reference Which Document" table above provides quick guidance.

### Issue: Standards conflicting between documents

**Resolution hierarchy:** PM Guidelines for structure (what sections, what format) → Methodology for execution (how to build, code standards) → Appendices for deep dives.

### Issue: CLAUDE.md too verbose

**Solution:** Use `@path` imports instead of copying content. Keep only project-specific details (timeline, stakeholders, constraints, active advanced practices) in DSM_0.2_Custom_Instructions. See **Implementation Guide** for the concise template.

### Issue: Environment setup fails

See **Appendix A** in DSM_1.0_Methodology_Appendices.md for detailed troubleshooting (Python version, virtual environment, package conflicts, VS Code interpreter selection).

### Issue: Agent forgets context mid-session

Create a session handoff document (Section 6.1 template), start a new chat, and reference the handoff in your first message.

### Issue: Don't know which advanced practices to activate

**Start simple:** First project uses core workflow only. Add practices as needed (experiment tracking for multiple models, testing for production code, ethics for sensitive data). See **Appendix C** for detailed guidance on each of the 10 practices.

---

## When to Reference Which Document

| Situation                  | Primary Reference                 | Secondary Reference     |
| -------------------------- | --------------------------------- | ----------------------- |
| Starting new project       | This guide + Implementation Guide | -                       |
| Environment issues         | Appendix A                        | setup scripts           |
| Creating notebooks         | Methodology Section 2.X           | Appendix B (examples)   |
| Documenting decisions      | Methodology Section 4.1           | Appendix E (template)   |
| Stakeholder updates        | Methodology Section 2.5           | -                       |
| Pivot decision needed      | Methodology Section 4.2           | -                       |
| Writing sprint plan        | PM Guidelines Section X           | -                       |
| Complex multi-day planning | PM Guidelines v2.0 Templates      | -                       |
| Managing risks             | PM Production Extension           | -                       |
| Defining deliverables      | PM Guidelines Section X           | -                       |
| Quality assurance          | Methodology Section 6             | PM Production Extension |
| Governance & roles         | PM Production Extension           | -                       |
| Advanced practice setup    | Appendix C                        | Methodology Section 5   |
| Domain-specific guidance   | Appendix D                        | -                       |
| Quick command lookup       | Appendix E                        | -                       |
| Phase transition           | Methodology Section 2.X           | Appendix E (checklist)  |
| Project retrospective      | PM Production Extension           | -                       |

---

## What Makes This System Unique

### 1. Battle-Tested Foundation
- Built from successful projects listed in README.md
- Proven patterns that actually worked

### 2. Clear Organization
- Numbered priority system (0_ START HERE → 1_ Execution → 2_ Planning → 3_ Setup)
- Self-documenting with hierarchical numbering (no TOC maintenance)
- Quick start (5 minutes) to comprehensive guide
- Modular appendices for targeted deep dives

### 3. Complete Integration
- Project Reference + Methodology + PM Guidelines + Implementation
- All documents reference each other appropriately using section numbers
- No duplication, clear boundaries between document purposes
- AI code assistant integration via `.claude/CLAUDE.md` imports

### 4. Academic-Optimized, Production-Ready
- Standard edition for coursework/thesis/portfolio
- Production edition for industry work with governance
- Advanced Practices activate as needed (10 optional complexity practices)
- Professional standards throughout (no emojis, WARNING/OK/ERROR)

### 5. AI Code Assistant Design
- Uses `.claude/CLAUDE.md` with `@path` imports for context
- DSM_0.2_Custom_Instructions template for project-specific settings
- Progressive execution patterns (cell-by-cell, review outputs)
- Session management built-in (Section 6.1)
- Daily documentation protocol (Section 6.1.4)

### 6. Hierarchical Structure (v1.3.0)
- Main methodology: ~3,400 lines (focused on core workflow)
- Consolidated appendices: ~4,010 lines (5 appendices in one file)
- Total: ~7,410 lines of methodology content
- Section numbering: "See Section 4.1.2" instead of "See Phase X"
- Easy referencing and navigation
- Better maintainability with consolidated structure

---

**Quality Checklists:** See **DSM_2.0 Project Management Guidelines** (planning quality) and **DSM_1.0 Section 6** (execution quality standards).

---

## Common Mistakes to Avoid

**WARNING: Keep CLAUDE.md focused**
- Use `@path` imports instead of copying content
- Don't duplicate methodology content
- Focus on project-specific details in DSM_0.2_Custom_Instructions
- Use checkboxes for advanced practices (checked = active)

**WARNING: Don't skip DSM_0.2_Custom_Instructions**
- The agent needs project context to work effectively
- Generic methodology isn't enough for personalization
- Stakeholder info is critical for communication
- Timeline helps the agent pace the work

**WARNING: Update as you go**
- Don't set and forget
- Projects evolve, instructions should too
- Dead/outdated instructions worse than no instructions
- Review and update each sprint

**OK: This approach scales**
- Same methodology for all projects
- Only DSM_0.2_Custom_Instructions changes per project
- Reusable, maintainable, efficient
- Proven across multiple domains

---

## Complete Project Lifecycle Example

### Project: Customer Segmentation Analysis

**Setup Phase (Day 0)**
```
0. Run environment setup:
   # Academic/exploratory:
   python scripts/setup_base_environment_minimal.py

   # Production (with code quality):
   python scripts/setup_base_environment_prod.py

   - Install VS Code extensions
   - Select interpreter
1. Create .claude/ folder:
   mkdir .claude
2. Create .claude/CLAUDE.md:
   @../DSM_0.2_Custom_Instructions_v1.1.md
   # Quick Reference
   ...
3. Create DSM_0.2_Custom_Instructions_v1.1.md (using template from Implementation Guide)
4. First message: "Review CLAUDE.md and help create Sprint 1 plan"
```

**Sprint 1: Planning & EDA**
```
Day 1:
- Reference: PM Guidelines v2 (add Production Extension if needed)
- Create: CustomerSeg_Sprint1_Plan.md (project plan)
- Sections: Purpose, Inputs, Timeline, Deliverables, Success Criteria

Day 2-5:
- Reference: Methodology Section 2.2 + Appendix B
- Create: 01_EDA_data_quality.ipynb, 02_EDA_behavioral.ipynb
- Follow: Methodology notebook standards (~400 lines, 5-6 sections)
- Document: Decision log entries as needed
```

**Sprint 2: Feature Engineering**
```
Day 1:
- Reference: PM Guidelines v2
- Create: CustomerSeg_Sprint2_Plan.md

Day 2-5:
- Reference: Methodology Section 2.3 + Appendix B
- Create: 03_FE_core.ipynb, 04_FE_advanced.ipynb
- Follow: Feature engineering standards
- Document: Major feature decisions
```

**Sprint 3: Clustering Analysis**
```
Day 1:
- Reference: PM Guidelines v2 + Appendix D (clustering guidance)
- Create: CustomerSeg_Sprint3_Plan.md

Day 2-5:
- Reference: Methodology Section 2.4 + Appendix D
- Create: 05_CLUSTERING_prep.ipynb, 06_CLUSTERING_assignment.ipynb
- Document: Major decision on K selection (decision log)
- Validate: Silhouette, Davies-Bouldin, Calinski-Harabasz scores
```

**Sprint 4: Communication**
```
Day 1:
- Reference: PM Guidelines v2
- Create: CustomerSeg_Sprint4_Plan.md

Day 2-5:
- Reference: Methodology Section 2.5
- Create: Presentation, reports, documentation
- Follow: Communication standards
- Deliver: Stakeholder presentations
```

---

## Next Steps

**For Your First Project:**

1. **Read this document** (you're here!)
2. **Run environment setup** (10 minutes)
3. **Create `.claude/` folder** in project root
4. **Create `.claude/CLAUDE.md`** with imports:
   ```markdown
   @../DSM_0.2_Custom_Instructions_v1.1.md
   # Quick Reference
   ...
   ```
5. **Create DSM_0.2_Custom_Instructions_v1.1.md** (use template from Implementation Guide)
6. **Send first chat message** (pattern in Section 5)
7. **Create project structure** (directories, README files)
8. **Start Sprint 1 planning** (PM Guidelines)
9. **Execute phases 1-4** (Methodology)

**For Your Second Project:**

1. Copy DSM_0.2_Custom_Instructions template from first project
2. Update project-specific sections (timeline, stakeholders, domain)
3. Adjust advanced practices checkboxes as needed
4. Create new `.claude/CLAUDE.md` with import
5. Start immediately with Sprint 1 planning

**Same methodology, different projects. That's the power of this system.**

---

## References

- Nygard, M. (2011). [Documenting Architecture Decisions](https://www.cognitect.com/blog/2011/11/15/documenting-architecture-decisions). Cognitect Blog.
- Preston-Werner, T. (2013). [Semantic Versioning 2.0.0](https://semver.org/).

---

**Version History:** See **CHANGELOG.md** for complete release notes.
