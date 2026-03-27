# DSM_3 Implementation Guide - Module A: Template Examples and Quick Reference

This module provides concrete examples of the Custom Instructions template
(Section 2 in the core document) filled out for each DSM track, along with
a quick reference for common methodology locations, prompts, and troubleshooting.

## Contents

1. [Template Examples by DSM Track](#4-template-examples-by-dsm-track)
2. [Quick Reference for DSM Projects](#5-quick-reference-for-dsm-projects)

---

## 4. Template Examples by DSM Track

These examples show how to fill out the Custom Instructions template for each
DSM track. Domain-specific details (techniques, packages, metrics) belong in
each project's template, not in this guide. The examples below use representative
but intentionally generic projects.

### 4.1. Example: Data Science Project (DSM 1.0)

```markdown
# Project: Regional Demand Forecasting
Domain: Operational Analytics

## Framework Documents
[Standard framework references - see template]

## Project Planning Context

### Scope
- **Purpose**: Forecast weekly demand 4 weeks ahead for resource allocation
- **Resources**: 4 sprints unless specified
- **Success Criteria**:
  - Quantitative: Error metric below agreed threshold on held-out test set
  - Qualitative: Actionable forecasts for operations team
  - Technical: Reproducible pipeline, reasonable runtime

### Data & Dependencies
- **Primary dataset**: 3 years of historical records (~26K rows), relational database
- **Secondary data**: External context data (CSV)
- **Dependencies**: None
- **Data quality**: ~2% missing values from collection gaps, seasonal outliers

### Stakeholders & Governance
- **Primary**: Operations Manager (non-technical), needs accuracy and confidence intervals
- **Secondary**: Engineering team (technical), needs reproducible pipeline
- **Communication**: Per sprint updates, final presentation

## Execution Context

### Timeline & Phases
- **Duration**: 4 sprints
- **Phase 1 - Exploration** (Sprint 1): Distribution analysis, pattern identification, quality assessment
- **Phase 2 - Feature Engineering** (Sprint 2): Derived features, temporal components, external variable integration
- **Phase 3 - Analysis** (Sprint 3): Baseline model, advanced alternatives, cross-validation
- **Phase 4 - Communication** (Sprint 4): Final predictions, documentation, deployment artifacts

### Deliverables
- [ ] Notebooks: 6 (following 4-phase structure)
- [ ] Project plans: Per sprint following PM Guidelines templates
- [ ] Presentation: 15 slides for operations team (non-technical focus)
- [ ] Report: 20 pages technical documentation
- [ ] Other: Deployment-ready prediction function

## Domain Adaptations

### Key Techniques (Reference: Appendix D for domain-specific guidance)
- [List 3-5 techniques specific to your domain and problem type]
- [e.g., cross-validation strategy appropriate for your data structure]
- [e.g., feature selection method suited to your variable types]

### Known Challenges
- Missing values from collection gaps → Imputation strategy appropriate for data type
- Seasonal effects need explicit handling → Calendar-aware feature engineering
- Outliers during unusual periods → Robust preprocessing with documented thresholds

## Advanced Practices

- [x] Experiment Tracking (comparing model variants)
- [x] Performance Baseline (naive reference for comparison)
- [ ] Ethics & Bias Review (activate if applicable)
- [x] Testing Strategy (deployment requires unit tests for prediction function)

## Communication & Style
[Use standard template - no changes needed]

### Language & Formatting
- Primary language: English
- Presentation: English with simplified terminology for stakeholders
- Numbers: US format (1,234.56)
- Dates: YYYY-MM-DD

## Project-Specific Requirements
- Focus on interpretability (stakeholders must understand model behavior)
- Uncertainty quantification critical (confidence intervals mandatory)
- [Add domain-specific constraints here]
```

### 4.2. Example: Application Project (DSM 4.0)

```markdown
# Project: Workflow Insight Engine
Domain: Software Engineering (Application)

## Framework Documents
This project uses:
- **DSM 4.0: Software Engineering Adaptation** (via `@` reference): Adapted phases for SW projects
- **PM Guidelines** (via `@` reference): Sprint planning structure
- **Collaboration Methodology** (via `@` reference): Core philosophy, communication style

## Project Planning Context

### Scope
- **Purpose**: Build a service that processes structured logs and generates actionable reports
- **Resources**: 4 days, solo project
- **Success Criteria**:
  - Functional: End-to-end pipeline works (data -> processing -> report)
  - Code Quality: Modular codebase, type hints, docstrings
  - Testing: Unit tests for core modules, integration test for pipeline
  - Documentation: README with setup instructions, architecture diagram

### Data & Dependencies
- **Primary dataset**: Structured log data (500K+ records)
- **Secondary data**: Configuration metadata
- **Dependencies**: Domain-specific libraries, API clients

### Stakeholders & Governance
- **Primary**: Technical reviewers, need clean code and clear architecture
- **Secondary**: End users, need usable interface and documentation

## Execution Context (DSM 4.0 Adapted Phases)

### Timeline & Phases
- **Duration**: 4 days (1 day per phase)
- **Phase 1 - Data Pipeline** (Day 1): Data loading, validation, schema definition
- **Phase 2 - Core Modules** (Day 2): Service layer, data models, business logic
- **Phase 3 - Integration** (Day 3): Orchestration, evaluation pipeline, testing
- **Phase 4 - Application** (Day 4): User interface, README, architecture docs

### Deliverables
- [ ] Source code: `src/` with modular structure
- [ ] Tests: `tests/` with pytest
- [ ] Demo: Application interface
- [ ] Documentation: README, architecture diagram
- [ ] Decision log: Architectural decisions in `dsm-docs/decisions/`

## Domain Adaptations (DSM 4.0)

### Key Techniques
- [List architectural patterns relevant to your application]
- [e.g., data models for type safety]
- [e.g., provider abstraction for external services]

### Known Challenges
- Multiple external integrations → Abstraction layer with provider registry
- Reproducibility → Configuration management, logging
- [Add domain-specific challenges here]

## Advanced Practices

- [x] Testing Strategy (production-ready code)
- [x] Performance Baseline (reference implementation for comparison)
- [ ] Experiment Tracking (activate if comparing multiple approaches)

## Communication & Style

### Artifact Generation
- Follow DSM 4.0 Module Development Protocol
- Build incrementally: imports -> constants -> one function -> test -> next
- User approves all files via permission window

### Standards
- No emojis
- Use WARNING/OK/ERROR text conventions
- Type hints on public interfaces
- Docstrings for all modules

## Project-Specific Requirements
- Modular design from scratch
- Includes evaluation pipeline
- [Add domain-specific requirements here]
```

### 4.3. Example: Documentation Project (DSM 5.0)

```markdown
# Project: Team Knowledge Base
Domain: Documentation

## Framework Documents
This project uses:
- **DSM 5.0: Documentation Project Adaptation** (via `@` reference): Documentation structure and standards
- **PM Guidelines** (via `@` reference): Sprint planning structure
- **Collaboration Methodology** (via `@` reference): Core philosophy, communication style

## Project Planning Context

### Scope
- **Purpose**: Create a structured, versioned knowledge base for team processes and decisions
- **Resources**: 2 sprints
- **Success Criteria**:
  - Quantitative: All identified topics documented, cross-references resolve
  - Qualitative: New team members can onboard using the knowledge base alone
  - Technical: Consistent structure, version-controlled, searchable

### Data & Dependencies
- **Primary sources**: Existing team wikis, meeting notes, process documents
- **Secondary sources**: Stakeholder interviews, recorded decisions
- **Dependencies**: None
- **Quality considerations**: Outdated content in legacy wikis, inconsistent terminology

### Stakeholders & Governance
- **Primary**: Team leads, need accurate process documentation
- **Secondary**: New hires, need self-service onboarding material
- **Communication**: Weekly review sessions

## Execution Context

### Timeline & Phases
- **Duration**: 2 sprints
- **Phase 1 - Discovery** (Sprint 1): Inventory existing docs, identify gaps, define structure
- **Phase 2 - Writing** (Sprint 1-2): Draft documents following agreed structure
- **Phase 3 - Review** (Sprint 2): Cross-reference validation, stakeholder review
- **Phase 4 - Publication** (Sprint 2): Final edits, versioning, distribution

### Deliverables
- [ ] Documents: Structured markdown files following DSM 5.0 conventions
- [ ] Project plans: Per sprint following PM Guidelines templates
- [ ] Index: Table of contents with cross-references
- [ ] Style guide: Terminology and formatting standards for future authors

## Domain Adaptations

### Key Techniques (Reference: DSM 5.0 for documentation-specific guidance)
- Document structure standard (line budgets, intro paragraphs, file indexes)
- Cross-reference validation
- Terminology consistency checks

### Known Challenges
- Legacy content is scattered → Inventory-first approach, consolidate before restructuring
- Inconsistent terminology → Define glossary early, apply retroactively
- Stakeholder availability for review → Async review with comment deadlines

## Advanced Practices

- [ ] Experiment Tracking (not applicable)
- [ ] Performance Baseline (not applicable)
- [ ] Ethics & Bias Review (not applicable)
- [x] Risk Management (stakeholder alignment, scope creep)

## Communication & Style
[Use standard template - no changes needed]

### Language & Formatting
- Primary language: English
- Target audience: Mixed technical/non-technical
- Dates: YYYY-MM-DD

## Project-Specific Requirements
- All documents must be self-contained (readable without external context)
- Version history required on each document
- [Add domain-specific constraints here]
```

---

## 5. Quick Reference for DSM Projects

This section provides fast lookup tables, common prompts, and troubleshooting
guidance for practitioners who have already read the core document.

### 5.1. Key Methodology Reference Locations

| Need                       | Location                                      | Section         |
| -------------------------- | --------------------------------------------- | --------------- |
| Complete system overview   | `DSM_0.0_START_HERE_Complete_Guide.md`              | All             |
| Environment setup          | Main Methodology                              | Section 2.1     |
| Phase guidance             | Main Methodology                              | Section 2.2-2.5 |
| Phase detailed examples    | Appendix B                                    | All sections    |
| Notebook standards         | Main Methodology                              | Section 3.1     |
| Code quality               | Main Methodology                              | Section 3.2     |
| Decision log framework     | Main Methodology                              | Section 4.1     |
| Advanced practices         | Main Methodology                              | Section 5       |
| Advanced practices details | Appendix C                                    | All sections    |
| Session management         | Main Methodology                              | Section 6.1     |
| File naming standards      | Appendix E                                    | E.11            |
| File naming quick card     | `1.4_File_Naming_Quick_Reference.md`          | All             |
| Domain adaptations         | Appendix D                                    | D.1-D.5         |
| Quick checklists           | Appendix E                                    | E.1-E.10        |
| PM Guidelines templates    | `2_0_ProjectManagement_Guidelines_v2_v1.1.md` | All             |

### 5.2. Common Prompts for First Chat

**Setup & Planning:**
```
"I'm starting a new [domain] project. Please:
1. Review the Complete Getting Started Guide (DSM_0)
2. Review the Collaboration Methodology (core + relevant appendices)
3. Read my Custom Instructions
4. Confirm understanding of our working style
5. Help me create Sprint 1 project plan following PM Guidelines structure"
```

**Domain Extension:**
```
"Based on my project documentation, generate a domain-specific dependency
list that extends the base environment with packages for [your domain]"
```

**Phase Kickoff:**
```
"Starting Phase [X]: [Phase name]. Review methodology Section 2.[X] for
best practices, then help me create [specific deliverable following
methodology standards]."
```

### 5.3. Tips for Successful DSM Adoption

**DO:**
- Start simple (core workflow only, add advanced practices as needed)
- Reference methodology sections (don't duplicate in Custom Instructions)
- Update Custom Instructions as project evolves
- Use file naming conventions from Day 1 (Appendix E.11)
- Create decision log early (track major choices)
- Follow text conventions (WARNING/OK/ERROR, no emojis)

**DON'T:**
- Copy entire methodology sections into Custom Instructions
- Activate all advanced practices immediately
- Skip environment setup (causes issues later)
- Use emojis or special characters in documentation
- Print generic confirmations ("Done!", "Complete!")
- Forget to update Custom Instructions when scope changes

### 5.4. Troubleshooting Common Agent Issues

**Issue:** Agent not following standards
**Solution:** Explicitly reference section numbers: "Follow methodology Section 3.1 notebook standards"

**Issue:** Custom Instructions too long (>8K characters)
**Solution:** Remove methodology content, keep only project-specific details

**Issue:** Lost context between sessions
**Solution:** Create session handoff document (Section 6.1 template), store in `dsm-docs/handoffs/` within the project repository

**Issue:** Unsure which advanced practices to activate
**Solution:** Start with 0-2 practices, add as complexity increases. See Appendix C for guidance.

**For complete troubleshooting guide, see:** `DSM_0.0_START_HERE_Complete_Guide.md` Section 8

---

**Parent document:** `DSM_3.0_Methodology_Implementation_Guide_v1.1.md`
