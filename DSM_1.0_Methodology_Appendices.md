# Methodology Appendices - Complete Reference

**Part of:** Data Science Collaboration Methodology v1.3.0
**Main Document:** `1.0_Data_Science_Collaboration_Methodology_v1.1.md`
**Purpose:** Consolidated detailed guidance for all methodology aspects

**Version:** 1.3.0 (Consolidated)
**Last Updated:** 2026-01-22

---

## Appendices Overview

This document consolidates all appendices for the Data Science Collaboration Methodology:

- **Appendix A:** Environment Setup (Tool selection, troubleshooting, cross-platform setup)
- **Appendix B:** Phase Deep Dives (Decision frameworks, templates, orientation per phase)
- **Appendix C:** Advanced Practices (Experiment tracking, capability templates, risk/debt registers)
- **Appendix D:** Domain Adaptations (Orientation blocks for time series, NLP, CV, clustering, supervised learning)
- **Appendix E:** Quick Reference (Checklists, templates, commands)
- **Appendix F:** Coding Anti-Patterns (Python, data science, ML engineering patterns)

**Cross-references to main methodology:** Use "Section X.Y" format (e.g., "See Section 2.2")

---

# Appendix A: Environment Setup Details

**Part of:** Data Science Collaboration Methodology v1.1  
**Main Document:** `1.0_Data_Science_Collaboration_Methodology.md` → Section 2.1  
**Purpose:** Environment setup guidance, tool selection, and troubleshooting

---

## A.1. Base Environment (Minimal)

**Core Data Science Stack:** jupyter, ipykernel, pandas, numpy, matplotlib, seaborn (~82 MB total)

**Setup steps:**
1. Create virtual environment: `python -m venv .venv`
2. Activate: `source .venv/bin/activate` (Linux/Mac) or `.venv\Scripts\activate` (Windows)
3. Install: `pip install jupyter ipykernel pandas numpy matplotlib seaborn`
4. Register kernel: `python -m ipykernel install --user --name=project_kernel`
5. Verify: import all packages, check versions, run a basic plot

See A.7 for environment tool selection (venv, uv, Poetry, Conda).

---

## A.2. Base Environment (Full with Code Quality)

**Additional tools:** black (formatter), flake8 (linter), isort (import sorter), autopep8 (auto-fix)

**When to use full setup:**
- Team projects, code review expected, production deployment planned

**When to skip:**
- Individual academic projects, exploratory analysis, early exploration

Configuration: Add formatter/linter settings to `.vscode/settings.json` or equivalent IDE config.

---

## A.3. Domain-Specific Extensions

Domain-specific packages (time series, NLP, deep learning, computer vision) should
be installed only when the project requires them. Install after project planning
identifies actual needs, not speculatively.

**Key considerations:**
- Create separate requirements files per domain (`requirements_timeseries.txt`, etc.)
- Deep learning frameworks are large (400+ MB); only install if needed
- Some packages require additional downloads (spaCy models, NLTK data)
- Verify imports after installation before proceeding to analysis
- Document why each domain package was chosen in the project README

---

## A.4. Troubleshooting Environment Issues

### A.4.1. Common Installation Errors

| Error | Cause | Solution |
|-------|-------|----------|
| "pip is not recognized" | Python not in PATH | Reinstall Python with "Add to PATH" |
| "No module named pip" | pip missing | `python -m ensurepip --upgrade` |
| "Could not find version" | Name misspelled or version incompatible | Check package name and Python version |
| "Visual C++ 14.0 required" | Missing build tools (Windows) | Install MS C++ Build Tools or use wheels |
| Long path issues (Windows) | MAX_PATH limitation | Enable long path support or use shorter paths |

### A.4.2. Platform-Specific Notes

- **Windows:** Use `Scripts\activate`, backslash paths, may need admin rights
- **Mac/Linux:** Use `bin/activate`, forward slash paths, prefer venvs over system Python
- **Apple Silicon:** Some packages need Rosetta 2; use miniforge for ARM support

### A.4.3. Dependency Conflicts

If installation fails due to version conflicts:
1. **Create fresh environment** (deactivate, remove .venv, recreate)
2. **Pin versions** in requirements file
3. **Install in dependency order** (numpy before pandas before sklearn)

### A.4.4. Jupyter Kernel Issues

| Issue | Check | Solution |
|-------|-------|----------|
| Kernel not found | `jupyter kernelspec list` | Re-register kernel, reload IDE |
| Wrong Python version | `cat .../kernel.json` | Uninstall old kernel, re-register |
| Kernel dies immediately | Test imports in terminal | Verify activation and packages |

### A.4.5. Environment Maintenance Orientation

Key maintenance tasks:
- Update packages: `pip install --upgrade <package>` or `pip list --outdated`
- Security audit: `pip-audit`
- Export: `pip freeze > requirements.txt`
- Clean rebuild: deactivate, remove .venv, recreate from requirements file

---

## A.5. Quick Reference

**Setup Commands:**
```bash
# Create environment
python -m venv .venv

# Activate
.venv\Scripts\activate  # Windows
source .venv/bin/activate  # Mac/Linux

# Install
pip install -r requirements_base.txt

# Register kernel
python -m ipykernel install --user --name=project_base_kernel

# Verify
jupyter kernelspec list
```

**Troubleshooting Commands:**
```bash
# Check Python version
python --version

# Check pip version
pip --version

# Check installed packages
pip list

# Check package details
pip show pandas

# Reinstall package
pip uninstall pandas
pip install pandas
```

---

## A.6. Environment Transition Checklist

**Purpose:** Guide for transitioning between development environments (e.g., Windows to WSL2/Linux, CPU to GPU, local to cloud).

### A.6.1. When Environment Transition Is Needed

**Common Transition Scenarios:**
- Windows development to Linux production server
- CPU training to GPU training (cloud or local)
- Local development to Docker container
- Single machine to distributed computing

**Signs You Need to Plan Transition:**
- Dataset exceeds local memory (need cloud/HPC)
- Training time exceeds acceptable threshold (need GPU)
- Deployment target differs from development OS

### A.6.2. Pre-Transition Checklist

**Before Starting Transition:**
- [ ] Requirements file is current (`pip freeze > requirements.txt`)
- [ ] All code uses relative paths from project root (use `pathlib`)
- [ ] No hardcoded OS-specific paths
- [ ] Data files accessible from target environment
- [ ] Model artifacts are portable (no absolute paths in serialized objects)
- [ ] Tests exist to validate pipeline works end-to-end

### A.6.3. Path Handling for Cross-Platform Compatibility

Use `pathlib.Path` for all file operations. Define paths relative to project root
in a configuration cell at the top of each notebook. Avoid hardcoded OS-specific
paths (`D:\`, `/home/user/`).

**Key principle:** `Path(__file__).parent` or `Path.cwd()` as base, then compose
with `/` operator: `DATA_DIR = PROJECT_ROOT / "data" / "raw"`.

### A.6.4. GPU Environment Setup

When transitioning to GPU compute (WSL2, cloud, HPC):
- Verify GPU driver and CUDA version compatibility with your framework
- Enable memory growth to prevent OOM errors
- Test GPU detection before starting training
- Common issues: driver mismatch, CUDA version conflicts, memory limits

### A.6.5. Post-Transition Validation

After transitioning, verify:
1. Python version matches or is compatible
2. All required packages import successfully
3. GPU is detected (if applicable)
4. Project paths resolve correctly
5. Data files are accessible
6. Pipeline runs end-to-end

### A.6.6. Best Practices for Environment Transitions

- Test transition early (Sprint 2-3), not at delivery time
- Keep `requirements.txt` synchronized across environments
- Use `pathlib` for all file operations
- Document environment-specific configurations
- Run end-to-end pipeline validation after each transition

---

## A.7. Environment Tool Selection Guide

Choosing the right environment tool depends on project type, team experience,
and deployment needs. DSM supports multiple tools; this guide helps you choose.

### A.7.1. Two-Phase Setup Approach

Separate infrastructure setup from project-specific dependencies:

**Phase 1: Infrastructure Only (before project planning)**

| Project Type | Infrastructure Setup | Purpose |
|-------------|---------------------|---------|
| DSM 1.0 (Notebooks) | `python -m venv .venv && pip install jupyter ipykernel` | Enable notebook development |
| DSM 4.0 (Applications) | `python -m venv .venv && pip install pytest` | Enable development and testing |
| Hybrid | `python -m venv .venv && pip install jupyter ipykernel pytest` | Enable both workflows |

**Phase 2: Project-Specific Libraries (after project planning)**

Install based on actual project needs identified during planning:
```bash
# After planning identifies required libraries
pip install pandas numpy scikit-learn matplotlib seaborn
pip freeze > requirements.txt
```

This prevents installing unnecessary packages and keeps environments lean.

### A.7.2. Tool Comparison

| Tool | Best For | Pros | Cons |
|------|----------|------|------|
| **venv + pip** | Simple projects, beginners, DSM 1.0 | Built-in, simple, lightweight | No Python version management |
| **pyenv + venv** | Multi-Python projects | Python version control, flexible | Extra tool, Windows/WSL issues |
| **Poetry** | Applications, packages, DSM 4.0 | Dependency resolution, lock files | Learning curve, slower installs |
| **Conda** | Cross-platform data science | Binary packages, env + Python mgmt | Large, can conflict with pip |
| **uv** | Modern Python projects (2025+) | 10-100x faster, manages Python versions, pip-compatible, lock files | Newer tool (but rapidly adopted, backed by Astral) |

### A.7.3. Recommended Defaults by Project Type

**DSM 1.0 (Notebook Projects):**
```bash
# Option A: uv (recommended for 2026+)
uv init --no-readme
uv add jupyter ipykernel pandas numpy matplotlib seaborn
uv run python -m ipykernel install --user --name=project-kernel

# Option B: venv + pip (simple, no extra tools)
python -m venv .venv
source .venv/bin/activate          # Linux/Mac
# .venv\Scripts\activate           # Windows
pip install jupyter ipykernel
python -m ipykernel install --user --name=project-kernel
```

**DSM 4.0 (Application Projects):**
```bash
# Option A: uv (recommended for 2026+)
uv init
uv add pytest
# Install project dependencies as identified in planning

# Option B: venv + pip with requirements.txt
python -m venv .venv
source .venv/bin/activate
pip install pytest
```

**Production/Team Projects:**
```bash
# Recommended: uv or Poetry with pyproject.toml and lock file
uv init && uv add pandas numpy scikit-learn
# OR
poetry init && poetry add pandas numpy scikit-learn
```

### A.7.4. Legacy Setup Scripts

The repository includes two convenience scripts in `scripts/`:
- `setup_base_environment_minimal.py`, academic/exploratory (essential packages)
- `setup_base_environment_prod.py`, production (includes code quality tools)

**NOTE:** These scripts use `venv + pip` and contain deprecated VS Code settings (see BACKLOG-059). They remain functional for quick setup, but for new projects, prefer the `pyproject.toml`-based approach described in A.7.3. The scripts may be modernized or replaced with `pyproject.toml` templates in a future version.

Cross-reference: Section 2.1 (Environment Setup), DSM 4.0 Section 3 (Development Protocol)

## A.8. Model & Data Cache Management

Large model downloads (embeddings, transformers, pretrained models) can consume
significant disk space. Document and manage these to avoid storage surprises.

**Key practices:**
- Document large model downloads in project README with expected sizes
- Check cache sizes periodically: `du -sh ~/.cache/` and library-specific locations
- Clean domain-specific caches after project completion
- Ensure cache directories are in `.gitignore`
- On shared compute, coordinate cache management with the team

Cross-reference: Appendix A.3 (Domain-Specific Extensions)

## A.9. WSL & Cross-Platform Setup

Working in WSL (Windows Subsystem for Linux) introduces specific issues with
paths and Python configuration. This section documents common solutions.

### A.9.1. WSL Path Mapping

| Windows Path | WSL Path |
|-------------|----------|
| `D:\data-science\` | `/mnt/d/data-science/` |
| `C:\Users\name\` | `/mnt/c/Users/name/` |
| `D:\project\notebooks\` | `/mnt/d/project/notebooks/` |

### A.9.2. Python in WSL

Windows Python may appear on the WSL PATH, causing conflicts:

```bash
# Check which Python is active
which python3
# Expected: /usr/bin/python3 or /home/user/.pyenv/shims/python3
# Problem: /mnt/c/Users/.../python3 (Windows Python leaking into WSL)

# Fix: Use python3 explicitly (not python)
python3 -m venv .venv
source .venv/bin/activate
```

If using pyenv in WSL, verify shims are working:
```bash
pyenv which python3
# Should point to pyenv-managed Python, not Windows
```

### A.9.3. CLAUDE.md Paths for WSL Users

The `@path` import in CLAUDE.md must match the context:

| Context | CLAUDE.md Path |
|---------|---------------|
| Windows IDE (VS Code) | `@D:/data-science/agentic-ai-data-science-methodology/DSM_0.2_Custom_Instructions_v1.1.md` |
| WSL terminal | `@/mnt/d/data-science/agentic-ai-data-science-methodology/DSM_0.2_Custom_Instructions_v1.1.md` |

NOTE: If using VS Code with the WSL extension, VS Code operates in the WSL
filesystem context, so use WSL paths.

### A.9.4. Common WSL Issues

| Issue | Cause | Solution |
|-------|-------|----------|
| `python` not found | Windows Python not on WSL PATH | Use `python3` explicitly |
| Permission denied on .venv | Windows filesystem permissions | Create .venv in WSL-native path (`~/projects/`) |
| Slow file access | WSL accessing `/mnt/` Windows files | Clone repos to WSL-native filesystem for speed |
| Git line endings | Windows CRLF vs Linux LF | Configure `git config core.autocrlf input` |

Cross-reference: Section 2.1 (Environment Setup), Appendix A.7 (Environment Tool Selection)

### A.10. External API Portability

When projects depend on external APIs for data download (Kaggle, HuggingFace, cloud
storage), authentication and access methods can change without notice. Plan for
portability from the start.

**Key Principles:**

1. **Prefer direct HTTP calls over CLI wrappers.** CLI wrappers add dependency layers
   that break across environments (local vs Colab vs CI). Direct API calls with bearer
   tokens are more portable and debuggable.

2. **Document the auth method used.** Include a comment in the notebook explaining
   why a specific auth approach was chosen. Future readers need context when the API
   changes.

3. **Implement fallback logic for data paths:**
   ```python
   import os
   if os.path.exists('data/train.csv'):
       df = pd.read_csv('data/train.csv')  # Local path
   else:
       # Download from API (environment-specific)
       df = download_from_api(competition_name)
   ```

4. **Pin the auth method in project documentation.** Record in the checkpoint or
   README which auth approach works, so it can be updated when APIs change.

5. **Test API calls in the target environment early** (Day 1-2), not at the end.
   Environment-specific auth issues are easier to resolve before the full pipeline
   is built.

**Common API Portability Issues:**

| API | Issue | Solution |
|-----|-------|----------|
| Kaggle | CLI conflicts with Colab packages | Use direct HTTP with bearer token |
| HuggingFace | Token storage varies by environment | Use `HF_TOKEN` environment variable |
| Cloud storage | Credential file paths differ | Use environment variables, not file paths |

Cross-reference: Section 2.1 (Environment Setup), Appendix A.9 (WSL & Cross-Platform)

---

**End of Appendix A**

Return to main document: **Section 2.1: Phase 0: Environment Setup**

---

# Appendix B: Phase Deep Dives

**Part of:** Data Science Collaboration Methodology v1.1  
**Main Document:** `1.0_Data_Science_Collaboration_Methodology.md` → Section 2  
**Purpose:** Implementation guidance and decision frameworks for each project phase

---

## B.1. Phase 0 Deep Dive: Environment Setup

Setup scripts and VS Code configuration are covered in Appendix A.

**Key IDE setup points:**
- Configure your IDE to point to the project virtual environment interpreter
- Register separate Jupyter kernels per project for isolation

---

## B.2. Phase 1 Deep Dive: Exploration

### B.2.1. Data Quality Assessment Orientation

A quality assessment should cover:
- **Structure:** shape, memory usage, data types
- **Completeness:** missing values by column (count and percentage)
- **Uniqueness:** duplicate rows, unique value counts for categorical columns
- **Validity:** outlier detection, value range checks
- **Statistics:** descriptive statistics for numeric columns

Print actual values at each step.

### B.2.2. Cohort Definition Strategies

When defining analysis cohorts:
- Start with full population, apply filters sequentially
- Print population size after each filter to track reduction
- Document filter criteria explicitly (time window, activity threshold, completeness requirements)
- Validate final cohort against business expectations

### B.2.3. EDA Best Practices

For distribution analysis, combine multiple views:
- Histogram (shape), box plot (outliers), Q-Q plot (normality)
- Always print descriptive statistics alongside visualizations

### B.2.4. EDA Techniques by Data Type

Select techniques appropriate to data type:

- **Numeric:** Distribution summary, histograms, box plots, Q-Q plots, correlation heatmaps
- **Categorical:** Value counts, bar charts, cross-tabulations, independence tests
- **Temporal:** Time series plots, rolling statistics, seasonal decomposition, autocorrelation
- **Text:** Length distribution, word frequency, language detection

### B.2.5. Business Understanding Integration

**Domain Briefing Template (Before EDA):**



**EDA Validation Checklist (After EDA):**

Before moving to Feature Engineering, validate findings with domain expert:
- [ ] Shared summaries with stakeholder
- [ ] Confirmed entity definitions match business understanding
- [ ] Validated surprising findings (expected or investigate?)
- [ ] Agreed on analysis direction
- [ ] Documented any domain knowledge gained

### B.2.6. References

**EDA Framework Foundations:**

- **Three-Layer Framework:** Adapted from DIKW hierarchy (Ackoff, 1989) and general BI principles (Facts → Insights → Actions)
- **Exploratory Data Analysis Philosophy:** Based on John Tukey's seminal work (1977)
- **Business Understanding Integration:** Inspired by CRISP-DM (Chapman et al., 1999)

**Key References:**
- Tukey, J. W. (1977). *Exploratory Data Analysis*. Addison-Wesley.
- Chapman, P., et al. (1999). *CRISP-DM 1.0: Step-by-step data mining guide*. SPSS Inc.
- Ackoff, R. L. (1989). From data to wisdom. *Journal of Applied Systems Analysis*, 16(1), 3-9.

---

## B.3. Phase 2 Deep Dive: Feature Engineering

### B.3.1. Feature Generation Strategies

**Common feature generation patterns:**
- **Behavioral aggregations:** Group by entity, compute count/sum/mean/std/min/max
- **Derived ratios:** Rates, propensities (category_count / total_count)
- **Temporal features:** Days since last event, tenure, recency
- **Flatten multi-level columns** after groupby aggregation for clean feature names

**Key considerations:**
- Print feature count and shapes after generation
- Document each feature in a feature dictionary
- Use a reference date for temporal features (document which date and why)

### B.3.2. Feature Selection Methods

**Correlation-based selection orientation:**
- Compute absolute correlation matrix, identify pairs above threshold (e.g., 0.95)
- Use upper triangle to avoid duplicate pairs
- Print which features are dropped and why
- Correlation alone is insufficient; validate with importance methods (see B.3.3)

### B.3.3. Feature Ablation Study Methodology

**Purpose:** Systematically validate which features improve model performance.

**When to Use:**
- After feature engineering and before final model training
- When feature count is high (>30 features) or overfitting is a concern

**Three-Stage Validation:**

1. **Permutation Importance (Quick Filter):** Shuffle each feature's values, measure performance drop. Features with importance below threshold are candidates for removal.
2. **Ablation Study (Confirm Removal):** Remove candidate features, retrain, compare metrics. Confirm removal only if performance stays same or improves.
3. **SHAP Values (Optional Deep Validation):** Computationally expensive; use for final confirmation, not initial screening.

**Common Pitfalls:**
- Removing features based on correlation alone (use importance + ablation)
- Keeping all features "just in case" (simpler models generalize better)
- Removing without validation (always retrain and measure)
- Ignoring domain knowledge (investigate if model disagrees with business logic)

---

## B.4. Phase 3 Deep Dive: Analysis

### B.4.1. Algorithm Selection Orientation

When selecting algorithms:
- Compare at least 2-3 candidate approaches with consistent metrics
- Use internal validation metrics appropriate to the problem type
- Document the comparison in a structured decision log entry

### B.4.2. Validation Techniques Orientation

Key validation considerations:
- Test stability across random seeds or initializations
- Use appropriate cross-validation strategy (temporal for time series, grouped for entity data)
- Report confidence intervals, not just point estimates

### B.4.3. Scale-Dependent Validation Protocol

**Critical Finding:** Model selection at sample scale may not hold at production scale.

**Why This Happens:**
- Hyperparameters tuned on samples may not generalize
- Different computational patterns at scale (memory, batch dynamics)
- Convergence behavior changes with dataset size

**Protocol:**
1. **Sample Development (10-30% of data):** Train and compare candidate models
2. **Scale Validation (50-100% of data):** Test top 2-3 models at production scale before finalizing
3. **Compare and Document:** If the winner changes at scale, document in decision log

**When to Apply:**
- Production dataset >10x sample size
- Models with many hyperparameters
- When sample winner has narrow margin (<5% improvement)

---

## B.5. Phase 4 Deep Dive: Communication

### B.5.1. Notebook Consolidation Strategy

**Consolidation Process:**

1. **Identify Essential Code:** Remove dead ends, keep successful approaches, consolidate similar analyses
2. **Add Narrative:** Clear headers, explain rationale, interpret results
3. **Clean Outputs:** Remove excessive prints, keep key visualizations, add summaries

### B.5.2. Report Writing Guidelines

**Executive Summary Template:**


**Technical Report Structure:**


### B.5.3. Presentation Design

**Slide Deck Structure:**
- **Title** (1 slide): Project name, date, presenter
- **Executive Summary** (2 slides): Key findings, bottom-line recommendation
- **Business Context** (2 slides): Problem, objectives, success criteria
- **Approach** (2 slides): Methodology overview, data sources
- **Results** (4-5 slides): Main findings (1 per slide), visualizations, business interpretation
- **Recommendations** (2 slides): Actions, expected impact, next steps
- **Q&A / Appendix** (1 slide): Technical details available

---

**End of Appendix B**

Return to main document: **Section 2: Core Workflow**

---

# Appendix C: Advanced Practices Detailed

**Part of:** Data Science Collaboration Methodology v1.1  
**Main Document:** `1.0_Data_Science_Collaboration_Methodology.md` → Section 5  
**Purpose:** Detailed implementation guidance for advanced practices (Tiers 2-4)

---

## C.1. Experiment Tracking Implementation

**When to Use:** Projects with multiple model iterations, parameter tuning, or algorithm comparisons.

### C.1.1. Experiment Tracking Orientation

Track experiments systematically using either manual methods (CSV/spreadsheet logging) or dedicated tools (MLflow, Weights & Biases, Neptune.ai). Key requirements:
- Log parameters, metrics, and notes for every experiment run
- Maintain a central registry of all experiments
- Ensure reproducibility: another practitioner should be able to rerun from the log

### C.1.2. Tool Selection Guidance

| Approach | Best For | Trade-off |
|----------|----------|-----------|
| Manual CSV | Small projects, quick prototyping | Simple but no versioning |
| MLflow | Team projects, model registry needed | Setup overhead, full features |
| W&B / Neptune | Collaborative research, visualization | Cloud dependency, cost |

Choose based on project complexity and team size. Manual tracking is sufficient for solo academic projects.

---

### C.1.3. Capability Experiment Template

#### General 7-Element Framework

A domain-agnostic experiment template grounded in established frameworks
(Sculley et al., 2015; Google Rules of ML; MLflow; Weights & Biases;
Neptune.ai; Papers with Code). Use this for any experiment; the detailed
templates below extend it for RAG and software-specific evaluations.

```markdown
# EXP-###: [Experiment Title]

## 1. Hypothesis
[Testable claim with measurable prediction]

## 2. Baseline
[Current state with quantified metrics; what "before" looks like]

## 3. Method
[Steps to test the hypothesis; reproducible procedure]

## 4. Variables
- **Independent:** [What you change]
- **Dependent:** [What you measure]
- **Controlled:** [What you hold constant]

## 5. Success Criteria
[Threshold for accepting/rejecting; defined BEFORE running]

## 6. Results
[Actual outcomes with comparison to baseline]

## 7. Decision
[Accept / Reject / Iterate — with rationale]
```

**Key discipline:** Define success criteria (element 5) before running the
experiment. Post-hoc criteria invite confirmation bias.

#### RAG and Software Capability Experiments

**When to Use:** Testing system behaviors, edge cases, or capabilities where results include both numeric metrics and behavioral observations. Run a minimal capability experiment against real data in Sprint 1 to validate format assumptions before finalizing parser/extractor design (see DSM 4.0 Section 4.4.1: Fixture Validation Principle).

**Gap Addressed:** Standard experiment tracking (C.1.1, C.1.2) focuses on ML metrics. Software and RAG projects require structured documentation for both quantitative scores and qualitative capability assessments.

**Evaluation Framework (per Chen et al., 2025):**

| Dimension | Type | What It Measures |
|-----------|------|------------------|
| **Internal - Retrieval** | Quantitative | Precision@K, Recall@K, NDCG, MRR |
| **Internal - Generation** | Quantitative | ROUGE, BLEU, BERTScore, faithfulness |
| **Internal - Capability** | Qualitative | Pass/Fail/Partial behavioral tests |
| **External - Safety** | Both | Robustness, factuality, adversarial resilience |
| **External - Efficiency** | Quantitative | Latency, token consumption, cost-per-query |

**Required Fields:**

| Field | Description |
|-------|-------------|
| experiment_id | Unique identifier (EXP-###) |
| experiment_name | Descriptive name |
| objective | What capability is being tested |
| hypothesis | Expected behavior or metric threshold |
| test_setup | Configuration, test data, environment |
| test_cases | Specific scenarios to evaluate |
| evaluation_type | Quantitative / Qualitative / Both |

**Quantitative Results Template:**

```markdown
## Quantitative Results

### Retrieval Metrics
| Metric | Value | Threshold | Status |
|--------|-------|-----------|--------|
| Precision@5 | 0.82 | >= 0.75 | Pass |
| Recall@10 | 0.91 | >= 0.85 | Pass |
| MRR | 0.76 | >= 0.70 | Pass |

### Generation Metrics
| Metric | Value | Threshold | Status |
|--------|-------|-----------|--------|
| Faithfulness (RAGAS) | 0.87 | >= 0.80 | Pass |
| Context Precision | 0.92 | >= 0.85 | Pass |
| BERTScore F1 | 0.89 | >= 0.80 | Pass |

### Efficiency Metrics
| Metric | Value | Threshold | Status |
|--------|-------|-----------|--------|
| Avg Latency | 1.2s | <= 2.0s | Pass |
| Cost per Query | $0.003 | <= $0.01 | Pass |
| Token Usage | 1,850 | <= 3,000 | Pass |
```

**Qualitative Results Template:**

```markdown
## Qualitative Results

### Capability Tests
| Test Case | Expected Behavior | Actual Behavior | Status |
|-----------|-------------------|-----------------|--------|
| Scenario 1 | Behavior X | Observed behavior | Pass/Fail/Partial |
| Scenario 2 | Behavior Y | Observed behavior | Pass/Fail/Partial |

### Safety Tests
| Test Case | Risk Category | Expected | Actual | Status |
|-----------|---------------|----------|--------|--------|
| Adversarial prompt | Robustness | Reject/deflect | Behavior | Pass/Fail |
| PII in context | Privacy | Redact/ignore | Behavior | Pass/Fail |
| Conflicting sources | Factuality | Note conflict | Behavior | Pass/Fail |
```

**Findings Section Template:**

```markdown
## Findings

### Quantitative Summary
- Retrieval: [X/Y metrics passed threshold]
- Generation: [X/Y metrics passed threshold]
- Efficiency: [X/Y metrics within budget]

### Confirmed Capabilities
- [What works as expected - behavioral]

### Limitations Identified
- [What doesn't work or works inconsistently]

### Safety Observations
- [Robustness, factuality, adversarial findings]

### Edge Cases
- [Unexpected behaviors discovered]

### User Guidance
- [Workarounds for limitations if MVP]

### Future Improvements
- [Actions for next version]
```

**Design Decisions Template:**

Within an experiment, implementation-level decisions (alternative approaches,
trade-offs, external concepts) should be documented separately from project-level
DEC-### records. This captures rationale that would otherwise be lost in code.

```markdown
## Design Decisions

| Decision | Alternatives Considered | Rationale | Reference |
|----------|------------------------|-----------|-----------|
| [Choice made] | [What else was considered] | [Why this option] | [Paper, API doc, benchmark] |
```

**References Template:**

Cite external tools, benchmarks, APIs, and research used in the experiment.
Every external concept referenced in the implementation should appear here.

```markdown
## References

| Source | Type | How Used |
|--------|------|----------|
| [Paper/tool/API name] | Paper / Library / API / Benchmark | [Role in experiment] |
```

**Complete Example - RAG System Evaluation:**

```markdown
# EXP-001: Multi-Source Conflict Detection

**Objective:** Test whether RAG system identifies conflicting information and maintains factuality.

**Hypothesis:**
- Quantitative: Faithfulness >= 0.80, Context Precision >= 0.85
- Qualitative: System notes when sources disagree on factual matters

**Test Setup:**
- 3 documents with intentionally conflicting dates
- 50 test queries (25 simple, 25 comparative)
- Standard retrieval configuration, Temperature: 0.1

**Evaluation Type:** Both

## Quantitative Results

### Retrieval Metrics
| Metric | Value | Threshold | Status |
|--------|-------|-----------|--------|
| Precision@5 | 0.84 | >= 0.75 | Pass |
| Context Recall | 0.88 | >= 0.85 | Pass |

### Generation Metrics (RAGAS)
| Metric | Value | Threshold | Status |
|--------|-------|-----------|--------|
| Faithfulness | 0.87 | >= 0.80 | Pass |
| Context Precision | 0.92 | >= 0.85 | Pass |
| Answer Relevancy | 0.91 | >= 0.85 | Pass |

### Efficiency Metrics
| Metric | Value | Threshold | Status |
|--------|-------|-----------|--------|
| Avg Latency | 1.4s | <= 2.0s | Pass |
| Cost per Query | $0.004 | <= $0.01 | Pass |

## Qualitative Results

### Capability Tests
| Query Type | Multi-Source Detection | Conflict Identification | Status |
|------------|------------------------|------------------------|--------|
| Simple question | Partial | No | Partial |
| Explicit "differences" query | Yes | Yes | Pass |
| Implicit conflict question | Yes | Yes | Pass |

### Safety Tests
| Test Case | Risk Category | Expected | Actual | Status |
|-----------|---------------|----------|--------|--------|
| Contradictory facts | Factuality | Note uncertainty | Silent merge | Fail |
| Outdated vs current | Factuality | Prefer recent | Used both | Partial |

## Findings

### Quantitative Summary
- Retrieval: 2/2 metrics passed
- Generation: 3/3 metrics passed
- Efficiency: 2/2 metrics within budget

### Confirmed Capabilities
- Retrieves from multiple sources when query mentions "differences"
- Can identify conflicts when explicitly asked
- High faithfulness to retrieved context

### Limitations Identified
- LIM-001: Simple queries may miss conflicts (silent merge)
- LIM-002: No automatic date/version preference

### Safety Observations
- Factuality risk: System may present conflicting info as unified truth
- Recommend: Add conflict detection prompt engineering

### User Guidance
- Use explicit comparison language: "What are the differences..."
- Ask follow-up: "Do sources agree on this?"

### Future Improvements
- Add conflict detection layer before generation
- Implement source recency weighting
```


### C.1.4. RAG Evaluation Metrics Reference

**Framework Overview (per Chen et al., 2025 Survey):**

| Framework | Focus | Key Metrics |
|-----------|-------|-------------|
| **RAGAS** | Generation quality | Faithfulness, Context Precision/Recall, Answer Relevancy |
| **RAGBench** | End-to-end | TRACe: Utility, Relevance, Adherence, Completeness |
| **SafeRAG** | Safety | Adversarial robustness, attack resistance |
| **FreshLLMs** | Temporal | Dynamic QA, false-premise detection |

**Internal Evaluation Metrics:**

| Category | Traditional Metrics | LLM-Based Metrics |
|----------|--------------------|--------------------|
| **Retrieval** | Precision@K, Recall@K, NDCG, MRR, MAP | ARES, External Context Score |
| **Generation** | ROUGE, BLEU, BERTScore, Exact Match | RAGAS faithfulness, GPTScore, FactScore |

**External Evaluation Metrics:**

| Category | What to Measure | Example Tests |
|----------|-----------------|---------------|
| **Robustness** | Resistance to input variations | Typos, paraphrasing, adversarial prompts |
| **Factuality** | Groundedness in sources | Hallucination rate, citation accuracy |
| **Adversarial** | Attack resistance | Prompt injection, jailbreak attempts |
| **Privacy** | PII handling | Redaction, refusal to expose sensitive data |
| **Fairness** | Bias detection | Demographic parity in responses |
| **Efficiency** | Resource usage | Latency, tokens, cost-per-query |

**Best Practice - Combined Evaluation:**

1. **Baseline Quantitative (Required):** Faithfulness, context precision/recall, efficiency metrics
2. **Extended Quantitative (Recommended):** TRACe metrics, traditional NLG metrics for ground truth comparison
3. **Qualitative Capability (Required):** Use C.1.3 template for behavioral tests
4. **Safety Evaluation (For Production):** Adversarial prompt testing, PII/privacy checks, factuality under conflicting sources

**References:**
1. Chen et al. (2025). "Retrieval Augmented Generation Evaluation in the Era of Large Language Models." arXiv:2504.14891
2. RAGAS Documentation: https://docs.ragas.io/en/stable/concepts/metrics/overview/

---

### C.1.5. Limitation Discovery Protocol

**When an experiment identifies a limitation:**

**Step 1: Document in Experiment File**

```markdown
## Limitation: LIM-###: [Brief Description]

**Discovery:** EXP-### [Experiment where discovered]
**Type:** Quantitative Threshold / Qualitative Behavior / Safety Gap

**Evidence:**
- Metric/Test: [What was measured or tested]
- Expected: [Threshold or behavior]
- Actual: [Result]

**Impact:** [How this affects users]
**Severity:** Critical / High / Medium / Low

**Reproducible Test Case:**
- Input: "[exact query or input]"
- Configuration: [relevant settings]
- Expected: [expected output/behavior]
- Actual: [actual output/behavior]
```

**Step 2: Determine Disposition**

| Disposition | Criteria | Action Required |
|-------------|----------|-----------------|
| **Fix Now** | Critical/High severity, blocks release | Create task, fix before release |
| **Accept for MVP** | Low/Medium, workaround exists | Document workaround, note in README |
| **Defer** | Medium, complex fix, not blocking | Add to backlog, track in roadmap |

**Decision Matrix:**

| Severity | Workaround Exists | Disposition |
|----------|-------------------|-------------|
| Critical | Any | Fix Now |
| High | No | Fix Now |
| High | Yes | Accept for MVP (with prominent warning) |
| Medium | No | Defer or Fix Now (team decision) |
| Medium | Yes | Accept for MVP |
| Low | Any | Accept for MVP or Defer |

**Step 3: If Accepting for MVP**

Checklist:
- [ ] Add user guidance to UI/documentation
- [ ] Document in README "Known Limitations" section
- [ ] Note in release checkpoint
- [ ] Create backlog item for future fix (BACKLOG-###)
- [ ] Update experiment doc with disposition

**README Known Limitations Template:**

```markdown
## Known Limitations

| ID | Description | Workaround | Planned Fix |
|----|-------------|------------|-------------|
| LIM-001 | Conflict detection requires explicit query | Use "compare" or "differences" in query | v2.0 |
| LIM-002 | PDF tables not parsed | Extract tables manually | v1.1 |
```

**Step 4: If Deferring to Future Version**

```markdown
## Future Improvements

### LIM-###: [Limitation Name]

**Current Behavior:** [What happens now]
**Desired Behavior:** [What should happen]
**Root Cause:** [Why this happens - if known]

**Proposed Solution:**
[Technical approach]

**Quantitative Target:**
- Current: [metric = X]
- Target: [metric >= Y]

**Estimated Effort:** Small / Medium / Large
**Priority:** Low / Medium / High
**Target Version:** vX.Y
**Backlog Reference:** BACKLOG-###
```

**Limitation Tracking Summary Table:**

| ID | Description | Type | Severity | Evidence | Disposition | Tracking |
|----|-------------|------|----------|----------|-------------|----------|
| LIM-001 | Conflict detection needs explicit query | Qualitative | Medium | EXP-001: 0/25 simple queries detected conflicts | Accept MVP | README, BACKLOG-004 |
| LIM-002 | Faithfulness drops below threshold on long context | Quantitative | High | EXP-002: 0.72 < 0.80 threshold | Fix Now | TASK-015 |
| LIM-003 | No adversarial prompt protection | Safety | Critical | EXP-003: 3/5 injection attempts succeeded | Fix Now | TASK-016 |

**Cross-Reference:**

For software/RAG projects using these templates, see also:
- DSM_4.0 Section 3: Testing Strategy (unit/integration/E2E)
- DSM_4.0 Section 4: Quality Gates (when to use capability experiments)

**References:**

1. Chen et al. (2025). "Retrieval Augmented Generation Evaluation in the Era of Large Language Models: A Comprehensive Survey." arXiv:2504.14891
2. RAGAS Documentation: https://docs.ragas.io/en/stable/concepts/metrics/overview/
3. RAGBench: TRACe metrics for end-to-end RAG evaluation

---

### C.1.6. Experiment Artifact Organization

**When to Use:** Any project conducting capability experiments (C.1.3) that needs systematic organization of experiment scripts, results, and test data.

**Operational protocol:** The Experiment Execution Protocol in DSM_0.2 core
provides the behavioral trigger that activates this framework. This appendix
defines the templates and conventions; DSM_0.2 ensures they are followed.

#### Folder Structure

```
data/experiments/
├── EXPERIMENTS_REGISTRY.md           # Central index (required)
├── s{SS}_d{DD}_exp{NNN}/             # Experiment folder (one per experiment)
│   ├── README.md                     # Summary + quick reference
│   ├── exp_{NNN}_*.py                # Experiment script(s)
│   ├── exp_{NNN}_results.json        # Results data
│   └── test_data/                    # Optional: experiment-specific test files
```

#### Naming Convention

**Folder Pattern:** `s{sprint}_d{day}_exp{id}`

| Component | Format | Description | Example |
|-----------|--------|-------------|---------|
| Sprint | `sXX` | Two-digit sprint number | `s03` |
| Day | `dXX` | Two-digit day number | `d07` |
| Experiment | `expNNN` | Three-digit experiment ID | `exp002` |

**Full Example:** `s03_d07_exp002/` = Sprint 3, Day 7, EXP-002

#### Experiments Registry Template

Create `data/experiments/EXPERIMENTS_REGISTRY.md`:

```markdown
# Experiments Registry

| ID | Name | Sprint | Day | Date | Result | Folder |
|----|------|--------|-----|------|--------|--------|
| EXP-001 | Multi-Source Detection | 2 | 6 | 2026-01-25 | PARTIAL | `s02_d06_exp001/` |
| EXP-002 | Cross-Lingual Retrieval | 3 | 7 | 2026-01-26 | PASS | `s03_d07_exp002/` |
```

**Required Columns:**
- **ID:** Unique experiment identifier (EXP-NNN)
- **Name:** Short descriptive name
- **Sprint/Day:** Timeline reference
- **Date:** Execution date
- **Result:** PASS / PARTIAL / FAIL / INCONCLUSIVE
- **Folder:** Link to experiment folder

#### Experiment README Template

Each experiment folder should contain a `README.md`:

```markdown
# EXP-{NNN}: {Experiment Name}

**Sprint:** {N} | **Day:** {N} | **Date:** YYYY-MM-DD

## Summary
{One paragraph describing experiment aim and approach}

## Files
| File | Description |
|------|-------------|
| `exp_{NNN}_script.py` | Experiment script |
| `exp_{NNN}_results.json` | Results data |

## Key Findings
- {Finding 1}
- {Finding 2}

## Result
**{PASS/PARTIAL/FAIL}** - {Brief explanation}

## References
- Capability Experiment: See C.1.3 template for full methodology
- Related Decision: DEC-{NNN} (if applicable)
```

#### Relationship to Documentation

| Location | Purpose | Content |
|----------|---------|---------|
| `data/experiments/` | Executable artifacts | Scripts, results, test data |
| `dsm-docs/experiments/` | Documentation | Detailed reports, methodology discussions |

Link between them in README files for traceability.

#### Benefits

1. **Timeline Visibility:** Sprint/day prefix shows experiment chronology
2. **Self-Contained:** Each experiment folder has everything needed to reproduce
3. **Quick Reference:** Registry provides instant overview of all experiments
4. **Scalable:** Works for 5 or 50 experiments
5. **DSM-Aligned:** Uses established `sYY_dXX` naming pattern from file naming standards

#### Cross-Reference

- **C.1.3:** Capability Experiment Template (how to conduct experiments)
- **C.1.4:** RAG Evaluation Metrics (what metrics to capture)
- **C.1.5:** Limitation Discovery Protocol (how to document limitations found)
- **DSM 4.0 Section 3.4:** Tests vs Capability Experiments (when to use each)

---


## C.2. Hypothesis Management Implementation

**When to Use:** Research projects, stakeholder validation, or projects with clear hypotheses.

### C.2.1. Hypothesis Documentation Template

```markdown
# Hypothesis H1: [Brief Description]

**Date Proposed:** YYYY-MM-DD
**Status:** [Proposed | Testing | Confirmed | Rejected | Revised]
**Priority:** [High | Medium | Low]

## Hypothesis Statement
**Formal:** [Statistical hypothesis]
**Plain Language:** [Business hypothesis]

## Variables
**Independent:** [What we're testing]
**Dependent:** [What we're measuring]
**Controls:** [What we're holding constant]

## Pre-Registration
**Test Method:** [Statistical test to use]
**Significance Level:** [e.g., 0.05]

## Test Results
**Test Date:** YYYY-MM-DD
**Test Statistic:** [Value]
**P-Value:** [Value]
**Effect Size:** [Value]
**Conclusion:** [Reject/Fail to Reject null]

## Business Interpretation
[What this means for stakeholders]

## Next Steps
[Action items based on results]
```

### C.2.2. Statistical Testing Orientation

Choose the appropriate statistical test based on your data:
- **Two independent groups:** t-test (continuous) or chi-square (categorical)
- **Paired observations:** Paired t-test or Wilcoxon signed-rank
- **Multiple groups:** ANOVA or Kruskal-Wallis
- Always report effect size alongside p-values; statistical significance alone is insufficient

---

## C.3. Performance Baseline Orientation

**When to Use:** Evaluating model improvements or justifying approach complexity.

Establish baselines before building complex models:
- **Naive baseline:** Majority class (classification) or mean value (regression)
- **Simple model baseline:** Logistic regression or decision tree with default parameters
- **Domain baseline:** Current business process performance (if available)

Any model must demonstrably outperform the baseline to justify its complexity.

---

## C.4. Ethics and Bias Audit Orientation

**When to Use:** Models affecting people, sensitive attributes, or regulated industries.

Key audit steps:
- Check outcome distributions across sensitive attributes (gender, age, location)
- Calculate fairness metrics: demographic parity, equalized odds
- Test for disparate impact using the four-fifths rule
- Document findings and mitigation strategies in the decision log

---

## C.5. Testing Strategy Orientation

**When to Use:** Production deployments, team collaboration, or code reuse.

Essential test categories:
- **Data validation:** Schema checks, type enforcement, range constraints
- **Function unit tests:** Verify transformations produce expected results
- **Pipeline integration tests:** End-to-end data flow verification

Use pytest or equivalent. Write tests alongside code, not after.

---

## C.6. Data Versioning Orientation

**When to Use:** Multiple data versions, reproducibility critical, or team data sharing.

Versioning approaches:
- **Simple file versioning:** `{entity}_v{N.N}_{YYYYMMDD}.csv` naming convention
- **DVC (Data Version Control):** Git-like versioning for large data files
- **Database snapshots:** For SQL-based data sources

Choose based on data size and team needs. Simple file versioning is sufficient for most individual projects.

---

## C.7. Technical Debt Register Implementation

**When to Use:** Long-term projects (>6 months), growing codebases, or team projects.

### C.7.1. Debt Documentation

```markdown
# Technical Debt Register

## TD-001: [Debt Title]

**Created:** YYYY-MM-DD
**Priority:** High / Medium / Low
**Effort:** [Estimated hours]

### Current State
[What exists now and why it is problematic]

### Ideal State
[What the code/process should look like]

### Impact
- **Maintenance:** [How this affects ongoing work]
- **Portability:** [How this affects deployment/sharing]
- **Risk:** [What could go wrong]

### Paydown Plan
1. [Step 1]
2. [Step 2]
**Estimated time:** [hours]

### Status
- [ ] Planned
- [ ] In Progress
- [ ] Complete
```

---

## C.8. Scalability Orientation

**When to Use:** Data growth expected, user base expansion, or performance issues.

Key considerations:
- Estimate memory requirements before loading full datasets
- Use chunked processing or distributed frameworks (Dask, Spark) for datasets exceeding available RAM
- Profile code to identify bottlenecks before optimizing
- Design data pipelines for incremental processing where possible

---

## C.9. Literature Review Implementation

**When to Use:** Novel problems, research projects, or no established best practices.

### C.9.1. Information Extraction Template

```markdown
# Literature Review: [Topic]

## Paper 1: "[Title]"

**Citation:** [Author et al. (Year). Journal, Volume(Issue), Pages.]

### Problem Addressed
[What the paper tackles]

### Approach
[Methods used]

### Key Findings
[Main results]

### Relevant to Our Project
[How this informs our work]

### Limitations
[What the paper does not cover]
```

---

## C.10. Risk Management Implementation

**When to Use:** High-stakes decisions, multiple dependencies, or uncertain requirements.

### C.10.1. Risk Register Template

```markdown
# Risk Register

## Risk R-001: [Risk Title]

**Probability:** [High / Medium / Low]
**Impact:** [High / Medium / Low]
**Risk Score:** [Combined assessment]

### Description
[What could go wrong]

### Mitigation
[Steps to reduce probability or impact]

### Contingency
[Plan if the risk materializes]

### Owner
[Who is responsible]

### Status
- [ ] Identified
- [ ] Mitigation in place
- [ ] Triggered
- [ ] Resolved
```

---

**End of Appendix C**

Return to main document: **Section 5: Advanced Practices**

---

# Appendix D: Domain Adaptations

**Part of:** Data Science Collaboration Methodology v1.1
**Main Document:** `1.0_Data_Science_Collaboration_Methodology.md` → Section 2
**Purpose:** Domain-specific adaptations of the 4-phase methodology

---

**For projects where the primary deliverable is a working application** (not analytical insights), see **DSM 4.0: Software Engineering Adaptation** (`DSM_4.0_Software_Engineering_Adaptation_v1.0.md`).

DSM 4.0 provides:
- Adapted phase structure (Data Pipeline → Core Modules → Integration → Application)
- Module development protocol (replaces notebook protocol)
- Architectural decision log templates
- Portfolio project checklists
- Deployment patterns (Streamlit, APIs)

**Use DSM 4.0 for:** LLM applications, ML pipelines, data processing tools, API services with ML backends.

---

## D.1. Time Series Projects

### D.1.1. Phase Adaptations

Each DSM phase requires domain-specific adjustments for time series work:

- **Exploration:** Focus on temporal patterns, stationarity, decomposition, and autocorrelation
- **Feature Engineering:** Lag features, rolling statistics, seasonal indicators, time-based aggregations
- **Analysis:** Respect temporal order in splits and cross-validation; define forecast horizon clearly
- **Communication:** Forecast vs actual plots, confidence intervals, horizon limitations, update strategy

### D.1.2. Key Techniques

- Stationarity testing (ADF, KPSS) to determine differencing needs
- Seasonal decomposition to separate trend, seasonal, and residual components
- Autocorrelation analysis (ACF/PACF) to inform model order selection

### D.1.3. Common Challenges

- Non-stationarity requiring differencing
- Seasonality at multiple scales
- Missing timestamps
- Irregular sampling intervals
- External regressors (holidays, events)

### D.1.4. Temporal Consistency Principle (Critical for Seasonal Data)

**Key Insight from Retail Forecasting Project:**

> **"In seasonal time series forecasting, temporal relevance trumps data volume."**

Use RECENT, SEASONALLY-RELEVANT data over MORE but MISMATCHED data.

**Key considerations:**
- More data does not always mean better performance; seasonal alignment matters more than volume
- Training and test ranges should be aligned to avoid extrapolation
- Validate training period choices with ablation studies
- Document rationale, especially when rejecting "use all data" defaults


## D.2. NLP Projects

### D.2.1. Orientation

Each DSM phase requires domain-specific adjustments for NLP work:

- **Exploration:** Text distribution analysis, token frequencies, language detection, class balance for labeled data
- **Feature Engineering:** Text cleaning, tokenization, vectorization choices (TF-IDF, embeddings), dimensionality
- **Analysis:** Model selection appropriate to task (classification, generation, extraction); evaluation metrics that account for text ambiguity
- **Communication:** Include example predictions, confusion patterns, and vocabulary-level insights

**Key considerations:**
- Preprocessing choices (stemming, lemmatization, stopwords) significantly affect results
- Embedding dimensionality and pretrained model selection are critical design decisions
- Human baseline is often the ceiling; establish inter-annotator agreement early
- Visualize embeddings to validate that representations capture expected structure

---

## D.3. Computer Vision Projects

### D.3.1. Orientation

Each DSM phase requires domain-specific adjustments for computer vision work:

- **Exploration:** Image quality assessment, class distribution, annotation quality review, resolution analysis
- **Feature Engineering:** Augmentation strategy, preprocessing pipeline, transfer learning base model selection
- **Analysis:** Architecture selection (pretrained vs custom), validation strategy accounting for data leakage through augmentation
- **Communication:** Visual examples of predictions, failure cases, and model attention (saliency/activation maps)

**Key considerations:**
- Data augmentation is essential but must be applied correctly (only to training set)
- Transfer learning from pretrained models is standard practice; fine-tuning strategy matters
- Validation must account for augmented copies of the same source image
- Model interpretability tools (Grad-CAM, saliency maps) are critical for stakeholder trust

---

## D.4. Clustering Projects

### D.4.1. Orientation

Each DSM phase requires domain-specific adjustments for clustering work:

- **Exploration:** Feature distributions, scale differences, distance metric appropriateness, dimensionality
- **Feature Engineering:** Scaling strategy, handling mixed data types (numeric + categorical), dimensionality reduction
- **Analysis:** Algorithm selection (partitional, hierarchical, density-based), K selection with internal metrics, cluster profiling
- **Communication:** Cluster profiles with business-meaningful descriptions, segment sizes, actionable characteristics

**Key considerations:**
- K selection should be data-driven; be prepared to pivot from business expectations
- Use multiple validation metrics (silhouette, Davies-Bouldin, domain-specific)
- Cluster profiling is the deliverable, not the clustering itself
- Scale and distance metric choices can change results dramatically

---

## D.5. Regression/Classification Projects

### D.5.1. Orientation

Each DSM phase requires domain-specific adjustments for supervised learning work:

- **Exploration:** Target variable distribution, class balance, feature-target relationships, outlier impact
- **Feature Engineering:** Encoding strategy for categoricals, interaction features, target-informed features (with leakage prevention)
- **Analysis:** Model selection, hyperparameter tuning, cross-validation strategy, threshold optimization (classification)
- **Communication:** Performance metrics appropriate to problem type, feature importance, decision boundaries, error analysis

**Key considerations:**
- Class imbalance requires explicit handling (sampling, loss weighting, threshold tuning)
- Feature importance interpretation depends on model type; use model-agnostic methods when comparing
- Regression outlier sensitivity varies by model; robust methods may be needed
- Threshold selection (classification) should be driven by business cost asymmetry

---

## D.6. General Domain Adaptation Guidelines

### When Adapting This Methodology:

**1. Preserve Core Structure:**
- Keep 4-phase workflow
- Maintain decision logging
- Document pivot criteria
- Follow stakeholder communication patterns

**2. Adjust Phase Content:**
- Phase 1: Domain-specific EDA techniques
- Phase 2: Domain-specific feature engineering
- Phase 3: Domain-appropriate models and validation
- Phase 4: Domain-relevant visualizations and metrics

**3. Extend Advanced Practices:**
- Add domain-specific Tier 2-4 practices as needed
- Example: Computer vision may need annotation quality checks
- Example: Time series may need forecast monitoring

**4. Update Standards:**
- Domain-specific file naming if needed
- Domain-specific notebook structure
- Adjust line count guidelines for domain complexity

---

**End of Appendix D**

Return to main document: **Section 2: Core Workflow**

For package recommendations by domain, see: **`1.1_Domain_Specific_Package_Reference.md`**

---

# Appendix E: Quick Reference

**Part of:** Data Science Collaboration Methodology v1.1  
**Main Document:** `1.0_Data_Science_Collaboration_Methodology.md`  
**Purpose:** Quick reference tables, checklists, and command reminders

---

## E.1. Phase Checklist Summary

### Phase 0: Environment Setup
- [ ] Virtual environment created (`.venv`)
- [ ] Base packages installed
- [ ] Jupyter kernel registered
- [ ] VS Code configured
- [ ] First notebook created
- [ ] Test imports successful

### Phase 1: Exploration
- [ ] Data loaded and validated
- [ ] Cohort defined and documented
- [ ] Data quality assessed
- [ ] Missing data understood
- [ ] Key distributions visualized
- [ ] Decision log updated
- [ ] Stakeholder update sent

### Phase 2: Feature Engineering
- [ ] All features calculated
- [ ] Feature dictionary created
- [ ] No data leakage verified
- [ ] Distributions validated
- [ ] Feature dataset exported
- [ ] Decision log updated
- [ ] Stakeholder update sent

### Phase 3: Analysis
- [ ] Model/algorithm selected and justified
- [ ] Validation performed
- [ ] Results interpreted
- [ ] Limitations documented
- [ ] Decision log updated
- [ ] Stakeholder update sent
- [ ] Ready for communication

### Phase 4: Communication
- [ ] Notebooks consolidated
- [ ] Presentation created
- [ ] Technical report written
- [ ] Q&A document prepared
- [ ] All deliverables reviewed
- [ ] Stakeholders notified
- [ ] Repository organized

---

## E.2. Command Cheat Sheet

### Environment Setup
```bash
# Create environment
python -m venv .venv

# Activate (Windows)
.venv\Scripts\activate

# Activate (Mac/Linux)
source .venv/bin/activate

# Install packages
pip install -r requirements_base.txt

# Register Jupyter kernel
python -m ipykernel install --user --name=project_base_kernel

# List kernels
jupyter kernelspec list

# Deactivate
deactivate
```

### Package Management
```bash
# List installed packages
pip list

# Save requirements
pip freeze > requirements.txt

# Install from requirements
pip install -r requirements.txt

# Upgrade package
pip install --upgrade package_name

# Uninstall package
pip uninstall package_name
```

### Git Commands (If Using)
```bash
# Initialize repo
git init

# Add files
git add .

# Commit
git commit -m "Message"

# Check status
git status

# View log
git log --oneline

# Create branch
git checkout -b branch_name
```

---

## E.3. Text Convention Reference

### Professional Standards

| Instead of | Use |
|------------|-----|
| Warning emoji | WARNING: |
| Checkmark symbol | OK: |
| Cross mark symbol | ERROR: |
| Decorative emoji (fire, chart, etc.) | (remove entirely) |

### Print Statement Standards

**Good Examples:**
```python
print(f"Loaded {df.shape[0]:,} rows, {df.shape[1]} columns")
print(f"OK: Data validation passed")
print(f"WARNING: Missing values detected in 'age' column")
print(f"Correlation: {value:.4f}")
```

**Bad Examples:**
```python
print("Done!")  # Not informative
print("OK: Complete")  # Uses emoji
print("Ready for next step!")  # Generic confirmation
```

---

## E.4. Common Patterns Table

### File Naming Patterns

| File Type | Pattern | Example |
|-----------|---------|---------|
| Notebook | `[##]_[PHASE]_[description].ipynb` | `01_EDA_data_quality.ipynb` |
| Data | `[entity]_v[#.#]_[YYYYMMDD].csv` | `users_v2.1_20251115.csv` |
| Report | `[Project]_[Type]_[Audience].ext` | `ProjectName_Executive_Summary.pdf` |

### Phase Codes

| Phase | Code | Purpose |
|-------|------|---------|
| 0 | ENV | Environment setup |
| 1 | EDA | Exploration & data analysis |
| 2 | FE | Feature engineering |
| 3 | CLUSTERING / CLASSIFICATION / REGRESSION | Analysis |
| 4 | FINAL | Communication & delivery |

### Number Formatting

| Context | Format | Example Output |
|---------|--------|----------------|
| Counts | `{value:,}` | `5,765` |
| Currency | `${value:,.2f}` | `$1,234.56` |
| Percentage | `{value:.1f}%` | `23.5%` |
| Correlation | `{value:.4f}` | `0.8542` |
| P-value | `{value:.4f}` | `0.0023` |

---

## E.5. Validation Metrics Quick Reference

### Clustering Metrics

| Metric | Range | Better | Description |
|--------|-------|--------|-------------|
| Silhouette Score | [-1, 1] | Higher | Cluster separation |
| Davies-Bouldin Index | [0, âˆž) | Lower | Cluster compactness vs separation |
| Calinski-Harabasz Score | [0, âˆž) | Higher | Ratio of between/within cluster variance |

### Classification Metrics

| Metric | Range | Use Case |
|--------|-------|----------|
| Accuracy | [0, 1] | Balanced classes |
| Precision | [0, 1] | Minimize false positives |
| Recall | [0, 1] | Minimize false negatives |
| F1-Score | [0, 1] | Balance precision and recall |
| ROC-AUC | [0, 1] | Overall discriminative ability |

### Regression Metrics

| Metric | Range | Better | Description |
|--------|-------|--------|-------------|
| RÂ² | (-âˆž, 1] | Higher | Variance explained |
| RMSE | [0, âˆž) | Lower | Root mean squared error |
| MAE | [0, âˆž) | Lower | Mean absolute error |

---

## E.6. Enhanced Decision Log Format

**Each decision should include these sections:**

1. **ID:** DEC-XXX (sequential across project)
2. **Date:** When decided (YYYY-MM-DD or Sprint X, Day Y)
3. **Notebook:** Filename where implemented (if applicable)
4. **Status:** Active / Superseded / Rejected
5. **Context:** What situation prompted this decision
6. **Decision:** What was decided (specific and actionable)
7. **Rationale:** Why this option was chosen (evidence-based)
8. **Alternatives Considered:** Other options evaluated and why rejected
9. **Impact:** Effect on scope, timeline, quality, or cost

**Full Template:**

```markdown
## DEC-XXX: [Decision Name]

**Date:** [YYYY-MM-DD] or Sprint [N], Day [D]
**Notebook:** [filename.ipynb] (if applicable)
**Status:** Active / Superseded / Rejected

**Context:**
[What situation or problem prompted this decision? What analysis led here?]

**Decision:**
[What was decided? Be specific and actionable. Use imperative language.]

**Rationale:**
[Why was this option chosen? What evidence supports it? Include metrics if available.]

**Alternatives Considered:**
1. [Option A] - Rejected because [specific reason with evidence]
2. [Option B] - Rejected because [specific reason with evidence]
3. [Option C] - Rejected because [specific reason with evidence]

**Impact:**
- **Scope:** [How this affects what's included/excluded]
- **Timeline:** [How this affects schedule - faster/slower/same]
- **Quality:** [How this affects accuracy/reliability/interpretability]
- **Cost:** [Resource implications - computational, time, budget]
- **Risk:** [New risks introduced or mitigated]

**Validation Plan:** (if applicable)
[How will we verify this was the right decision? What metrics will we track?]
```

**Benefits of Enhanced Format:**
- **Transparency:** Clear reasoning for future reference
- **Learning:** Failed alternatives teach as much as successes
- **Stakeholder communication:** Can explain "why not X?" confidently
- **Reproducibility:** Others can understand and challenge decisions
- **Portfolio value:** Demonstrates systematic thinking for job interviews

**Condensed Format (for quick reference):**

```markdown
## Decision [ID]: [Title]
**Date:** YYYY-MM-DD | **Phase:** [0-4] | **Status:** [Proposed/Approved/Implemented]

### Context
[Why this decision is needed]

### Options
1. Option A: [Pros/Cons]
2. Option B: [Pros/Cons] â† Selected

### Rationale
[Why Option B chosen]

### Impact
[What changed / Results]
```

### E.6.1. Decision Invalidation Arc Documentation

**Purpose:** Track how decisions evolve over time, including when earlier decisions are invalidated by later findings.

**Why Document Invalidation Arcs:**
- Decisions made with incomplete information may need revision
- Shows scientific process (hypothesis -> test -> revise)
- Prevents others from questioning "why did you include then remove?"
- Demonstrates learning and adaptation
- Valuable for project retrospectives

**Decision Invalidation Template:**

```markdown
## DEC-XXX: [New Decision Title]

**Date:** [Current date]
**Status:** Active
**Invalidates:** DEC-YYY ([Original decision title])

### Invalidation Context

**Original Decision (DEC-YYY):**
- Date: [When made]
- Decision: [What was decided]
- Rationale at the time: [Why it seemed correct]

**New Evidence:**
- [What changed or was discovered]
- [Specific metrics/findings that contradict original decision]
- [When/how this was discovered]

### Current Decision

**Decision:**
[What is now decided - often the opposite of DEC-YYY]

**Rationale:**
[Why the new evidence changes our approach]

### Arc Analysis

**What We Learned:**
[Key insight from this invalidation]

**Was DEC-YYY Wrong?**
[ ] Yes - Should have been caught earlier
[X] No - Made sense with available information at the time
[ ] Partially - Some aspects were incorrect

**Process Improvement:**
[How to potentially catch this earlier in future projects]

### Decision Chain
DEC-YYY (Sprint X) -> [Invalidation reason] -> DEC-XXX (Sprint Y)
```

**Best Practices for Invalidation Arcs:**

1. **Link decisions explicitly** - Use "Invalidates: DEC-XXX" in new decisions
2. **No shame in invalidation** - It's a sign of rigorous testing
3. **Document the arc, not just the outcome** - The journey matters
4. **Include in retrospectives** - Invalidation arcs are learning opportunities
5. **Update original decision status** - Mark as "Superseded by DEC-XXX"

**Decision Status Lifecycle:**
```
Proposed -> Active -> [Superseded by DEC-XXX | Rejected | Completed]
```

---

## E.7. Session Handoff Template (Condensed)

```markdown
# Session Handoff - [Project]
**Date:** YYYY-MM-DD | **Tokens:** X/190K (Y%)

## Status
- **Phase:** [Current]
- **Completed:** [What was done]
- **Next:** [Clear next steps]

## Key Decisions
- DEC-XXX: [Brief description]

## Files Created
- [File list with paths]

## Next Session Prompt
"Continuing [project]. Last completed [X]. Next: [Y]. Review handoff in dsm-docs/handoffs/."
```

**Note:** Store in `dsm-docs/handoffs/` within the project repository for continuity across sessions.

---

## E.8. Stakeholder Update Template (Condensed)

```markdown
## [Project] - Sprint [N] Update
**Date:** YYYY-MM-DD | **Status:** [On Track/Delayed/Blocked]

### Completed
- [Specific accomplishments]

### Key Insights
- [Data-driven findings]

### Next Sprint
- [Clear objectives]

### Concerns
- [Issues or "None"]
```

---

## E.9. Troubleshooting Quick Guide

| Issue | Quick Fix |
|-------|-----------|
| Kernel not found | Re-run: `python -m ipykernel install --user --name=project_base_kernel` |
| Package not found | Verify activation: `.venv\Scripts\activate`, then reinstall |
| Data won't load | Check path, file exists, read permissions |
| NaN in features | Check for division by zero, missing source data |
| Poor model performance | Check feature distributions, try different approach |
| Stakeholders confused | Simplify language, use analogies, add visuals |

---

## E.10. Quality Checklist

### E.10.1. Code Quality
- [ ] All cells execute without errors
- [ ] Outputs are informative (not "Done!")
- [ ] No hard-coded paths
- [ ] Clear variable names
- [ ] Comments for complex logic
- [ ] Text conventions followed (WARNING/OK/ERROR)
- [ ] No emojis in code or markdown

### E.10.2. Documentation Quality
- [ ] README.md updated
- [ ] Decision log current
- [ ] Feature dictionary complete
- [ ] Notebooks have markdown explanations
- [ ] Stakeholder updates sent

### E.10.3. Reproducibility
- [ ] requirements.txt current
- [ ] All data files documented
- [ ] Random seeds set
- [ ] Clear execution order
- [ ] No manual data edits

### E.10.4. Sprint Transition Verification

**Purpose:** Automated check that sprint is complete before proceeding.

**When to Run:** End of each sprint, before starting next sprint.

**What to Verify:**
1. **Required files exist:** Final dataset, feature dictionary, checkpoint, handoff document
2. **Dataset quality:** Shape matches expectations, target variable present, no unexpected nulls
3. **Documentation complete:** Checkpoint checklist items done, handoff has required sections

Create a project-specific verification script (`verify_sprint[N]_complete.py`) that
checks these categories and reports errors/warnings with clear pass/fail criteria.

---

## E.11. File Naming Standards

**Convention:** `sYY_dXX_PHASE_description.extension`

### E.11.1. Core Pattern Components

**Format breakdown:**
- `sYY`: Sprint number (01-04)
- `dXX`: Day number within sprint (01-05)
- `PHASE`: Work phase code (SETUP, EDA, FE, MODEL, REPORT)
- `description`: Brief descriptor (1-3 words, lowercase, hyphens)
- `extension`: File type (.ipynb, .pkl, .png, .md, etc.)

**Examples:**
- `s02_d01_FE_lags.ipynb` - Sprint 2, Day 1, Feature Engineering, lags notebook
- `s03_d02_MODEL_baseline-arima.pkl` - Sprint 3, Day 2, Modeling, baseline ARIMA model

### E.11.2. Phase Codes

| Phase Code | Purpose | Typical Sprint |
|------------|---------|----------------|
| SETUP | Environment configuration, data acquisition | Sprint 1 |
| EDA | Exploratory data analysis | Sprint 1 |
| FE | Feature engineering | Sprint 2 |
| MODEL | Modeling and validation | Sprint 3 |
| REPORT | Communication and documentation | Sprint 4 |

### E.11.3. File Type Conventions

**Notebooks (.ipynb):**
- **Working (Sprints 1-3):** `sYY_dXX_PHASE_description.ipynb`
  - Example: `s02_d01_FE_lags.ipynb`
- **Final (Sprint 4):** `XX_PHASE_description.ipynb`
  - Example: `03_FE_lags-rolling-aggregations.ipynb`

**Datasets (.pkl, .csv, .parquet):**
- **Working (Sprints 1-3):** `sYY_dXX_PHASE_description.pkl`
  - Example: `s02_d01_FE_with-lags.pkl`
- **Final (Sprint 4):** `PHASE_description_vX.pkl`
  - Example: `FE_features-engineered_v1.pkl`

**Visualizations (.png, .jpg):**
- **Working (Sprints 1-3):** `sYY_dXX_PHASE_description.png`
  - Example: `s02_d01_FE_lag-validation.png`
- **Final (Sprint 4):** `figXX_PHASE_description.png`
  - Example: `fig03_FE_feature-importance.png`

**Documentation (.md):**
- **Decision logs:** `DEC-XXX_description.md`
  - Example: `DEC-011_lag-nan-strategy.md`
- **Checkpoints:** `sYY_dXX_checkpoint.md`
  - Example: `s02_d01_checkpoint.md`
- **Sprint plans:** `SprintYY_ProjectPlan_vX.md`
  - Example: `Sprint2_ProjectPlan_v2.md`

### E.11.4. Directory Structure

```
project/
├── notebooks/              # sYY_dXX_*.ipynb (working) → XX_*.ipynb (final)
├── data/
│   ├── raw/               # Original data (never rename)
│   ├── processed/         # sYY_dXX_*.pkl (working)
│   └── results/           # PHASE_*_vX.pkl (final)
├── outputs/
│   └── figures/
│       ├── eda/           # sYY_dXX_EDA_*.png
│       ├── features/      # sYY_dXX_FE_*.png
│       ├── models/        # sYY_dXX_MODEL_*.png
│       └── final/         # figXX_*.png (Sprint 4)
└── dsm-docs/
    ├── decisions/         # DEC-XXX_*.md
    ├── plans/             # sYY_dXX_checkpoint.md, SprintYY_*.md
    └── reports/           # sYY_PHASE_report.md
```

### E.11.5. Naming Rules (Critical)

**DO:**
- Use sprint-first: `sYY_dXX` (not `dXX_sYY`)
- Lowercase descriptions: `lag-validation` (not `Lag_Validation`)
- Use hyphens: `temporal-patterns` (not `temporal_patterns`)
- Keep descriptions 1-3 words max
- Always include phase code
- Be consistent from Day 1

**DON'T:**
- Mix conventions (some sYY_dXX, some dXX_sYY)
- Use vague descriptions (`output.pkl`, `test.png`, `final.ipynb`)
- Omit phase codes
- Use special characters or spaces
- Create deeply nested unnamed folders

### E.11.6. Sprint 4 Consolidation Process

**Purpose:** Transform working files into clean, professional final structure

**Notebooks consolidation:**
1. Merge related daily notebooks (e.g., s02_d01, s02_d02, s02_d03 → 03_FE_comprehensive.ipynb)
2. Remove intermediate checkpoints and debugging cells
3. Add comprehensive markdown documentation
4. Sequential numbering: 01, 02, 03, 04, 05

**Datasets consolidation:**
1. Keep only final versions (e.g., `FE_features-engineered_v1.pkl`)
2. Archive intermediate datasets → `data/processed/archive/`
3. Document lineage in README

**Visualizations consolidation:**
1. Select 10-15 best visualizations for publication
2. Rename with `fig##` prefix (sequential)
3. Move to `outputs/figures/final/`
4. Archive working plots

**Sprint 4 Consolidation Checklist:**
- [ ] Merge EDA notebooks → `02_EDA_comprehensive.ipynb`
- [ ] Merge FE notebooks → `03_FE_features.ipynb`
- [ ] Merge MODEL notebooks → `04_MODEL_analysis.ipynb`
- [ ] Finalize datasets in `data/results/`
- [ ] Select and rename visualizations with `fig##` prefix
- [ ] Archive intermediate files
- [ ] Update all README files with lineage

### E.11.7. Quick Examples by Sprint

**Sprint 1 (EDA):**
```
s01_d01_SETUP_data-inventory.ipynb
s01_d02_EDA_data-loading.ipynb
s01_d03_EDA_quality-check.ipynb
s01_d04_EDA_temporal-patterns.ipynb
s01_d05_EDA_context-export.ipynb
```

**Sprint 2 (Feature Engineering):**
```
s02_d01_FE_lags.ipynb
s02_d02_FE_rolling.ipynb
s02_d03_FE_aggregations.ipynb
s02_d04_FE_validation.ipynb
s02_d05_FE_final-export.ipynb
```

**Sprint 3 (Modeling):**
```
s03_d01_MODEL_baseline.ipynb
s03_d02_MODEL_advanced.ipynb
s03_d03_MODEL_validation.ipynb
s03_d04_MODEL_tuning.ipynb
s03_d05_MODEL_final.ipynb
```

**Sprint 4 (Consolidation):**
```
01_SETUP_environment-data.ipynb
02_EDA_comprehensive.ipynb
03_FE_features-engineering.ipynb
04_MODEL_analysis-validation.ipynb
05_REPORT_final-deliverables.ipynb
```

### E.11.8. Git Integration

**Commit message pattern:**
```
Sprint YY Day XX: [Phase] [Description] - [Status]

Examples:
Sprint 2 Day 1: FE lag features complete - 1.5h under budget
Sprint 3 Day 2: MODEL baseline implemented - on schedule
```

**Gitignore recommendations:**
```gitignore
# Ignore intermediate datasets (large files)
data/processed/s*_d*_*.pkl

# Keep only final datasets
!data/results/*.pkl

# Ignore working visualizations
outputs/figures/*/s*_d*_*.png

# Keep final visualizations
!outputs/figures/final/fig*.png
```

### E.11.9. Common Mistakes to Avoid

| Mistake | Problem | Correct |
|---------|---------|---------|
| `d01_s02_FE_lags.ipynb` | Wrong order | `s02_d01_FE_lags.ipynb` |
| `s02_d01_lags.ipynb` | Missing phase | `s02_d01_FE_lags.ipynb` |
| `s02_d01_FE_Lag_Validation.ipynb` | Wrong case | `s02_d01_FE_lag-validation.ipynb` |
| `s02_d01_FE_lag_validation.ipynb` | Underscores | `s02_d01_FE_lag-validation.ipynb` |
| `output.pkl` | Too vague | `s02_d01_FE_with-lags.pkl` |

### E.11.10. Best Practices

1. **Start with convention from Day 1** - Don't try to rename later
2. **Be descriptive** - Future you will thank you
3. **Be concise** - 1-3 words maximum in description
4. **Use hyphens** - Not underscores for multi-word descriptions
5. **Always lowercase** - Consistency matters
6. **Version thoughtfully** - Only increment for significant changes
7. **Archive, don't delete** - Move superseded files to archive/
8. **Document lineage** - Note file relationships in README

**For printable quick reference card, see:** `1.4_File_Naming_Quick_Reference.md`

---

## E.12. DSM Validation Tracker (Integrated into Feedback System)

### E.12.1. Purpose

Track methodology effectiveness during project execution to provide actionable
feedback for DSM improvement.

**NOTE (v1.3.19):** The standalone Validation Tracker has been integrated into
the project feedback system (Section 6.4.5). Section-level scoring is now part
of `dsm-docs/feedback-to-dsm/methodology.md` rather than a separate file. The template
below is retained as reference for the scoring format.

### E.12.2. Template Structure (Reference)

**File Location:** `dsm-docs/feedback-to-dsm/methodology.md` (integrated with project methodology record)

```markdown
# DSM Validation Tracker

**Project:** [Project Name]
**DSM Version:** [e.g., v1.3.1]
**Tracking Period:** [Start Date] - [End Date]
**Author:** [Name]

---

## Sections Used

| DSM Section | Sprint/Day | Times Used | Avg Score | Top Issue |
|-------------|------------|------------|-----------|-----------|
| Section 2.1 (Environment) | S1D0 | 1 | 4.5 | None |
| Section 2.2 (Exploration) | S1D1-3 | 3 | 4.0 | Missing X |
| Appendix C.1 (Experiments) | S2D1 | 2 | 3.0 | Needs Y |

---

## Feedback Log

### Entry 1
- **Date:** YYYY-MM-DD
- **DSM Section:** [Section reference]
- **Sprint/Day:** [e.g., S1D2]
- **Type:** Gap | Success | Improvement | Pain Point
- **Context:** [What were you trying to do]
- **Issue:** [What happened]
- **Resolution:** [How resolved, if applicable]

**Scores:**
| Criterion | Score (1-5) | Notes |
|-----------|-------------|-------|
| Clarity | [X] | [Comment] |
| Applicability | [X] | [Comment] |
| Completeness | [X] | [Comment] |
| Efficiency | [X] | [Comment] |

**Recommendation:** [Suggestion for DSM improvement]

---

### Entry 2
[Repeat format]

---

## Summary Metrics

### By DSM Section
| Section | Times Used | Avg Score | Issues Found |
|---------|------------|-----------|--------------|
| [Section] | [N] | [X.X] | [Count] |

### By Feedback Type
| Type | Count | Sections Affected |
|------|-------|-------------------|
| Gap | [N] | [List] |
| Success | [N] | [List] |
| Improvement | [N] | [List] |
| Pain Point | [N] | [List] |

---

## Recommendations for DSM

### High Priority
1. [Recommendation from project experience]

### Medium Priority
1. [Recommendation]

### Low Priority
1. [Recommendation]

---

## Project-Specific Adaptations

**Modifications made to DSM for this project:**
1. [Adaptation and why]

**Would recommend for similar projects:**
- [ ] Yes, use DSM as-is
- [ ] Yes, with these adaptations: [list]
- [ ] Partially, only these sections: [list]
```

### E.12.3. Scoring Guidelines

| Score | Meaning | When to Use |
|-------|---------|-------------|
| 5 | Excellent | Guidance was exactly what was needed, saved significant time |
| 4 | Good | Guidance was helpful with minor gaps |
| 3 | Adequate | Guidance was useful but required adaptation |
| 2 | Poor | Guidance was minimal, significant gaps |
| 1 | Not useful | Guidance didn't apply or was misleading |

### E.12.4. When to Update

- **After each milestone:** Log sections used and initial assessment
- **When encountering issues:** Document immediately while context is fresh
- **End of sprint:** Review and summarize
- **Project completion:** Final recommendations and adaptations

### E.12.5. Feeding Back to DSM

If using DSM for a significant project, consider:

1. **Creating BACKLOG items** for significant gaps identified
2. **Sharing validation tracker** with DSM maintainers (if open source contribution)
3. **Documenting adaptations** that could benefit others

This feedback loop ensures DSM continuously improves based on real-world usage.

---

**End of Appendix E**

Return to main document: **Section 6.2: Quality Assurance**

For complete methodology: **`1.0_Data_Science_Collaboration_Methodology.md`**

---

# Appendix F: Coding Anti-Patterns

**Purpose:** Comprehensive reference of common defective patterns in Python, data science, ML engineering, and agent collaboration. Each anti-pattern includes the problem, a code example, the fix, and a cross-reference to the relevant DSM best practice.

**Relationship to existing content:** This appendix complements the phase-specific pitfalls (Sections 2.2.5-2.5.5) which focus on workflow mistakes. Appendix F focuses on coding-level mistakes that occur across all phases.

**Sources:** The Little Book of Python Anti-Patterns (quantifiedcode), arXiv:2107.00079 (MLOps Anti-Patterns), Ploomber Data Science Checklist, LLM workflow research (Addy Osmani 2026), Clutch.co developer survey 2025.

---

## F.1. Python Anti-Patterns

Common Python mistakes that affect correctness, maintainability, and security.

**Anti-Pattern: Mutable Default Arguments**
- **Problem:** Using mutable objects (lists, dicts) as default arguments causes shared state across function calls
- **Example:**
  ```python
  def add_item(item, items=[]):  # WRONG: shared list across calls
      items.append(item)
      return items
  ```
- **Fix:**
  ```python
  def add_item(item, items=None):  # RIGHT: new list each call
      if items is None:
          items = []
      items.append(item)
      return items
  ```
- **DSM Reference:** Section 3.2.3 (Code Quality Guidelines)

**Anti-Pattern: Bare Except**
- **Problem:** `except:` or `except Exception:` swallows all errors, hiding bugs and making debugging impossible
- **Example:**
  ```python
  try:
      result = process_data(df)
  except:  # WRONG: catches KeyboardInterrupt, SystemExit, everything
      pass
  ```
- **Fix:**
  ```python
  try:
      result = process_data(df)
  except ValueError as e:  # RIGHT: catch specific exceptions
      logger.warning(f"Processing failed: {e}")
      result = fallback_value
  ```
- **DSM Reference:** Section 3.2.3 (Code Quality Guidelines)

**Anti-Pattern: Wildcard Imports**
- **Problem:** `from module import *` pollutes namespace, causes name collisions, makes code origin unclear
- **Example:** `from numpy import *` then using `array()`, unclear if it's numpy or another module
- **Fix:** `import numpy as np` then `np.array()`, explicit and traceable
- **DSM Reference:** Section 3.2.3 (Code Quality Guidelines)

**Anti-Pattern: Not Using Context Managers**
- **Problem:** Manual file open/close without `with` risks resource leaks on exceptions
- **Example:**
  ```python
  f = open('data.csv')  # WRONG: not closed on exception
  data = f.read()
  f.close()
  ```
- **Fix:**
  ```python
  with open('data.csv') as f:  # RIGHT: guaranteed cleanup
      data = f.read()
  ```
- **DSM Reference:** Appendix A (Environment Setup)

**Anti-Pattern: Type Checking with ==**
- **Problem:** `type(x) == int` fails for subclasses; fragile and non-Pythonic
- **Example:** `if type(value) == float:` misses numpy float types
- **Fix:** `if isinstance(value, (int, float)):` handles inheritance correctly
- **DSM Reference:** Section 3.2.3 (Code Quality Guidelines)

**Anti-Pattern: String Concatenation in Loops**
- **Problem:** Using `+=` on strings in loops creates a new string object each iteration (O(n^2))
- **Example:**
  ```python
  result = ""
  for row in data:  # WRONG: quadratic time
      result += str(row) + "\n"
  ```
- **Fix:**
  ```python
  result = "\n".join(str(row) for row in data)  # RIGHT: linear time
  ```
- **DSM Reference:** Section 3.2.5 (Print Statement Standards)

**Anti-Pattern: Not Using Comprehensions**
- **Problem:** Verbose loops where list/dict comprehensions are clearer and faster
- **Example:**
  ```python
  squares = []
  for x in range(10):  # WRONG: verbose, slower
      squares.append(x ** 2)
  ```
- **Fix:**
  ```python
  squares = [x ** 2 for x in range(10)]  # RIGHT: Pythonic, faster
  ```
- **DSM Reference:** Section 3.2.3 (Code Quality Guidelines)

**Anti-Pattern: Using exec() / eval()**
- **Problem:** Dynamic code execution opens code injection risks and makes debugging nearly impossible
- **Example:** `eval(user_input)` executes arbitrary code
- **Fix:** Use explicit mappings, `ast.literal_eval()` for safe literal parsing, or structured dispatch patterns
- **DSM Reference:** Section 3.2.3 (Code Quality Guidelines)

### F.1.1. Security Anti-Patterns (OWASP-Informed)

Security vulnerabilities in generated code. These patterns are especially critical
in DSM 4.0 (application) projects where code is production-facing. In notebook-only
projects (DSM 1.0), the risk is lower but the patterns should still be avoided to
prevent unsafe habits from carrying into production code.

**OWASP context:** These patterns map to OWASP LLM05 (Improper Output Handling),
where LLM-generated code contains vulnerabilities that downstream systems inherit.
See DSM_0.2 Untrusted Input Protocol for the complementary agent-behavior protocol
(OWASP LLM01).

**Anti-Pattern: SQL Injection via String Formatting**
- **Problem:** Constructing SQL queries with f-strings or string concatenation allows user input to alter query structure
- **OWASP mapping:** LLM05 (Improper Output Handling), traditional OWASP A03 (Injection)
- **Example:**
  ```python
  # WRONG: user_input can contain '; DROP TABLE users; --
  query = f"SELECT * FROM users WHERE name = '{user_input}'"
  cursor.execute(query)
  ```
- **Fix:**
  ```python
  # RIGHT: parameterized query, database driver handles escaping
  query = "SELECT * FROM users WHERE name = %s"
  cursor.execute(query, (user_input,))
  ```
- **Context:** In notebooks (DSM 1.0), queries typically use hardcoded values or
  DataFrame operations, making this low risk. In applications (DSM 4.0) with
  user-facing inputs, this is critical.
- **DSM Reference:** DSM_0.2 (Untrusted Input Protocol), DSM 4.0 Section 4.5 (Package Verification)

**Anti-Pattern: XSS in Generated HTML**
- **Problem:** Inserting user-provided data into HTML without escaping allows script injection
- **OWASP mapping:** LLM05, traditional OWASP A03 (Injection)
- **Example:**
  ```python
  # WRONG: user_name could contain <script>alert('xss')</script>
  html = f"<h1>Welcome, {user_name}</h1>"
  ```
- **Fix:**
  ```python
  # RIGHT: use a templating engine with auto-escaping
  from markupsafe import escape
  html = f"<h1>Welcome, {escape(user_name)}</h1>"

  # OR use Jinja2 with autoescape enabled (default in Flask)
  template.render(user_name=user_name)
  ```
- **Context:** Relevant for Streamlit apps, Flask/FastAPI frontends, and HTML
  report generation. Not applicable to pure notebook analysis.
- **DSM Reference:** DSM 4.0 Section 4.5 (Package Verification)

**Anti-Pattern: Path Traversal in File Operations**
- **Problem:** Using user-provided file paths without validation allows access to files outside the intended directory
- **OWASP mapping:** LLM05, traditional OWASP A01 (Broken Access Control)
- **Example:**
  ```python
  # WRONG: filename could be "../../etc/passwd"
  filepath = os.path.join(upload_dir, filename)
  with open(filepath) as f:
      data = f.read()
  ```
- **Fix:**
  ```python
  # RIGHT: resolve and validate the path stays within the allowed directory
  from pathlib import Path
  filepath = Path(upload_dir).joinpath(filename).resolve()
  if not filepath.is_relative_to(Path(upload_dir).resolve()):
      raise ValueError(f"Path traversal detected: {filename}")
  with open(filepath) as f:
      data = f.read()
  ```
- **Context:** Relevant in any project that processes user-provided filenames:
  upload handlers, data loading APIs, file export features.
- **DSM Reference:** DSM 4.0 Section 4.5 (Package Verification)

**Anti-Pattern: Command Injection via subprocess**
- **Problem:** Passing unsanitized input to shell commands allows arbitrary command execution
- **OWASP mapping:** LLM05, traditional OWASP A03 (Injection)
- **Example:**
  ```python
  # WRONG: filename could be "file.txt; rm -rf /"
  os.system(f"wc -l {filename}")

  # ALSO WRONG: shell=True with string command
  subprocess.run(f"grep {pattern} {filename}", shell=True)
  ```
- **Fix:**
  ```python
  # RIGHT: use list form without shell=True
  subprocess.run(["wc", "-l", filename], check=True)

  # RIGHT: use Python libraries instead of shell commands
  with open(filename) as f:
      line_count = sum(1 for _ in f)
  ```
- **Context:** Common in automation scripts, data pipeline orchestration, and
  MCP server implementations. Prefer Python standard library over shell commands.
- **DSM Reference:** DSM_0.2 (Untrusted Input Protocol), DSM 4.0 Section 4.5 (Package Verification)

---

## F.2. Data Science Anti-Patterns

Patterns that undermine reproducibility, maintainability, and correctness of analysis notebooks.

**Anti-Pattern: God Notebook**
- **Problem:** Single notebook with everything (data loading, EDA, feature engineering, modeling, visualization), hundreds of cells
- **Consequence:** Unmaintainable, unreproducible, impossible to debug or review
- **Fix:** Split into focused notebooks per phase: `01_EDA_quality.ipynb`, `02_FE_aggregations.ipynb`, `03_MODEL_baseline.ipynb`
- **DSM Reference:** Section 3.1 (Notebook Structure), Section 6.1.4 (Daily Documentation)

**Anti-Pattern: Copy-Paste Cells**
- **Problem:** Duplicating code blocks across cells instead of extracting functions
- **Consequence:** Divergent copies, bugs fixed in one place but not others
- **Fix:** Extract repeated logic into functions; import shared utilities from a `utils.py` module
- **DSM Reference:** Section 3.2.3 (Code Quality Guidelines)

**Anti-Pattern: Invisible State**
- **Problem:** Global variables mutated across cells, relying on execution order
- **Consequence:** Non-reproducible on "Restart & Run All"; different results depending on cell execution order
- **Fix:** Each cell should produce explicit outputs; use "Restart & Run All" to validate
- **DSM Reference:** Section 3.1 (Notebook Structure)

**Anti-Pattern: Shape Blindness**
- **Problem:** Not checking data dimensions after transforms (merges, filters, pivots)
- **Consequence:** Silent data corruption, unexpected row count changes
- **Fix:** Print `df.shape` after every transform; assert expected dimensions
  ```python
  df_merged = df_left.merge(df_right, on='id')
  print(f"Merged: {df_merged.shape}")  # Always verify
  assert len(df_merged) >= len(df_left), "Unexpected row loss"
  ```
- **DSM Reference:** Section 2.2 (Exploration), Section 3.2.2 (Output Standards)

**Anti-Pattern: Magic Numbers**
- **Problem:** Hardcoded thresholds without explanation (`df[df['score'] > 0.7]`)
- **Consequence:** Unreproducible decisions, no rationale for reviewers
- **Fix:** Define named constants with justification:
  ```python
  CHURN_THRESHOLD = 0.7  # Based on business stakeholder input (DEC-005)
  high_risk = df[df['score'] > CHURN_THRESHOLD]
  ```
- **DSM Reference:** Section 4.1 (Decision Log Framework)

**Anti-Pattern: Zombie Code**
- **Problem:** Commented-out code blocks left in notebooks "just in case"
- **Consequence:** Confusion, noise, unclear what is active logic
- **Fix:** Delete unused code; rely on version control (git) for history
- **DSM Reference:** Section 3.1 (Notebook Structure)

**Anti-Pattern: Metric Soup**
- **Problem:** Tracking dozens of metrics without declaring a primary evaluation metric upfront
- **Consequence:** Decision paralysis, cherry-picking favorable results
- **Fix:** Declare primary metric in sprint plan; report secondary metrics for context only
- **DSM Reference:** Section 2.4 (Analysis), Section 4.1 (Decision Log)

**Anti-Pattern: Config in Code**
- **Problem:** Hardcoded file paths, API keys, and parameters scattered in source cells
- **Consequence:** Fragile, non-portable, security risk
- **Fix:** Use configuration cells at the top of notebooks, environment variables for secrets, `pathlib.Path` for paths
- **DSM Reference:** Section 3.2.4 (Path Management)

**Anti-Pattern: Mixing Concerns**
- **Problem:** Data loading, processing, and visualization in a single cell
- **Consequence:** Hard to debug, hard to test, hard to rerun parts independently
- **Fix:** One responsibility per cell; separate load, transform, and visualize steps
- **DSM Reference:** Section 3.1.1 (Standard Template)

---

## F.3. ML Engineering Anti-Patterns

Patterns that compromise ML pipeline integrity and production readiness.

**Anti-Pattern: Training-Serving Skew**
- **Problem:** Different code paths for training vs. inference (e.g., different preprocessing, feature computation)
- **Consequence:** Silent prediction errors in production; model performs differently than in evaluation
- **Fix:** Share preprocessing code between training and serving; test with production-like inputs
- **DSM Reference:** DSM 4.0 (Software Engineering Adaptation)

**Anti-Pattern: Feature Leakage**
- **Problem:** Target information leaking into features (e.g., fitting scaler on full dataset before split)
- **Consequence:** Inflated evaluation metrics, catastrophic production failure
- **Fix:** Always split before preprocessing; use sklearn Pipelines to encapsulate fit/transform:
  ```python
  # WRONG: fit on full data, then split
  scaler.fit(X)
  X_train, X_test = train_test_split(scaler.transform(X))

  # RIGHT: split first, fit only on train
  X_train, X_test = train_test_split(X)
  scaler.fit(X_train)
  X_test_scaled = scaler.transform(X_test)
  ```
- **DSM Reference:** Section 2.3.7 (Data Leakage Prevention)

**Anti-Pattern: Monolith Pipeline**
- **Problem:** One script/notebook for the entire ML workflow (data to deployment)
- **Consequence:** Impossible to debug individual steps, test components, or swap parts
- **Fix:** Modular pipeline with clear stage boundaries; each stage reads input and writes output
- **DSM Reference:** Section 3.1 (Notebook Structure), DSM 4.0 Section 2

**Anti-Pattern: Premature Abstraction**
- **Problem:** Creating generic frameworks before understanding the problem (e.g., building a "universal data loader" on day 1)
- **Consequence:** Wrong abstractions that don't fit actual needs, technical debt
- **Fix:** Write concrete code first; abstract only when you see 3+ repeated patterns
- **DSM Reference:** Section 2.2 (Exploration, start simple)

**Anti-Pattern: Dependency Bloat**
- **Problem:** Installing packages "just in case" without actual need
- **Consequence:** Version conflicts, security vulnerabilities, slow environment setup
- **Fix:** Start minimal; add dependencies only when needed. Document why each package is included
- **DSM Reference:** Appendix A.7 (Environment Tool Selection Guide)

**Anti-Pattern: Test-Free Refactoring**
- **Problem:** Restructuring code without test coverage
- **Consequence:** Regression bugs, silent behavior changes
- **Fix:** Write tests before refactoring; compare outputs before and after
- **DSM Reference:** DSM 4.0 Section 4.4 (Tests vs Capability Experiments)

**Anti-Pattern: Role Segregation**
- **Problem:** No single person understands the end-to-end ML system
- **Consequence:** Knowledge silos, failures at integration points
- **Fix:** Document pipeline architecture; ensure handoff documents cover system context
- **DSM Reference:** Section 6.1 (Session Management), Section 4.3 (Stakeholder Communication)

**Anti-Pattern: Prototype-to-Production**
- **Problem:** Shipping notebook prototype code directly to production
- **Consequence:** Fragile, unobservable, no error handling, no logging
- **Fix:** Refactor proven notebook logic into tested modules following DSM 4.0 patterns
- **DSM Reference:** DSM 4.0 (Software Engineering Adaptation)

---

## F.4. Agent Collaboration Anti-Patterns

Patterns specific to working with AI code assistants that reduce output quality.

**Anti-Pattern: Context Dumping**
- **Problem:** Overloading the agent with unfiltered context (pasting entire files, long error logs without narrowing)
- **Consequence:** Diluted focus, lower quality output, wasted tokens
- **Fix:** Provide focused context: relevant code sections, specific error messages, clear problem statement
- **DSM Reference:** Section 6.1 (Session Management)

**Anti-Pattern: Blind Acceptance**
- **Problem:** Not reviewing agent-generated code before executing or committing
- **Consequence:** Bugs, security issues, logic errors, style inconsistencies
- **Fix:** Review every code block before execution; test outputs against expectations. 59% of developers use AI-generated code they don't fully understand (Clutch.co 2025)
- **DSM Reference:** Section 3.2 (Code Standards), DSM_0.2 Notebook Collaboration Protocol

**Anti-Pattern: Session Amnesia**
- **Problem:** Not using handoff documents between sessions, forcing the agent to re-discover context
- **Consequence:** Repeated work, lost decisions, inconsistent approaches across sessions
- **Fix:** Create session handoff documents following Section 6.1 template; start each session by referencing the previous handoff
- **DSM Reference:** Section 6.1 (Session Management)

**Anti-Pattern: Prompt Drift**
- **Problem:** Inconsistent or contradictory instructions across sessions (e.g., changing coding standards mid-project without updating Custom Instructions)
- **Consequence:** Unpredictable agent behavior, style inconsistencies
- **Fix:** Update DSM_0.2_Custom_Instructions when project standards change; keep a single source of truth
- **DSM Reference:** DSM_0.2 (Custom Instructions), Section 6.5 (Gateway Review)

**Anti-Pattern: Output Hoarding**
- **Problem:** Keeping all generated artifacts without pruning (unused notebooks, abandoned experiments, draft code)
- **Consequence:** Project bloat, confusion about which artifacts are current
- **Fix:** Archive or delete unused outputs at sprint boundaries; maintain a clean project structure
- **DSM Reference:** Section 3.4 (Directory Structure)

**Anti-Pattern: Cascade Failure**
- **Problem:** Not validating intermediate agent outputs before building on them
- **Consequence:** Errors compound downstream; late discovery requires rework of multiple steps
- **Fix:** Validate each step before proceeding: check data shapes, run assertions, review logic
- **DSM Reference:** Section 2.2.5 (Common Pitfalls), DSM_0.2 Notebook Collaboration Protocol

**Anti-Pattern: Over-Confidence Trust**
- **Problem:** Assuming agent output is correct because it looks plausible (especially statistical results, SQL queries, regex patterns)
- **Consequence:** Subtle bugs, wrong conclusions, security vulnerabilities
- **Fix:** Spot-check agent outputs against known values; verify edge cases; test SQL on sample data first
- **DSM Reference:** Section 3.2.2 (Output Standards), Section 3.2.5 (Print Statement Standards)

**Anti-Pattern: Missing Guardrails**
- **Problem:** No CI/CD, linting, type checking, or review process for agent-generated code
- **Consequence:** Gradual quality degradation, inconsistent style, accumulating technical debt
- **Fix:** Set up linters (flake8/ruff), formatters (black), and run "Restart & Run All" before committing notebooks
- **DSM Reference:** Appendix A (Environment Setup), DSM 4.0 Section 4.4

---

**End of Appendix F**

Return to main document: **Section 3.2.6: Coding Anti-Patterns**

For complete methodology: **`1.0_Data_Science_Collaboration_Methodology.md`**
