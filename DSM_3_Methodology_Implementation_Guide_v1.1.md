# Methodology Implementation Guide

**Purpose:** Quick setup guide for new data science projects using an AI agent  
**Version:** 1.3.0
**Last Updated:** 2026-01-22

---

## 1. Overview

### What This Guide Provides

**Complete Custom Instructions Template** for configuring agent projects with:
- Project planning context (scope, stakeholders, timeline)
- Execution standards (notebook format, code quality, communication)
- Domain-specific adaptations
- Advanced practices selection

**Two Complete Examples:**
- Time Series Forecasting (operational predictions)
- NLP Sentiment Analysis (classification with deployment)

### Quick Start (5 Steps)

1. **Read:** `DSM_0_START_HERE_Complete_Guide.md` (system overview)
2. **Create `.claude/CLAUDE.md`** in your project with `@` reference to DSM Custom Instructions
3. **Copy template** (Section 2) → Customize for your project
4. **Add project-specific instructions** after the `@` reference in CLAUDE.md
5. **Start first session** with project plan request

**For system overview, see:** `DSM_0_START_HERE_Complete_Guide.md`

---

## 2. Custom Instructions Template

**Copy this template and customize bracketed sections:**

```markdown
# Project: [PROJECT_NAME]
Domain: [Time Series / NLP / Computer Vision / Clustering / Regression / Classification]

## Framework Documents
This project uses:
- **PM Guidelines** (via `@` reference): Project planning structure and templates
- **Collaboration Methodology v1.3.0** (via `@` reference): Execution workflow with hierarchical numbering
- **Project Reference Documentation** (project-specific): Domain context (create if needed)
- **Complete Getting Started Guide** (via `@` reference): Integrated system overview

## Project Planning Context

### Scope
- **Purpose**: [Main objective and business value in 1-2 sentences]
- **Resources**: [Time: X sprints, Team: Y people, Budget/constraints]
- **Success Criteria**:
  - Quantitative: [Measurable metrics, e.g., "RMSE < 10%", "F1 > 0.85"]
  - Qualitative: [Business alignment, e.g., "Actionable insights for marketing"]
  - Technical: [Reproducibility, documentation quality]

### Data & Dependencies
- **Primary dataset**: [Name, size (rows/GB), source, access method]
- **Secondary data**: [External sources, APIs, if applicable]
- **Dependencies**: [Outputs from prior work, team deliverables]
- **Data quality**: [Known issues: missing values, outliers, bias]

### Stakeholders & Governance
- **Primary**: [Name, role] - needs [information type, e.g., "executive summary"]
- **Secondary**: [Name, role] - needs [information type, e.g., "technical details"]
- **Communication**: [Frequency: per sprint/biweekly, Format: email/Slack/presentation]
- **Governance** (Production only): [Project Lead, Data Owner, RACI matrix if multi-team]

## Execution Context

### Timeline & Phases
- **Duration**: [X sprints total]
- **Phase 1 - Exploration** (Sprint 1): [Specific focus for your domain]
- **Phase 2 - Feature Engineering** (Sprint 2): [Key features to create]
- **Phase 3 - Analysis** (Sprint 3): [Models/algorithms to test - might iterate to phase 2 if major changes are identified]
- **Phase 4 - Communication** (Sprint 4): [Deliverables to produce]

### Deliverables
- [ ] Notebooks: [Number, e.g., "6 notebooks following methodology structure"]
- [ ] Project plans: [Sprint plans following PM Guidelines templates]
- [ ] Presentation: [Slide count, audience, e.g., "15 slides for executives"]
- [ ] Report: [Length, format, e.g., "20-page technical report"]
- [ ] Other: [Code package, API, dashboard, etc.]

## Domain Adaptations

### Key Techniques (Reference: Appendix D for domain-specific guidance)
- [Technique 1 specific to this domain/problem]
- [Technique 2 specific to this domain/problem]
- [Technique 3 specific to this domain/problem]

### Known Challenges
- [Challenge 1] → [Mitigation strategy]
- [Challenge 2] → [Mitigation strategy]

### Solved Challenges (Update as you progress)
- [Challenge X] → [Solution applied]

## Advanced Practices

**Select from Methodology Section 5 (activate as needed):**
- [ ] Experiment Tracking (ML-heavy, comparing >10 model variants)
- [ ] Hypothesis Management (research/academic projects)
- [ ] Performance Baseline & Benchmarking (production benchmarking required)
- [ ] Ethics & Bias Considerations (sensitive data, fairness concerns)
- [ ] Testing Strategy (production deployment, team collaboration)
- [ ] Data Versioning & Lineage (frequent data updates, multiple sources)
- [ ] Technical Debt Register (long-term maintenance, production systems)
- [ ] Scalability Considerations (large datasets >10GB, production deployment)
- [ ] Literature Review Phase (novel domain, research validation)
- [ ] Risk Management (high-stakes decisions, production requirements)

**For implementation details, see:** Appendix C

## Communication & Style

### Artifact Generation
- Ask clarifying questions before generating artifacts
- Confirm understanding: "Confirm that you understand what I need"
- Be concise in work
- Progressive execution: Execute cell-by-cell, each output becomes reference
- ~400 lines per notebook, 5-6 sections
- Follow methodology notebook structure (Section 3.1)
- File naming: See Appendix E.11 for detailed conventions

### Environment Setup
- Run `scripts/setup_base_environment_minimal.py` (academic) or `scripts/setup_base_environment_prod.py` (production)
- Generate domain extensions as needed (see Appendix A for guidance)
- Always resolve paths relative to project root using `.resolve()`
- Document functions with docstrings
- See Methodology Section 2.1 (Environment Setup) for complete guide

### Standards (CRITICAL - Always Follow)

**Text Formatting:**
- Never use emojis (no checkmarks, cross marks, warning symbols, chart symbols, etc.)
- Use plain text: "OK:", "WARNING:", "ERROR:"
- Checkboxes: `[ ]` incomplete, `[x]` complete
- ASCII-only characters in all documentation

**Code Output:**
- Show actual values/metrics (shapes, counts, correlations)
- Avoid generic confirmations: "Complete!", "Done!", "Success!"
- Use: `print(f"Correlation: {value:.3f}")` or `print(df.shape)`
- Avoid: `print("Data loaded successfully!")`

**Print Statement Patterns (See Appendix E.4 for details):**
- Use DataFrame string methods: `print(df.to_string(index=False))`
- Use f-strings for metrics: `print(f"RMSE: {rmse:.4f}")`
- Let pandas/numpy handle formatting

**Notebook Standards:**
- Always precede code cells with markdown description
- Format: "### Section X: [Name]" with 1-2 sentence explanation
- Each code cell must show visible output
- See Methodology Section 3 for complete standards

### Session Management
- Monitor tokens continuously
- Alert at 80% capacity (~160K tokens)
- Provide session summary as Handoff for the following chat if nearing limit
- Reference Methodology Section 6.1 for session handoff templates
- Store handoffs in `docs/handoffs/` within the project repository for continuity
  - **Why**: Keeps session handoffs alongside the project code, accessible via git history

### Language & Formatting
- Primary language: [English / German / Spanish]
- Presentation language: [If different from primary]
- Number format: [1,234.56 or 1.234,56]
- Date format: [YYYY-MM-DD or DD/MM/YYYY]
- Code examples: [Language/framework if specific]

## Project-Specific Requirements
- [Unique constraints: regulatory, compliance, business rules]
- [Required/prohibited tools or libraries]
- [Output format specifications: file types, schemas]
- [Performance requirements: runtime, memory, latency]
- [Privacy/security considerations]
```

---

## 3. Template Usage Guide

### Filling Out the Template

**Project Planning Context:**
- **Purpose:** One clear sentence. Business value first, technical second.
- **Success Criteria:** Be specific. "Improve model" is vague. "RMSE < 10% of baseline" is clear.
- **Stakeholders:** Include communication preferences (technical depth, frequency).

**Execution Context:**
- **Timeline:** Methodology assumes 4-sprint academic project structure unless specified. See DSM_2.0 Template 8 (Sprint Plan with Cadence Guidance) for sprint configuration.
- **Phase Focus:** Customize based on domain (see Appendix D for domain-specific guidance).

**Domain Adaptations:**
- **Key Techniques:** List 3-5 domain-specific methods you'll use.
- **Known Challenges:** Document upfront. Add solutions as you discover them.

**Advanced Practices:**
- Start simple: Check only 2-3 practices initially.
- Add more as project complexity increases.
- Each checked practice has detailed implementation in Appendix C.

**Communication & Style:**
- Keep this section mostly as-is (proven standards).
- Customize language/formatting based on location and audience.

### When to Update Custom Instructions

**During project:**
- Activate new advanced practices (check boxes)
- Add newly discovered challenges and solutions
- Update timeline if scope changes
- Add project-specific requirements as discovered

**Don't update:**
- Core standards (text formatting, notebook structure)
- Methodology references (keep stable)

### What NOT to Include

**Avoid duplicating:**
- Complete methodology content (available via `@` reference, searchable)
- Detailed templates (reference section numbers instead)
- Generic guidance (focus on project-specific only)

**Character limit:** Keep under 8K characters for best performance.

---

## 4. Domain-Specific Examples

### Example 1: Time Series Forecasting

```markdown
# Project: Energy Demand Forecasting
Domain: Time Series Analysis

## Framework Documents
[Standard framework references - see template]

## Project Planning Context

### Scope
- **Purpose**: Forecast daily energy demand 7 days ahead for grid optimization and cost reduction
- **Resources**: 4 sprints unless specified
- **Success Criteria**:
  - Quantitative: MAPE < 8%, MAE < 500 kWh
  - Qualitative: Actionable 7-day forecasts for operations team
  - Technical: Reproducible pipeline, <2hr runtime

### Data & Dependencies
- **Primary dataset**: Historical demand (PostgreSQL), 3 years hourly data (~26K rows)
- **Secondary data**: Weather data (CSV), daily temperature/humidity
- **Dependencies**: None
- **Data quality**: Missing values from sensor failures (known 2% rate), holiday outliers

### Stakeholders & Governance
- **Primary**: Operations Manager (non-technical) - needs forecast accuracy and confidence intervals
- **Secondary**: Engineering team (technical) - needs reproducible pipeline
- **Communication**: Per sprint email updates, final presentation

## Execution Context

### Timeline & Phases
- **Duration**: 4 sprints
- **Phase 1 - Exploration** (Sprint 1): Stationarity tests, seasonality decomposition, trend analysis
- **Phase 2 - Feature Engineering** (Sprint 2): Lag features (1-7 days), rolling stats (7/14/30 day), datetime components (day-of-week, month)
- **Phase 3 - Analysis** (Sprint 3): ARIMA baseline, Prophet seasonal model, LSTM comparison
- **Phase 4 - Communication** (Sprint 4): Multi-step predictions with confidence intervals, deployment function

### Deliverables
- [ ] Notebooks: 6 (following 4-phase structure)
- [ ] Project plans: Per sprint following PM Guidelines v2.0 templates
- [ ] Presentation: 15 slides for operations team (non-technical focus)
- [ ] Report: 20 pages technical documentation
- [ ] Other: Python forecasting function for deployment

## Domain Adaptations

### Key Techniques (See Appendix D.1: Time Series for details)
- Augmented Dickey-Fuller test for stationarity
- ACF/PACF plots for lag selection
- Time-series cross-validation (no shuffling, expanding window)
- Prophet for handling holidays and seasonality
- Multi-step forecasting with uncertainty quantification

### Known Challenges
- Missing values from sensor failures → Forward fill <6hrs, interpolate >6hrs
- Holiday effects need explicit modeling → Use Prophet holiday calendar
- Outliers during extreme weather → Winsorization at 1st/99th percentiles

## Advanced Practices

- [x] Experiment Tracking (comparing ARIMA/Prophet/LSTM variants)
- [x] Performance Baseline (naive forecast: yesterday's demand)
- [ ] Ethics & Bias Review (not applicable - operational data)
- [x] Testing Strategy (deployment requires unit tests for forecast function)

## Communication & Style
[Use standard template - no changes needed]

### Language & Formatting
- Primary language: English
- Presentation: English with simplified terminology for operations
- Numbers: US format (1,234.56)
- Dates: YYYY-MM-DD

## Project-Specific Requirements
- Focus on interpretability (operations team must understand model behavior)
- Uncertainty quantification critical (confidence intervals mandatory for all forecasts)
- Forecast horizon: Exactly 7 days (weekly planning cycle)
```

### Example 2: NLP Sentiment Analysis

```markdown
# Project: Customer Review Sentiment Analysis
Domain: Natural Language Processing (NLP)

## Framework Documents
[Standard framework references - see template]

## Project Planning Context

### Scope
- **Purpose**: Classify product reviews as positive/negative/neutral for marketing insights and product improvement
- **Resources**: 3 sprints, solo project
- **Success Criteria**:
  - Quantitative: F1-score > 0.80 on balanced test set, precision > 0.85 (minimize false positives)
  - Qualitative: Marketing-actionable insights by product category
  - Technical: Inference latency <100ms per review, model explainability

### Data & Dependencies
- **Primary dataset**: 50K product reviews from company database (SQL export to CSV)
- **Secondary data**: Product metadata (IDs, categories, timestamps, star ratings)
- **Dependencies**: None
- **Data quality**: Class imbalance (70% positive, 20% neutral, 10% negative), some multilingual reviews

### Stakeholders & Governance
- **Primary**: Marketing Director (non-technical) - needs aggregate sentiment trends by product
- **Secondary**: Product team (semi-technical) - needs per-product breakdown with examples
- **Communication**: Bi-weekly check-ins, Slack updates for questions

## Execution Context

### Timeline & Phases
- **Duration**: 3 sprints
- **Phase 1 - Exploration** (Sprint 1): Text length distributions, vocabulary analysis, class balance, language detection
- **Phase 2 - Feature Engineering** (Sprint 1-2): Text preprocessing pipeline, TF-IDF vectors, word embeddings, BERT tokenization
- **Phase 3 - Analysis** (Sprint 2-3): Logistic regression baseline, LSTM with embeddings, fine-tuned BERT comparison
- **Phase 4 - Communication** (Sprint 3): Model cards, API design, monitoring recommendations, deployment guide

### Deliverables
- [ ] Notebooks: 6 (EDA, preprocessing, baseline, advanced models, evaluation, deployment prep)
- [ ] Project plans: Per sprint following PM Guidelines v1.0 templates (simple planning sufficient)
- [ ] Presentation: 12 slides for marketing team (business focus, sample predictions)
- [ ] Report: 15 pages with model cards and bias analysis
- [ ] Other: Inference API documentation, preprocessing function package

## Domain Adaptations

### Key Techniques (See Appendix D.2: NLP for details)
- Text preprocessing pipeline (cleaning, tokenization, stopword removal, lemmatization)
- Handling class imbalance (weighted loss functions or SMOTE for minority classes)
- Transfer learning with pre-trained transformers (BERT, RoBERTa)
- Model explainability (SHAP or LIME for prediction interpretation)
- Multi-class evaluation (per-class precision/recall, confusion matrix)

### Known Challenges
- Imbalanced classes (70% positive, 20% neutral, 10% negative) → Weighted loss, stratified sampling
- Sarcasm and nuanced language detection → Focus on clear cases first, flag ambiguous for review
- Multilingual reviews (English + Spanish) → Focus on English subset first (80%), expand if time permits

## Advanced Practices

- [x] Experiment Tracking (comparing TF-IDF/LSTM/BERT architectures and hyperparameters)
- [x] Performance Baseline (majority class predictor, then logistic regression with TF-IDF)
- [x] Ethics & Bias Review (avoid demographic bias in sentiment detection, test on diverse examples)
- [x] Testing Strategy (unit tests for preprocessing, integration tests for end-to-end pipeline)
- [ ] Hypothesis Management (academic rigor not required for business project)

## Communication & Style
[Use standard template - no changes needed]

### Language & Formatting
- Primary: English
- Presentation: Business-friendly language (avoid ML jargon, use examples)
- Include sample predictions with explanations for stakeholder understanding

## Project-Specific Requirements
- Model interpretability needed (SHAP or LIME for explaining individual predictions to product team)
- Inference latency: <100ms per review (real-time application requirement)
- Cannot use customer names or PII in examples (privacy requirement)
- Must handle out-of-vocabulary words gracefully (robust to typos, slang)
- Confidence scores required (flag low-confidence predictions for manual review)
```

---

### Example 3: Software Engineering / ML Application (DSM 4.0)

```markdown
# Project: DevFlow Analyzer
Domain: Software Engineering (ML Application)

## Framework Documents
This project uses:
- **DSM 4.0: Software Engineering Adaptation** (via `@` reference): Adapted phases for SW projects
- **PM Guidelines** (via `@` reference): Sprint planning structure
- **Collaboration Methodology v1.3.0** (via `@` reference): Core philosophy, communication style

## Project Planning Context

### Scope
- **Purpose**: Build an agentic ML system that applies process mining to software development workflows and generates actionable insights via LLM
- **Resources**: 4 days, solo project
- **Success Criteria**:
  - Functional: End-to-end pipeline works (data -> processing -> LLM report)
  - Code Quality: Modular codebase, type hints, docstrings
  - Testing: Unit tests for core modules, integration test for pipeline
  - Documentation: README with setup instructions, architecture diagram

### Data & Dependencies
- **Primary dataset**: TravisTorrent (519K CI builds from Java projects)
- **Secondary data**: Git logs for process mining
- **Dependencies**: PM4Py, LangChain, Anthropic API

### Stakeholders & Governance
- **Primary**: Technical reviewers - need clean code, clear architecture
- **Secondary**: Portfolio audience - need demonstration of ML system design skills

## Execution Context (DSM 4.0 Adapted Phases)

### Timeline & Phases
- **Duration**: 4 days (1 day per phase)
- **Phase 1 - Data Pipeline** (Day 1): PM4Py integration, data loading, validation
- **Phase 2 - Core Modules** (Day 2): LLM provider factory, reporter service, data models
- **Phase 3 - Integration** (Day 3): Agent orchestration, evaluation pipeline, testing
- **Phase 4 - Application** (Day 4): Streamlit demo, README, architecture docs

### Deliverables
- [ ] Source code: `src/` with modular structure
- [ ] Tests: `tests/` with pytest
- [ ] Demo: Streamlit application
- [ ] Documentation: README, architecture diagram
- [ ] Decision log: Architectural decisions in `docs/decisions/`

## Domain Adaptations (DSM 4.0)

### Key Techniques
- Provider-agnostic LLM factory pattern
- Pydantic data models for type safety
- LangChain for prompt management
- MLflow for experiment tracking

### Known Challenges
- Multiple LLM providers -> Factory pattern with AVAILABLE_MODELS registry
- Reproducibility -> Seed control, MLflow logging
- Prompt versioning -> Separate `prompts/` directory

## Advanced Practices

- [x] Testing Strategy (production-ready code)
- [x] Performance Baseline (naive baseline for comparison)
- [ ] Experiment Tracking (activate if comparing multiple approaches)

## Communication & Style

### Artifact Generation
- Follow DSM 4.0 Module Development Protocol
- Build incrementally: imports -> constants -> one function -> test -> next
- User creates all files from provided code segments

### Standards
- No emojis
- Use WARNING/OK/ERROR text conventions
- Type hints on public interfaces
- Docstrings for all modules

## Project-Specific Requirements
- Demonstrates ML system design from scratch
- Shows ability to apply existing models (not training from scratch)
- Includes evaluation pipeline
- Code is in Python with modern frameworks (LangChain, HuggingFace if applicable)
- Agentic patterns for LLM orchestration
```

---

## 5. Quick Reference

### Key Methodology References

| Need                       | Location                                      | Section         |
| -------------------------- | --------------------------------------------- | --------------- |
| Complete system overview   | `0_START_HERE_Complete_Guide.md`              | All             |
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

### Common Prompts for First Chat

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
"Based on my project documentation, generate domain-specific package 
installation script (setup_domain_extensions.py) that extends the base 
environment with packages for [time series/NLP/computer vision/etc.]"
```

**Phase Kickoff:**
```
"Starting Phase [X]: [Phase name]. Review methodology Section 2.[X] for 
best practices, then help me create [specific deliverable following 
methodology standards]."
```

### Tips for Success

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

### Troubleshooting

**Issue:** Agent not following standards  
**Solution:** Explicitly reference section numbers: "Follow methodology Section 3.1 notebook standards"

**Issue:** Custom Instructions too long (>8K characters)  
**Solution:** Remove methodology content, keep only project-specific details

**Issue:** Lost context between sessions
**Solution:** Create session handoff document (Section 6.1 template), store in `docs/handoffs/` within the project repository

**Issue:** Unsure which advanced practices to activate  
**Solution:** Start with 0-2 practices, add as complexity increases. See Appendix C for guidance.

**For complete troubleshooting guide, see:** `0_START_HERE_Complete_Guide.md` Section 8

---

## 6. Project Handover Protocols

DSM uses a hub-and-spoke model, a distribution pattern originating from
transportation logistics and widely adopted in organizational design, where
DSM Central provides governance and spoke projects execute work. This section
covers spoke-to-hub feedback (6.1), hub-to-spoke project kickoff (6.2),
version propagation (6.3), the bidirectional inbox pattern for ongoing
communication (6.4), AI contribution guidelines (6.5), external contribution
governance (6.6), spoke project initialization (6.7), the private project
pattern (6.8), and the standard spoke pattern (6.9).

### Project Participation Patterns

Every DSM project follows one of three participation patterns. The pattern
governs git configuration, communication with DSM Central, and isolation
rules. The DSM track (Notebook, Application, Hybrid, Documentation) is
orthogonal to the pattern: a Standard Spoke can be a Notebook project;
a Private Project can be Documentation. The agent identifies both dimensions
at session start.

| Property | Standard Spoke | External Contribution | Private Project |
|----------|---------------|----------------------|-----------------|
| Git tracking | Remote (GitHub) | Fork of upstream | Local only |
| Registry visibility | DSM_3 Section 7 | DSM_3 Section 7 | Gitignored locally only |
| Inbox direction | Bidirectional | Via governance folder | Receive only |
| Feedback push | Automatic | Via governance folder | Manual (sanitized) |
| README notifications | Yes | No (milestone notifications) | No |
| Cross-repo writes | Yes | Governance folder only | Minimal inbox only |
| CLAUDE.md location | Project `.claude/` | Project `.claude/` (excluded from upstream) | Project `.claude/` |
| Pattern reference | Section 6.9 | Section 6.6 | Section 6.8 |

**When to use each pattern:**
- **Standard Spoke:** New project created under DSM governance, tracked on GitHub, participates fully in the ecosystem feedback loop.
- **External Contribution:** Contributing to an upstream project you do not own; governance artifacts live in DSM Central, not in the external repo.
- **Private Project:** Personal or sensitive work (financial records, medical data, private research) where content must not leave the local machine.

### 6.1. Spoke-to-Hub Feedback Handover

When a spoke project completes, its feedback files need to be reviewed and
integrated into DSM. Use this standardized handover process.

#### 6.1.1. Handover Prompt Template

Copy this prompt and customize the bracketed sections. Use it in a DSM Central
session to trigger feedback review:

```
Review project feedback at ~/[project-name]/docs/feedback/:
- methodology.md ([N] scored entries, avg [X.X]/5, [M] gaps identified)
- backlogs.md ([N] backlog proposals, [M] medium / [L] low priority)

For each backlog proposal in backlogs.md:
- Accept: create BACKLOG-XXX in plan/backlog/improvements/ or developments/
- Reject: note why (already addressed, out of scope, or insufficient evidence)
- Defer: note dependency or prerequisite

For methodology.md scores below 3:
- Assess whether a DSM improvement is warranted
- Cross-reference with existing backlog items to avoid duplicates

Project context: [1-2 sentence summary of project type, duration, and key outcomes]
```

#### 6.1.2. Handover Checklist

Before handing off feedback, verify in the spoke project:

| Check | Description |
|-------|-------------|
| Files exist | `docs/feedback/methodology.md` and `backlogs.md` present |
| Scores complete | All used DSM sections scored (1-5 scale) |
| Proposals structured | Each backlog proposal has Problem, Proposed Solution, Evidence |
| Summary metrics | Entry count, average score, gap count included |
| Blog separated | Blog materials in `docs/blog/`, not in `docs/feedback/` |

#### 6.1.3. DSM Review Process

In the DSM Central session, the review follows this sequence:

1. **Read** all feedback files from the spoke project path
2. **Triage** backlog proposals: accept, reject, or defer each
3. **Create** accepted proposals as BACKLOG-XXX items
4. **Assess** methodology scores below 3 for DSM improvements
5. **Update** CHANGELOG and version if changes were made
6. **Commit** with reference to the source project

Cross-reference: Section 6.4.5 (Project Feedback Deliverables), DSM_0.2 Custom
Instructions (CLAUDE.md Configuration)

### 6.2. Hub-to-Spoke Project Kickoff

When DSM Central initiates a new spoke project, use this standardized kickoff
process. The hub provides governance and direction (scope, scaffolding, research
prompts); the spoke owns execution planning (sprint plans, daily work).

Principle: the entity that knows the standard should create the initial structure.

#### 6.2.1. Preliminary Scope Template

Create this in the DSM Central session before handing off to the spoke:

```
# [Project Name] - Preliminary Scope

## Goals
- [Primary objective]
- [Secondary objectives]

## Success Criteria
- Quantitative: [measurable targets]
- Qualitative: [quality standards]
- Technical: [technical requirements]

## Constraints and Dependencies
- Timeline: [estimated duration, sprint count]
- Time budget: [available hours per deliverable; forces realistic scoping]
- Data: [data sources, access requirements]
- Technical: [required libraries, APIs, infrastructure]

## DSM Track
- [ ] Notebook (DSM 1.0)
- [ ] Application (DSM 4.0)
- [ ] Hybrid (DSM 1.0 + 4.0)

## Phase 0.5 Research (if applicable)
- Research questions: [what needs investigation before sprint planning]
- Expected deliverable: docs/research/{topic}_research.md
- Skip criteria: [why research may not be needed]

## Protocols to Reinforce in CLAUDE.md
- [ ] Notebook Collaboration Protocol (DSM 1.0/Hybrid)
- [ ] App Development Protocol (DSM 4.0)
- [ ] Pre-Generation Brief Protocol (all)
- [ ] [Project-specific protocols]
```

#### 6.2.2. Scaffolding Checklist

The hub creates these artifacts before the spoke session begins:

| Artifact | Location | Notes |
|----------|----------|-------|
| CLAUDE.md | `.claude/CLAUDE.md` | With `@` reference to DSM_0.2 and protocol reinforcement |
| Feedback files | `docs/feedback/` | `methodology.md` and `backlogs.md` (2 files) |
| Decision log | `docs/decisions/` | Initialized with DEC-000 template |
| Blog directory | `docs/blog/` | Empty directory for sprint journal entries |
| Research directory | `docs/research/` | If Phase 0.5 applies |
| Sprint plan location | `docs/plans/` | Directory ready for spoke to create sprint plan |
| Inbox directory | `_inbox/` | For hub-to-spoke action items (see Section 6.4) |
| Handoffs directory | `docs/handoffs/` | Session continuity documents |
| Checkpoints directory | `docs/checkpoints/` | Milestone snapshots |

Use canonical folder names from DSM_0.1. Before creating any folder, check if a
similar folder already exists (e.g., `plan/` when creating `plans/`) to avoid
duplicates.

Cross-reference: Gateway 1 criteria (DSM_1.0 Section 6.5.2) for validation.

#### 6.2.3. Kickoff Prompt Template

Use this prompt to start the spoke project's first session:

```
This is a new DSM project. Preliminary scope and scaffolding have been
prepared by DSM Central.

Read the CLAUDE.md for project configuration and protocol reinforcement.

Preliminary scope: [path or inline summary]

Phase 0.5 research questions (if applicable):
- [question 1]
- [question 2]

First task: [Phase 0.5 research | Sprint 1 planning | specific starting point]

Governance notes:
- Feedback files initialized in docs/feedback/ (methodology.md, backlogs.md)
- Blog materials go in docs/blog/ (not docs/feedback/)
- Decision log initialized in docs/decisions/
- Sprint boundary checklist: checkpoint, feedback, decision log, blog entry, README
```

### 6.3. DSM Version Propagation

Spoke projects inherit DSM protocols through the `@DSM_0.2` reference in their
CLAUDE.md. When DSM Central is updated, spoke agents detect changes through two
mechanisms:

**Immediate detection (session start):** The version header at the top of DSM_0.2
is visible to agents via the `@` reference. Agents compare it against the version
recorded in their most recent handoff document.

**Handoff tracking (session end):** Each handoff records the DSM version active
during that session (DSM_1.0 Section 6.1.2 template). This creates a version trail
that the next session can reference.

**When versions differ:** The agent notes the delta, checks the DSM CHANGELOG for
relevant changes, and applies updated protocols. No manual spoke CLAUDE.md updates
are needed; the `@` reference always reads the latest DSM_0.2.

Cross-reference: DSM_0.2 (Session-Start Version Check), DSM_1.0 Section 6.1.2
(Handoff Template)

### 6.4. Bidirectional Project Inbox

Sections 6.1 and 6.2 handle batch handovers (project end feedback, project start
kickoff). The inbox pattern handles ongoing communication between hub and spoke
during active work, with a defined lifecycle: write, process, remove.

#### 6.4.1. Architecture

**Hub inbox** (`_inbox/` at project root in DSM Central):
- One file per spoke project: `{project-name}.md`
- Contains entries pushed by spokes when observations are ripe
- Hub processes entries at session start, then removes them

**Spoke inbox** (`_inbox/` at project root in spoke projects):
- Single file: `from-hub.md`
- Contains action items, notifications, or guidance from DSM Central
- Spoke processes entries at session start, then removes them

**Relationship to feedback files:** Spoke `docs/feedback/` files (backlogs.md,
methodology.md) remain as a drafting space where observations accumulate over
multiple sessions. The inbox handles entries that are ripe and need attention.
Feedback files are for collecting; the inbox is for transmitting.

#### 6.4.2. Entry Format

Each inbox entry uses this structure:

```markdown
### [YYYY-MM-DD] Entry title

**Type:** Backlog Proposal | Methodology Observation | Action Item | Notification
**Priority:** High | Medium | Low
**Source:** [project name or "DSM Central"]

[Description: problem statement, proposed solution, or action requested]
```

#### 6.4.3. Lifecycle

The inbox is a transit point, not a permanent record. Entries are written,
processed, and removed:

1. **Write:** Author creates an entry in the target inbox file
2. **Surface:** At session start, the agent reads inbox and presents pending entries
3. **Process:** For each entry, take action:
   - Backlog Proposal: create BACKLOG-XXX item (accept), note reason (reject/defer)
   - Methodology Observation: assess, create improvement if warranted
   - Action Item: implement, defer with rationale, or reject with reason
   - Notification: acknowledge and apply
4. **Remove:** Delete processed entries from the inbox file

Permanent records of processing outcomes live in the backlog system, CHANGELOG,
and decision logs, not in the inbox.

#### 6.4.4. Spoke-to-Hub Flow

**When to push (ripe criteria):**
- Backlog proposals: has Problem, Proposed Solution, and Evidence sections
- Methodology feedback: concrete gap identified with score and context
- Cross-project observation: pattern or issue that affects multiple projects

**Pushing process:**
1. At session end, review `docs/feedback/` for ripe entries
2. Copy ripe entries to DSM Central's `_inbox/{project-name}.md`
3. Remove or mark the source entry in `docs/feedback/` as "Pushed to hub"

**Hub processing:**
1. At session start, check `_inbox/` for unprocessed files
2. For each entry, read the source spoke's `docs/feedback/` files (methodology.md,
   backlogs.md) to extract full context; the inbox entry is a summary, the feedback
   file has the detailed rationale and evidence
3. Process each entry per Section 6.4.3 using the full context
4. Clear processed entries from inbox

#### 6.4.5. Hub-to-Spoke Flow

**When to send:**
- DSM protocol changes that require spoke action
- Requested improvements or fixes for a specific project
- Feedback on spoke's proposals (accept/reject/defer decisions)

**Sending process:**
1. Write entry to spoke's `_inbox/from-hub.md`
2. Entry is surfaced at spoke's next session start

**Spoke processing:**
1. At session start, check `_inbox/from-hub.md`
2. Process each entry per Section 6.4.3
3. Clear processed entries

#### Anti-Patterns

**DO NOT:**
- Use the inbox as a drafting space; draft in `docs/feedback/`, push when ripe
- Leave processed entries in the inbox; the inbox is a transit point, not an archive
- Push entries without the required structure (type, priority, description); unstructured entries cannot be triaged
- Skip surfacing inbox entries at session start; unseen entries defeat the purpose

Cross-reference: Section 6.1 (Spoke-to-Hub Feedback), Section 6.2 (Hub-to-Spoke
Kickoff), DSM_0.2 (Feedback Tracking, Session-Start Version Check)

#### 6.4.6. Breaking Change Notification

When DSM_0.2 introduces a breaking change (new mandatory protocol, modified protocol
behavior, or removed protocol), DSM Central uses the Hub-to-Spoke Flow (6.4.5) to
notify all affected projects. This subsection defines the spoke-side handling.

**Spoke action on receiving a breaking change notification:**

1. Read the notification to understand what changed
2. Update the Protocol Applicability table in `.claude/CLAUDE.md`:
   - Add the new protocol with `Yes`, `No`, or `Partially` and a rationale
   - If the protocol does not apply, document why (e.g., "No notebooks in this project")
3. Delete the inbox entry after updating the table

**Grace period enforcement (agent behavior):**

The Session-Start Version Check (DSM_0.2) detects version changes between sessions.
When a version change includes a breaking change and the spoke's Protocol Applicability
table has not been updated, the agent must:

1. Identify protocols added or modified in the version gap (from CHANGELOG)
2. Check whether each protocol appears in the spoke's Protocol Applicability table
3. For any missing protocol, surface the gap to the user before executing:
   "Protocol {name} was added/modified in vX.Y.Z but is not listed in your Protocol
   Applicability table. Apply, skip, or defer?"
4. Record the user's decision in the session transcript
5. Never execute an unlisted protocol silently

**Why this matters:** Without this gate, new protocols run in spoke projects without
the human having declared whether they apply. This violates the principle that the
human understands first, reviews second, approves third (DSM_6.0 Principle 1).

**Anti-Patterns:**

**DO NOT:**
- Execute a new protocol in a spoke without checking the Protocol Applicability table
- Assume all DSM protocols apply to all projects; each spoke declares applicability
- Skip the notification because "the spoke will see the version change anyway"; the
  notification provides context the CHANGELOG alone may not convey

### 6.5. External Project AI Contribution Guidelines

Open-source projects increasingly receive AI-assisted contributions, but most lack
guidelines for how these should be handled. Some projects ban AI contributions
entirely, others accept them with disclosure requirements, most have no policy at
all. DSM agents encounter this gap during external contributions (see BACKLOG-069,
BACKLOG-094) and can help projects define their own guidelines using this template.

This section provides a reusable template, not a prescriptive policy. The project's
governance model, community norms, and maintainer preferences determine where on
the policy spectrum the guidelines should land.

#### 6.5.1. The Policy Spectrum

Five positions observed in published policies, from most permissive to most
restrictive:

| Position | Example | Key Trait |
|----------|---------|-----------|
| Full embrace | [ClickHouse](https://github.com/ClickHouse/ClickHouse/blob/master/AI_POLICY.md) | AI welcome, no disclosure required, contributor takes full responsibility |
| Disclosure | Linux Kernel (mailing list discussions) | AI-assisted code accepted with `Co-developed-by:` trailer, contributor signs off |
| Proportional | Red Hat (internal guidelines, blog post) | Trivial AI use (autocomplete): no disclosure; substantial use: must be marked |
| Strict | [Ghostty](https://github.com/ghostty-org/ghostty/blob/main/AI_POLICY.md) | Mandatory disclosure (tool + extent), accepted issues only, human testing required |
| Ban | QEMU (mailing list discussion) | AI-generated code cannot satisfy DCO, full prohibition |

These are reference points, not the only options. Most projects will land between
positions. Use this spectrum to calibrate the template sections below.

#### 6.5.2. Guidelines Template

A reusable 6-section structure. Each section addresses a dimension that every
published policy, regardless of strictness, covers.

**Section 1: Philosophy**

*Question answered:* What is this project's stance on AI-assisted contributions?

Connect to the project's existing values (lean software, code quality, community
culture). This section sets the tone for everything that follows.

| Permissive | "AI is a normal developer's tool, similar to an IDE or a keyboard. We welcome its use." |
|------------|-----------------------------------------------------------------------------------------|
| Strict | "We welcome AI as a tool, but require transparency due to quality concerns from unqualified use." |

**Section 2: Scope**

*Question answered:* What types of contributions are covered?

Define which contribution types the guidelines apply to: code, documentation,
tests, issues, discussions, media. Some policies cover all artifacts; others
focus on code only.

**Section 3: Disclosure**

*Question answered:* Must AI usage be disclosed? How?

| Approach | Mechanism |
|----------|-----------|
| Not required | No special disclosure (ClickHouse position) |
| Encouraged | PR description note, optional (contributor decides) |
| Required | Commit message tag, PR body section, or both (Ghostty, LLVM position) |

Specify the preferred mechanism: commit trailer (`Co-developed-by:`), PR body
section, checkbox in PR template, or other project-specific convention.

**Section 4: Quality Standards**

*Question answered:* What review expectations apply to AI-assisted contributions?

Common minimum: contributor must understand and be able to explain all submitted
code without referencing AI. This is the "human-in-the-loop" standard from LLVM.
Stricter policies add: human testing required, no AI-generated media, higher
review scrutiny.

**Section 5: Contributor Responsibility**

*Question answered:* Who is accountable for AI-generated code?

Universal answer across all published policies: the contributor who submits the
code takes full responsibility, regardless of how it was generated. This section
makes that explicit for the project.

**Section 6: Enforcement**

*Question answered:* What happens when guidelines are violated?

| Severity | Response |
|----------|----------|
| Graduated | Warning, then PR closure, then ban (most common) |
| Immediate | PR closed on first violation (Ghostty for undisclosed AI) |
| Informal | Reputation-based ("it may negatively affect your reputation as an engineer") |

#### 6.5.3. Optional Extensions

For projects with stricter requirements, add these sections as needed:

| Extension | When to add | Example |
|-----------|-------------|---------|
| Eligible contributions | Project receives many drive-by PRs | "AI PRs only for accepted issues" (Ghostty) |
| Verification requirements | Safety-critical or complex codebase | "Must be verified with human testing" |
| Media restrictions | Project includes visual/audio assets | "No AI-generated media" |
| Maintainer exemptions | Trusted contributors have different workflow | "Maintainers are exempt from disclosure" |
| Tooling restrictions | Specific tools raise concerns | "Only tools that respect project license" |

#### 6.5.4. Adaptation Process

When a DSM agent helps an external project create AI contribution guidelines:

1. **Assess project character:** Examine governance model (BDFL, committee,
   foundation), community size, license type (permissive licenses have lower
   legal risk than copyleft + DCO), and existing contribution norms
2. **Map to spectrum position:** Use Section 6.5.1 to identify the closest
   reference point based on the project's character assessment
3. **Fill template sections:** Calibrate each section (6.5.2) to the mapped
   position; use the permissive/strict language examples as starting points
4. **Reference project-specific precedents:** Look for existing PRs with AI
   disclosure, maintainer statements about AI, or community discussions that
   reveal the project's implicit norms
5. **Present draft to maintainers:** The guidelines belong to the project, not
   to DSM. Present as a suggestion for the project to own and adapt

#### Legal Context

License type affects AI contribution risk:

| License Type | Risk Level | Reason |
|-------------|------------|--------|
| MIT / Apache-2.0 | Lower | Permissive, attribution-based, no copyleft |
| GPL / AGPL | Higher | Copyleft + DCO requirements may conflict with AI generation |
| BSD | Lower | Similar to MIT |

No court has ruled definitively on AI-generated code and OSS licenses. The
practical consensus: contributors take responsibility regardless of generation
method, and standard copyright rules apply equally to AI-generated and manual code.

#### Anti-Patterns

**DO NOT:**
- Impose DSM's preferences on the project; the project's governance model determines the position on the spectrum
- Skip the spectrum assessment; a strict template for a permissive project wastes maintainer time, and a permissive template for a strict project undermines trust
- Create guidelines without reviewing existing project norms and precedents (PRs, maintainer statements, community discussions)
- Present guidelines as final; they are a draft for the project to own and iterate on

Cross-reference: BACKLOG-094 (External Contribution Onboarding Pattern), BACKLOG-069
(External Contribution Governance Structure), DSM_0.2 (Session-Start Inbox Check for
AI policy detection)

Research basis: `docs/research/done/2026-02-13_backlog-096-ai-contribution-guidelines-research.md`
(7 policies mapped, legal analysis, ecosystem data, full source list)

### 6.6. External Contribution Governance

Sections 6.1-6.4 govern spoke projects the contributor owns. This section governs
contributions to repositories owned by others: fork model, pull requests to upstream
maintainers. The contributor does not control the repository, cannot commit governance
artifacts there, and must adapt to the upstream project's conventions and review cycles.

Section 6.5 provides a template the target project itself can adopt for AI guidelines.
This section governs the contributor's side: where to keep governance artifacts, what
checks to perform, and how feedback flows back to DSM.

#### 6.6.1. When to Use

Apply this section when all of the following are true:

- The target repository is owned by someone else (not the contributor)
- Contributions go through a fork-and-PR workflow
- DSM governance artifacts (feedback, decisions, plans) cannot live in the target repo
- The contributor follows DSM methodology for their own workflow

#### 6.6.2. Governance Artifact Location

All DSM governance artifacts for external contributions live in the governance
storage repo at `{contributions-docs-path}/{project-name}/` (resolved from the
Ecosystem Path Registry), not in the external repository:

```
{contributions-docs-path}/{project-name}/
  _inbox/          # Hub-spoke communication (Section 6.4 pattern)
  _references/     # Upstream docs, architecture notes, API references
  backlog/         # Contribution-specific backlog items
  blog/            # Blog journal entries and materials
  checkpoints/     # Milestone snapshots
  decisions/       # Design decisions log
  feedback/        # methodology.md, backlogs.md (DSM feedback)
  handoffs/        # Session handoff documents
  plan/            # Contribution plans and scope documents
  research/        # Phase 0.5 research (upstream analysis, gap studies)
  README.md        # Project overview, status, and contribution roadmap
```

This structure mirrors the spoke project `docs/` layout (DSM_0.1) but is stored
externally because the external repo is not ours to modify. The path is resolved
from the Ecosystem Path Registry (`contributions-docs` logical name).

#### 6.6.3. Key Differences from Spoke Projects

| Aspect | Spoke Project | External Contribution |
|--------|--------------|----------------------|
| Repo ownership | Contributor owns | Upstream maintainer owns |
| Governance artifacts | In project `docs/` | In `{contributions-docs-path}/` |
| Scaffolding | Hub creates `docs/` structure | Project already exists; no scaffolding |
| Sprint cadence | Contributor-defined | Upstream review cycles dictate pace |
| Feedback cadence | Sprint boundaries | Contribution milestones (PR merged, issue resolved) |
| Commit authorship | Per project CLAUDE.md policy | Must follow upstream conventions |
| CLAUDE.md location | `.claude/CLAUDE.md` (committed or gitignored) | `.claude/CLAUDE.md` (excluded via `.git/info/exclude`) |
| DSM visibility | DSM references may appear in project | No DSM references in the external repo |

#### 6.6.4. Mandatory Checks

**Step zero: AI policy check.** Before any technical work on a new external project,
determine the project's stance on AI-assisted contributions. Use the policy spectrum
in Section 6.5.1 to map the project's position. Check for:

- Published AI policy (e.g., `AI_POLICY.md`, `CONTRIBUTING.md` section)
- Maintainer statements in PRs, issues, or discussions
- Community norms (existing AI-disclosed PRs and their reception)

If no policy exists, apply the **human-in-the-loop standard** by default: the
contributor must understand and be able to explain all submitted code without
referencing AI assistance.

**Upstream precedence rule:** If the target project establishes an AI disclosure
policy at any point, it takes precedence over the contributor's preferences. This
includes commit attribution, disclosure requirements, and any restrictions on
AI-generated content. The contributor adapts, not the project.

#### 6.6.5. CLAUDE.md Pattern for External Projects

External projects require a local `.claude/CLAUDE.md` for the agent to follow DSM
protocols, but this file must not appear in commits or pull requests. The file is
created locally and excluded via `.git/info/exclude` (not `.gitignore`, which would
be committed).

**Why protocol filtering matters:** Not all DSM_0.2 sections apply to external
contributions. The IronCalc protocol analysis (R1) found only ~3 of 13 sections
apply directly; the rest need adaptation or do not apply. The CLAUDE.md must
specify which protocols apply and which are filtered out.

See **Section 6.6.8** for the complete CLAUDE.md template, kickoff prompt template,
and setup checklist.

#### 6.6.6. Feedback Cadence

Contribution milestones replace sprint boundaries as feedback triggers:

| Milestone | Feedback Action |
|-----------|----------------|
| PR submitted | Note approach, design decisions, observations |
| PR reviewed (changes requested) | Record reviewer feedback, adapt approach |
| PR merged | Update methodology.md scores, note what worked |
| Issue resolved | Record contribution impact and lessons |
| Review cycle complete | Push ripe entries to DSM Central inbox |

Feedback files use the same structure as spoke projects (methodology.md, backlogs.md)
but are located in `{contributions-docs-path}/{project}/feedback/`.

#### 6.6.7. Onboarding Lifecycle

External contributions follow a three-phase progression that builds understanding
incrementally while producing value at each stage.

**Phase 1: Opportunity Research**

Before writing any code, understand the project and map contribution opportunities:

- Explore the project's philosophy, mission, architecture, and contribution norms
- Identify where the contributor's skills align with project needs (not just open issues)
- Check AI policy (Section 6.6.4) and contribution requirements
- Deliverable: **Contribution Scope Plan** in `{contributions-docs-path}/{project}/plan/`

This follows the Phase 0.5 research pattern (DSM_0.2): stated question, research,
validation gate. The question is "where can I contribute most effectively?"

**Contribution Scope Plan Template:**

```markdown
# Contribution Scope Plan - {Project}

**Date:** YYYY-MM-DD
**Contributor Profile:** {Summary of relevant skills and domain expertise}
**Project Overview:** {One-line description of the project and its mission}

---

## {Domain Area 1} ({path or component})

### Current State
- {What exists: file count, function count, coverage level}

### Gaps
- {What is missing, broken, or incomplete}

### Opportunities

| ID | Description | Difficulty | Value |
|----|-------------|------------|-------|
| {A1} | {Specific opportunity} | Green/Yellow/Red | High/Medium/Low |

---

## {Domain Area N}
{Repeat Current State / Gaps / Opportunities for each relevant area}

---

## Ranked Opportunities

### Immediate (Green, 1-2 weeks)
1. **{ID}**: {Description} - {Why this is a good starting point}

### Short-Term (Yellow, 2-4 weeks)
2. **{ID}**: {Description} - {What skills are needed}

### Long-Term (Red, requires discussion)
3. **{ID}**: {Description} - {Why maintainer input is needed}
```

**Portfolio-to-Opportunity Mapping:**

The Scope Plan maps contributor skills to project domains, not just open issues.
Assess each opportunity along two dimensions:

- **Difficulty tier:** Green (follows existing patterns, low risk), Yellow (moderate
  complexity or unfamiliar tooling), Red (requires architectural discussion with
  maintainer). Tier reflects the contributor's current skill level, not absolute
  difficulty.
- **Value assessment:** High when the contributor has domain expertise the project
  team lacks (e.g., statistical knowledge for a spreadsheet engine). Medium for
  general improvements. Low for cosmetic or optional enhancements.

Prioritize opportunities where high contributor expertise meets high project need;
these produce the most value with the least friction.

**Value-Add Identification:**

Look beyond open issues. The most impactful contributions often address needs the
project team has not yet articulated:

- Missing functionality that domain expertise reveals (functions, algorithms, edge cases)
- Test gaps that only show up with domain-specific test data (e.g., NIST reference datasets)
- Documentation that requires specialist knowledge to write accurately
- Cross-reference the project's roadmap and discussions to align value-add proposals
  with the project's direction

Reference implementation: `{contributions-docs-path}/IronCalc/plan/value-add-opportunities.md`

**Phase 2: Onboarding**

Build trust through small, high-quality contributions:

- Start with low-hanging fruit: documentation fixes, test additions, small bug fixes
- Learn the project's review process, coding conventions, and communication norms
- Collect feedback on contribution style and quality
- Deliverable: first merged contributions, lessons learned documented

**Phase 3: Deepening**

Increase contribution complexity based on earlier feedback:

- Feedback from Phases 1-2 informs which deeper contributions to pursue
- Understanding of project philosophy enables contributions that align with direction
- Deliverable: substantial contributions, potential for ongoing collaboration

**Phase Transitions**

| Transition | Validation Criteria |
|------------|-------------------|
| Phase 1 → 2 | Opportunity map reviewed, initial contribution targets selected, AI policy checked |
| Phase 2 → 3 | At least one contribution merged, conventions understood, reviewer feedback positive |

Do not skip phases. A contributor who jumps to Phase 3 without Phase 1 research
misaligns contributions with project needs; a contributor who skips Phase 2 produces
work that doesn't match project conventions.

**PR Size Guidance (Match the Room)**

External contributions must match the upstream project's review culture. Oversized PRs
burden maintainers and delay review; undersized PRs fragment context. The right size is
whatever the maintainer can review with substance (DSM_6.0 Principle 1: Take a Bite;
Principle 6: Match the Room).

| Project Signal | Typical PR Size | Contributor Target |
|----------------|----------------|-------------------|
| Small PRs in merge history (30-60 lines) | Micro | Match: one function, one test, one doc section per PR |
| Medium PRs (100-300 lines) | Standard | Keep under 300 lines; split if larger |
| Large PRs accepted (500+ lines) | Liberal | Still prefer smaller; split when natural boundaries exist |
| No clear pattern | Unknown | Default to small PRs until feedback calibrates expectations |

**How to calibrate:**
1. During Phase 1 research, review the project's recent merged PRs (last 20-30)
2. Note the median line count, number of files, and review turnaround time
3. Record findings in the Contribution Scope Plan
4. Use this as the target for your own PRs

**Anti-Patterns:**

**DO NOT:**
- Submit a 500-line PR to a project with a 50-line PR culture; split into smaller PRs
- Assume your internal session output maps 1:1 to a PR; a session may produce work for
  multiple PRs or a PR may span multiple sessions
- Treat PR size guidance as absolute; maintainer feedback overrides any heuristic

#### 6.6.8. External Contribution Templates

These templates support the onboarding lifecycle (Section 6.6.7) and governance
structure (Section 6.6.2). Copy, fill in project-specific sections, and customize.

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
| `{contributions-docs-path}/{project}/feedback/` | Methodology and backlog feedback |
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

The checklist is organized into four phases. Complete each phase before
moving to the next.

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
| 12 | Scaffold governance directory structure | Governance folder | See directory list below |
| 13 | Add project to ecosystem path registry | `.claude/dsm-ecosystem.md` | DSM_0.2 Ecosystem Path Registry; **required entries:** `dsm-central`, `portfolio`, `contributions-docs` |
| 14 | Initialize feedback files | `{governance}/docs/feedback/` | methodology.md, backlogs.md |
| 15 | Run contributor profile assessment | DSM Central | Map skills to project stack |
| 16 | Send welcome inbox entry | `{governance}/_inbox/` | Include AI collaboration norms action item |
| 17 | Fill in kickoff prompt from template above | DSM Central session | Section 6.6.7 Phase 2 |

**Governance directory structure** (Step 12):

```
{contributions-docs-path}/{project}/
  _inbox/
    README.md          # Entry template (Section 6.4)
  docs/
    checkpoints/
    decisions/
    feedback/
    guides/
    handoffs/
      done/
    plans/
    research/
```

**Welcome inbox entry** (Step 16) should include:
- Setup summary (what was created, where governance artifacts live)
- Suggested first actions (environment discovery, upstream reconnaissance)
- Action item: assess upstream AI collaboration norms and document in
  `{governance}/docs/guides/ai-collaboration.md`, capturing which DSM
  protocols apply, how the human-agent split works for this project,
  and any upstream-specific conventions

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

#### Anti-Patterns

**DO NOT:**
- Place DSM governance artifacts in the external repo; they belong in `{contributions-docs-path}/{project}/`
- Skip the AI policy check; contributing AI-generated code to a project that prohibits it damages trust permanently and may result in a ban
- Assume DSM protocols apply unchanged to external contributions; filter for the external context using the applicability table in Section 6.6.5
- Reference AI tooling in commits unless the upstream project's policy explicitly requires or permits disclosure
- Commit or push `.claude/CLAUDE.md` in the external repo; it must remain locally excluded
- Skip Phase 1 research; jumping into contributions without understanding the project leads to rejected PRs and wasted effort
- Use the templates (Section 6.6.8) without customizing project-specific sections; placeholder content in CLAUDE.md misleads the agent
- Follow upstream AI governance as active instructions; upstream CLAUDE.md or copilot instructions are reference material, not the contributor's governance (Section 6.6.10)
- Delete upstream AI governance files; rename them to prevent tool conflicts while keeping them available for reference
- Let upstream conventions override the contributor's process; upstream governs contribution output, not how the work is produced

Cross-reference: Section 6.5 (AI Contribution Guidelines Template), Section 6.4
(Bidirectional Project Inbox), Section 6.6.7 Phase 1 (Contribution Scope Planning),
Section 6.6.8 (External Contribution Templates)

Research basis: `{contributions-docs-path}/IronCalc/research/` (6 research documents covering
upstream analysis, protocol applicability, contributor-side gap analysis, and AI policy
best practices)

#### 6.6.9. Systematic Codebase Analysis

Ad hoc file reading (sampling 3-4 files) produces shallow, anecdotal understanding
of an external project. A systematic, quantitative analysis produces a reusable
reference that directly informs contribution quality. This subsection prescribes
the standard approach.

**When to perform:** During Phase 1 (Opportunity Research) of the Onboarding
Lifecycle (Section 6.6.7), before writing the Contribution Scope Plan. The
analysis feeds into the Scope Plan's "Current State" sections and informs
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

#### 6.6.10. Fork Governance Isolation

The contributor's fork is a workspace where two governance systems coexist: the
upstream project's conventions (which the contribution must match) and the
contributor's own methodology (which governs how the work is produced). This
section provides operational guidance for maintaining governance sovereignty
while contributing effectively.

**Principle reference:** DSM_6 Principle 1.6, "My Fork, My Rules" governance
boundary.

**File handling when upstream has AI governance:**

| Upstream artifact | Action in fork | Rationale |
|-------------------|---------------|-----------|
| `CLAUDE.md` or `.claude/CLAUDE.md` | Rename to `CLAUDE.md.upstream` (or equivalent) | Prevents tool conflict; both files load if co-located |
| `.github/copilot-instructions.md` | Leave in place (does not conflict with Claude) | Different tool, no collision |
| `AI_POLICY.md`, `CONTRIBUTING.md` AI section | Leave in place; reference in your CLAUDE.md | Policy documents, not tool configuration |
| `.cursorrules`, `.windsurfrules` | Leave in place (does not conflict with Claude) | Different tool, no collision |

**Rename, not delete:** The upstream's AI governance file is renamed, not
removed. Deletion would create a diff that appears in PRs. Renaming keeps the
file locally accessible for reference while preventing tool conflicts. The
renamed file should be added to `.git/info/exclude` to avoid accidental commits.

**Governance layers:**

```
Fork workspace
├── .claude/CLAUDE.md          ← Contributor's governance (DSM, excluded via .git/info/exclude)
├── CLAUDE.md.upstream         ← Upstream's AI governance (renamed, excluded)
├── .git/info/exclude          ← Excludes both from commits
└── [project files]            ← Contributions match upstream conventions
```

**Conflict resolution:** When the contributor's methodology and upstream
conventions disagree on a specific practice (e.g., test structure, documentation
format, commit message style), upstream conventions win for the contribution
itself. The contributor's methodology governs the process (how to research, plan,
review) but not the output format. This is Match the Room applied to governance.

**Session-start awareness:** When starting a session in an external contribution
project, the agent should note the governance boundary in the session transcript:
"External contribution project. Contributor governance (DSM) is active; upstream
conventions govern contribution output." This makes the dual-governance context
explicit for every session.

**Evidence:** Reclaim Launcher (Sessions 82-89) validated this pattern. The
project had a pre-existing `CLAUDE.md` from the upstream maintainer. The
contributor renamed it to `CLAUDE.md.upstream`, created a DSM-governed
`.claude/CLAUDE.md`, and excluded both from commits via `.git/info/exclude`.
All 3 PRs merged with no governance artifacts leaking into upstream.

---

### 6.7. Spoke Project Initialization Checklist

When initializing a new DSM spoke project, follow this mechanical checklist.
Section 6.2 covers what the hub prepares (preliminary scope, scaffolding
artifacts, kickoff prompt); this section covers the spoke-side setup that
creates a fully functional DSM project ready for its first working session.

For external contribution projects (repos you don't own), use Section 6.6.8
instead. That checklist handles fork setup, governance separation, and
upstream-specific concerns.

#### Prerequisites

- Preliminary scope exists (created per Section 6.2.1)
- Hub scaffolding checklist complete (Section 6.2.2)

#### Checklist

| Step | Action | Location | Reference |
|------|--------|----------|-----------|
| 1 | Initialize git repo | Project root | `git init` |
| 2 | Create `.gitignore` | Project root | Standard DSM exclusions |
| 3 | Create `.claude/CLAUDE.md` with `@` reference | `.claude/` | Section 2 template, DSM_0.2 |
| 4 | Create `.claude/dsm-ecosystem.md` | `.claude/` | DSM_0.2 Ecosystem Path Registry |
| 5 | Create `_inbox/` with README.md | Project root | Section 6.4 entry template |
| 6 | Create canonical `docs/` structure | `docs/` | DSM_0.1 (9 subdirectories) |
| 7 | Move preliminary plan to `docs/research/` | `docs/research/` | If exists from hub kickoff |
| 8 | Send first-session prompt to spoke's `_inbox/` | `_inbox/` | See template below |
| 9 | Send inbox confirmation to DSM Central's `_inbox/` | Hub `_inbox/` | DSM_0.2 migration confirmation |
| 10 | Create AI collaboration norms | `docs/guides/` | See Section 6.7.3 below |
| 11 | Create README.md | Project root | Project name, purpose, setup, structure |
| 12 | Check `~/.claude/CLAUDE.md` for user conventions | `.claude/CLAUDE.md` | Inherit punctuation, formatting, tone preferences |
| 13 | Initial commit | Project root | |

The canonical `docs/` structure (Step 6) contains 9 subdirectories per DSM_0.1:
`blog/`, `checkpoints/`, `decisions/`, `feedback/`, `guides/`, `handoffs/` (with
`done/`), `inbox/`, `plans/`, `research/`.

#### 6.7.1. First-Session Prompt

Send this as an inbox entry to the spoke's `_inbox/`, not as a handoff document.
It is a hub-to-spoke action item: it arrives, gets processed in the first session,
and gets deleted.

```markdown
### [YYYY-MM-DD] First session: project initialization

**Type:** Action Item
**Priority:** High
**Source:** DSM Central

This is a DSM ecosystem project. Read `.claude/CLAUDE.md` for methodology
and interaction protocols.

Read the preliminary plan in `docs/research/` to understand the project
goals and initial design direction.

Based on the preliminary plan:
1. Do extensive research to validate and expand on the plan. Document
   findings with citations in `docs/research/`.
2. Create a project plan in `docs/plans/` covering scope, phases,
   deliverables, and success criteria.
3. Present the plan for review and approval before starting implementation.
4. Create AI collaboration norms in `docs/guides/ai-collaboration.md`
   (see DSM_3 Section 6.7.3).
```

#### 6.7.2. CLAUDE.md Essentials

The `.claude/CLAUDE.md` (Step 3) must include at minimum:

- `@` reference to DSM_0.2 Custom Instructions (discovery mechanism for all DSM protocols)
- Project name, domain, and DSM track (Notebook / Application / Hybrid / Documentation)
- Protocol reinforcements per DSM_0.2 CLAUDE.md Configuration table
- Project-specific instructions (data sources, key paths, standards)
- **Multi-deliverable scope:** When a project contains multiple sub-deliverables,
  enumerate all of them with their respective tool stacks, data sources, and DSM
  tracks. The first-session prompt should cross-check the CLAUDE.md against the
  preliminary plan to catch scope mismatches early.
- **DSM_1 methodology references:** The `@` reference imports DSM_0.2 (behavior
  protocols) but not DSM_1 (methodology content). The CLAUDE.md should reference
  or summarize applicable DSM_1 sections so the spoke agent can discover them:
  - Section 2.1 for environment setup (venv, requirements, setup scripts)
  - Section 2.2 for EDA methodology (Three-Layer Framework)
  - Section 2.5 for communication standards

Use the Custom Instructions template in Section 2 as the starting point. See
DSM_0.2's "Protocol Reinforcement Required" table for which protocols to
explicitly restate.

#### 6.7.3. AI Collaboration Norms

As part of project initialization, create `docs/guides/ai-collaboration.md`
capturing how human-AI collaboration works for this specific project:

- **Protocol applicability:** Which inherited DSM protocols apply, which are
  skipped, and which need adaptation for this domain
- **Human-agent responsibility split:** What the human owns (decisions, domain
  judgment, review) vs. what the agent owns (research, drafting, mechanical tasks)
- **Collaboration mode:** The expected interaction pattern (notebook cell-by-cell,
  app dev file-by-file, research-then-plan, etc.)
- **Project-specific conventions:** Standards not covered by DSM defaults (naming
  conventions, domain terminology, tool preferences)

This document serves two purposes: it primes the agent with project-specific
collaboration expectations at session start, and it gives the human a reference
for what to expect from the agent's behavior.

For external contributions, the equivalent step is assessing the upstream AI
policy (Section 6.6.4) and documenting collaboration approach in the governance
folder (`{contributions-docs-path}/{project}/docs/guides/ai-collaboration.md`).

#### Anti-Patterns

**DO NOT:**
- Skip the ecosystem path registry (Step 4); without it, cross-repo operations
  (inbox push, feedback handover) silently fail
- Place the first-session prompt in `docs/handoffs/`; it is a transient action
  item, not a session continuity document
- Copy the full DSM_0.2 protocol list into the AI collaboration norms; reference
  the Protocol Applicability table pattern from Section 6.6.5 and customize for
  the project's context
- Skip the inbox confirmation to DSM Central (Step 9); the hub needs to know the
  spoke's inbox system is operational
- Defer AI collaboration norms to "later"; the first session is when collaboration
  patterns are established, and undocumented patterns drift

#### 6.7.4. DSM Adoption for Existing Projects

When initializing DSM in a project with prior non-DSM sessions, follow this
adoption checklist before the standard initialization (Section 6.7 checklist).

**Pre-existing artifact migration:**

1. Discover: list all non-DSM session artifacts (`context/`, handoffs,
   checkpoints, memory files at project root)
2. Classify and migrate:
   - `context/*.md` or loose handoff files → `docs/handoffs/done/` with
     `**Consumed at:** DSM adoption (YYYY-MM-DD)` annotation
   - Checkpoint files at root → `docs/checkpoints/done/` with consumed annotation
   - Agent-created memory files (e.g., `memody.md`) → extract key user
     preferences into CLAUDE.md, then archive the source file in place
3. Preserve all originals; they are the user's pre-DSM work record
4. Document the migration in the session transcript

**Hierarchical project guidance:**

- CLAUDE.md and `_inbox/` belong at the top-level project root, not in
  subprojects
- Subproject work: navigate to the subproject directory for active work;
  session governance artifacts (transcript, baseline) live in the parent
  `.claude/`
- One CLAUDE.md at root with subproject-specific sections is preferred;
  separate CLAUDE.md per subproject only if governance needs diverge
  significantly

**Agent-created memory vs DSM MEMORY.md:**

- DSM MEMORY.md (in `~/.claude/projects/`) is the canonical cross-session
  memory for Claude Code
- Agent-created memory files in project directories are pre-DSM artifacts;
  extract user preferences into CLAUDE.md, then treat per migration checklist
- Do not maintain parallel memory systems; consolidate into MEMORY.md

---

### 6.8. Private Project Pattern

Some projects contain personal or sensitive data (financial, medical, legal)
that must never appear in any committed artifact. These projects benefit from
DSM's methodology structure but cannot participate in the ecosystem's standard
communication channels without risking data exposure. The Private Project
Pattern provides DSM methodology with strict data isolation.

#### When to Use

- Project contains personal data subject to GDPR or similar regulations
- Data must never appear in any committed artifact across the ecosystem
- Project benefits from DSM structure (session management, checkpoints,
  feedback) but not from public visibility

#### Core Properties

| Property | Standard DSM Spoke | Private Project |
|----------|-------------------|-----------------|
| Git tracking | Remote (GitHub) | Local only (no remote) |
| DSM_3 Section 7 registry | Yes | No |
| Ecosystem path registry | Yes (gitignored) | Yes (gitignored) |
| Inbox (inbound) | Bidirectional | Receive only |
| Feedback push (outbound) | Automatic at wrap-up | Manual only, after user sanitization |
| Inbox notification (outbound) | Automatic with content | Minimal: "feedback available" (path only, no content) |
| README notifications | Yes | No (local README, no notifications) |
| Cross-repo writes from project | Yes | Never (except minimal inbox notification) |
| CLAUDE.md `@` reference | Yes | Yes (with privacy overrides) |
| README.md | Public project description | Local project status dashboard |

#### Git Configuration

Private projects use **local git only**: `git init` with no remote configured.
This provides change history, revert capability, and `git diff` visibility
while ensuring no data leaves the local machine. DSM session commands work
without modification.

**What to track:** The intelligence layer, checkpoints, markdown, CSVs,
structured extracts.

**What to gitignore:** Raw source documents (PDFs, bank statements, scanned
images), application data files (WISO, Elster), and any file containing
unprocessed personal data.

The objective is data isolation from internet exposure, not absence of
version control. Local git minus a remote equals local-only version control
with no exposure risk.

#### Project Status README

Private projects maintain a `README.md` at the project root as a local
status dashboard. Unlike standard spoke READMEs (which describe the project
for external audiences), this README serves the user as a quick orientation
when returning to the project.

**Content:**
- Project description and purpose (1-2 sentences)
- Current stage or phase
- Last session summary (date, what was done)
- Next steps (3-5 actionable items)
- Key file locations within the project

**Lifecycle:**
- **Updated at:** Full `/dsm-wrap-up` (current stage, last session, next steps)
- **Read at:** Full `/dsm-go` (orientation before starting work)
- **Never sent externally:** No README Change Notifications (no remote, no
  portfolio entry)

This README is committed to local git alongside other intelligence-layer
artifacts.

#### CLAUDE.md Template

The project CLAUDE.md includes the standard `@` reference to DSM_0.2 and
adds a Privacy and Data Isolation section:

```markdown
@/path/to/dsm-central/DSM_0.2_Custom_Instructions_v1.1.md

# Project: [Project Name]
Domain: [domain]
Project type: Private Documentation. DSM private project pattern
(see DSM_3 Section 6.8).

## Privacy and Data Isolation

**Data classification:** Personal/sensitive. GDPR applies.

### Protocol Applicability

| Protocol | Applies? | Override |
|----------|:--------:|---------|
| Session Transcript Protocol | Yes | Standard |
| Pre-Generation Brief Protocol | Yes | Standard |
| Destructive Action Protocol | Yes | Standard |
| Inbox, inbound | Yes | Receive only; DSM Central writes to `_inbox/` |
| Feedback Push, outbound | Yes | Manual only; user sanitizes, then agent sends minimal inbox notification |
| README Change Notification | No | No public README; no notifications |
| Cross-repo writes | No | Only minimal inbox notification to DSM Central |
| DSM_3 Section 7 registration | No | Private; invisible to all committed artifacts |
| Continuous Learning | Yes | Web searches must not include personal data |

### Agent Constraints

- Never include personal data in conversation text
- Never write project content to any path outside this project root
- Never push feedback autonomously; all outbound data requires explicit
  user review and sanitization
- Web searches must not include personal identifiers (Query Sanitization
  applies)

### Data Flow

DSM Central --writes--> _inbox/               (methodology updates only)
{project}   --writes--> DSM Central/_inbox/    (minimal: "feedback available")
DSM Central <--reads--- docs/feedback/         (sanitized by user, read-only)

### Session Transcript Protocol (reinforces inherited protocol)

- Append thinking to `.claude/session-transcript.md` BEFORE acting
- Output summary AFTER completing work
- Conversation text = results only
- Use Reasoning Delimiter Format for every thinking block:
  `<------------Start Thinking / HH:MM------------>`
  [reasoning content]
- HH:MM is 24-hour local time when thinking begins; no end delimiter needed
```

Extend the Agent Constraints with project-specific sensitive data types
(e.g., IBANs, tax numbers, card numbers, addresses) as appropriate.

#### Directory Structure

```
{project}/
  README.md                (local status dashboard)
  .claude/
    CLAUDE.md              (@ reference + privacy overrides)
    session-transcript.md
    session-baseline.txt
    reasoning-lessons.md   (optional)
  _inbox/                  (receives from DSM Central only)
  docs/
    decisions/
    feedback/              (per-session: YYYY-MM-DD_sN_{type}.md)
      done/
    checkpoints/
      done/
    research/
      done/
    plans/
      done/
```

Project-specific directories sit alongside the DSM structure. The DSM
directories provide methodology infrastructure; project directories hold
domain content.

#### Data Flow Architecture

```
DSM Central --writes--> {project}/_inbox/         (methodology updates only)
{project}   --writes--> DSM Central/_inbox/       (minimal: "feedback available")
DSM Central <--reads--- {project}/docs/feedback/  (sanitized by user)
```

No other cross-boundary data flow. The user is the sanitization gate.

#### Communication Protocol

**Inbound (DSM Central to project):**
DSM Central writes methodology updates, protocol changes, and notifications
to `{project}/_inbox/` using the standard inbox entry format (Section 6.4).
The agent processes these at session start per DSM_0.2 Inbox Check.

**Outbound (project to DSM Central):**
The agent writes per-session feedback files to `{project}/docs/feedback/`
during the session. At wrap-up:
1. Agent lists feedback files that are ripe
2. User reviews content for personal data and confirms sanitization
3. After explicit confirmation, the agent sends a **minimal** inbox
   notification to DSM Central's `_inbox/`:

```markdown
### [YYYY-MM-DD] Feedback available from {project-name}

**Type:** Notification
**Priority:** Low
**Source:** {project-name}

Sanitized feedback is available for review.

**Feedback file:** `{project-path}/docs/feedback/{filename}`
```

The notification contains only the file path, never project content.
DSM Central reads the feedback file directly when processing the inbox entry.

4. After DSM Central processes the feedback, the source file moves to
   `docs/feedback/done/`

**Receiver-side validation (DSM Central):**
When DSM Central reads a feedback file from a private project, it must scan
for sensitive patterns (personal names, financial data, card numbers,
addresses) before ingesting. If sensitive content is detected, alert the
user and do not act on the content until re-sanitized.

#### Ecosystem Visibility

- The project path is registered in `.claude/dsm-ecosystem.md` (gitignored),
  giving DSM Central a way to write inbox entries
- No entry in DSM_3 Section 7 project registry (committed)
- No backlog item in `plan/backlog/developments/` (committed)
- The project is invisible to all committed artifacts

#### WSL2 Path Constraint

The CLAUDE.md `@` reference uses a Linux path (e.g.,
`@/home/berto/.../DSM_0.2_Custom_Instructions_v1.1.md`). This works when
the project is opened from WSL2, where both `/home/berto/` and `/mnt/d/`
are accessible. It fails if opened from native Windows, where Linux paths
do not resolve.

**Constraint:** Private projects on Windows drives must be opened via WSL2
(VS Code Remote - WSL or `code "/mnt/d/..."` from WSL terminal). Document
this requirement in the project CLAUDE.md.

#### Initialization Checklist

Use the standard Spoke Project Initialization Checklist (Section 6.7) with
these modifications:

| Step | Standard | Private Project Override |
|------|----------|------------------------|
| 1 | `git init` + remote | `git init` only, no remote |
| 3 | Standard CLAUDE.md | Add Privacy and Data Isolation section (template above) |
| 5 | Bidirectional inbox | Add note: "Receives from DSM Central only" |
| 9 | Inbox confirmation to hub | Same, but note privacy project type |
| 11 | Initial commit + push | Initial commit only (no push, no remote) |
| New | N/A | Create `README.md` as local status dashboard |

#### Anti-Patterns

**DO NOT:**
- Configure a git remote for private projects; the isolation guarantee
  depends on no remote existing
- Include personal data in inbox notifications to DSM Central; the
  notification contains only the file path, never content
- Register private projects in DSM_3 Section 7 or in committed backlog
  items; ecosystem visibility is gitignored-only
- Skip the Privacy and Data Isolation section in CLAUDE.md; without it,
  inherited DSM_0.2 protocols (automatic feedback push, cross-repo writes)
  execute with default behavior, which leaks data
- Send feedback content in the inbox notification; the inbox entry says
  "feedback available" and points to the file, DSM Central reads the
  file directly
- Skip the local README.md; without it, the user loses project orientation
  between sessions

---

### 6.9. Standard Spoke Pattern

The Standard Spoke is the default DSM project type: a project created under
DSM governance, tracked on GitHub, and participating fully in the ecosystem
feedback loop. Most DSM projects follow this pattern. This section provides
a unified entry point; detailed protocols are in Sections 6.1-6.7.

#### When to Use

- New project created to solve a data science, application, or documentation
  problem within the DSM ecosystem
- Project will have a public GitHub repository
- Full participation in the ecosystem feedback loop is appropriate (README
  notifications, automatic feedback push, bidirectional inbox)

#### Core Properties

| Property | Value |
|----------|-------|
| Git tracking | Remote (GitHub) |
| Registry visibility | DSM_3 Section 7 (committed) |
| Inbox direction | Bidirectional |
| Feedback push | Automatic at wrap-up |
| README notifications | Yes (portfolio + DSM Central) |
| Cross-repo writes | Yes |
| CLAUDE.md location | Project `.claude/` |
| `@` reference | Required |

#### Git Configuration

Standard spokes use `git init` with a remote configured to GitHub:

```
git init
git remote add origin https://github.com/{user}/{repo}.git
git branch -m main
```

The remote ensures commits are backed up and the project is visible to
the ecosystem. Push at every session wrap-up.

#### CLAUDE.md Template

```markdown
@/path/to/dsm-central/DSM_0.2_Custom_Instructions_v1.1.md

# Project: [Project Name]
Domain: [domain]
Project type: [Notebook | Application | Hybrid | Documentation].
Standard spoke pattern (see DSM_3 Section 6.9).

## Project-Specific Instructions
[project-specific content here]

## Protocol Applicability

| Protocol | Applies? | Override |
|----------|:--------:|---------|
| Session Transcript Protocol | Yes | Standard |
| Pre-Generation Brief Protocol | Yes | Standard |
| Destructive Action Protocol | Yes | Standard |
| Inbox, inbound | Yes | Bidirectional |
| Feedback Push, outbound | Yes | Automatic at wrap-up |
| README Change Notification | Yes | Standard |
| Cross-repo writes | Yes | Standard |
| DSM_3 Section 7 registration | Yes | Standard |

## Session Transcript Protocol (reinforces inherited protocol)

- Append thinking to `.claude/session-transcript.md` BEFORE acting
- Output summary AFTER completing work
- Conversation text = results only
- Use Reasoning Delimiter Format for every thinking block:
  `<------------Start Thinking / HH:MM------------>`
  [reasoning content]
- HH:MM is 24-hour local time when thinking begins; no end delimiter needed
```

#### Directory Structure

```
{project}/
  README.md                (project description for external audiences)
  .claude/
    CLAUDE.md              (@ reference + project-specific instructions)
    session-transcript.md
    session-baseline.txt
    reasoning-lessons.md   (optional)
    dsm-ecosystem.md       (gitignored: cross-repo paths)
  _inbox/                  (bidirectional; README.md with entry template)
  docs/
    blog/
      done/
    checkpoints/
      done/
    decisions/
    feedback/
      done/
    guides/
    handoffs/
    plans/
      done/
    research/
      done/
```

See DSM_0.1 for the full nine-subdirectory canonical structure.

#### Data Flow Architecture

```
DSM Central  --writes--> {project}/_inbox/          (methodology updates, backlog proposals)
{project}    --writes--> DSM Central/_inbox/        (feedback, README notifications)
{project}    --writes--> portfolio/_inbox/          (README notifications)
DSM Central  <--reads--- {project}/docs/feedback/   (methodology observations, backlogs)
```

Full bidirectional communication. The agent executes inbox and feedback
steps automatically at session start and wrap-up per DSM_0.2 protocols.

#### Communication Protocol

**Inbound (DSM Central to project):** DSM Central writes methodology
updates, protocol change notifications, and backlog proposals to
`{project}/_inbox/`. The agent processes these at session start.

**Outbound (project to DSM Central):** The agent pushes ripe feedback
files at wrap-up (per Session-End Inbox Push in DSM_0.2) and sends
README Change Notifications when `README.md` changes.

See Section 6.1 (feedback handover), Section 6.4 (inbox protocol),
and DSM_0.2 (session-end inbox push, README change notification).

#### Initialization

Use the Spoke Project Initialization Checklist (Section 6.7) without
modifications. All steps apply.

#### Anti-Patterns

**DO NOT:**
- Register standard spokes in `plan/backlog/developments/` without also
  adding them to DSM_3 Section 7; the registry is the discovery mechanism
- Skip README Change Notifications; they keep the portfolio current
- Configure the project as a private project pattern when the repository
  will have a public GitHub remote; the pattern governs isolation rules,
  not just git configuration
- Omit the Protocol Applicability table from CLAUDE.md; without it,
  protocol gaps surface at every session start (DSM_0.2 grace period
  protocol)

---

## 7. Canonical External Description

When describing DSM in external-facing documents (job applications, blog posts, README,
presentations), use these canonical descriptions. They ensure consistent framing across
all projects and prevent misattribution.

**Critical framing rules:**
- DSM is a personal initiative, independently developed since August 2025
- Masterschool specialization projects (TravelTide, Favorita) are case studies that stress-tested DSM, not the source of DSM
- Dog-fooding projects (Graph Explorer, Research Agent) validate DSM by building tools using DSM itself
- Never frame DSM as a Masterschool product or coursework output

**Usage:** The descriptions below are in first person ("I developed"). For third-person
contexts (LinkedIn summaries, portfolio "About" sections), adapt the voice but preserve
the framing rules above. When writing job applications, cover letters, or portfolio
materials, reference this section directly rather than re-deriving the framing each time.

### Short Version (1-2 sentences)

> The Data Science Methodology (DSM) is a personal framework for managing data science
> and ML projects with AI agents. It covers the full lifecycle from exploration through
> production, validated across 10+ projects.

### Medium Version (1 paragraph)

> The Data Science Methodology (DSM) is a comprehensive framework I independently
> developed for managing data science and ML projects with AI agents. Started in August
> 2025, it provides a structured 4-phase workflow, project management templates, software
> engineering adaptations, and documentation standards. The methodology has been
> stress-tested through real-world case studies, including customer analytics (TravelTide)
> and demand forecasting (Favorita) projects completed during my Masterschool AI Data
> Science specialization, as well as through a growing ecosystem of dog-fooding tools
> that validate DSM by building with DSM.

### Full Version (3-4 paragraphs)

> The Data Science Methodology (DSM) is a comprehensive, open-source framework I
> independently developed for managing data science and ML projects with AI coding
> agents. Started in August 2025, the methodology addresses a gap I identified in
> how data scientists collaborate with AI tools: most workflows lack the structure
> needed for reproducibility, quality assurance, and systematic decision tracking.
>
> The framework provides an integrated system of five core documents covering
> project management, a 4-phase execution workflow, software engineering adaptations
> for ML applications, documentation project standards, and an implementation guide.
> At over 10,000 lines, it includes sprint planning templates, notebook standards,
> app development protocols, domain adaptation guides, and a gateway review protocol
> for multi-project governance.
>
> DSM has been validated across 20+ projects spanning customer analytics, demand
> forecasting, NLP, computer vision, process mining, RAG systems, energy engineering,
> and agentic AI. Case studies completed during my Masterschool AI Data Science
> specialization (TravelTide, Favorita) served as early stress tests, with lessons
> learned incorporated back into the framework. A growing ecosystem of dog-fooding
> projects, tools built using DSM to validate DSM itself, provides continuous
> feedback and demonstrates the methodology's adaptability across project types.
>
> The methodology is agent-agnostic and open-source (MIT License), designed for data
> scientists, students, and professionals who want a systematic approach to working
> with AI coding agents across notebook, application, and documentation projects.

### Project Registry

Complete list of projects that DSM has supported, organized by domain. When
referencing DSM externally, select projects relevant to the context.

**Customer Analytics & Forecasting:**
- TravelTide: Customer segmentation, CLV analysis, hierarchical clustering (case study)
- Corporacion Favorita: Demand forecasting, XGBoost, 4.8M transactions (case study)
- Favorita App: Streamlit deployment of demand forecasting model

**NLP & Text Analysis:**
- Disaster Tweets: Tweet classification, TF-IDF vs embeddings vs transformers
- NLP Topic Modeling: LDA on Jira case data, process mining integration

**Computer Vision:**
- Computer Vision: CIFAR-10 classification (ResNet50), steel defect segmentation (U-Net)

**Agentic AI & RAG:**
- SQL Query Agent: Text-to-SQL with Ollama, local LLM
- RAG Document Assistant: Multi-provider RAG system, FastAPI, MLflow evaluation
- DSM Research Agent: MCP server for academic paper search across 6 APIs (in progress)

**Process Mining & MLOps:**
- DevFlow Analyzer: LangGraph ReAct agent for CI/CD analysis, 10K+ builds
- Log Processor: ETL pipeline, BPM data to event logs

**Energy Engineering:**
- Residential Heating DS Guide: 6K-line domain knowledge base, German standards documentation
- Residential Energy Apps: Heating curve simulator, Streamlit app, RANSAC regression

**DSM Tooling (dog-fooding):** See also `docs/core-tools.md` for the authoritative
Core Tools registry (branding, ecosystem-wide updates).
- DSM Graph Explorer: Cross-reference validation, 471 tests, 95% coverage
- Take AI Bite: Public-facing framework distribution, curated DSM subset for external adoption
- DSM Jupyter Book: Automated methodology publishing (planned)
- DSM Blog Poster: Hugo site for methodology insights (planned)

**Other:**
- Political Parties: CHES 2019 dataset analysis
- Loan Approval Prediction: ML classification
- IronCalc: External contribution to open-source spreadsheet engine (Rust)

---

## Version History

**v1.1.1** (2025-11-19):
- Updated all references to v1.1.1 file structure
- Consolidated content, removed duplication
- Updated file naming references to Appendix E.11
- Streamlined examples with reference-based approach
- Added Quick Reference section
- Aligned with consolidated methodology system

**v1.1.0** (2025-11-19):
- Updated references to hierarchical numbering
- Added appendix references

**v1.0** (2025-11-13):
- Initial release with comprehensive template
- Two domain examples (Time Series, NLP)

---

**End of Implementation Guide**

**For complete methodology system, see:** `0_START_HERE_Complete_Guide.md`  
**For detailed phase guidance, see:** `1.0_Methodology_Appendices.md`
