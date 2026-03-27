# Project Management Guidelines for DSM Projects

**Version:** 2.0 v1.1
**Scope:** All DSM project types (data science, software engineering, documentation, external contribution)

This document provides a standardized framework for planning, executing, and
documenting DSM projects. It ensures consistency, efficiency, and clarity across
all phases, from initial setup to delivery and reporting. For production/enterprise
projects requiring governance, quality assurance, and risk management, reference
DSM_2.1_PM_ProdGuidelines_extension.md.

## Contents

| § | Section | Description |
|---|---------|-------------|
| 1 | [Purpose and Scope of PM Guidelines](#1-purpose-and-scope-of-pm-guidelines) | Objectives and intended audience for the PM framework |
| 2 | [Project Structure Overview and Core Sections](#2-project-structure-overview-and-core-sections) | Required sections in every project plan |
| 3 | [Technical Prerequisites and Phase Readiness](#3-technical-prerequisites-and-phase-readiness) | Environment setup, deliverables, and readiness checklists |
| 4 | [Recommended Style and Formatting Standards](#4-recommended-style-and-formatting-standards) | Document structure, tone, and character restrictions |
| 5 | [Example Project Flow and Phasing](#5-example-project-flow-and-phasing) | Sprint phasing overview with example timeline |
| 6 | [Project Management Best Practices](#6-project-management-best-practices) | Principles for reproducibility, transparency, and communication |
| 7 | [File Naming Standards Across Project Types](#7-file-naming-standards-across-project-types) | Conventions for notebooks, source code, and documents |
| 8 | [Template Reference and Naming Conventions](#8-template-reference-and-naming-conventions) | Plan filename convention and author section format |
| 9 | [Module Dispatch Table for PM Guidelines](#9-module-dispatch-table-for-pm-guidelines) | Index of templates, checklists, and operational protocols in modules |

---

## 1. Purpose and Scope of PM Guidelines

This section defines the objectives and intended audience for the project
management framework.

**Objective:** Establish a clear, time-bound, and reproducible plan that delivers
measurable outcomes aligned with business goals.

**Scope:** Any project following DSM methodology, regardless of domain or
project type. The guidelines apply equally to data science exploration,
application development, documentation efforts, and external contributions.

---

## 2. Project Structure Overview and Core Sections

Each project plan should include the following core sections. These provide the
structural backbone for any DSM project, ensuring that plans are complete,
reviewable, and actionable.

1. **Purpose**
   - Define the project's main objective and deliverable.
   - Describe the expected impact or business value.
   - Specify available resources and time allocation.

2. **Inputs and Dependencies**
   - List all inputs and their key characteristics (datasets: record count,
     features, source; code: modules, APIs; documents: scope, format).
   - Reference outputs or dependencies from prior project phases.
   - Document quality assumptions and preprocessing status.

3. **Execution Timeline**
   - Break the project into daily or sprint milestones.
   - Define key focus areas and deliverables for each time unit.
   - Provide estimated effort per phase (in hours or days).

4. **Detailed Deliverables**
   - Clearly outline goals, deliverables, and success metrics for each milestone.
   - Use bullet points to describe analytical steps, validation checks, and outputs.
   - Include both technical (code, models, reports) and analytical deliverables
     (insights, recommendations).

5. **Readiness Checklist**
   - Define preconditions for transitioning to the next phase (e.g., modeling
     readiness, deployment readiness).
   - Include data validation, documentation completeness, and reproducibility checks.

6. **Success Criteria**
   - Quantitative: measurable indicators of completion or quality (e.g., test
     coverage, performance metrics, document completeness).
   - Qualitative: alignment with business logic, interpretability, or stakeholder
     expectations.
   - Technical: data quality, code reproducibility, and version control compliance.

7. **Documentation and Ownership**
   - Ensure all deliverables (scripts, notebooks, documents, datasets) are
     versioned and linked to the project plan.
   - Document assumptions, transformations, and limitations.
   - Include author name, role, and project timeline.

---

## 3. Technical Prerequisites and Phase Readiness

This section covers environment setup requirements and readiness checklists that
apply before beginning Phase 1 work. These prerequisites ensure that the
development environment is functional and verified before project work starts.

### 3.1. Environment Setup Requirements

Run the appropriate setup for your project type:
- Data science: `scripts/setup_base_environment_minimal.py` or `scripts/setup_base_environment_prod.py`
- Application: Language runtime, dependency manager, test framework
- Documentation: Markdown tooling, linter, spell checker

**Environment Requirements:**
- Project-appropriate runtime environment configured
- Dependencies installed and verified
- Editor/IDE configured with required extensions
- Version control initialized

**Reference:** See DSM_1.0 Section 2.1 (Phase 0: Environment Setup) for data
science setup details. Application projects should follow DSM_4.0 Section 11
(GitHub Repository Setup Checklist). See also DSM_0.2 Environment Preflight
Protocol for complete instructions.

### 3.2. Environment Verification Checklist

- [ ] Dependency manifest generated (e.g., `requirements.txt`, `package.json`, `Cargo.toml`)
- [ ] All dependencies install and import successfully
- [ ] Development environment functional (editor, runtime, debugger)
- [ ] Code quality tools active (linter, formatter)

### 3.3. Technical Deliverables for Environment Phase

**Environment Documentation:**
- Dependency manifest (e.g., `requirements.txt`, `package.json`, `Cargo.toml`)
- Full dependency lockfile for reproducibility
- Editor/IDE configuration (e.g., `.vscode/settings.json`, `.editorconfig`)
- Setup scripts or automation (if applicable)

**Purpose:** Enable environment reproduction by collaborators or for deployment.

### 3.4. Phase 1 Readiness Checklist

Before beginning the first work phase:

- [ ] Development environment created and activated
- [ ] All required dependencies installed and verified
- [ ] Editor/IDE configured with project-appropriate extensions
- [ ] Build/run/test cycle verified (e.g., test notebook runs, tests pass, docs build)
- [ ] Domain-specific tooling installed (if needed)

---

## 4. Recommended Style and Formatting Standards

This section defines the formatting, tone, and character restrictions that apply
to all DSM project documentation and deliverables.

### 4.1. Document Formatting Conventions

| Section               | Format                                                 | Description                                                                       |
| --------------------- | ------------------------------------------------------ | --------------------------------------------------------------------------------- |
| **Headers**           | Use H2/H3 hierarchy (`##`, `###`)                      | Maintain consistent hierarchy and clarity                                         |
| **Tables**            | Markdown tables for timelines and deliverables         | Use columns for *Day/Sprint*, *Focus Area*, and *Deliverables*                    |
| **Bullets**           | Concise, action-oriented                               | Begin each bullet with an actionable verb (e.g., *Define*, *Compute*, *Validate*) |
| **Metrics & Outputs** | Use bold formatting for key metrics and filenames      | e.g., **output.csv**, **coverage score**, **accuracy >= 0.85**                    |
| **Separation**        | Use `---` for visual separation between major sections | Enhances readability and consistency                                              |

### 4.2. Tone and Style Requirements

All documentation, project plans, and deliverables should adhere to a
**professional, concise, and objective tone**.

**Requirements:**
- **Professional language only.** Avoid informal expressions and personal opinions.
- **No emojis or decorative symbols** in any document or deliverable.
- **Each section** of a markdown or project plan must include a **short, informative
  description** summarizing its content and intent.
- **Each code artifact** (notebook cell, script section, module) must:
  - Contain a description explaining what it does and why.
  - Generate **at least one visible output** (table, plot, metric, or print statement)
    to demonstrate results or intermediate checks. For non-interactive artifacts,
    include logging or test output instead.
- **Formatting consistency** should be prioritized; all text, tables, and figures
  must be clear, aligned, and free of unnecessary embellishments.
- **Comments in code** should be brief, meaningful, and written in complete
  sentences where relevant.

This section ensures the deliverables communicate technical rigor and are
accessible to both technical and non-technical stakeholders.

### 4.3. Character and Symbol Restrictions

To ensure compatibility across all systems and maintain professional standards:

**Prohibited:**
- Emojis of any kind
- Unicode checkmarks or symbols
- Special decorative characters

**Required:**
- Standard markdown checkboxes: `[ ]` for incomplete, `[x]` for complete
- Plain text status prefixes: "OK:", "WARNING:", "ERROR:"
- ASCII-only characters in all documentation

**Applies to:**
- Project plans and reports
- Code comments and notebook markdown cells
- README files
- All markdown documentation

---

## 5. Example Project Flow and Phasing

This section provides a reference timeline for typical DSM project phasing.
Actual sprint counts and focus areas vary by project scope and complexity.

| Sprint      | Focus Area                  | Key Outputs                                               |
| ----------- | --------------------------- | --------------------------------------------------------- |
| **Day 0**   | Environment Setup           | Development environment, dependencies, tool configuration |
| **Sprint 1**| Research and exploration    | Validated inputs, initial findings, scope decisions       |
| **Sprint 2**| Core implementation         | Primary deliverables, tested components                   |
| **Sprint 3**| Integration and validation  | End-to-end verification, quality reports                  |
| **Sprint 4**| Delivery and reporting      | Final artifacts, documentation, stakeholder presentation  |

---

## 6. Project Management Best Practices

These practices apply across all project types and phases. They represent the
minimum standards for any DSM project.

- **Environment Setup:** Complete environment configuration (Day 0) before
  beginning project work. See DSM_1.0 Section 2.1 (Phase 0: Environment Setup)
  for data science setup, DSM_4.0 Section 11 for application projects.
- **Modularization:** Structure deliverables by phase (e.g., `01_exploration/`,
  `02_implementation/`, or `01_data_cleaning.ipynb`, `02_feature_engineering.ipynb`).
- **Reproducibility:** Store parameters, configuration, and random seeds. Ensure
  builds and analyses are reproducible from committed artifacts.
- **Transparency:** Keep assumptions and exclusions explicit.
- **Version Control:** Commit all code and documents to Git with descriptive
  messages. Use semantic versioning tags for releases:
  - `vX.Y.Z` for content/feature releases
  - `vX.Y.Z-consistency` for post-release cleanup (version alignment, docs fixes)
  - This creates clear recovery points and documents work progression
- **Documentation:** Maintain a centralized README linking inputs, deliverables,
  and reports.
- **Validation:** Integrate both technical and domain-specific validation for
  each phase.
- **Communication:** Provide concise daily or sprint summaries of progress and
  blockers.

---

## 7. File Naming Standards Across Project Types

This section defines file naming conventions by project type. Consistent naming
enables automated tooling, predictable directory listings, and clear artifact
identification.

**Notebooks (data science projects):**
- Working development: `sYY_dXX_PHASE_description.ipynb` (e.g., `s01_d01_EDA_data_quality.ipynb`)
- Final deliverables: `XX_PHASE_description.ipynb` (e.g., `01_EDA_data_quality_cohort.ipynb`)
- Consolidation occurs in Phase 4 (Sprint 4)

**Source code (application projects):** Follow the language/framework convention
(e.g., `snake_case.py`, `kebab-case.ts`).

**Documents (documentation projects):** `YYYY-MM-DD_{type}-{scope}.md` or
descriptive kebab-case.

See DSM_0.1 for complete naming conventions.

---

## 8. Template Reference and Naming Conventions

This section provides the standard naming convention for project plan files and
the author attribution format.

**Filename Convention:**
`<ProjectName>_ProjectPlan_<Phase>.md`
Example: `GraphExplorer_ProjectPlan_Sprint1.md`

**Author Section:**
```
**Prepared by:** [Your Name]
**Timeline:** [Sprint/Phase/Duration]
**Next Phase:** [Next Planned Stage]
```

---

## 9. Module Dispatch Table for PM Guidelines

DSM_2.0 is structured as this core file plus four on-demand modules. When a task
requires a template, checklist, or protocol from this table, read the
corresponding module file using the Read tool before applying it.

All module files are in the same directory as this core file.

### 9.1. Core Sections (this file)

| § | Section |
|---|---------|
| 1 | Purpose and Scope of PM Guidelines |
| 2 | Project Structure Overview and Core Sections |
| 3 | Technical Prerequisites and Phase Readiness |
| 4 | Recommended Style and Formatting Standards |
| 5 | Example Project Flow and Phasing |
| 6 | Project Management Best Practices |
| 7 | File Naming Standards Across Project Types |
| 8 | Template Reference and Naming Conventions |
| 9 | Module Dispatch Table for PM Guidelines |

### 9.2. Module Contents (on-demand)

| Template / Protocol | Trigger | Module |
|---------------------|---------|--------|
| Template 1: Daily Task Breakdown Format | Planning daily work structure | [A](DSM_2.0.A_Planning_Templates.md) |
| Template 2: Phase Summary Format | End-of-phase reporting | [A](DSM_2.0.A_Planning_Templates.md) |
| Template 3: Expected Outcomes Table Format | Quantifying expected results | [A](DSM_2.0.A_Planning_Templates.md) |
| Template 4: Phase Prerequisites Format | Phase transition readiness | [A](DSM_2.0.A_Planning_Templates.md) |
| Template 5: Daily Checkpoint Framework | Daily review in complex phases | [B](DSM_2.0.B_Advanced_Planning_Framework.md) |
| Template 6: Progressive Expected Outcomes Table | Multi-day progress tracking | [B](DSM_2.0.B_Advanced_Planning_Framework.md) |
| Template 7: MUST/SHOULD/COULD Priority Framework | Structured prioritization | [B](DSM_2.0.B_Advanced_Planning_Framework.md) |
| V2.0 Risk Management and Communication | Enhanced risk tracking | [B](DSM_2.0.B_Advanced_Planning_Framework.md) |
| V2.0 Decision Tree and Best Practices | Choosing v1.0 vs v2.0 planning | [B](DSM_2.0.B_Advanced_Planning_Framework.md) |
| Template 8: Sprint Plan with Cadence Guidance | Sprint-level planning | [C](DSM_2.0.C_Sprint_Assessment_Templates.md) |
| Template 10: End-of-Day Checkpoint Questions | Daily quality gates | [C](DSM_2.0.C_Sprint_Assessment_Templates.md) |
| Template 11: Q&A Preparation Document | Presentation preparation | [C](DSM_2.0.C_Sprint_Assessment_Templates.md) |
| Template 12: Scope Limitations Log | Scope boundary documentation | [C](DSM_2.0.C_Sprint_Assessment_Templates.md) |
| Code Artifact Quality Checklist | Incremental code development | [D](DSM_2.0.D_Quality_Operations.md) |
| Artifact Portability Checklist | Multi-environment artifacts | [D](DSM_2.0.D_Quality_Operations.md) |
| Visualization Quality Checklist | Figure inclusion in deliverables | [D](DSM_2.0.D_Quality_Operations.md) |
| Debugging Log Template | Issues requiring 3+ attempts | [D](DSM_2.0.D_Quality_Operations.md) |
| Scope Review Checkpoint | Project scope expansion | [D](DSM_2.0.D_Quality_Operations.md) |
| Operational Monitoring and Metrics | Resource tracking during sessions | [D](DSM_2.0.D_Quality_Operations.md) |
| Project Change Tracking System | Backlog, changelog, versioning | [D](DSM_2.0.D_Quality_Operations.md) |
