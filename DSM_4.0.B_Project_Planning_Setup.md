# DSM 4.0 Module B: Project Planning and Repository Setup

**Parent document:** [DSM 4.0 Software Engineering Adaptation](DSM_4.0_Software_Engineering_Adaptation_v1.0.md)
**Purpose:** Sprint planning templates, portfolio checklists, GitHub repository configuration, and production/MLOps references.

This module contains planning and setup content for software engineering projects.
Load this module when planning sprints, preparing a project for portfolio showcase,
setting up a new GitHub repository, or considering production deployment.

## Contents

1. [Portfolio Project Showcase Checklist](#1-portfolio-project-showcase-checklist)
2. [Sprint Planning for SW Projects](#2-sprint-planning-for-sw-projects)
3. [Sprint Planning Document Template](#3-sprint-planning-document-template)
4. [GitHub Repository Setup Checklist](#4-github-repository-setup-checklist)
5. [Beyond DSM: Production and MLOps](#5-beyond-dsm-production-and-mlops)

## Document Structure Index

| § | Section | Description |
|---|---------|-------------|
| 1 | Portfolio Project Showcase Checklist | Quality checklist for projects intended as portfolio pieces |
| 2 | Sprint Planning for SW Projects | Example sprint structure and time allocation guidance |
| 3 | Sprint Planning Document Template | Backlog and sprint document templates |
| 4 | GitHub Repository Setup Checklist | Repository settings, README essentials, IDE configuration |
| 5 | Beyond DSM: Production and MLOps | References to MLOps frameworks and deployment patterns |

---

## 1. Portfolio Project Showcase Checklist

For projects intended to demonstrate skills (job applications, portfolio), this
checklist covers repository quality, code standards, and ML-specific requirements.

### 1.1. Repository Quality Standards for Portfolio

- [ ] Clear, descriptive README
- [ ] Architecture diagram
- [ ] Setup instructions that work
- [ ] Sample data or instructions to obtain it
- [ ] License file

### 1.2. Code Demonstration Quality Criteria

- [ ] Clean separation of concerns
- [ ] Design patterns where appropriate
- [ ] Error handling
- [ ] Configuration management (env vars, not hardcoded)
- [ ] Logging (not print statements in production code)

### 1.3. ML/AI Specific Portfolio Requirements

- [ ] Reproducible experiments (seed, logging)
- [ ] Evaluation metrics defined and tracked
- [ ] Model/prompt versioning
- [ ] Clear distinction between training and inference (if applicable)

### 1.4. ML Engineer Portfolio Criteria

- [ ] Demonstrates ML system design from scratch
- [ ] Shows ability to apply and integrate existing models
- [ ] Includes evaluation pipeline with metrics
- [ ] Code is in Python with type hints
- [ ] Modern frameworks relevant to the project domain
- [ ] Agentic patterns where applicable

---

## 2. Sprint Planning for SW Projects

This section provides a concrete example of sprint structure for a multi-day
ML application project, along with time allocation guidance.

### 2.1. Example: 4-Day ML Application Sprint

**Day 1: Foundation**
- Phase 0: Environment setup
- Phase 1: Data pipeline
- Deliverable: Working data loading and basic analysis

**Day 2: Core Implementation**
- Phase 2: Core modules
- Deliverable: All main classes/functions implemented

**Day 3: Integration and Testing**
- Phase 3: Integration, evaluation, testing
- Deliverable: End-to-end flow works, tests pass

**Day 4: Polish and Documentation**
- Phase 4: Application, documentation
- Deliverable: Demo app, README, ready for showcase

### 2.2. Time Allocation Guidance per Phase

| Phase | Typical Allocation | Notes |
|-------|-------------------|-------|
| Phase 0 | 5-10% | Should be quick if reusing setup scripts |
| Phase 1 | 15-20% | Depends on data complexity |
| Phase 2 | 30-40% | Core development work |
| Phase 3 | 20-25% | Integration often reveals issues |
| Phase 4 | 15-20% | Don't underestimate documentation |

---

## 3. Sprint Planning Document Template

This section provides reusable templates for backlog and sprint plan documents
in software engineering projects.

### 3.1. BACKLOG.md Structure and Format Template

```markdown
# Product Backlog

## Priority Definitions
- **P0**: Critical for MVP
- **P1**: Important, next sprint
- **P2**: Nice to have
- **P3**: Future consideration

## Backlog Items

### P0 - Critical
- [ ] Item 1: Description

### P1 - Important
- [ ] Item 2: Description

### P2 - Nice to Have
- [ ] Item 3: Description

### P3 - Future
- [ ] Item 4: Description
```

### 3.2. SPRINT_X.md Structure and Format Template

```markdown
# Sprint X: [Theme]

**Duration:** X days
**Goal:** [One sentence]

## Day 1: [Focus]
- [ ] Task 1
- [ ] Task 2

## Day 2: [Focus]
- [ ] Task 3
- [ ] Task 4

## Success Criteria
- [ ] Criterion 1
- [ ] Criterion 2

## Risks
- Risk 1: [Mitigation]
```

---

## 4. GitHub Repository Setup Checklist

This section covers repository settings, README essentials, and IDE configuration
for new software engineering projects.

### 4.1. Repository Settings and Metadata Configuration

| Field | Guidelines | Example |
|-------|------------|---------|
| **Description** | Under 100 chars, action-oriented | "ML-powered data pipeline for automated report generation" |
| **Website** | Link to live demo | `https://your-app.example.com/` |
| **Topics** | 8-12 keywords for discoverability | `machine-learning data-science python api automation` |

### 4.2. README Essentials and Content Checklist

- [ ] One-sentence description
- [ ] Live demo link (if deployed)
- [ ] Architecture diagram
- [ ] Features list
- [ ] Installation instructions
- [ ] Usage examples
- [ ] Development progress/roadmap
- [ ] License
- [ ] Author info

### 4.3. IDE Configuration for VS Code

Auto-configure the Python environment so developers do not need to manually
select the interpreter each time they open the project.

**`.vscode/settings.json`:**

```json
{
    "python.defaultInterpreterPath": "${workspaceFolder}/.venv/bin/python",
    "python.testing.pytestArgs": ["tests"],
    "python.testing.unittestEnabled": false,
    "python.testing.pytestEnabled": true
}
```

| Setting | Purpose |
|---------|---------|
| `python.defaultInterpreterPath` | Auto-select project virtual environment |
| `python.testing.pytestArgs` | Configure test discovery directory |
| `python.testing.pytestEnabled` | Enable pytest integration in VS Code |

**Cross-platform note:** The path `.venv/bin/python` works on Linux/Mac.
On Windows, the actual path is `.venv\Scripts\python.exe`, but VS Code resolves
`${workspaceFolder}/.venv/bin/python` correctly on all platforms.

**Optional: `.vscode/extensions.json`:**

```json
{
    "recommendations": [
        "ms-python.python",
        "ms-python.vscode-pylance"
    ]
}
```

This prompts collaborators to install recommended extensions when opening the project.

### 4.4. Claude Code Permission Mode Configuration

When using Claude Code (CLI or VS Code extension), verify the permission mode
preserves human-in-the-loop review. The default mode may auto-accept file edits
without showing a diff approval dialog.

```json
{
    "claudeCode.initialPermissionMode": "default"
}
```

Set this in VS Code user or workspace settings. The `default` mode requires
explicit approval for file writes, maintaining the Pre-Generation Brief Protocol
and human review of all changes. Without this, the agent may write multiple files
before the user notices changes were auto-applied.

Cross-reference: DSM 4.0 Section 4 (Development Protocol), Appendix A.7 (Environment Tool Selection)

---

## 5. Beyond DSM: Production and MLOps

DSM focuses on building applications through the adapted phase workflow. For
production deployment and operations, these established frameworks and resources
are recommended. This section serves as a curated reference, not a protocol.

### 5.1. MLOps Maturity Models and Frameworks
- **Google MLOps Maturity Model** (Levels 0-2): Progression from manual ML to full CI/CD for ML
- **Microsoft ML Maturity Model**: Enterprise-focused maturity assessment

### 5.2. Model and Data Documentation Standards
- **Model Cards** (Mitchell et al., 2019): Standardized model documentation
- **Data Cards** (Google, 2022): Dataset documentation standards

### 5.3. Deployment Patterns for ML Systems
- **Shadow Mode**: New model runs parallel, predictions logged but not served
- **Canary Deployment**: Gradual traffic shift (5% → 100%)
- **Blue/Green**: Instant switchover with easy rollback
- **Champion/Challenger**: Statistical testing for model promotion

### 5.4. Data Quality and Monitoring Tools
- **Great Expectations**: Data validation framework
- **dbt**: Data transformation and testing
- **Model drift detection**: Performance degradation monitoring
- **Data drift detection**: Feature distribution monitoring

These topics are outside DSM scope but are important for production systems. DSM provides the foundation for building working applications; these resources extend into production operations.
