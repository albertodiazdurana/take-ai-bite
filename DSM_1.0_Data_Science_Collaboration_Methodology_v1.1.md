# Data Science Project Collaboration Methodology
## Working Framework for Alberto Diaz Durana & AI Agent
### Academic Edition v1.1

**Version:** 1.3.0 (Academic Edition)
**Date:** January 2026  
**Purpose:** Standard operating procedures for data science projects across domains, optimized for academic tasks with extensibility for advanced complexity

**This document is part of an Integrated System** â†’ Refer to `0_Integrated_System_Guide-START-HERE.md` for complete guide

---

# 1. Introduction

## 1.1. Overview & Purpose

This methodology provides a systematic framework for collaborative data science projects between human analysts and an AI agent. It emerged from real-world project experience, particularly the TravelTide Customer Segmentation project, where rigorous methodology enabled data-driven pivots and successful stakeholder communication.

**Core Value Proposition:**
- **Systematic Workflow:** 4-phase process from environment setup through communication
- **Quality Standards:** Reproducible notebooks, clear documentation, validated decisions
- **Scalability:** Core practices for all projects + advanced practices for complex scenarios
- **Stakeholder Focus:** Technical rigor balanced with business communication needs

## 1.2. When to Use This Methodology

**Ideal For:**
- Academic data science projects (thesis, coursework, research)
- Exploratory analysis with uncertain requirements
- Projects requiring stakeholder communication (technical + non-technical audiences)
- Iterative development with AI agent collaboration
- Projects where requirements may pivot based on data insights

**Best Fit Scenarios:**
- Customer segmentation and clustering analysis
- Predictive modeling with business constraints
- Feature engineering from raw transactional data
- Multi-stakeholder projects requiring documentation at various technical levels
- Projects with 4-8 sprint timelines and iterative deliverables

**Not Ideal For:**
- Simple one-off analyses (<4 hours total work)
- Projects with complete, unchanging specifications
- Real-time production systems (though methodology can inform development)
- Projects without need for documentation or reproducibility

**For Software Engineering Projects:**
If your primary deliverable is a working application (not analytical insights), see **DSM 4.0: Software Engineering Adaptation** which provides adapted phases, architectural decision templates, and code organization standards for ML application development.

## 1.3. Core Philosophy

### 1.3.1. Communication Style
- **Concise responses**: Direct answers without unnecessary elaboration
- **Clarifying questions first**: Before generating artifacts or lengthy outputs, confirm understanding
- **Token monitoring**: Track conversation length and warn at 95% capacity for session summary
- **Text conventions**: 
  - Use "WARNING:" instead of warning emoji
  - Use "OK:" instead of checkmark
  - Use "ERROR:" instead of cross mark
  - No emojis in professional deliverables

### 1.3.2. Project Structure Philosophy
- **Phased approach**: Break complex projects into 3-5 major phases
- **Sprint iteration cycles**: Each sprint represents a distinct analytical stage
- **Daily objectives**: Each day within a sprint has clear deliverables
- **Progressive execution**: Each phase builds on validated outputs from previous stages

### 1.3.3. Code Organization Standards
- **Consolidated notebooks**: Prefer fewer, well-structured notebooks (~400 lines, 5-6 sections) over many small files
- **Stage-based naming**: Use sequential numbers with descriptive names (See Section 3.3 for details)
- **Section structure per notebook**:
  1. Setup & environment configuration
  2. Data loading & validation
  3. Core processing (3-4 sections)
  4. Validation & export
  5. Summary & next steps
- **Path management**: Relative paths with constants defined at notebook start
- **Reproducibility**: Each notebook must run end-to-end without manual intervention

### 1.3.4. Data-Driven Decision Making
- **Validate assumptions**: Never trust predetermined business expectations without verification
- **Pivot when necessary**: Statistical validity overrides initial hypotheses
- **Document decisions**: Every significant choice needs rationale and evidence (See Section 4.1)
- **Honest limitations**: Better to remove uncertain features than include misleading metrics

### 1.3.5. Factual Accuracy - No Guessing

**Core Principle:** Never provide information based on estimation, assumption, or speculation in data science work.

**Requirements:**

1. **Token Counting:**
   - ONLY report from system warnings
   - Never estimate manually ("I think we've used about 150K tokens")
   - Wait for: "Token usage: 73372/190000"
   - Report exactly: "Current: 73K tokens (38%), 117K remaining"

2. **Data Metrics:**
   - ONLY report actual computed values
   - Never approximate: "About 300,000 rows"
   - Always compute: `print(f"Rows: {len(df):,}")`
   - Result: "Rows: 300,896"

3. **File Locations:**
   - ONLY reference confirmed paths
   - Never assume: "The file is probably in data/processed/"
   - Always check: `Path('data/processed/file.pkl').exists()`

4. **Code Results:**
   - ONLY state what actual output shows
   - Never predict: "This should give you around 0.6 correlation"
   - Always verify: Run code, report actual result

5. **Decision References:**
   - ONLY cite documented decisions
   - Never paraphrase from memory: "I think we decided to use XGBoost"
   - Always reference: "DEC-014: Selected XGBoost based on ablation study"

**When Uncertain:**

```
OK: "I need to check [source] to confirm"
OK: "Can you run [command] so I can see the actual result?"
OK: "I don't have that information available"
OK: "We could find this out by [approach]"

ERROR: "Approximately..." (without computing from data)
ERROR: "Should be around..." (without verification)
ERROR: "I estimate..." (without basis)
ERROR: "Probably..." (without evidence)
```

**Especially Critical For:**
- Performance metrics (RMSE, accuracy, improvement percentages)
- Resource usage (tokens, memory, GPU utilization)
- Data dimensions (row counts, feature counts)
- File sizes and locations
- Decision log references
- Statistical test results
- Model hyperparameters

**This is non-negotiable in data science where precision and reproducibility are paramount.**

## 1.4. Version History

**v1.1 (November 2025):**
- Reorganized with hierarchical numbering (4 levels: # ## ### ####)
- Split detailed content into 5 appendices for better maintainability
- Enhanced cross-referencing system
- Improved navigation without Table of Contents
- All content preserved from v1.0, better organized

**v1.0 (November 2025):**
- Initial academic edition release
- Based on TravelTide Customer Segmentation project experience
- Integrated 4-phase workflow with advanced complexity practices
- Comprehensive decision-making and stakeholder communication frameworks

---

# 2. Core Workflow (The 4-Phase Process)

> **Note for Software Engineering Projects:** If you are building an ML application (where the deliverable is code/package rather than analytical insights), see **DSM 4.0: Software Engineering Adaptation** for adapted phases:
> - Phase 1: Data Pipeline (load, validate, transform)
> - Phase 2: Core Modules (models, services, providers)
> - Phase 3: Integration & Evaluation (agents, testing, metrics)
> - Phase 4: Application & Documentation (UI, README, demos)

## 2.1. Phase 0: Environment Setup

### 2.1.1. Purpose & When to Execute

**Purpose:**
Establish a reproducible Python environment with base packages and VS Code configuration before beginning analysis work. This ensures consistency across all projects and enables immediate notebook execution.

**When to Execute:**
- Day 0 of any new project (before Day 1 Sprint 1)
- After project folder creation
- Before first notebook development
- Only once per project (unless major environment changes needed)

### 2.1.2. Two-Step Environment Setup

Environment setup follows a **two-step process** to maintain consistency while allowing project-specific customization:

| Step | Purpose | When | Packages |
|------|---------|------|----------|
| **Step 1: Base Environment** | Core data science foundation | Every project | pandas, numpy, matplotlib, seaborn, scikit-learn |
| **Step 2: Project-Specific** | Domain-specific packages | After base setup | TensorFlow, XGBoost, NLP libraries, etc. |

**Why Two Steps:**
- Base environment ensures consistency across all projects
- Project-specific step adds only what's needed (smaller environments, fewer conflicts)
- Easier troubleshooting (base issues vs. project-specific issues)
- Clear separation in requirements files (`requirements_base.txt` + `requirements_project.txt`)

### 2.1.3. Step 1: Base Environment

**Minimal Setup (Recommended for Academic Work):**
- Script: `scripts/setup_base_environment_minimal.py`
- Packages: 5 core packages (jupyter, ipykernel, pandas, numpy, matplotlib, seaborn)
- Use for: Coursework, thesis, exploration, individual projects
- Benefits: Faster, simpler, no linting annoyances
- Installation time: ~2 minutes

**Full Setup (Production/Team Projects):**
- Script: `scripts/setup_base_environment_prod.py`
- Packages: 9 packages (adds black, flake8, isort, autopep8)
- Use for: Team projects, production code, code reviews
- Benefits: Consistent style, professional standards
- Installation time: ~3-4 minutes

### 2.1.4. Step 2: Project-Specific Packages

**After base setup completes**, install domain-specific packages:

| Domain | Key Packages | Installation |
|--------|--------------|--------------|
| **Time Series** | statsmodels, prophet | `pip install statsmodels prophet` |
| **Computer Vision** | tensorflow, opencv-python | `pip install tensorflow opencv-python` |
| **NLP** | transformers, nltk, spacy | `pip install transformers nltk spacy` |
| **Deep Learning** | tensorflow or pytorch | `pip install tensorflow` or `pip install torch` |
| **Experiment Tracking** | mlflow | `pip install mlflow` |

**Project-Specific Setup Steps:**
```bash
# 1. Activate the base environment
source .venv/bin/activate  # Linux/Mac
.venv\Scripts\activate     # Windows

# 2. Install project-specific packages
pip install tensorflow opencv-python  # Example for CV project

# 3. Generate project requirements file
pip freeze > requirements_project.txt
```

**Document in Notebook:**
```python
# Project-specific imports (beyond base)
import tensorflow as tf
print(f"TensorFlow: {tf.__version__}")
print(f"GPU available: {tf.config.list_physical_devices('GPU')}")
```

For detailed package lists by domain, see **Appendix A.3: Domain-Specific Packages**.

For detailed package installation guidance and troubleshooting, see **Appendix A: Environment Setup Details**.

### 2.1.5. Running the Base Setup Script

**Run Base Setup Script:**

```bash
# From project root directory
python scripts/setup_base_environment_minimal.py  # OR
python scripts/setup_base_environment_prod.py
```

**What it does:**
1. Creates `.venv` virtual environment
2. Upgrades pip to latest version
3. Installs base packages
4. Registers Jupyter kernel: `project_base_kernel`
5. Generates `requirements_base.txt`
6. Configures VS Code settings (`.vscode/settings.json`)

**Expected output:**
```
OK: Virtual environment '.venv' created
OK: pip upgraded to latest version
OK: Base packages installed
OK: Jupyter kernel registered as 'project_base_kernel'
OK: requirements_base.txt generated
OK: VS Code settings configured
```

### 2.1.6. VS Code Configuration

**Automatic Configuration:**
The setup script creates `.vscode/settings.json` with:
- Python interpreter path: `./.venv/Scripts/python.exe` (Windows) or `./.venv/bin/python` (Mac/Linux)
- Jupyter kernel: `project_base_kernel`
- File associations: `.ipynb` files open in Jupyter

**Manual Verification:**
1. Open VS Code in project directory
2. Open any `.ipynb` file
3. Check top-right kernel selector shows: `project_base_kernel`
4. If wrong kernel, click selector and choose `project_base_kernel`

### 2.1.7. Jupyter Kernel Verification

**Verify kernel registration:**
```bash
# List all Jupyter kernels
jupyter kernelspec list
```

**Expected output:**
```
Available kernels:
  project_base_kernel    /path/to/.venv/share/jupyter/kernels/project_base_kernel
  python3               /usr/share/jupyter/kernels/python3
```

**Test kernel in notebook:**
```python
import sys
print(f"Python: {sys.version}")
print(f"Executable: {sys.executable}")

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

print("OK: All base packages imported successfully")
```

### 2.1.8. Phase 0 Verification Checklist

Before proceeding to Phase 1, verify:
- [ ] `.venv` directory exists in project root
- [ ] `requirements_base.txt` generated
- [ ] `.vscode/settings.json` configured
- [ ] Jupyter kernel `project_base_kernel` registered
- [ ] VS Code recognizes kernel in notebook files
- [ ] Test imports successful (pandas, numpy, matplotlib, seaborn)
- [ ] First notebook created with kernel selected

**Common Issues:**
For troubleshooting environment setup problems, see **Appendix A.4: Troubleshooting Environment Issues**.

**Native toolchain projects:** For projects with compiled dependencies (Android/Kotlin, C/C++, Rust, embedded), run the Environment Preflight Protocol (DSM_0.2) before this checklist. Native dependencies surface iteratively without upfront detection.

### 2.1.9. Business Understanding Foundation

**Purpose:** Establish business context before data exploration. This isn't separate from EDA - it's the starting point for an iterative dialogue between business understanding and data understanding.

**The Business Understanding ↔ EDA Loop:**
```
Business Understanding                    EDA
       ↓                                   ↓
"What problem are we solving?"    "What does the data show?"
       ↓                                   ↓
"What would success look like?"   "Is that achievable with this data?"
       ↓                                   ↓
"What do experts expect?"         "Does the data match expectations?"
       ↓                                   ↓
       ←←←←← ITERATE →→→→→→
```

**The Five Business Questions:**

Before touching data, answer these:

| # | Question | Why It Matters |
|---|----------|----------------|
| 1 | **What decision will this analysis inform?** | Focuses the entire project |
| 2 | **How is this decision made today?** | Establishes baseline to beat |
| 3 | **What would change if we had a perfect answer?** | Defines real impact |
| 4 | **What constraints exist?** | Bounds the solution space |
| 5 | **Who needs to trust the results?** | Shapes communication approach |

**Business Understanding Template:**

```markdown
## Business Understanding Summary

### The Decision
**Decision to inform:** [Specific decision, not vague goal]
**Decision maker:** [Who will act on this]
**Decision frequency:** [One-time / Daily / Weekly / Real-time]
**Current approach:** [How it's done today without ML]

### Success Definition
**Business success:** [What changes in the business if this works]
**Measurable outcome:** [Specific metric, e.g., "reduce churn by 10%"]
**Minimum viable:** [What's the smallest useful improvement]
**Timeline:** [When is the decision needed]

### Constraints
**Data constraints:** [What's available, what's not]
**Technical constraints:** [Infrastructure, latency, scale]
**Business constraints:** [Budget, regulation, ethics]
**Interpretability needs:** [Black box OK? Need explanations?]

### Domain Knowledge
**Expert expectations:** [What should the data show based on domain knowledge]
**Known relationships:** [Established cause-effect in this domain]
**Historical attempts:** [Has this been tried before? Results?]
```

**Business Understanding Checkpoint:**

Before starting EDA, can you answer:
- [ ] What specific decision does this inform?
- [ ] How will we know if the analysis succeeded?
- [ ] What does the domain expert expect to find?
- [ ] Who needs to trust the results?

**If you cannot answer these, stop and get clarity before proceeding.**

---

## 2.2. Phase 1: Exploration

### 2.2.1. Objectives

**Primary Goals:**
- Understand data quality, completeness, and structure
- Define analytical cohort based on business requirements
- Identify data limitations and potential issues
- Establish baseline metrics and distributions
- Document assumptions and decisions

**Key Questions to Answer:**
- What is the grain of the data? (customer-level, transaction-level, etc.)
- What is the time range and coverage?
- What are missing data patterns?
- What filters define our analysis cohort?
- What are the distributions of key variables?

### 2.2.2. Key Activities

**Data Quality Assessment:**
- Load and validate data structure
- Check for duplicates, missing values, data types
- Identify outliers and anomalies
- Document data quality issues

**Cohort Definition:**
- Apply business filters (e.g., active in date range)
- Exclude edge cases based on data quality
- Document inclusion/exclusion criteria
- Validate cohort size and representativeness

**Exploratory Data Analysis:**
- Univariate analysis of key variables
- Distribution visualizations
- Correlation analysis
- Temporal patterns (if applicable)

**Example Activities:**
```python
# Data quality checks
print(f"Total rows: {df.shape[0]:,}")
print(f"Duplicates: {df.duplicated().sum():,}")
print(f"Missing values:\n{df.isnull().sum()}")

# Cohort definition
active_users = df[df['last_activity_date'] >= '2023-01-01']
print(f"Active users: {len(active_users):,}")

# Distribution analysis
df['metric'].describe()
sns.histplot(df['metric'])
```

#### The Three-Layer EDA Framework

Structure your exploration as three progressive layers of understanding:

```
Layer 3: IMPLICATIONS
"What does this mean for our analysis?"
        ↑
Layer 2: PATTERNS
"What relationships and structures exist?"
        ↑
Layer 1: FACTS
"What is in the data?"
```

**Layer 1: Facts (Data Inventory)**

Goal: Know exactly what you have before analyzing.

| Category | Questions | Output |
|----------|-----------|--------|
| **Structure** | How many records? How many features? What types? | Data shape summary |
| **Time** | What time period? Any gaps? What granularity? | Temporal coverage map |
| **Entities** | What does each row represent? How many unique entities? | Entity definition |
| **Completeness** | What's missing? Where? Why? | Missing data matrix |
| **Source** | Where did this come from? How was it collected? | Data provenance |

**Checkpoint:** Can you explain in one paragraph what this dataset contains?

**Layer 2: Patterns (Statistical Understanding)**

Goal: Understand distributions, relationships, and anomalies.

| Category | Questions | Techniques |
|----------|-----------|------------|
| **Distributions** | What shape? Skewed? Multimodal? Outliers? | Histograms, box plots, KDE |
| **Central tendency** | What's typical? Mean vs median gap? | Summary stats, trimmed means |
| **Relationships** | What correlates? Linear or nonlinear? | Correlation matrix, scatter plots |
| **Groups** | Are there natural segments? | Groupby analysis, clustering preview |
| **Anomalies** | What doesn't fit? One-off or systematic? | IQR, Z-score, isolation |

**Key Insight:** Don't just compute correlations - ask "why might these be related?"

**Checkpoint:** Can you describe the 3-5 most important patterns in the data?

**Layer 3: Implications (Analysis Direction)**

Goal: Translate understanding into analysis strategy.

| Category | Questions | Decision |
|----------|-----------|----------|
| **Feasibility** | Can the data answer our question? | Go/No-go/Pivot |
| **Target** | Is the target well-defined? Balanced? Leakage risk? | Target validation |
| **Features** | What looks predictive? What needs engineering? | Feature priority list |
| **Challenges** | What will be hard? Missing data? Imbalance? Scale? | Risk register |

**Checkpoint:** Can you write a one-page analysis plan based on EDA findings?

#### Domain Validation During EDA

At each layer, ask: "Does this match domain expectations?"

| Finding | Expected? | If Unexpected |
|---------|-----------|---------------|
| [EDA finding] | Yes/No | Investigate / Document / Flag for expert |

**Key Practice:** When something doesn't match expectations, investigate. It's either:
1. A data quality issue (needs fixing)
2. A real insight (domain knowledge was incomplete)
3. A methodological artifact (your analysis is wrong)

### 2.2.3. Deliverables

**Required Outputs:**
1. **EDA Notebook(s):** Typically 1-2 notebooks (~400 lines each)
   - Data quality assessment
   - Cohort definition
   - Key visualizations and statistics

2. **Cohort Definition Document:** Clear documentation of:
   - Inclusion/exclusion criteria
   - Final cohort size
   - Rationale for filters
   - Data quality decisions

3. **Decision Log Entries:** Document significant choices (See Section 4.1)
   - Why certain filters were applied
   - How missing data was handled
   - Why specific cohorts were defined

4. **Layer Summary Templates:** Capture understanding, not just outputs

**Layer 1 Summary Template:**
```markdown
**Dataset:** [name]
**Records:** [N] representing [entity type] over [time period]
**Features:** [M] columns ([X] numeric, [Y] categorical, [Z] datetime)
**Completeness:** [%] complete, missing concentrated in [columns/patterns]
**Source:** [origin and collection method]
**One-line description:** [What this data captures]
```

**Layer 2 Summary Template:**
```markdown
**Key Patterns Discovered:**
1. **[Pattern name]:** [Description]
   - Evidence: [Statistic/visualization reference]
   - Hypothesis: [Why this might exist]

**Anomalies Noted:**
- [Anomaly 1]: [Description, frequency, handling decision]

**Relationships:**
- Strong: [List correlated pairs > 0.7]
- Moderate: [List correlated pairs 0.4-0.7]
- Surprising absence: [Expected correlations not found]
```

**Layer 3 Summary Template:**
```markdown
**Can We Answer the Question?**
- [ ] Yes - data supports the analysis goal
- [ ] Partially - with limitations: [list]
- [ ] No - pivot required: [reason]

**Promising Features:** [List with rationale from EDA]
**Features to Engineer:** [Ideas based on EDA findings]
**Key Challenges Identified:** [With mitigation approaches]
**Recommended Approach:** [1-2 sentences on modeling strategy]
```

5. **Updated Business Understanding (Post-EDA):**

```markdown
### Original Assumptions vs. Reality
| Assumption | EDA Finding | Implication |
|------------|-------------|-------------|
| [What we thought] | [What data shows] | [How this changes approach] |

### Refined Problem Statement
**Original:** [Initial problem framing]
**Refined:** [Updated framing based on EDA]
**Reason for change:** [What EDA revealed]
```

**File Naming Examples:**
- `s01_d01_EDA_data_quality_cohort.ipynb`
- `s01_d02_EDA_behavioral_analysis.ipynb`
- `cohort_definition.md`

### 2.2.4. Success Criteria

**EDA Exit Criteria Checklist:**

**Layer 1 Complete:**
- [ ] Can describe dataset in one paragraph
- [ ] Entity definition clear and documented
- [ ] Missing data pattern understood
- [ ] Temporal coverage mapped

**Layer 2 Complete:**
- [ ] Key distributions characterized
- [ ] Important correlations identified
- [ ] Anomalies documented with handling decisions
- [ ] 3-5 key patterns articulated

**Layer 3 Complete:**
- [ ] Feasibility confirmed (or pivot documented)
- [ ] Target variable validated
- [ ] Feature priorities established
- [ ] Challenges and mitigations identified
- [ ] Initial modeling approach selected

**Documentation Complete:**
- [ ] Layer summaries written (not just code output)
- [ ] Decision log entries created
- [ ] Domain validation completed (if applicable)
- [ ] Next steps clear
- [ ] Stakeholder update provided on data insights (Section 4.3)

**Quality Checkpoints:**
- Can you explain the cohort definition to a non-technical stakeholder?
- Have you documented why certain data was excluded?
- Do you understand the limitations of the data?
- Have you validated that your cohort matches business expectations?

**EDA Anti-Patterns (When to Stop):**

| Anti-Pattern | Sign | Action |
|--------------|------|--------|
| **Analysis Paralysis** | 3+ days on EDA without moving forward | Write summary, move to features |
| **Plot Overload** | 50+ visualizations, no synthesis | Delete redundant, write narrative |
| **Perfectionism** | Waiting for "complete" understanding | Accept uncertainty, iterate |
| **Scope Creep** | Exploring tangential questions | Refocus on original objective |

**Rule:** If you've completed the checklist, you're done. Move forward and return if needed.

### 2.2.5. Common Pitfalls

**Pitfall 1: Insufficient Cohort Documentation**
- **Problem:** Applying filters without clear rationale
- **Solution:** Document every inclusion/exclusion criterion with business justification
- **Example:** Don't just filter `df[df['transactions'] > 0]` â€” explain why zero-transaction users are excluded

**Pitfall 2: Ignoring Missing Data Patterns**
- **Problem:** Proceeding without understanding why data is missing
- **Solution:** Investigate missing data mechanisms (MCAR, MAR, MNAR)
- **Example:** In TravelTide, cancellation data missing for no-booking users had specific meaning

**Pitfall 3: Over-committing to Initial Hypotheses**
- **Problem:** Forcing data to support predetermined conclusions
- **Solution:** Let data drive insights; pivot if necessary (See Section 4.2)
- **Example:** TravelTide revealed K=3 clusters despite business expectation of K=5

**Pitfall 4: Inadequate Distribution Visualization**
- **Problem:** Missing outliers or unusual patterns
- **Solution:** Always visualize distributions before aggregation
- **Example:** Use histograms, box plots, and scatter plots for key variables

**For detailed Phase 1 techniques and examples, see Appendix B.2: Phase 1 Deep Dive.**

---

## 2.3. Phase 2: Feature Engineering

### 2.3.1. Objectives

**Primary Goals:**
- Transform raw data into meaningful analytical features
- Create domain-specific metrics aligned with business context
- Engineer propensity indicators for behavioral analysis
- Ensure feature validity and avoid data leakage
- Document feature definitions for reproducibility

**Key Questions to Answer:**
- What features capture user behavior effectively?
- How do we measure engagement, loyalty, value?
- Which temporal patterns matter?
- What aggregations make business sense?
- Are features calculated correctly without leakage?

### 2.3.2. Key Activities

**Core Feature Generation:**
- Aggregate transactional data to analytical grain (e.g., customer-level)
- Calculate behavioral metrics (frequency, recency, monetary value)
- Create propensity indicators (e.g., cancellation propensity, discount usage)
- Generate temporal features (time since first/last event)

**Feature Validation:**
- Check for null values and edge cases
- Validate feature distributions
- Test correlations between features
- Document feature definitions

**Advanced Feature Engineering (if needed):**
- Interaction features
- Polynomial features
- Domain-specific transformations
- Dimensionality reduction preparation

**Example Activities:**
```python
# Behavioral aggregation
user_features = transactions.groupby('user_id').agg({
    'booking_id': 'count',  # trip_count
    'booking_value': ['sum', 'mean'],  # total_spend, avg_spend
    'booking_date': ['min', 'max']  # first_trip, last_trip
})

# Propensity calculation
user_features['cancellation_propensity'] = (
    cancellations.groupby('user_id')['cancelled'].sum() /
    user_features['trip_count']
)

# Temporal features
user_features['days_since_last_trip'] = (
    (ref_date - user_features['last_trip']).dt.days
)
```

### 2.3.3. Deliverables

**Required Outputs:**
1. **Feature Engineering Notebook(s):** Typically 2-3 notebooks
   - Core features (demographics, behavioral metrics)
   - Advanced features (propensities, interactions)
   - Feature validation and distribution checks

2. **Feature Dictionary:** Documentation of:
   - Feature name and definition
   - Calculation logic
   - Business interpretation
   - Expected range/distribution
   - Null handling strategy

3. **Feature Dataset:** Clean CSV/parquet file with:
   - All engineered features at analytical grain
   - Documented column names
   - No missing critical features
   - Version controlled filename

**File Naming Examples:**
- `03_FE_core_features.ipynb`
- `04_FE_advanced_features.ipynb`
- `feature_dictionary.md`
- `user_features_v1.0_20251115.csv`

### 2.3.4. Success Criteria

**Phase 2 Complete When:**
- [ ] All features calculated at correct analytical grain
- [ ] Feature definitions documented in feature dictionary
- [ ] No data leakage (future information not used)
- [ ] Missing value patterns understood and handled
- [ ] Feature distributions visualized and validated
- [ ] Correlations between features analyzed
- [ ] Feature dataset exported with clear naming
- [ ] Decision log updated with feature engineering choices (Section 4.1)
- [ ] Stakeholder update on feature logic provided (Section 4.3)

**Quality Checkpoints:**
- Can you explain each feature to a business stakeholder?
- Have you validated that features make logical sense?
- Are feature definitions reproducible?
- Have you checked for unrealistic values or outliers?

### 2.3.5. Common Pitfalls

**Pitfall 1: Data Leakage**
- **Problem:** Using future information to calculate features
- **Solution:** Always use data available at prediction time
- **Example:** Don't calculate cancellation rate using ALL bookings for a user; use only past bookings

**Pitfall 2: Poorly Documented Features**
- **Problem:** Features with unclear definitions or logic
- **Solution:** Maintain comprehensive feature dictionary
- **Example:** Not just "engagement_score" but "7-day rolling average of daily logins"

**Pitfall 3: Over-Engineering**
- **Problem:** Creating hundreds of features without validation
- **Solution:** Start with core features, expand only if needed
- **Example:** TravelTide started with 89 features, not 500

**Pitfall 4: Ignoring Business Meaning**
- **Problem:** Mathematical transformations without domain interpretation
- **Solution:** Every feature should have clear business interpretation
- **Example:** "Principal Component 1" alone is not useful; explain what it captures

**Pitfall 5: Incomplete Null Handling**
- **Problem:** Not addressing missing values systematically
- **Solution:** Document null handling strategy per feature
- **Example:** Some nulls mean "never happened" (0), others mean "unknown" (median)

**For detailed Phase 2 techniques and examples, see Appendix B.3: Phase 2 Deep Dive.**

### 2.3.6. Missing Value Strategy for Engineered Features

**Context:** Lag and rolling features naturally create NaN values at boundaries

**Example:**
- Lag 7 feature: First 7 observations per group have NaN (no history)
- Rolling 30-day: First 29 observations per group have NaN (insufficient window)

**Options & Decision Framework:**

#### Option 1: Keep NaN (Recommended for Tree Models)

**When to use:**
- XGBoost, LightGBM, CatBoost (handle NaN natively)
- Random Forest (most implementations handle NaN)

**Pros:**
- No information loss (NaN signals "insufficient history")
- Models can learn: "If lag7 is NaN -> use other features more heavily"
- Fastest implementation (no imputation needed)
- Preserves temporal validity (don't pretend we have data we don't)

**Cons:**
- Linear models (sklearn LinearRegression) cannot handle NaN
- Some neural networks require complete data
- Requires verifying model can handle NaN before training

**Implementation:**
```python
# Create lag features, keep NaN
df['lag7'] = df.groupby(['store', 'item'])['sales'].shift(7)
# NaN count: ~10% of data (first 7 days per store-item)

# XGBoost handles NaN natively
model = xgb.XGBRegressor()
model.fit(X_train, y_train)  # Works with NaN in X_train
```

#### Option 2: Fill with Group Mean

**When to use:**
- Linear models (cannot handle NaN)
- Need complete data matrix
- Small percentage of NaN (<5%)

**Pros:**
- Preserves group structure (store 1 different from store 2)
- Reasonable assumption: "Unknown history ~ this group's average"

**Cons:**
- Introduces information leakage risk (future data in mean calculation)
- Masks true data availability
- May overestimate model confidence

**Implementation:**
```python
# Fill NaN with group mean
df['lag7'] = df.groupby(['store', 'item'])['sales'].shift(7)
df['lag7'] = df.groupby(['store', 'item'])['lag7'].transform(
    lambda x: x.fillna(x.mean())
)
```

**WARNING:** Ensure mean is calculated only on training data, not test!

#### Option 3: Fill with Global Constant (e.g., 0, median)

**When to use:**
- Need complete data matrix
- Groups are too small for reliable group mean
- Conservative approach preferred

**Pros:**
- Simple, no leakage risk
- Clear signal: "This is imputed, not real"
- Works across all models

**Cons:**
- Ignores group structure (store 1 treated same as store 2)
- May introduce bias (assuming zero history unrealistic)

**Implementation:**
```python
# Fill NaN with 0
df['lag7'] = df.groupby(['store', 'item'])['sales'].shift(7).fillna(0)

# OR fill with global median
global_median = df['sales'].median()
df['lag7'] = df.groupby(['store', 'item'])['sales'].shift(7).fillna(global_median)
```

#### Option 4: Drop Rows with NaN

**When to use:**
- RARELY - only if NaN is very small (<1%) and random
- NOT for lag features (NaN is systematic, not random)

**Pros:**
- Clean dataset, no imputation assumptions

**Cons:**
- Loses data (lag 30 -> lose first 30 days per group)
- May lose entire groups (if group has <30 observations)
- Temporal validity issues (can't forecast first N days)

**Implementation:**
```python
# NOT RECOMMENDED for lag features
df = df.dropna(subset=['lag7'])  # Loses first 7 days per group
```

#### Decision Log Template for NaN Strategy

```markdown
## DEC-XXX: NaN Handling for Lag Features

**Context:**
Lag 1/7/14/30 features create NaN at boundaries (first N days per store-item have no history).

**Decision:**
Keep NaN values, do not impute.

**Rationale:**
- XGBoost handles NaN natively (splits on "missing" branch)
- NaN signals "insufficient history" - informative, not noise
- Imputation would pretend we have data we don't (false confidence)
- NaN percentage acceptable: lag1 (9.1%), lag7 (10.7%), lag14 (11.7%), lag30 (13.3%)

**Alternatives Considered:**
1. Fill with group mean - Rejected: Introduces leakage risk, masks true data availability
2. Fill with 0 - Rejected: Assumes zero sales history (unrealistic for ongoing stores/items)
3. Drop rows - Rejected: Loses 13.3% of data (entire early periods per group)

**Impact:**
- Models: Works with XGBoost, LSTM (with masking), LightGBM, CatBoost
- Does NOT work with: sklearn LinearRegression, basic neural networks without preprocessing
- Sprint 3 validation: If model requires complete data, revisit with Option 2

**Validation Plan:**
- Sprint 3: Train XGBoost with NaN -> measure performance
- If switching to linear model -> apply Option 2 (group mean fill)
```

#### Best Practice Summary

**Default Strategy:**
1. Compute correlation/importance at MODELING granularity
2. Keep NaN if using tree models
3. Document NaN percentage in feature dictionary
4. Validate in Sprint 3 (feature importance confirms utility)

**Always Document:**
- Which features have NaN
- Why NaN exists (boundary effects, data gaps, merge mismatches)
- NaN percentage per feature
- Chosen strategy and rationale
- Which models can/cannot handle NaN

### 2.3.7. Data Leakage Prevention

**Context:** Data leakage occurs when information from outside the training dataset is used to create the model, leading to overly optimistic performance estimates that fail in production.

**Core Principle:** Split first, fit on train only, transform everything.

#### Pre-Modeling Checklist

**Before any transformation:**
- [ ] Split data into train/test BEFORE any fitting step
- [ ] Fit all transformers on training data only (`.fit()` on train, `.transform()` on test)
- [ ] Verify no test data information leaks into feature engineering
- [ ] Cross-validation uses proper fold isolation

**Common Leakage Patterns:**

| Pattern | Leaking Step | Correct Approach |
|---------|-------------|------------------|
| Scaling before split | `scaler.fit_transform(all_data)` | `scaler.fit(X_train)` then `scaler.transform(X_test)` |
| Encoding before split | `encoder.fit(all_categories)` | `encoder.fit(train_categories)` only |
| Imputing before split | `imputer.fit(all_data)` | `imputer.fit(X_train)` then `imputer.transform(X_test)` |
| Feature selection on all data | `SelectKBest.fit(X, y)` | `SelectKBest.fit(X_train, y_train)` |

#### Domain-Specific Leakage Risks

**NLP:**
- Fit TF-IDF/vectorizers on training corpus only
- Fit word embedding aggregations on training data only
- Sentence transformers: no fitting needed, but verify no data mixing during encoding

**Time Series:**
- Respect temporal order (no future data in features)
- Lag features: compute before split, but fit statistics on train only
- Rolling windows: ensure window does not cross train/test boundary

**Tabular:**
- Target encoding: compute means from training fold only
- Frequency encoding: compute counts from training data only
- Group-level aggregations: compute from training groups only

#### Recommended Pattern: Scikit-learn Pipeline

```python
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import StandardScaler
from sklearn.feature_extraction.text import TfidfVectorizer

# Tabular example
pipeline = Pipeline([
    ('scaler', StandardScaler()),
    ('classifier', LogisticRegression())
])
pipeline.fit(X_train, y_train)  # Scaler fits on train only

# NLP example
pipeline = Pipeline([
    ('vectorizer', TfidfVectorizer()),
    ('classifier', LogisticRegression())
])
pipeline.fit(X_train, y_train)  # Vectorizer fits on train corpus only
```

**Why pipelines prevent leakage:** Each step's `.fit()` is called only on training data during `pipeline.fit()`. During `pipeline.predict()`, only `.transform()` is called.

#### Leakage Detection

**Symptoms that suggest leakage:**
- Test accuracy suspiciously close to or higher than training accuracy
- Performance drops significantly on truly new data
- Model performs much better than domain baselines

**Verification steps:**
1. Compare train vs. test performance (gap should exist)
2. Test on completely held-out data from a different time period or source
3. Review feature creation code for any `fit` calls on full dataset

---

## 2.4. Phase 3: Analysis

### 2.4.1. Objectives

**Primary Goals:**
- Apply appropriate analytical techniques to answer business questions
- Validate model performance and statistical significance
- Interpret results in business context
- Document methodology and assumptions
- Prepare findings for communication

**Key Questions to Answer:**
- What analytical approach best addresses the business problem?
- How do we validate our model/analysis?
- What are the key findings and their confidence levels?
- How do results align with business expectations?
- What are the limitations and caveats?

### 2.4.2. Key Activities

**Model/Analysis Selection:**
- Choose appropriate technique (clustering, classification, regression, etc.)
- Define success metrics aligned with business goals
- Establish baseline performance for comparison
- Document selection rationale

**Model Development & Validation:**
- Train model(s) using appropriate techniques
- Validate using statistical tests and business logic
- Compare multiple approaches if applicable
- Assess robustness and sensitivity

**Results Interpretation:**
- Extract key insights from model outputs
- Translate statistical findings to business language
- Identify actionable recommendations
- Document limitations and assumptions

**Example Activities (Clustering):**
```python
# Model selection
from sklearn.cluster import KMeans
from sklearn.metrics import silhouette_score, davies_bouldin_score

# Try multiple K values
silhouette_scores = {}
for k in range(2, 8):
    kmeans = KMeans(n_clusters=k, random_state=42)
    labels = kmeans.fit_predict(X_scaled)
    silhouette_scores[k] = silhouette_score(X_scaled, labels)

# Interpret clusters
cluster_profiles = df.groupby('cluster')[key_features].mean()
```

### 2.4.3. Deliverables

**Required Outputs:**
1. **Analysis Notebook(s):** Typically 2-3 notebooks
   - Model selection and validation
   - Performance metrics and comparisons
   - Results interpretation
   - Sensitivity analysis

2. **Results Summary Document:**
   - Key findings with statistical support
   - Business interpretation of results
   - Limitations and caveats
   - Recommendations for action

3. **Model Artifacts (if applicable):**
   - Trained model files
   - Feature importance rankings
   - Cluster assignments or predictions
   - Validation metrics

**File Naming Examples:**
- `05_ANALYSIS_model_selection.ipynb`
- `06_ANALYSIS_validation_interpretation.ipynb`
- `results_summary.md`
- `cluster_assignments_v1.0.csv`

### 2.4.4. Success Criteria

**Phase 3 Complete When:**
- [ ] Analytical approach validated and justified
- [ ] Model performance meets business requirements
- [ ] Results interpreted in business context
- [ ] Key findings documented with statistical support
- [ ] Limitations and assumptions clearly stated
- [ ] Sensitivity analysis conducted
- [ ] Decision log updated with analytical choices (Section 4.1)
- [ ] Stakeholder update on findings provided (Section 4.3)
- [ ] Ready to proceed to communication phase

**Quality Checkpoints:**
- Do results make business sense?
- Have you validated findings using multiple approaches?
- Can you explain limitations to stakeholders?
- Are recommendations actionable and specific?

### 2.4.5. Common Pitfalls

**Pitfall 1: Overfitting to Validation Metrics**
- **Problem:** Optimizing for metric without business context
- **Solution:** Always validate with business logic and stakeholder input
- **Example:** High silhouette score doesn't mean clusters are useful

**Pitfall 2: Ignoring Model Assumptions**
- **Problem:** Applying techniques without checking prerequisites
- **Solution:** Validate assumptions (normality, independence, etc.)
- **Example:** K-means assumes spherical clusters; check if appropriate

**Pitfall 3: Insufficient Validation**
- **Problem:** Trusting single metric or single run
- **Solution:** Use multiple validation approaches and robustness checks
- **Example:** TravelTide used silhouette, Davies-Bouldin, AND business review

**Pitfall 4: Poor Results Interpretation**
- **Problem:** Reporting statistics without business meaning
- **Solution:** Translate every finding to stakeholder language
- **Example:** Not "Cluster 2 has high PC1" but "Cluster 2 represents high-value frequent travelers"

**Pitfall 5: Not Planning for Pivots**
- **Problem:** Forcing predetermined approach despite data insights
- **Solution:** Be ready to pivot based on analysis (Section 4.2)
- **Example:** TravelTide pivoted from K=5 to K=3 based on statistical evidence

**For detailed Phase 3 techniques and examples, see Appendix B.4: Phase 3 Deep Dive.**

### 2.4.6. Model Comparison Documentation

When comparing multiple models or approaches, use this structured template to
document decisions transparently. Negative results are valuable findings.

**Comparison Setup:**

```markdown
## Model Comparison: [Task Name]

**Objective:** [What we are optimizing for]
**Primary Metric:** [F1 / RMSE / Accuracy / AUC / etc.]
**Secondary Metrics:** [Precision, Recall, training time, interpretability, etc.]
**Dataset:** [Size, split strategy, any relevant characteristics]
```

**Results Table:**

| Model | Primary Metric | Secondary Metric(s) | Training Time | Notes |
|-------|---------------|---------------------|---------------|-------|
| Baseline (specify) | X.XXX | X.XXX | Xs | Why chosen as baseline |
| Model B | X.XXX (+/- vs baseline) | X.XXX | Xs | Key difference from baseline |
| Model C | X.XXX (+/- vs baseline) | X.XXX | Xs | Key difference from baseline |

**Selection Decision:**

```markdown
### Selection Decision

**Selected:** [Model Name]
**Rationale:** [Why this model over others - cite specific metrics and trade-offs]
**Trade-offs accepted:** [What we gave up by choosing this model]
**Decision logged:** DEC-[NNN] (Section 4.1)
```

**Negative Results (Required Section):**

Document models that underperformed and WHY. These findings prevent repeated
effort and provide insight into the problem's characteristics.

```markdown
### Negative Results

| Model | Expected | Actual | Why It Underperformed |
|-------|----------|--------|----------------------|
| [Model X] | Better than baseline | Worse by N% | [Root cause analysis] |
```

**Key principles:**
- Always establish a simple baseline first (e.g., majority class, linear model)
- Report relative improvement over baseline, not just absolute metrics
- Surprising negative results are valuable and must be documented, not hidden
- Cross-reference selection decisions with the Decision Log (Section 4.1)

### 2.4.7. Error Analysis Framework

After model selection, conduct structured error analysis to understand failure
modes and identify improvement opportunities.

**Error Analysis Template:**

```markdown
## Error Analysis: [Model Name]

**Total Errors:** [N] out of [total] ([X]%)
**Analysis Sample:** [Full test set / random sample of N errors]
```

**Error Categories:**

| Category | Count | % of Errors | Example | Root Cause |
|----------|-------|-------------|---------|------------|
| [Type A] | N | X% | "[example]" | [Why model failed] |
| [Type B] | N | X% | "[example]" | [Why model failed] |
| [Type C] | N | X% | "[example]" | [Why model failed] |

**Patterns Identified:**

```markdown
### Patterns

1. **[Pattern Name]:** [Description, frequency, and affected samples]
2. **[Pattern Name]:** [Description, frequency, and affected samples]
```

**Actionable Insights:**

| Finding | Potential Fix | Effort | Expected Impact |
|---------|-------------|--------|----------------|
| [Error pattern] | [How to address] | Low/Med/High | Low/Med/High |

**Limitations Acknowledged:**

Document what the model fundamentally cannot handle and why. This sets realistic
expectations and guides future work.

```markdown
### Known Limitations

- [Limitation 1]: [Why it exists and whether it is addressable]
- [Limitation 2]: [Why it exists and whether it is addressable]
```

**Domain-Specific Error Categories:**

*NLP Classification:*
- Metaphorical language (literal vs. figurative interpretation)
- Sarcasm and irony
- Domain-specific jargon or slang
- Ambiguous cases (reasonable annotator disagreement)

*Tabular Classification:*
- Outlier misclassification
- Class boundary cases
- Missing feature impact

*Regression:*
- Extreme value prediction errors
- Heteroscedasticity patterns
- Feature interaction effects

*Clustering:*
- Boundary assignments (between-cluster ambiguity)
- Outlier cluster sensitivity
- Scale-dependent groupings

**Key principle:** Error analysis should answer "What can we learn from failures?"
not just "Where did the model fail?"

Cross-reference: Section 2.4.6 (Model Comparison), Section 4.1 (Decision Log)

### 2.4.8. Human Performance Baseline

Before evaluating models, establish a human performance baseline to contextualize results.
Without this reference point, it is impossible to assess whether model performance is
approaching the ceiling or has significant room for improvement.

**When to Establish:**
- Task involves subjective judgment (sentiment, relevance, severity)
- Labels may be noisy or ambiguous (crowdsourced annotations)
- Model performance appears plateaued and context is needed
- Results will be presented to stakeholders who will ask "is this good?"

**Methods (by effort level):**

| Method | Effort | Description |
|--------|--------|-------------|
| Quick estimate | Low | Researcher labels 50-100 random samples, compare to ground truth |
| Inter-annotator agreement | Medium | 2-3 people label same 100-200 samples, measure agreement (Cohen's kappa) |
| Published benchmarks | Low | Search literature for human performance on similar tasks |
| Error inspection proxy | Low | During error analysis, count how many model errors are also ambiguous to humans |

**Reporting:** Include the human baseline in every model comparison table:

| Method | F1 Score |
|--------|----------|
| Human baseline (N=100) | 0.85 |
| Best model | 0.78 |
| Baseline model | 0.74 |

This immediately shows whether models are approaching human performance or have
significant room for improvement.

Cross-reference: Section 2.4.6 (Model Comparison), Section 2.4.7 (Error Analysis)

### 2.4.9. Model Complexity vs Explainability

When multiple models achieve similar performance, the choice between them should
consider explainability tradeoffs, not just the highest score.

**Decision Framework:**

| Factor | Favors Simpler Model | Favors Complex Model |
|--------|---------------------|---------------------|
| Performance gap | Small (<2-3% improvement) | Large (>5% improvement) |
| Stakeholder needs | Need to explain decisions | Performance is primary metric |
| Regulatory context | Regulated domain (finance, healthcare) | Low-stakes application |
| Debugging needs | Must diagnose individual predictions | Aggregate performance sufficient |
| Deployment constraints | Limited compute, fast inference needed | Resources available |
| Iteration speed | Rapid experimentation required | Final production model |

**When reporting model selection, include an explainability assessment:**
- Model interpretability level (high: feature coefficients / medium: feature importance / low: black-box embeddings)
- Inference speed characteristics
- Recommendation based on deployment context

**Key Principle:** A small performance gain (e.g., 0.6% F1 improvement) rarely justifies
losing full interpretability unless the use case specifically demands maximum performance
regardless of transparency. Document the decision explicitly.

Cross-reference: Section 2.4.6 (Model Comparison), Section 4.1 (Decision Log)

### 2.4.10. Grouped Data Splitting

When samples in a dataset share a common origin entity (user, patient, device, session),
standard random splitting may leak information between train and test sets. Samples from
the same entity can share patterns that allow the model to exploit source identity rather
than learn generalizable features.

**When to Use Grouped Splitting:**

| Scenario | Group Variable | Risk if Ignored |
|----------|---------------|-----------------|
| Tweets from same user | `user_id` | Model memorizes writing style |
| Medical records from same patient | `patient_id` | Model memorizes patient history |
| Time series from same sensor | `sensor_id` | Model memorizes sensor drift |
| Reviews of same product | `product_id` | Model memorizes product-specific language |
| Images from same session | `session_id` | Model memorizes lighting/background |

**Decision Checklist (before splitting):**
1. Can multiple samples originate from the same entity (user, patient, device)?
2. If yes, is a group variable available in the dataset?
3. If yes, use `GroupKFold` or `GroupShuffleSplit` instead of standard splitting
4. If no group variable exists but grouping is suspected, document the limitation

**Implementation:**
- Cross-validation: `sklearn.model_selection.GroupKFold`
- Single split: `sklearn.model_selection.GroupShuffleSplit`

Cross-reference: Section 2.3.7 (Data Leakage Prevention), Section 2.4.6 (Model Comparison)

**For detailed Phase 3 techniques and examples, see Appendix B.4: Phase 3 Deep Dive.**

---

## 2.5. Phase 4: Communication

### 2.5.1. Objectives

**Primary Goals:**
- Consolidate analysis into clear, compelling deliverables
- Tailor communication to different audience levels (technical, executive, operational)
- Present findings with appropriate level of detail
- Provide actionable recommendations
- Document complete methodology for reproducibility

**Key Questions to Answer:**
- What are the key findings stakeholders need to know?
- How do we present complex results simply?
- What recommendations can be acted upon?
- What level of technical detail is appropriate?
- How do we handle questions and pushback?

### 2.5.2. Key Activities

**Notebook Consolidation:**
- Combine exploratory notebooks into clear narrative
- Remove dead ends and unsuccessful approaches
- Keep only essential code and outputs
- Add explanatory markdown cells
- Create standalone executable notebook

**Presentation Development:**
- Executive summary (1-2 slides): Key findings and recommendations
- Methodology overview (2-3 slides): Approach and validation
- Results details (3-5 slides): Findings with visualizations
- Recommendations (1-2 slides): Actionable next steps
- Appendix (optional): Technical details for deep dives

**Report Writing:**
- Technical report: Complete methodology, assumptions, limitations
- Executive summary: High-level findings for decision-makers
- Q&A document: Anticipated questions with prepared answers

**Stakeholder Preparation:**
- Prepare for different audience levels
- Anticipate pushback and questions
- Develop supporting materials
- Plan presentation flow

**Example Outputs:**
- Consolidated analysis notebook (400-600 lines)
- PowerPoint presentation (8-12 slides)
- Executive summary (2-3 pages)
- Q&A document (20-30 questions)

### 2.5.3. Deliverables

**Required Outputs:**
1. **Consolidated Notebook:**
   - Clean, narrative-driven analysis
   - All code functional and reproducible
   - Clear section headers and explanations
   - Key visualizations included
   - Conclusions and recommendations

2. **Presentation (PowerPoint/PDF):**
   - Executive summary slide(s)
   - Methodology overview
   - Key findings with visuals
   - Recommendations
   - Appendix with technical details

3. **Written Report:**
   - Executive summary (1-2 pages)
   - Complete technical report (8-15 pages)
   - Methodology documentation
   - Assumptions and limitations

4. **Supporting Materials:**
   - Q&A document
   - Feature dictionary
   - Data dictionary
   - Code repository link

**File Naming Examples:**
- `00_FINAL_consolidated_analysis.ipynb`
- `TravelTide_Customer_Segmentation_Presentation.pptx`
- `TravelTide_Executive_Summary.pdf`
- `TravelTide_Technical_Report.pdf`
- `TravelTide_QA_Document.md`

### 2.5.4. Success Criteria

**Phase 4 Complete When:**
- [ ] All deliverables completed and reviewed
- [ ] Presentation tailored to audience(s)
- [ ] Anticipated questions prepared with answers
- [ ] Technical details documented for reproducibility
- [ ] Recommendations are clear and actionable
- [ ] Stakeholders have received materials
- [ ] Feedback incorporated (if applicable)
- [ ] Project repository organized and documented
- [ ] Handoff materials prepared (if needed)

**Quality Checkpoints:**
- Can a non-technical stakeholder understand key findings?
- Can a technical colleague reproduce your analysis?
- Are recommendations specific and actionable?
- Have you addressed potential concerns proactively?

### 2.5.5. Common Pitfalls

**Pitfall 1: Too Much Technical Detail**
- **Problem:** Overwhelming stakeholders with statistics and code
- **Solution:** Layer detail â€” executive summary, methodology, appendix
- **Example:** Don't explain PCA to marketing leadership; explain what clusters mean

**Pitfall 2: Vague Recommendations**
- **Problem:** "Consider improving customer engagement"
- **Solution:** Specific, actionable recommendations
- **Example:** "Offer free cancellation to Cluster 3 (budget travelers) to increase bookings"

**Pitfall 3: Unprepared for Questions**
- **Problem:** Unable to answer stakeholder concerns
- **Solution:** Develop comprehensive Q&A document (20-30 questions)
- **Example:** TravelTide Q&A covered 25+ anticipated questions before presentation

**Pitfall 4: No Clear Narrative**
- **Problem:** Presenting results without story
- **Solution:** Build narrative arc: problem â†’ approach â†’ findings â†’ recommendations
- **Example:** "We identified 3 distinct customer types, each requiring different perks..."

**Pitfall 5: Incomplete Documentation**
- **Problem:** Analysis not reproducible by others
- **Solution:** Document assumptions, decisions, code, data versions
- **Example:** Feature dictionary, decision log, data lineage all included

### 2.5.6. Blog/Communication Deliverable Process

When a project includes a public communication deliverable (blog post, article,
presentation), follow this structured process:

**Step 1: Preparation** -- Create one materials file per blog post (not per epoch
or sprint). The materials file serves as both capture space and draft structure:
- Working title options
- Hook (opening paragraph)
- Story arc (structured outline)
- Key insights (numbered takeaways)
- Technical details (code snippets, diagrams; use Mermaid for architecture diagrams)
- Figures available from the project
- References (papers and concepts to cite)
- Call to action ideas
- Session observations and quotable moments (add as you work, not only at drafting time)

**Step 2: Scoping** -- Clarify before drafting:

| Question | Options |
|----------|---------|
| Platform | Blog, LinkedIn Article, Medium, conference paper |
| Audience | Technical, mixed, non-technical |
| Tone | Tutorial, narrative, academic |
| Length | Short (500-1,000), medium (1,500-2,000), long (2,500-3,000 words) |

**Step 3: Drafting** -- Generate first draft from materials document and scoping answers.

**Step 4: Review** -- Line-by-line review with focus on:
- **Citation completeness:** Every claim from outside knowledge needs a reference
- **Language accessibility:** No unexplained jargon for the target audience
- **Decision justification:** What was chosen, what alternatives existed, why
- **Inclusive language:** Compliant with Section 3.5

**Step 5: Audit** -- Systematic scan of the entire document for:
- Missing citations (flag all claims from outside knowledge)
- Factual accuracy (verify technical claims)
- Internal consistency (dates, numbers, terminology match throughout)

**Step 6: Publication** -- Format for target platform and publish
(see Section 2.5.7 for LinkedIn-specific strategy).

**Step 7: Tracking** -- After publication, update `docs/blog/README.md` with the
publication date and platform status. Move all related files for the published post
to `docs/blog/done/`. See DSM_0.1 Blog Artifacts for the tracker table format and
the done/ convention.

**File Naming:** All blog artifacts use `YYYY-MM-DD_{type}-{scope}.md` and live
in `docs/blog/`. Types: `blog-materials-` (materials), `blog-` (draft),
`post-` (final), `linkedin-` (LinkedIn post). See DSM_0.1 Blog Artifacts
section for full convention and examples. Include the metadata header (Date,
Author, Status, Platform) from DSM_0.1 Blog Artifacts in each file.

### 2.5.7. Publication Strategy

When publishing on LinkedIn or similar platforms, a project blog produces three
distinct pieces of content:

| Deliverable | Format | Length | Purpose |
|-------------|--------|--------|---------|
| Short post | Plain text post | 150-300 words | Hook, key results, build curiosity |
| Full article | Rich text article | 1,500-3,000 words | Complete technical narrative with citations |
| Follow-up comment | Comment on short post | 2-3 sentences | Link the short post to the full article |

**Publication Sequence:**
1. Publish short post with key results and promise of full article
2. After article is finalized, publish full article
3. Immediately comment on original short post with article link

**Why this order:** Short post captures momentum while fresh; tests engagement
before full article investment; follow-up comment notifies original engagers.
If the article is ready simultaneously, publish it first, then the short post with
the link embedded.

**Short Post Structure:**
1. **Hook** (first 2-3 lines) -- Counterintuitive claim or surprising result
   (this appears before "see more" and must generate curiosity)
2. **Context** (1-2 sentences) -- What the project was and why it matters
3. **Key results** (numbered list) -- Headline findings, concise enough to scan
4. **Bridge to article** (1 sentence) -- What the full article adds
5. **Hashtags** (end) -- 4-6 relevant tags

NOTE: Place the article link in a comment, not in the post body. Platform algorithms
may penalize posts with outbound links.

**Formatting Notes (LinkedIn Articles):**
- Tables and code blocks are not supported -- use screenshots
- Headings, bold, italic, and bullet lists are supported
- Workflow: Render markdown in a preview tool, copy rendered output, paste into editor

### 2.5.8. Blog Post as Standard Deliverable

All finalized projects should produce a blog post as a standard communication
deliverable. Writing a blog forces the author to synthesize findings into a public
narrative, which deepens understanding, creates portfolio evidence, shares knowledge,
and practices technical communication skills.

**Expectations:**
- Length: 1,500-3,000 words depending on project scope
- Audience: Mixed (technical + non-technical) unless project dictates otherwise
- Content: Project narrative, key findings, methodology choices, lessons learned
- Quality: Cited claims, accessible language, decision justification
- Process: Follow Blog/Communication Deliverable Process (Section 2.5.6)
- Publication: Follow Publication Strategy (Section 2.5.7) or equivalent

**When to Skip:**
A blog post may be skipped only when:
- The project involves confidential or proprietary data
- The project was exploratory with no publishable findings
- Explicitly agreed with stakeholders that no public communication is needed

In all other cases, a blog post is expected as part of the Communication phase.

Cross-reference: Section 2.5.6 (Blog Process), Section 6.4.5 (Project Feedback Deliverables)

### 2.5.9. Blog Style Guide

When writing blog posts and LinkedIn content, follow these conventions to maintain
a consistent voice across all DSM ecosystem publications.

**Long-Form Blog Posts:**

| Element | Convention |
|---------|------------|
| Byline | Author name at top; AI assistance acknowledged in footnote or closing |
| Opening | Lead with a counterintuitive finding or surprising result, not background |
| Tone | First-person narrative; conversational but precise |
| Structure | Problem, approach, findings, lessons learned |
| Citations | Inline references with numbered list at end; every external claim cited |
| Code | Fenced code blocks with language tag; keep to essential snippets |
| Length | 1,500-3,000 words depending on scope (see Section 2.5.8) |
| Closing | End with actionable takeaway or open question, not summary |

**Short-Form LinkedIn Posts:**

| Element | Convention |
|---------|------------|
| Format | Plain text only; no markdown, no rich formatting |
| Length | 150-300 words; stays above the "see more" fold in first 2-3 lines |
| Links | Place in a follow-up comment, not in the post body (algorithm penalty) |
| Hashtags | 4-6 relevant tags at the end |
| Structure | Hook, context, key results (bulleted or numbered), bridge to full article |

**Style Consistency Step:**

Before drafting a new post, read the most recent published post to calibrate
tone, structure, and formatting patterns. This prevents drift across posts
written weeks or months apart.

Cross-reference: Section 2.5.6 (Blog Process), Section 2.5.7 (Publication Strategy)

### 2.5.10. Presentation Preparation Checklist

Before presenting project results, prepare for common technical questions that
stakeholders and reviewers ask.

**Questions to Prepare For:**

| Category | Question |
|----------|----------|
| Baselines | What is human performance on this task? What is the simplest possible baseline? |
| Alternatives | Why this model/method and not others? What was considered and rejected? |
| Limitations | What are the known weaknesses of the approach? |
| Data quality | How were labels created? What is the inter-annotator agreement? |
| Splitting strategy | Could there be data leakage? Are grouped splits needed? |
| Explainability | Can you explain individual predictions? Is the performance gain worth the complexity? |
| Generalization | Would this work on different data? What would break? |
| Next steps | If you had more time, what would you try? |

**Preparation Steps:**
1. Review results -- Know exact numbers (F1, accuracy, etc.) without looking at notes
2. Anticipate questions -- Walk through the table above and prepare one-line answers
3. Prepare fallback visuals -- Have extra plots ready (confusion matrix, feature importance,
   embedding projections) that may not be in the main presentation
4. Practice the narrative -- Can you explain the project in 2 minutes? In 10 minutes?
5. Test live demo (if applicable) -- Run the notebook end-to-end in the presentation
   environment before the session

Cross-reference: Section 2.4.8 (Human Performance Baseline), Section 2.4.9
(Model Complexity vs Explainability)

**For detailed Phase 4 techniques and examples, see Appendix B.5: Phase 4 Deep Dive.**

---

# 3. Working Standards

## 3.1. Notebook Structure

### 3.1.1. Standard Template (5-6 Sections)

Every notebook follows a consistent structure:

**Section 1: Setup & Environment Configuration**
- Import statements
- Path constants
- Configuration parameters
- Helper functions

**Section 2: Data Loading & Validation**
- Load data from files
- Validate data structure
- Check for expected columns and types
- Report data shape and basic info

**Sections 3-5: Core Processing**
- Main analytical work (3-4 sections)
- Each section has clear purpose
- Progressive building of insights
- Regular validation checkpoints

**Section 6: Validation & Export**
- Final validation checks
- Export processed data/results
- Save artifacts (models, visualizations)
- Document output locations

**Section 7: Summary & Next Steps**
- Recap key findings
- Document decisions made
- List next steps
- Flag issues or concerns

### 3.1.2. Line Count Guidelines

**Target:** ~400 lines per notebook

**Rationale:**
- Maintainable size for review and debugging
- Fits on screen with reasonable scrolling
- Each section ~60-80 lines
- Balance between detail and readability

**When to Split:**
- Notebook exceeds 600 lines
- More than 6-7 major sections
- Distinct analytical phases (EDA â†’ Feature Engineering)
- Natural breakpoints in workflow

**Example Split:**
```
# Instead of one 800-line notebook:
01_EDA_data_quality.ipynb (400 lines)
02_EDA_behavioral_patterns.ipynb (400 lines)

# Better than:
01_EDA_complete.ipynb (800 lines)
```

### 3.1.3. Section Naming Conventions

**Markdown Headers:**
```markdown
### Section 1: Setup & Configuration
Code and output here...

### Section 2: Data Loading
Code and output here...
```

**Clear Descriptive Names:**
- "Section 3: Customer Cohort Definition"
- "Section 3: Analysis"

**Progressive Narrative:**
- Each section builds on previous
- Clear flow from setup â†’ analysis â†’ export
- Tells a story

### 3.1.4. Output Display Requirements

**All code cells must show visible output:**
```python
# Good: Shows output
df = pd.read_csv('data.csv')
print(f"Loaded {df.shape[0]:,} rows, {df.shape[1]} columns")
print(df.head(3))

# Bad: Silent operation
df = pd.read_csv('data.csv')
```

**Informative Outputs (Use):**
- Show actual data/results: shapes, counts, correlations, statistics
- Example: `print(f"Correlation: {value:.3f}")`

**Confirmation Messages (Avoid):**
- Generic success messages: "Complete!", "Done!", "Ready!", "Success!"
- Example: `print("Data ready for model training!")` â† Remove this

**Print Statement Standards:**
- Numbers with commas: `print(f"Count: {value:,}")`
- Decimals appropriate to context: `{price:.2f}`, `{corr:.4f}`
- Descriptive labels: `print(f"Mean CLV: ${mean_clv:,.2f}")`

---

## 3.2. Code Standards

### 3.2.1. Text Conventions

**Professional Text Standards:**
- Use "WARNING:" instead of warning emoji
- Use "OK:" instead of checkmark
- Use "ERROR:" instead of cross mark
- No emojis in code, markdown, or deliverables

**Applies To:**
- Notebook markdown cells
- Print statements in code
- Documentation files
- Presentation materials
- Email communications

**Examples:**
```python
# Good
print("WARNING: Missing values detected in 'age' column")
print("OK: All validations passed")
print("ERROR: Unexpected data type for 'date'")

# Bad
print("WARNING: Missing values detected")
print("OK: All validations passed")
print("ERROR: Unexpected data type")
```

### 3.2.2. Output Standards

**Number Formatting:**
```python
# Always use comma separators
print(f"Customers: {len(customers):,}")  # "Customers: 5,765"
print(f"Revenue: ${revenue:,.2f}")       # "Revenue: $1,234,567.89"
```

**Decimal Precision:**
```python
# Context-appropriate precision
print(f"Price: ${price:.2f}")            # Currency: 2 decimals
print(f"Percentage: {pct:.1f}%")         # Percentage: 1 decimal
print(f"Correlation: {corr:.4f}")        # Statistics: 4 decimals
```

**List Formatting:**
```python
# Short lists (<5 items): Single line
features = ['age', 'income', 'trips', 'spend']

# Long lists (>10 items): Multi-line with clear structure
important_features = [
    'customer_lifetime_value',
    'trip_frequency',
    'avg_booking_value',
    'cancellation_propensity',
    'discount_usage_rate',
    'days_since_last_trip'
]
```

### 3.2.3. Code Quality Guidelines

**For Academic/Exploratory Work:**
- Focus on readability and reproducibility
- Avoid code quality tools (black, flake8)
- Clear variable names
- Adequate comments for complex logic

**For Production/Team Work:**
- Use code quality tools (Section 2.1.2)
- Consistent formatting
- Type hints where helpful
- Comprehensive documentation

**General Best Practices:**
```python
# Good: Clear variable names
customer_lifetime_value = calculate_clv(transactions)

# Bad: Unclear abbreviations
clv = calc(trx)

# Good: Documented complex logic
# Calculate cancellation propensity as ratio of cancelled to total bookings
# Handles division by zero for users with no bookings
cancellation_prop = cancelled_bookings / total_bookings if total_bookings > 0 else 0

# Bad: Uncommented complex logic
cp = cb / tb if tb > 0 else 0
```

### 3.2.4. Path Management

**Use Constants:**
```python
# Good: Constants at top of notebook
DATA_DIR = '../data/raw/'
OUTPUT_DIR = '../data/processed/'
RESULTS_DIR = '../results/'

df = pd.read_csv(f'{DATA_DIR}customers.csv')
df.to_csv(f'{OUTPUT_DIR}customers_clean.csv', index=False)
```

**Avoid Hard-Coded Paths:**
```python
# ERROR: Hard-coded paths throughout
df = pd.read_csv('../data/raw/customers.csv')
# ... 50 lines later ...
df2 = pd.read_csv('../data/raw/transactions.csv')
# ... 100 lines later ...
df.to_csv('../data/processed/output.csv')
```

### 3.2.5. Print Statement Standards

**DO Print (Informative Outputs):**
- Data shapes: `print(f"Shape: {df.shape}")`
- Specific metrics: `print(f"Correlation: {corr:.3f}")`
- Counts and statistics: `print(f"Outliers: {n} ({pct:.2f}%)")`
- Quantitative findings: `print(f"Weekend lift: +{lift:.1f}%")`
- Validation results: `print(f"Missing values: {df.isnull().sum().sum()}")`

**DO NOT Print (Generic Confirmations):**
- ERROR: "Complete!", "Done!", "Success!", "Ready!"
- ERROR: "Data loaded successfully!"
- ERROR: "Processing finished!"
- ERROR: "All set for next step!"
- ERROR: "Correlation computed successfully!"

**Rationale:**
Results should speak for themselves. Generic confirmations add noise without information.
If output shows `df.shape = (300896, 28)`, there's no need to also print "Data loaded successfully!"

**Examples:**

```python
# WRONG
df = pd.read_pickle('data.pkl')
print("Data loaded successfully!")  # ERROR: Generic, no value

# RIGHT
df = pd.read_pickle('data.pkl')
print(f"Loaded: {df.shape[0]:,} rows x {df.shape[1]} columns")  # OK: Informative

# WRONG
correlation = df['x'].corr(df['y'])
print("Correlation analysis complete!")  # ERROR: Useless

# RIGHT
correlation = df['x'].corr(df['y'])
print(f"Correlation (x, y): r = {correlation:.4f}")  # OK: Specific

# WRONG
df_clean = remove_outliers(df)
print("Outliers removed successfully!")  # ERROR: How many? What method?

# RIGHT
before = len(df)
df_clean = remove_outliers(df)
after = len(df_clean)
print(f"Outliers removed: {before - after} ({(before-after)/before*100:.2f}%)")  # OK: Quantified
```

---

### 3.2.6. Coding Anti-Patterns

Best practices tell you what to do; anti-patterns tell you what NOT to do. This section complements the code quality guidelines (Section 3.2.3) with common defective patterns across four categories.

| Category | Patterns | Focus |
|----------|----------|-------|
| Python Fundamentals | 8 | Correctness, maintainability, security |
| Data Science | 9 | Notebook hygiene, reproducibility |
| ML Engineering | 8 | Pipeline integrity, architecture |
| Agent Collaboration | 8 | Human-agent workflow quality |

**Quick reference, top 5 anti-patterns by impact:**

| Anti-Pattern | Category | Consequence |
|-------------|----------|-------------|
| Feature Leakage | ML Engineering | Inflated metrics, production failure |
| God Notebook | Data Science | Unmaintainable, unreproducible |
| Blind Acceptance | Agent Collaboration | Bugs, security issues |
| Mutable Default Arguments | Python | Shared state across calls |
| Training-Serving Skew | ML Engineering | Silent prediction errors |

Each anti-pattern includes Problem, Example (bad code), Fix (correct code), and a DSM Reference linking to the relevant best practice.

**For the complete anti-patterns reference with code examples, see Appendix F: Coding Anti-Patterns.**

---

## 3.3. File Naming Standards

### 3.3.1. Notebook Naming

**Standard Pattern:**
```
[Number]_[PHASE]_[description].ipynb
```

**Examples:**
- `01_EDA_data_quality_cohort.ipynb`
- `02_EDA_behavioral_analysis.ipynb`
- `03_FE_core_features.ipynb`
- `04_FE_advanced_features.ipynb`
- `05_CLUSTERING_preparation_selection.ipynb`
- `06_CLUSTERING_segmentation_assignment.ipynb`

**Phase Codes:**
- `EDA`: Exploration (Phase 1)
- `FE`: Feature Engineering (Phase 2)
- `CLUSTERING` / `CLASSIFICATION` / `REGRESSION`: Analysis (Phase 3)
- `FINAL`: Communication (Phase 4)

**Numbering:**
- Sequential from 01
- Reflects execution order
- Gaps allowed for inserted notebooks

### 3.3.2. Data File Naming

**Pattern:**
```
[entity]_[version]_[date].csv
```

**Examples:**
- `users_v2.1_20251108.csv`
- `user_features_v1.0_20251115.csv`
- `cluster_assignments_v1.0_20251120.csv`

**Versioning:**
- `v1.0`: Initial version
- `v1.1`: Minor updates (added columns, fixed calculations)
- `v2.0`: Major changes (different cohort, new logic)

### 3.3.3. Output File Naming

**Deliverables:**
```
[Project]_[Type]_[Audience].ext
```

**Examples:**
- `TravelTide_Executive_Summary.pdf`
- `TravelTide_Technical_Report.pdf`
- `TravelTide_Customer_Personas.pptx`
- `TravelTide_QA_Document.md`

### 3.3.4. Complete File Naming Guide

For comprehensive file naming standards across all project types, see:
**`1.2_File_Naming_Standards_Comprehensive.md`**

---

## 3.4. Directory Structure

### 3.4.1. Standard Layout

```
project_root/
â”œâ”€â”€ .venv/                      # Virtual environment (not committed)
â”œâ”€â”€ .vscode/                    # VS Code settings
â”‚   â””â”€â”€ settings.json
â”œâ”€â”€ data/
â”‚   â”œâ”€â”€ raw/                    # Original data (read-only)
â”‚   â”œâ”€â”€ processed/              # Cleaned data
â”‚   â””â”€â”€ features/               # Engineered features
â”œâ”€â”€ notebooks/
â”‚   â”œâ”€â”€ 01_EDA_*.ipynb
â”‚   â”œâ”€â”€ 02_EDA_*.ipynb
â”‚   â”œâ”€â”€ 03_FE_*.ipynb
â”‚   â””â”€â”€ ...
â”œâ”€â”€ results/
â”‚   â”œâ”€â”€ figures/                # Visualizations
â”‚   â”œâ”€â”€ models/                 # Trained models
â”‚   â””â”€â”€ reports/                # Written deliverables
â”œâ”€â”€ docs/
â”‚   â”œâ”€â”€ project_plan.md
â”‚   â”œâ”€â”€ decision_log.md
â”‚   â””â”€â”€ feature_dictionary.md
â”œâ”€â”€ requirements_base.txt       # Base packages
â”œâ”€â”€ requirements.txt            # All packages
â””â”€â”€ README.md
```

### 3.4.2. Data Folders Organization

**raw/**: Original data files (never modified)
- As received from source
- Preserved for reproducibility
- Version controlled filenames

**processed/**: Cleaned data
- After quality checks
- Missing data handled
- Outliers addressed
- Ready for feature engineering

**features/**: Engineered features
- Customer-level features
- Transaction-level features
- Aggregated metrics
- Versioned files

### 3.4.3. Output Organization

**figures/**: All visualizations
- EDA plots
- Model validation charts
- Final presentation graphics
- Organized by notebook or phase

**models/**: Serialized models
- Trained clustering models
- Classification models
- Scalers and transformers
- Versioned with date

**reports/**: Written deliverables
- Executive summaries
- Technical reports
- Presentations
- Q&A documents

### 3.4.4. Documentation Folders

**docs/**: Project documentation
- Project plan and timeline
- Decision log
- Feature dictionary
- Data dictionary
- Meeting notes
- Stakeholder communications

**notebooks/**: Analysis notebooks
- Numbered sequentially
- Phase-based organization
- Consolidated final notebook

### 3.4.5. Feature Dictionary Standard

**Purpose:** Document all features (original + engineered) for reproducibility and stakeholder communication

**When to Create/Update:**
- After Sprint 1 (Exploration) - original features
- After Sprint 2 (Feature Engineering) - engineered features
- When features change - create versioned copy

**Filename:** `feature_dictionary.txt` or `feature_dictionary_v[N].txt`

**Location:** `docs/`

**Format:**

```
Feature Dictionary - [Dataset Name]
Version: [N]
Last Updated: [Date]
Project: [Project Name]

==================================================

ORIGINAL FEATURES ([count])
==================================================

[feature_name_1]    [Data type] - [Description with units, source]
[feature_name_2]    [Data type] - [Description]

Example:
unit_sales          Float64 - Number of units sold (target variable, >=0, includes returns as negatives before clipping)
onpromotion         Boolean - Promotion flag (1=item promoted, 0=not promoted, NaN filled with 0 per DEC-003)
date                DateTime - Transaction date (YYYY-MM-DD, range: 2013-01-02 to 2017-08-15)

==================================================

ENGINEERED FEATURES - Sprint 2 ([count])
==================================================

[Temporal Features]
unit_sales_lag1     Float64 - Sales 1 day ago (lag feature, NaN for first observation per store-item)
unit_sales_lag7     Float64 - Sales 7 days ago (NaN ~10% per DEC-011)
unit_sales_7d_avg   Float64 - 7-day moving average (min_periods=1, NaN <1%)

[External Features]
oil_price           Float64 - Daily WTI crude price (USD, $26-$111, merged from oil.csv, forward-filled for weekends)
oil_price_lag7      Float64 - Oil price 7 days ago (USD)
oil_price_change7   Float64 - 7-day oil price momentum ($-79 to $+79, derivative feature)

[Aggregation Features]
store_avg_sales     Float64 - Historical average sales for store (baseline performance, constant within store)
item_avg_sales      Float64 - Historical average sales for item (baseline performance, constant within item)
cluster_avg_sales   Float64 - Historical average sales for cluster (baseline performance, constant within cluster)

[Interaction Features]
promo_item_avg      Float64 - onpromotion x item_avg_sales (promotion impact scaled by item baseline)
```

**Minimum Information Per Feature:**
- Name (as it appears in dataset)
- Data type (Float64, Int64, Boolean, DateTime, String)
- Description (what it represents)
- Units (if numerical - USD, units, days, percentage)
- Source (original data, engineered in Sprint X, merged from file.csv)
- Calculation method (if derived - e.g., "lag 7 days", "7-day rolling mean")
- Special handling (NaN strategy, transformations, clipping)
- Reference to decisions (if applicable - "per DEC-011")

**Versioning:**
- v1: After Sprint 1 (original features only)
- v2: After Sprint 2 (+ engineered features)
- v3: After Sprint 3 (if features added/removed based on modeling)

**Example Entry (Complete):**

```
unit_sales_lag14    Float64 - Sales 14 days ago
                    Source: Engineered in Sprint 2 Day 1
                    Calculation: groupby(['store_nbr', 'item_nbr']).shift(14)
                    NaN handling: Keep NaN (11.7% of rows, tree models handle natively per DEC-011)
                    Correlation with target: r = 0.3194 (moderate positive)
                    Business meaning: Captures bi-weekly shopping cycles (autocorrelation analysis showed lag14 strongest)
```

**Benefits:**
- Onboarding: New team members understand features quickly
- Debugging: Trace feature calculations when errors occur
- Stakeholder communication: Explain features in business terms
- Model interpretation: Reference when explaining feature importance
- Reproducibility: Clear documentation enables recreation

## 3.5. Inclusive Language

Technical writing should be welcoming to all readers. Choose examples and
terminology that demonstrate concepts without reinforcing stereotypes.

### 3.5.1. Terminology

**Avoid:**

| Term | Preferred Alternative |
|------|----------------------|
| master/slave | primary/replica, leader/follower |
| whitelist/blacklist | allowlist/denylist |
| sanity check | validation check, confidence check |
| dummy (variable) | indicator (variable), placeholder |

**Prefer:**
- Gender-neutral language: "they", "the user", "the developer"
- Descriptive terms over metaphorical: "primary branch" over "master branch"

### 3.5.2. Examples and Illustrations

When illustrating technical concepts, prefer examples that are domain-relevant
rather than culturally loaded:

**Word embeddings (NLP):**
- Instead of: "king - man + woman = queen" (gendered royalty)
- Use: "Paris - France + Japan = Tokyo" (geography analogy)
- Use: "good - better = bad - worse" (linguistic analogy)

**General principle:** If an example works equally well with neutral content,
choose the neutral version.

---

# 4. Essential Practices (Tier 1 - Always Use)

## 4.1. Decision Log Framework

### 4.1.1. When to Log Decisions

**Always Document:**
- Cohort definition choices (inclusion/exclusion criteria)
- Feature engineering approaches (why specific calculations)
- Model/algorithm selection (why this approach)
- Pivot decisions (changing direction based on data)
- Data quality compromises (accepting limitations)
- Stakeholder-driven changes (requirement modifications)

**Key Principle:** If you'll need to explain it to stakeholders or justify it later, log it now.

### 4.1.2. Decision Log Template

```markdown
## Decision [ID]: [Brief Title]

**Date:** YYYY-MM-DD  
**Phase:** [0-4]  
**Decision Maker:** [Your name, stakeholder name]  
**Status:** [Proposed | Approved | Implemented | Revised]

### Context
Brief background on the situation requiring a decision.
What prompted this decision? What were we trying to solve?

### Options Considered
1. **Option A:** Description
   - Pros: ...
   - Cons: ...

2. **Option B:** Description
   - Pros: ...
   - Cons: ...

3. **Option C:** Description (Selected)
   - Pros: ...
   - Cons: ...

### Decision
Clear statement of what was decided.

### Rationale
Why this option was chosen over alternatives.
- Evidence from data
- Stakeholder input
- Technical constraints
- Business priorities

### Implementation
How the decision was executed.
- Code changes
- Process adjustments
- Communication to stakeholders

### Impact
Results of the decision.
- What changed?
- Was it successful?
- Lessons learned

### Related Decisions
Links to other decisions that informed or were informed by this one.
```

### 4.1.3. Implementation Guidelines

**File Location:**
- `docs/decision_log.md` in project root
- Or separate file: `docs/DEC-[ID]_[title].md` for complex decisions

**Decision Numbering:**
- Sequential: DEC-001, DEC-002, DEC-003...
- Phase-based: DEC-P1-001, DEC-P2-001... (optional)

**Timing:**
- Log decisions when made, not retroactively
- Update status as decision progresses
- Revisit if decision needs revision

**Linking:**
- Reference decision IDs in notebooks
- Cross-reference related decisions
- Link to relevant code/data files

### 4.1.4. Example from TravelTide

**Real Decision Log Entry:**

```markdown
## Decision DEC-003: Use K=3 Instead of K=5 for Customer Segmentation

**Date:** 2025-11-12  
**Phase:** 3 (Analysis)  
**Decision Maker:** Alberto (analyst), Elena (stakeholder approval)  
**Status:** Approved & Implemented

### Context
Initial business requirement specified 5 customer segments for 5 perk types.
Clustering analysis revealed statistical evidence for 3 natural segments.

### Options Considered
1. **Force K=5 (as requested):**
   - Pros: Matches business request, one segment per perk
   - Cons: Silhouette score 0.23 (weak), clusters not statistically distinct

2. **Use K=3 (statistical optimum):**
   - Pros: Silhouette score 0.38 (moderate), clear behavioral differences
   - Cons: Need to assign 5 perks across 3 segments

3. **Recommend K=4 (compromise):**
   - Pros: Closer to business expectation
   - Cons: Silhouette score 0.28 (still weak), unclear segment definitions

### Decision
Proceed with K=3 clustering, implement fuzzy perk assignment strategy.

### Rationale
- Statistical validity: K=3 shows clear separation (silhouette = 0.38)
- Business alignment: Can assign multiple perks per segment based on propensities
- Data-driven: Let data guide segmentation, not predetermined expectations
- Stakeholder buy-in: Elena agreed after seeing statistical evidence

### Implementation
- K-Means with K=3 applied to 89 features
- Fuzzy perk assignment: Each segment gets 1-2 primary perks based on propensities
- Created detailed segment personas for business understanding

### Impact
- Successfully created 3 distinct, actionable customer segments
- Stakeholder satisfied with segment clarity and perk assignments
- Demonstrates value of data-driven pivots over rigid requirements

### Related Decisions
- DEC-002: Feature selection for clustering
- DEC-004: Perk assignment strategy across 3 segments
```

**Key Takeaway:** This decision log enabled clear stakeholder communication about why we deviated from initial requirements.

### 4.1.5. Hypothesis Testing with Rejection Protocol

**Core Principle:** Design experiments that CAN fail, document negative results as valuable findings.

**Source:** Favorita Demand Forecasting Project - DEC-015 (Full 2013 Training) was rejected after testing showed 106% worse RMSE. This rejection became one of the most valuable findings: temporal consistency matters more than data volume.

**Why This Matters:**
- Confirmation bias leads to only testing hypotheses we expect to succeed
- Negative results are scientifically valuable but often undocumented
- Explicit rejection criteria prevent "massaging" results to fit expectations
- Documenting failures prevents repeating mistakes

**Hypothesis Registration Template:**

```markdown
## HYPOTHESIS: [Clear, falsifiable statement]

**Registered:** [Date]
**Status:** TESTING / CONFIRMED / REJECTED

### Pre-Registration

**Hypothesis Statement:**
[Specific, testable claim - e.g., "Using full 2013 training data will improve Q1 2014 forecast accuracy"]

**Expected Outcome:**
[What you expect to see if hypothesis is true]
- Metric: [e.g., RMSE]
- Expected direction: [e.g., decrease by >5%]
- Baseline: [e.g., RMSE 6.89 with Q1-only training]

**Rejection Criteria (define BEFORE testing):**
- Reject if: [e.g., RMSE increases by >10%]
- Reject if: [e.g., model fails to converge]
- Reject if: [e.g., validation metrics degrade]

**Test Design:**
- Data split: [training/validation/test]
- Metrics: [primary and secondary]
- Comparison: [baseline vs. experimental]

### Results

**Actual Outcome:**
[Fill after testing]
- Metric value: [actual result]
- vs Expected: [comparison]
- Statistical significance: [if applicable]

**Verdict:** CONFIRMED / REJECTED

### Post-Mortem (if rejected)

**Why Did This Fail?**
[Root cause analysis]

**What Did We Learn?**
[Valuable insight from failure]

**How Does This Change Our Approach?**
[Next steps based on finding]
```

**Example: DEC-015 from Favorita Project**

```markdown
## HYPOTHESIS: More Training Data Improves Forecasting

**Registered:** 2025-12-08
**Status:** REJECTED

### Pre-Registration

**Hypothesis Statement:**
Using full 2013 training data (12 months) will improve Q1 2014 forecast accuracy compared to Q1-only training (3 months).

**Expected Outcome:**
- Metric: RMSE
- Expected direction: Decrease by 5-15%
- Baseline: RMSE 6.89 (Q1 2014 training only)

**Rejection Criteria:**
- Reject if: RMSE increases by >10%
- Reject if: Model shows seasonal mismatch patterns

**Test Design:**
- Training: Full 2013 (Jan-Dec) vs Q1-only (Jan-Mar 2014)
- Validation: Feb 2014
- Test: March 2014

### Results

**Actual Outcome:**
- Full 2013 RMSE: 14.88
- Q1-only RMSE: 6.89
- Change: +106% WORSE

**Verdict:** REJECTED

### Post-Mortem

**Why Did This Fail?**
Seasonal mismatch: Full 2013 included Q2-Q3 patterns (low season) that dominated the model, making it poorly suited for Q1 2014 (high season).

**What Did We Learn?**
Temporal consistency principle: Seasonally-aligned training data outperforms volume. 6 months of relevant data > 12 months of mixed data.

**How Does This Change Our Approach?**
- Created DEC-016: Temporal Consistency Principle
- Applied Q4 2013 + Q1 2014 training (seasonally aligned)
- Result: RMSE 6.84 (improvement achieved with LESS data)
```

**Best Practices:**

1. **Pre-register rejection criteria** - Define what constitutes failure BEFORE running tests
2. **Document ALL hypotheses tested** - Not just the ones that succeeded
3. **Treat rejections as findings** - Failed hypotheses teach as much as successful ones
4. **Link related decisions** - Show how rejections led to better approaches
5. **Share negative results** - Include in reports and presentations as methodology validation

**Integration with Decision Log:**
- REJECTED hypotheses become decision log entries with "Status: REJECTED"
- Link rejected decisions to subsequent decisions they informed
- Include rejection count in project summaries (e.g., "Tested 8 hypotheses, confirmed 5, rejected 3")

---

## 4.2. Pivot Criteria & Failure Modes

### 4.2.1. When to Pivot

**Pivot Triggers:**
- Data reveals different patterns than expected
- Initial assumptions proven invalid
- Stakeholder requirements change
- Technical constraints emerge
- Better approach discovered mid-project
- Timeline or resource constraints require scope change

**Signs You Should Consider Pivoting:**
- Forcing data to match predetermined conclusions
- Repeated validation failures
- Stakeholder feedback indicates misalignment
- Key assumptions invalidated
- Better alternative approach emerges

**When NOT to Pivot:**
- Minor setbacks that can be addressed
- Personal preference for different approach
- Incomplete exploration of current approach
- Stakeholder impatience (without technical reason)

### 4.2.2. Pivot Decision Framework

**Step 1: Recognize Signal**
- Validation metrics consistently poor
- Data patterns contradict hypothesis
- Stakeholder priorities shift
- Technical blocker encountered

**Step 2: Assess Impact**
- How significant is the issue?
- Can current approach be salvaged?
- What's the cost of continuing vs. pivoting?
- What's at risk if we don't pivot?

**Step 3: Evaluate Alternatives**
- What other approaches are viable?
- Do we have evidence for alternative?
- What's the effort to pivot?
- What's the expected improvement?

**Step 4: Stakeholder Communication**
- Present evidence for pivot
- Show alternatives and trade-offs
- Get buy-in before proceeding
- Document decision (Section 4.1)

**Step 5: Execute Pivot**
- Update project plan
- Adjust timelines
- Communicate changes
- Proceed with new approach

### 4.2.3. Common Failure Patterns

**Pattern 1: Ignoring Statistical Evidence**
- **Symptom:** Poor validation metrics, but continuing anyway
- **Example:** K=5 clustering with weak silhouette score
- **Solution:** Pivot to K=3 based on statistical evidence
- **Prevention:** Establish acceptance criteria upfront

**Pattern 2: Sunk Cost Fallacy**
- **Symptom:** "We've already spent 2 sprints on this approach..."
- **Example:** Continuing with approach that clearly won't work
- **Solution:** Accept losses, pivot to better approach
- **Prevention:** Regular checkpoint reviews with pivot criteria

**Pattern 3: Feature Engineering Rabbit Hole**
- **Symptom:** Creating hundreds of features without validation
- **Example:** 500+ features with unclear business meaning
- **Solution:** Pivot to core features with clear interpretation
- **Prevention:** Start simple, expand only if justified

**Pattern 4: Over-Optimization**
- **Symptom:** Endless tuning for marginal gains
- **Example:** Days spent improving metric by 0.01
- **Solution:** Pivot to next phase when diminishing returns
- **Prevention:** Set "good enough" thresholds upfront

**Pattern 5: Analysis Paralysis**
- **Symptom:** Trying every possible technique before deciding
- **Example:** Testing 10+ clustering algorithms
- **Solution:** Pick 2-3 reasonable approaches, choose best
- **Prevention:** Set decision criteria and timeline

### 4.2.4. Recovery Strategies

**When Behind Schedule:**
- Reduce scope to essential deliverables
- Simplify approach (complex â†’ simple)
- Parallel work where possible
- Honest communication with stakeholders

**When Data Quality Issues Emerge:**
- Document limitations clearly
- Adjust analytical scope
- Use available data effectively
- Don't create misleading features to compensate

**When Stakeholder Requirements Change:**
- Assess feasibility with current work
- Negotiate timeline adjustments
- Prioritize new requirements
- Document change in decision log

**When Technical Challenges Arise:**
- Seek alternative approaches
- Simplify technical complexity
- Leverage existing solutions
- Don't reinvent wheel unnecessarily

---

## 4.3. Stakeholder Communication

### 4.3.1. Communication Cadence

**Sprint Updates (Recommended):**
- Progress summary (what was completed)
- Key findings (data insights)
- Decisions made (reference decision log)
- Next sprint plan (clear objectives)
- Blockers or concerns (flag early)

**Phase Completion Updates:**
- Comprehensive phase summary
- Key deliverables review
- Significant decisions and rationale
- Next phase preview
- Timeline check-in

**Ad-Hoc Communications:**
- Pivot decisions (immediate notification)
- Unexpected findings (proactive sharing)
- Data quality issues (early warning)
- Requirement clarifications (as needed)

**Template for Sprint Update:**
```markdown
## [Project Name] - Sprint [N] Update

**Date:** YYYY-MM-DD
**Phase:** [Current Phase]
**Status:** [On Track | Slight Delay | Blocked]

### This Sprint Accomplishments
- Completed [specific tasks]
- Key finding: [insight from data]
- Decision made: [reference DEC-ID]

### Key Insights
- [Data-driven insights]
- [Preliminary findings]
- [Patterns observed]

### Next Sprint Plan
- [Specific objectives]
- [Expected deliverables]
- [Questions for stakeholder]

### Concerns / Blockers
- [Any issues, if none state "None"]
```

### 4.3.2. Update Templates

**Executive Summary Format:**
```markdown
## Executive Summary - [Phase] Complete

**Bottom Line:** [One sentence key takeaway]

**Key Findings:**
1. [Finding with business impact]
2. [Finding with business impact]
3. [Finding with business impact]

**Recommendations:**
1. [Actionable recommendation]
2. [Actionable recommendation]

**Next Steps:**
- [What happens next]
- [Timeline]
```

**Technical Update Format:**
```markdown
## Technical Progress - [Phase]

**Data Status:**
- Cohort: [size, description]
- Features: [count, key features]
- Quality: [assessment]

**Analysis Progress:**
- Approach: [methodology]
- Validation: [metrics, results]
- Findings: [technical details]

**Technical Decisions:**
- [Decision reference with rationale]

**Next Technical Steps:**
- [Specific tasks]
```

### 4.3.3. Technical Translation Guidelines

**Principle:** Stakeholders don't need to understand the how, but must understand the what and why.

**Translation Examples:**

**Technical:** "K-Means clustering on 89 features yielded K=3 with silhouette score 0.38"
**Stakeholder:** "Analysis identified 3 distinct customer groups with clear behavioral differences"

**Technical:** "Cancellation propensity calculated as ratio of cancelled bookings to total bookings"
**Stakeholder:** "Measured how likely each customer is to cancel trips based on past behavior"

**Technical:** "PCA explained variance 65% with 5 components"
**Stakeholder:** "Simplified 89 customer behaviors into 5 key patterns that capture most variation"

**Technical:** "Davies-Bouldin index decreased from 1.8 to 1.2"
**Stakeholder:** "Segment separation improved significantly, clusters are more distinct"

**Guidelines:**
- Replace jargon with plain language
- Focus on business impact, not statistical mechanics
- Use analogies where helpful
- Provide technical details in appendix if requested

### 4.3.4. Multi-Stakeholder Management

**Different Audiences, Different Needs:**

**Executive Leadership (e.g., Elena - Head of Marketing):**
- **Focus:** Business impact, ROI, strategic decisions
- **Format:** 1-2 page executive summary, 5-slide deck
- **Language:** Business terms, minimal technical jargon
- **Frequency:** Phase completions, major pivots

**Technical Team:**
- **Focus:** Methodology, reproducibility, code quality
- **Format:** Detailed notebooks, technical reports
- **Language:** Statistical terms, code examples
- **Frequency:** Regular updates, code reviews

**Operational Team:**
- **Focus:** Implementation, actionable insights
- **Format:** Persona descriptions, recommendation lists
- **Language:** Practical examples, clear instructions
- **Frequency:** Final deliverables, Q&A sessions

**Cross-Functional Meetings:**
- **Prepare:** Multiple versions (exec summary + technical details)
- **Start:** High-level findings (everyone understands)
- **Detail:** Available on request (for technical audience)
- **Close:** Clear next steps and ownership

**Example Multi-Level Communication:**
- **Email to Elena:** "3 customer segments identified with distinct behaviors. Recommend exclusive perks for high-value travelers, free cancellation for budget travelers."
- **Tech Doc:** Complete clustering methodology, validation metrics, code repository link
- **Operational Guide:** "Segment 1: High-value frequent travelers. Behaviors: Books luxury stays, travels monthly. Recommended perks: Exclusive lounge access, priority booking."

---

# 5. Advanced Practices (Tiers 2-4 - Selective Use)

## 5.1. When to Activate Advanced Practices

### 5.1.1. Complexity Assessment

**Use Advanced Practices When:**
- Project has production deployment goals
- Multiple stakeholders with conflicting requirements
- Large-scale data (millions of rows, hundreds of features)
- Novel problem requiring literature review
- High-stakes decisions with significant business impact
- Team environment requiring code standards
- Long-term maintenance expected

**Skip Advanced Practices When:**
- Academic coursework with clear scope
- Exploratory one-time analysis
- Small datasets (<10K rows)
- Well-understood problem domain
- Single stakeholder with clear requirements
- Short timeline (<4 sprints)

### 5.1.2. Selection Criteria

**Tier 2 (Enhanced Analysis):**
- **Activate When:** Multiple model iterations, hypothesis testing needed
- **Examples:** ML projects, comparative studies, research projects
- **Time Investment:** +20-30% project time
- **Practices:** Experiment tracking, hypothesis management, baseline benchmarking

**Tier 3 (Production Preparation):**
- **Activate When:** Production deployment planned, team collaboration
- **Examples:** Deployed models, shared codebases, regulated domains
- **Time Investment:** +40-60% project time
- **Practices:** Testing, ethics/bias review, data versioning

**Tier 4 (Enterprise Scale):**
- **Activate When:** Large teams, long-term projects, technical complexity
- **Examples:** Multi-year projects, novel research, scalable systems
- **Time Investment:** +80-100% project time
- **Practices:** Technical debt management, scalability planning, literature review, risk management

### 5.1.3. Tier System Explanation

**Cumulative Tiers:**
- Tier 2 includes Tier 1 (Essential Practices)
- Tier 3 includes Tier 1 + Tier 2
- Tier 4 includes Tier 1 + Tier 2 + Tier 3

**Example Project Classifications:**

**TravelTide Customer Segmentation:**
- **Tier Used:** Tier 1 + selective Tier 2
- **Rationale:** Academic project, no production deployment, clear stakeholder
- **Activated:** Experiment tracking (for K selection), hypothesis management (for validation)
- **Skipped:** Testing, versioning, technical debt, scalability (not needed)

**Production ML System:**
- **Tier Used:** Tier 1 + 2 + 3
- **Rationale:** Deployed model, ongoing maintenance, team collaboration
- **Activated:** All Tier 3 practices for production readiness
- **Skipped:** Tier 4 (unless scaling to millions of users)

### 5.1.4. Activation Guidelines

**Decision Process:**
1. **Start with Tier 1 (Essential):** Always use
2. **Assess Project Complexity:** Use criteria in 5.1.1
3. **Select Tier:** Match project needs
4. **Pick Specific Practices:** Not all practices in tier may be needed
5. **Document Choice:** Note in project plan which practices activated

**Red Flags (You Might Need Higher Tier):**
- "How do we track all these experiments?"
- "We need to deploy this to production."
- "Multiple teams will use this code."
- "This needs to scale to 10M users."
- "No one has solved this problem before."

---

## 5.2. Tier 2 Practices (Enhanced Analysis)

### 5.2.1. Experiment Tracking

**When to Use:**
- Training multiple models with different parameters
- Comparing different feature sets
- Iterating on model architecture
- A/B testing different approaches

**What It Provides:**
- Systematic tracking of model experiments
- Parameter and metric logging
- Comparison of model performance
- Reproducibility of best model

**Key Components:**
- Experiment naming convention
- Parameter logging
- Metric tracking
- Model artifact storage

**Example Use Case:**
Testing K=2 through K=7 for clustering, tracking silhouette scores, Davies-Bouldin index, and business interpretability for each K value.

**For complete implementation guidance, see Appendix C.1: Experiment Tracking Implementation.**

### 5.2.2. Hypothesis Management

**When to Use:**
- Research-oriented projects
- Projects with clear hypotheses to test
- Stakeholder expectations need validation
- Claims requiring statistical support

**What It Provides:**
- Structured hypothesis formulation
- Pre-registration of tests (avoid p-hacking)
- Systematic results tracking
- Clear distinction between exploratory and confirmatory analysis

**Key Components:**
- Hypothesis documentation template
- Pre-registration process
- Results tracking
- Statistical test selection

**Example Use Case:**
"H1: High CLV customers prefer exclusive perks" â€” test before implementing perk strategy.

**For complete implementation guidance, see Appendix C.2: Hypothesis Management Implementation.**

### 5.2.3. Performance Baseline & Benchmarking

**When to Use:**
- Evaluating model improvements
- Comparing to existing solutions
- Justifying new approach
- Setting success criteria

**What It Provides:**
- Clear performance baseline (naive, simple, existing)
- Meaningful comparison metrics
- Progress tracking over iterations
- Success criteria validation

**Key Components:**
- Baseline establishment (naive, simple model)
- Success criteria definition
- Progress tracking dashboard
- Benchmark selection

**Example Use Case:**
Establish baseline with random assignment, compare K-Means to hierarchical clustering, track improvement over iterations.

**For complete implementation guidance, see Appendix C.3: Performance Baseline Implementation.**

---

## 5.3. Tier 3 Practices (Production Preparation)

### 5.3.1. Ethics & Bias Considerations

**When to Use:**
- Models affecting people (hiring, lending, healthcare)
- Sensitive attributes (race, gender, age)
- Regulated industries
- Public-facing applications

**What It Provides:**
- Bias detection in data and models
- Fairness metric evaluation
- Disparate impact analysis
- Mitigation strategies
- Documentation for compliance

**Key Components:**
- Bias audit checklist
- Fairness metrics (demographic parity, equalized odds)
- Privacy assessment
- Ethical review triggers

**Example Use Case:**
Ensuring customer segmentation doesn't discriminate based on protected characteristics, validating perk assignments are fair across demographics.

**For complete implementation guidance, see Appendix C.4: Ethics & Bias Implementation.**

### 5.3.2. Testing Strategy

**When to Use:**
- Production deployments
- Team collaboration
- Code reuse across projects
- Long-term maintenance

**What It Provides:**
- Automated validation of data pipelines
- Regression prevention
- Confidence in refactoring
- Documentation through tests

**Key Components:**
- Unit tests for functions
- Integration tests for pipelines
- Data validation tests
- Regression tests

**Example Use Case:**
Test that feature engineering functions produce expected outputs, validate data transformations don't break with new data.

**For complete implementation guidance, see Appendix C.5: Testing Strategy Implementation.**

### 5.3.3. Data Versioning & Lineage

**When to Use:**
- Multiple data versions
- Reproducibility critical
- Regulatory requirements
- Team data sharing

**What It Provides:**
- Track data changes over time
- Reproduce analyses with specific data versions
- Understand data provenance
- Collaboration without conflicts

**Key Components:**
- Versioning strategy (semantic versioning)
- Lineage tracking (data transformations)
- Change logs (what changed, why)
- Reproducibility protocol

**Example Use Case:**
Track `users_v2.0.csv` â†’ `users_v2.1.csv` changes, document why cohort definition changed, enable reproduction of v2.0 analysis.

**For complete implementation guidance, see Appendix C.6: Data Versioning Implementation.**

---

## 5.4. Tier 4 Practices (Enterprise Scale)

### 5.4.1. Technical Debt Register

**When to Use:**
- Long-term projects (>6 months)
- Growing codebase
- Team projects
- Production systems

**What It Provides:**
- Systematic tracking of shortcuts and workarounds
- Prioritization of refactoring
- Prevention of debt accumulation
- Team awareness of code quality issues

**Key Components:**
- Debt documentation template
- Prioritization matrix (impact vs effort)
- Debt tolerance thresholds
- Paydown planning

**Example Use Case:**
"TD-003: Feature engineering code duplicated across 3 notebooks. Impact: High maintenance burden. Plan: Consolidate into shared module."

**For complete implementation guidance, see Appendix C.7: Technical Debt Implementation.**

### 5.4.2. Scalability Considerations

**When to Use:**
- Data growth expected (10x, 100x)
- User base expansion
- Real-time requirements emerging
- Performance bottlenecks observed

**What It Provides:**
- Resource estimation
- Optimization triggers
- Architecture decisions
- Performance monitoring

**Key Components:**
- Scalability checkpoints (when to optimize)
- Resource estimation (memory, compute)
- Optimization strategies
- Architecture decision checklist

**Example Use Case:**
"Current: 5K customers, in-memory processing. Trigger: Optimize when >100K customers. Strategy: Move to Dask or Spark."

**For complete implementation guidance, see Appendix C.8: Scalability Implementation.**

### 5.4.3. Literature Review Phase

**When to Use:**
- Novel problem domain
- Research-oriented projects
- No established best practices
- Academic publications planned

**What It Provides:**
- State-of-art understanding
- Best practice identification
- Methodology justification
- Citation foundation for publications

**Key Components:**
- Review scope definition
- Information extraction template
- Synthesis and application
- Citation management

**Example Use Case:**
"No established approach for XYZ problem. Review: 25 papers on similar domains. Finding: Technique ABC shows promise, adapt to our context."

**For complete implementation guidance, see Appendix C.9: Literature Review Implementation.**

### 5.4.4. Risk Management

**When to Use:**
- High-stakes decisions
- Multiple dependencies
- Uncertain requirements
- Long timelines with many unknowns

**What It Provides:**
- Risk identification
- Mitigation strategies
- Monitoring approach
- Contingency planning

**Key Components:**
- Risk identification framework
- Impact and probability assessment
- Mitigation planning
- Monitoring and triggers

**Example Use Case:**
"Risk: Stakeholder requirements change mid-project. Probability: Medium. Impact: High. Mitigation: Sprint check-ins, documented requirements, flexible architecture."

**For complete implementation guidance, see Appendix C.10: Risk Management Implementation.**

---

# 6. Session & Quality Management

## 6.1. Session Management

### 6.1.1. Token Monitoring

**Why It Matters:**
- The agent has conversation length limits (~190K tokens)
- Long sessions degrade context quality
- Important to plan handoffs before hitting limits

**Monitoring Guidelines:**
- Check token usage periodically
- Alert at 90% capacity (~171K tokens)
- Plan handoff at 95% capacity (~180K tokens)
- Don't wait until 100% â€” context gets truncated

**How to Monitor:**
- Ask the agent: "What's our current token usage?"
- The agent will report: "Currently X/190K tokens (Y% used)"
- Plan accordingly

### 6.1.2. Session Handoff Templates

**When to Create Handoff:**
- Approaching token limit (90-95%)
- End of work session (even if tokens remaining)
- Major phase transition
- Before pivoting direction

**Handoff Document Template:**
```markdown
# Session Handoff - [Project Name]

**Date:** YYYY-MM-DD  
**Session:** [Number/Description]  
**Token Usage:** [X/190K tokens (Y% used)]
**DSM Version:** [e.g., v1.3.7]

## Current Status
- **Phase:** [Current phase]
- **Last Completed:** [What was just finished]
- **In Progress:** [What's partially done]
- **Next Steps:** [Clear next actions]

## Key Decisions Made
- [Decision reference: DEC-ID]
- [Decision reference: DEC-ID]
- [Brief summary if needed]

## Files Created/Modified
- [List of files with brief description]
- [Include file paths]

## Important Context
- [Any crucial information for next session]
- [Open questions]
- [Blockers or concerns]

## Next Session Prompt
[Exact prompt to start next session efficiently]
"I'm continuing work on [project]. Last session we completed [X]. 
Next step is [Y]. Please review the handoff document in docs/handoffs/."
```

**Example Handoff Prompt:**
```
I'm continuing the TravelTide customer segmentation project.
Last session we completed Phase 2 (feature engineering) and created 89 features.
Next step is Phase 3: clustering analysis to identify customer segments.
Please review the session handoff in docs/handoffs/.
```

**Note:** Store handoffs in `docs/handoffs/` within the project repository. For same-date
sessions, append to the existing handoff file rather than creating a new one.

### 6.1.3. Continuity Best Practices

**Before Starting New Session:**
- Review previous session handoff in `docs/handoffs/`
- Review decision log for context
- Check what files were created
- Understand where we left off

**During Session:**
- Reference previous decisions by ID
- Build on previous work, don't restart
- Update decision log as new decisions made
- Track progress toward next handoff

**Ending Session:**
- Follow Section 6.1.5 Session Close-Out Protocol
- Create or update handoff document in `docs/handoffs/`
- Summarize key accomplishments
- Document any pending questions
- Provide clear next steps

### 6.1.4. Daily Documentation Protocol

**Purpose:**
Maintain project continuity and progress visibility through consistent documentation at notebook completion and end of each working day.

#### End of Notebook Checklist

**Before closing any notebook, verify:**

```markdown
## Notebook Completion Checklist

### Data Outputs
- [ ] All processed data saved to appropriate location
- [ ] File names follow naming convention (sYY_dXX_PHASE_description.pkl)
- [ ] Data shapes and key statistics printed for verification

### Code Quality
- [ ] All cells execute without errors (Kernel > Restart & Run All)
- [ ] No hardcoded paths (using constants from setup section)
- [ ] Temporary/debugging cells removed or marked

### Documentation
- [ ] Summary section completed with key findings
- [ ] Next steps clearly stated
- [ ] Any new decisions logged (DEC-XXX format)

### Validation
- [ ] Output data validated (shape, nulls, value ranges)
- [ ] Results make business sense
- [ ] Checkpoint saved if notebook > 200 lines
```

**Notebook Summary Cell Template (add as final cell):**
```python
# ============================================================
# NOTEBOOK SUMMARY
# ============================================================
#
# Completed: [Brief description of what was accomplished]
#
# Key Outputs:
# - [output_file_1.pkl]: [description] ([X] rows, [Y] columns)
# - [output_file_2.csv]: [description]
#
# Key Findings:
# - [Finding 1]
# - [Finding 2]
#
# Decisions Made:
# - DEC-XXX: [Brief description]
#
# Next Steps:
# - [Next notebook or task]
#
# ============================================================
```

#### Daily Checkpoint Template

**File:** `docs/checkpoints/sYY_dXX_checkpoint.md`

```markdown
# Daily Checkpoint - Sprint [Y] Day [X]

**Date:** YYYY-MM-DD
**Hours Worked:** [X]h
**Cumulative Sprint Hours:** [X]h

## Completed Today
- [ ] [Task 1 with notebook reference]
- [ ] [Task 2 with notebook reference]
- [ ] [Task 3 with notebook reference]

## Notebooks Created/Modified
| Notebook | Status | Key Output |
|----------|--------|------------|
| sYY_dXX_PHASE_description.ipynb | Complete | output_file.pkl |

## Decisions Made
- DEC-XXX: [Brief summary]

## Blockers/Issues
- [Issue 1 and resolution or status]
- None (if no blockers)

## Tomorrow's Priority
1. [First priority task]
2. [Second priority task]

## Notes
[Any context needed for continuity]
```

#### End of Day Summary

**Quick Protocol (5 minutes):**

1. **Save all work**
   - Ensure all notebooks saved
   - Commit to git if applicable

2. **Update checkpoint file**
   - Create/update `docs/checkpoints/sYY_dXX_checkpoint.md`
   - Mark completed items
   - Note any blockers

3. **Update decision log**
   - Add any new DEC-XXX entries
   - Update status of existing decisions if changed

4. **Prepare next day**
   - Identify first task for tomorrow
   - Note any questions to resolve

**When to Create Session Handoff Instead:**
- Approaching token limit (90%+)
- Won't continue same session tomorrow
- Major phase transition
- Need to share context with collaborator

### 6.1.5. Session Close-Out Protocol

**Purpose:** Standardize session endings to prevent data loss, maintain continuity,
and keep governance artifacts current.

**When to use:** At the end of every working session, whether hub (DSM Central) or
spoke (project) session.

**Universal Close-Out Checklist:**

1. **Commit all pending changes**
   - Stage modified files (`git add` specific files, not `-A`)
   - Commit with descriptive message referencing BACKLOG-### if applicable
   - Verify clean working tree (`git status`)

2. **Push to remote**
   - Ensure commits are pushed; local-only work is at risk of loss

3. **Create or update handoff document**
   - If session has complex pending work or spans multiple sessions on the same day,
     append to the existing date's handoff
   - Location: `docs/handoffs/` within the project repository
   - Use Section 6.1.2 handoff template

**Hub-Specific Close-Out (DSM Central):**

In addition to the universal checklist:

4. **Update session memory**
   - Update MEMORY.md (live) with session summary, key decisions, and pending work
   - Refresh repo backup: copy live MEMORY.md to `.claude/memory/MEMORY.md`

5. **Check contributor profile**
   - If new skills were exercised or proficiency levels changed, update
     `.claude/contributor-profile.md`

**Spoke-Specific Close-Out (Project Sessions):**

In addition to the universal checklist:

4. **Update feedback files** (if methodology observations were made)
   - `docs/feedback/methodology.md` and `docs/feedback/backlogs.md`

5. **Sprint boundary deliverables** (if at sprint end)
   - Checkpoint document, feedback files, decision log, blog entry, README update
   - Reference: PM Guidelines Template 8 Sprint Boundary Checklist

**Quick Reference:**
- "Wrap up" trigger: user says "wrap up" or session is ending
- Minimum: commit, push, handoff (steps 1-3)
- Full: all applicable steps for hub or spoke context

---

## 6.2. Quality Assurance

### 6.2.1. Phase Completion Checklists

**Phase 0 Checklist:**
- [ ] Virtual environment created and activated
- [ ] Base packages installed
- [ ] Jupyter kernel registered
- [ ] VS Code configuration complete
- [ ] First notebook created successfully
- [ ] Test imports functional

**Phase 1 Checklist:**
- [ ] Data quality assessment complete
- [ ] Cohort definition documented
- [ ] Missing data patterns understood
- [ ] Key distributions visualized
- [ ] Decision log updated
- [ ] Stakeholder update provided

**Phase 2 Checklist:**
- [ ] All features engineered
- [ ] Feature dictionary created
- [ ] No data leakage verified
- [ ] Distributions validated
- [ ] Feature dataset exported
- [ ] Decision log updated

**Phase 3 Checklist:**
- [ ] Model/analysis validated
- [ ] Results interpreted
- [ ] Limitations documented
- [ ] Decision log updated
- [ ] Ready for communication

**Phase 4 Checklist:**
- [ ] Notebooks consolidated
- [ ] Presentation created
- [ ] Technical report written
- [ ] Q&A document prepared
- [ ] All deliverables reviewed
- [ ] Stakeholders notified

### 6.2.2. Code Review Guidelines

**Self-Review Checklist:**
- [ ] All cells execute without errors
- [ ] Outputs are informative (not "Done!")
- [ ] No hard-coded paths
- [ ] Clear variable names
- [ ] Comments for complex logic
- [ ] Text conventions followed (WARNING/OK/ERROR)
- [ ] No emojis in code or markdown
- [ ] Proper file naming

**Peer Review Focus:**
- Logic correctness
- Reproducibility
- Clarity of explanations
- Assumption validity
- Edge case handling

### 6.2.3. Reproducibility Standards

**Required for Reproducibility:**
- [ ] Clear environment setup instructions
- [ ] requirements.txt or environment.yml
- [ ] All data files documented (location, version)
- [ ] Random seeds set for stochastic processes
- [ ] Clear execution order of notebooks
- [ ] No manual data edits (all programmatic)

**Testing Reproducibility:**
```bash
# Fresh environment test
python -m venv test_venv
test_venv\Scripts\activate
pip install -r requirements.txt

# Run all notebooks in order
jupyter execute 01_EDA_*.ipynb
jupyter execute 02_EDA_*.ipynb
# ... etc
```

### 6.2.4. Documentation Completeness Checks

**Project-Level Documentation:**
- [ ] README.md with project overview
- [ ] Decision log maintained
- [ ] Feature dictionary complete
- [ ] Data dictionary (if needed)
- [ ] Stakeholder communications archived

**Code-Level Documentation:**
- [ ] Notebook markdown cells explain logic
- [ ] Function docstrings present
- [ ] Complex calculations commented
- [ ] Assumptions documented

**Deliverable Documentation:**
- [ ] Executive summary standalone
- [ ] Technical report complete
- [ ] Q&A document comprehensive
- [ ] Presentation self-explanatory

### 6.2.5. Progressive Execution Standard (Cell-by-Cell Protocol)

**Jupyter Notebook Execution Best Practice:**

Execute notebooks progressively, validating output at each step rather than running all cells at once.

**Protocol:**
1. Execute one cell at a time
2. Read and validate output before proceeding
3. Request specific quantitative findings after major steps
4. Never skip validation to "save time" - errors compound

**Why This Matters:**
- Catches errors immediately (not at end of notebook)
- Builds confidence in results (verified at each step)
- Easier debugging (know exactly where issue occurred)
- Prevents cascading errors from bad intermediate outputs

**Output Validation Pattern:**

```python
# After each transformation
print(f"Shape: {df.shape}")  # NOT "Data loaded successfully!"
print(f"Missing: {df.isnull().sum().sum()}")
print(f"Date range: {df['date'].min()} to {df['date'].max()}")

# After each calculation
print(f"Correlation: {corr:.4f}")  # NOT "Correlation computed!"
print(f"Weekend lift: +{lift:.1f}%")  # NOT "Analysis complete!"

# After each merge
print(f"Rows before: {before_rows}, after: {after_rows}")  # NOT "Merge successful!"
print(f"Columns added: {new_cols}")
```

**Anti-Pattern:**
```python
# WRONG - No verification
df = df.merge(other_df, on='date')
# Proceed to next cell without checking merge result
```

**Correct Pattern:**
```python
# RIGHT - Immediate verification
before_rows = len(df)
df = df.merge(other_df, on='date', how='left')
after_rows = len(df)

print(f"Merge verification:")
print(f"  Rows: {before_rows} -> {after_rows}")
print(f"  Expected: {before_rows} (left join preserves)")
print(f"  Match: {'OK' if before_rows == after_rows else 'ERROR'}")
```

**Agent Collaboration:**
- Request quantitative findings after each code step
- Don't accept generic "Complete!" messages
- Ask for specific metrics to validate correctness

---

## 6.3. Troubleshooting

### 6.3.1. Common Issues by Phase

**Phase 0 Issues:**
- **Issue:** Virtual environment not recognized
- **Solution:** Verify VS Code Python interpreter path points to `.venv`
- **Issue:** Jupyter kernel not found
- **Solution:** Re-run kernel registration: `python -m ipykernel install --user --name=project_base_kernel`

**Phase 1 Issues:**
- **Issue:** Data loading fails
- **Solution:** Check file paths, verify file exists, check read permissions
- **Issue:** Unexpected data types
- **Solution:** Explicit type conversion, check source data format

**Phase 2 Issues:**
- **Issue:** Feature calculations produce NaN
- **Solution:** Check for division by zero, missing data in source
- **Issue:** Features don't align with expectations
- **Solution:** Validate sample calculations manually

**Phase 3 Issues:**
- **Issue:** Poor model performance
- **Solution:** Check feature distributions, try different approaches, revisit features
- **Issue:** Inconsistent validation results
- **Solution:** Set random seeds, check for data leakage

**Phase 4 Issues:**
- **Issue:** Stakeholders don't understand findings
- **Solution:** Simplify language, use analogies, focus on business impact
- **Issue:** Questions about methodology
- **Solution:** Reference decision log, provide technical appendix

### 6.3.2. Error Resolution Patterns

**Data-Related Errors:**
1. Check data shape and types
2. Validate sample of data manually
3. Look for nulls, zeros, infinities
4. Check data version matches expectations

**Code-Related Errors:**
1. Read error message carefully
2. Check recent changes (what worked before?)
3. Validate inputs to failing function
4. Simplify and isolate problem

**Conceptual Errors:**
1. Review assumptions
2. Validate approach with simpler example
3. Check literature/documentation
4. Consult with peers or stakeholders

### 6.3.3. When to Ask for Help

**Ask Immediately If:**
- Blocked for >2 hours without progress
- Data quality issue threatens project viability
- Stakeholder requirement conflicts with technical feasibility
- Ethical concerns emerge
- Deadline at risk

**Try First:**
- Google error message
- Check documentation
- Review similar examples
- Simplify problem

**Who to Ask:**
- Technical peers: Implementation questions
- Stakeholders: Business logic, requirements
- Domain experts: Interpretation, validity
- AI agent: Coding help, methodology questions

### 6.3.4. Debugging Strategies

**Systematic Debugging:**
```python
# 1. Print intermediate values
print(f"DEBUG: df shape before filter: {df.shape}")
filtered_df = df[df['value'] > 0]
print(f"DEBUG: df shape after filter: {filtered_df.shape}")

# 2. Check data types
print(f"DEBUG: column types:\n{df.dtypes}")

# 3. Validate sample
print(f"DEBUG: sample rows:\n{df.head(3)}")

# 4. Check for nulls/infinities
print(f"DEBUG: null counts:\n{df.isnull().sum()}")
print(f"DEBUG: inf counts: {np.isinf(df.select_dtypes(include=[np.number])).sum().sum()}")
```

**Isolation Testing:**
```python
# Test function with simple known input
def calculate_clv(transactions, revenue):
    return transactions * revenue

# Test with known values
test_transactions = 10
test_revenue = 100
result = calculate_clv(test_transactions, test_revenue)
print(f"DEBUG: Expected 1000, got {result}")
```

## 6.4. Checkpoint and Feedback Protocol

### 6.4.1. Milestone Checkpoints

After each significant milestone (sprint day, phase completion, major feature):

1. **Create checkpoint document** using PM Guidelines Template 5
2. **Document outputs** - Files created, code written, decisions made
3. **Record issues encountered** - What didn't work, workarounds used
4. **Note methodology gaps** - Did DSM guidance apply? What was missing?

**Checkpoint Triggers:**
- End of each sprint day
- Phase completion (Exploration, Feature Engineering, Analysis, Communication)
- Major feature implementation
- Before extended breaks (weekend, vacation)

**Intra-Sprint Checkpoints:**
For sprints with multiple phases, create a lightweight checkpoint at each phase
transition. This prevents retroactive documentation when a phase completes and
work moves on before the milestone is recorded. Use PM Guidelines Template 5
(abbreviated: outputs, decisions, next steps) rather than a full checkpoint.
Phase boundary items are listed in PM Guidelines Template 8.

### 6.4.2. Methodology Feedback Collection

Projects using DSM should maintain a **Validation Tracker** to systematically evaluate methodology effectiveness:

| Activity | Frequency | Purpose |
|----------|-----------|---------|
| Log DSM sections used | Per milestone | Track coverage |
| Score section effectiveness | After use | Quantify quality |
| Document gaps/successes | As discovered | Capture details |
| Propose improvements | End of sprint | Actionable feedback |

**Evaluation Criteria:**

| Criterion | Description | Scale |
|-----------|-------------|-------|
| Clarity | Was guidance clear and unambiguous? | 1-5 |
| Applicability | Did it fit project context? | 1-5 |
| Completeness | Was anything missing? | 1-5 |
| Efficiency | Time saved vs. ad-hoc approach? | 1-5 |

### 6.4.3. Feedback Loop

```
Project Uses DSM -> Checkpoints Created -> Feedback Collected ->
                                              |
                         +--------------------+--------------------+
                         |                                         |
              dsm-feedback-backlogs.md              dsm-feedback-methodology.md
              (Concrete improvement proposals)      (What was actually built)
                         |                                         |
              BACKLOG items created                  DSM informed of real-world
              DSM updated                            patterns and techniques
                         |                                         |
                         +--------------------+--------------------+
                                              |
                                Future Projects Benefit
```

This creates continuous methodology improvement through real-world validation.

**Key Insight:** Projects using DSM are the best source of methodology feedback, but only if feedback is captured systematically through both deliverables (Section 6.4.5).

### 6.4.4. Daily Checkpoint Template Addition

Add to each daily checkpoint (PM Guidelines Template 5):

```markdown
## Methodology Notes (Optional)

**DSM Sections Used Today:**
- Section X.Y: [Brief assessment]

**Gaps Identified:**
- [Description of any missing guidance]

**Feedback Logged:**
- [ ] Added to Validation Tracker (if applicable)
```

See **Appendix E.12** for the complete Validation Tracker Template.

### 6.4.5. Project Feedback Deliverables

At project start, create two feedback files in `docs/feedback/`. These files
are maintained throughout execution and finalized at project completion. The
methodology file integrates section-level scoring (previously in the standalone
Validation Tracker, Appendix E.12) directly into the feedback system.

**Required Feedback Files:**

| File | Purpose | When Created |
|------|---------|-------------|
| `docs/feedback/backlogs.md` | Concrete improvement proposals for DSM | Collected during execution, finalized at project end |
| `docs/feedback/methodology.md` | DSM usage log with per-section scores and project record | Updated at sprint boundaries, finalized at project end |

**Blog deliverables** (materials, drafts, publication notes) live in `docs/blog/`,
not in `docs/feedback/`. Blog output is a project deliverable, not DSM methodology
feedback. See Section 2.5.6 for the blog process and DSM_0.1 for file naming.

#### File 1: backlogs.md

Captures specific, actionable improvement proposals that become BACKLOG items
in the DSM repository. These are not limited to the project's domain -- they
include any observation about DSM gaps, unclear guidance, or missing patterns
encountered during the project.

**Template:**

```markdown
# DSM Feedback: Backlog Proposals

**Project:** [Project Name]
**DSM Version Used:** [e.g., v1.3.9]
**Author:** [Name]
**Date:** [YYYY-MM-DD]

---

## High Priority

### [Short Title]
- **DSM Section:** [Section reference or "New"]
- **Problem:** [What was missing or unclear]
- **Proposed Solution:** [Concrete suggestion]
- **Evidence:** [What happened in the project that exposed this gap]

---

## Medium Priority

### [Short Title]
[Same format]

---

## Low Priority

### [Short Title]
[Same format]
```

**Scope:** Any DSM improvement -- not limited to the project's domain (e.g., an
NLP project may identify gaps in environment setup, notebook standards, or
communication templates).

#### File 2: methodology.md

Records DSM section usage with effectiveness scores (integrating the Validation
Tracker from Appendix E.12) and the actual technical pipeline. This serves three
purposes: (1) tracking which DSM sections worked well or poorly during execution,
(2) project documentation for future reference, and (3) informing DSM of
real-world patterns that may not yet exist in the methodology.

**Section scoring (maintained during execution):**

When referencing a DSM section, log it with a score:

| DSM Section | Sprint/Day | Score (1-5) | Notes |
|-------------|------------|-------------|-------|
| Section 2.1 | S1 Setup | 4.5 | Clear checklist, minor gaps |
| Section 2.2 | S1D1-3 | 4.0 | Missing X pattern |

Scoring: 5=Excellent, 4=Good, 3=Adequate, 2=Poor, 1=Not useful.

**Project record (finalized at completion):**

Records the actual pipeline, tools, and decisions.

**Template:**

```markdown
# DSM Feedback: Final Project Methodology

**Project:** [Project Name]
**Author:** [Name]
**Date:** [YYYY-MM-DD]
**Duration:** [Timeline]

---

## 1. Project Overview

| Item | Planned | Actual |
|------|---------|--------|
| **Objective** | [Goal] | [What was delivered] |
| **Dataset** | [Source, size] | [Actual data used] |
| **Timeline** | [Plan] | [Reality] |
| **Deliverables** | [Expected] | [Actual] |

---

## 2. Technical Pipeline (What Was Actually Built)

[Document each phase with: tools used, parameters chosen, results obtained]

---

## 3. Libraries & Tools

| Library | Version | Purpose |
|---------|---------|---------|
| [name] | [ver] | [why used] |

---

## 4. Final Results

[Summary table of outcomes]

---

## 5. Project Structure (Final)

[Directory tree of final project state]

---

## 6. Plan vs Reality

| Aspect | Planned | Actual | Delta |
|--------|---------|--------|-------|
| [item] | [plan] | [reality] | [difference and why] |

---

## 7. Methodology Observations for DSM

[Patterns, techniques, or approaches used that DSM could learn from]
```

**Key distinction:** This file is informational with improvement potential.
Unlike the backlogs file (which contains direct action items), the methodology
file documents what worked in practice. DSM maintainers review these to identify
patterns worth incorporating -- especially techniques, libraries, or workflows
not yet covered in DSM.

#### Relationship Between Feedback Files

```
During Execution          At Sprint Boundaries    In DSM Repository
-----------------         --------------------    -----------------
DSM section used     -->  methodology.md     -->  Scores inform DSM
  (log with score)          (scores + record)       section improvements
Gap/issue found      -->  backlogs.md        -->  BACKLOG items created
                           (proposals)
```

Both files live in `docs/feedback/` and are updated at sprint boundaries
(per the Sprint Boundary Checklist in PM Guidelines Template 8).

The backlogs file generates immediate action. The methodology file (with
integrated section scoring) tracks DSM effectiveness and builds a knowledge base.

Blog materials and drafts are tracked separately in `docs/blog/` as project
deliverables (see Section 2.5.6).

**Note:** The standalone Validation Tracker (Appendix E.12) has been integrated
into `methodology.md`. Projects no longer need a separate tracker file.

#### Feedback Handover to DSM

At project completion, hand off feedback files to a DSM Central session for
integration. Use the standardized handover prompt in DSM_3 Section 6.1 to
trigger the review process.

**Handover sequence:**
1. Verify feedback files are complete (methodology scored, backlogs structured)
2. Open a DSM Central session
3. Use the handover prompt template with project-specific stats
4. DSM triages proposals: accept (create BACKLOG-XXX), reject, or defer
5. Methodology scores below 3 are assessed for DSM improvements

Cross-reference: DSM_3 Section 6 (Feedback Handover), `/dsm-review-feedback`
command

### 6.4.6. Documentation Audit

Before marking a project as finalized, verify documentation completeness. This
step catches gaps that incremental documentation misses.

**Audit Checklist:**

| Document | Check |
|----------|-------|
| Notebook | All cells run in order, outputs present, markdown explanations complete |
| README | Project description, setup instructions, results summary, references |
| Checkpoints | One per day/phase, no gaps in coverage |
| DSM feedback files | Entries for all days, final closure section present |
| Blog post (if applicable) | Drafted, reviewed, citations verified |
| Outputs | All figures saved, model artifacts documented |
| Plan vs Reality | Documented in methodology feedback |

**When to Audit:**
- At project closure (after final presentation or delivery)
- Before publishing any deliverable externally (blog, report)
- Before archiving the project

**Audit Process:**
1. List all expected deliverables from the project plan
2. Check each deliverable exists and is complete
3. Identify gaps and fill them
4. Record audit completion in the final checkpoint

Cross-reference: Section 6.4.5 (Project Feedback Deliverables), Section 2.5.8
(Blog Post as Standard Deliverable)

## 6.5. Gateway Review Protocol

### 6.5.1. Purpose

Gateway reviews provide bidirectional feedback between the central DSM methodology
and consuming projects. While Section 6.4 covers project-to-DSM feedback (bottom-up),
gateway reviews add methodology-to-project guidance (top-down): reviewing project
state against DSM standards and providing alignment recommendations.

**Architecture:** Hub-and-Spoke model where DSM is the hub (methodology authority)
and projects are spokes. Gateway reviews are the connections.

See `docs/research/2026-02-01_multi-agent-governance-research.md` for the full research
grounding (multi-agent coordination, organizational learning theory, stage-gate
processes).

### 6.5.2. Three Gateway Levels

**Hub Kickoff Gate (pre-Gateway 1):**
If the project was initiated by DSM Central (hub-to-spoke), verify that the hub
completed the scaffolding checklist (DSM_3 Section 6.2.2) before proceeding to
Gateway 1. This pre-check ensures the spoke inherits correct structure, reducing
Gateway 1 failures from missing scaffolding.

**Gateway 1: Project Setup Complete** (before any code/analysis)

| Check | Criterion |
|-------|-----------|
| CLAUDE.md | Created with `@` reference to DSM_0.2_Custom_Instructions_v1.1.md |
| Project type | Identified (Notebook/Application/Hybrid) |
| Directory structure | Follows DSM pattern for project type (see DSM_0 Section 3) |
| Environment | Virtual environment with dependencies documented |
| Feedback files | Two files initialized in `docs/feedback/` (backlogs.md, methodology.md) |
| Decision log | Initialized |
| Sprint plan | Created (with Phase 0.5 research if applicable) |

**Gateway 2: Sprint/Phase Boundary**

| Check | Criterion |
|-------|-----------|
| Deliverables | Phase deliverables meet Definition of Done |
| Decision log | Updated with sprint decisions |
| Feedback files | Updated with observations and section scores |
| Checkpoint | Document created in `docs/checkpoints/` |
| Deviations | No methodology deviations without documented rationale |
| Tests | Passing (DSM 4.0 projects) |
| Blog | Journal entry written for sprint |

**Gateway 3: Project Delivery**

| Check | Criterion |
|-------|-----------|
| Prior gateways | All previous gateways passed |
| Feedback files | Finalized (backlogs, methodology with scores) |
| Communication | Blog/communication deliverable complete |
| Cross-project | Observations documented with cross-project relevance noted |
| BACKLOG items | Generated for DSM improvements |
| After Action Review | Completed (what was planned vs actual, lessons learned) |

### 6.5.3. Gateway Review Process

1. **Project reaches milestone** and triggers review (self-triggered at boundary)
2. **Review against checklist** for the appropriate gateway level
3. **Produce alignment report** with:
   - Items met (confirmed)
   - Items missing or incomplete (recommendations)
   - Cross-project observations (relevant learning from other projects, if available)
   - Deviations noted (with or without documented rationale)
4. **Project addresses feedback** or documents rationale for deviation
5. **Gateway passed** when critical items met (non-critical items tracked)

**Key principle:** Gateways produce recommendations, not blockers. Projects retain
autonomy within guardrails. The governance model is facilitative rather than
directive.

### 6.5.4. Cross-Project Learning

When multiple projects use DSM concurrently, gateway reviews enable knowledge
transfer:

1. **Observation tagging:** Projects tag feedback items with "Cross-Project
   Relevance: Yes/No" to flag observations that may benefit other projects
2. **Aggregation:** At sprint boundaries, aggregate tagged observations across
   projects to identify patterns
3. **Distribution:** Include relevant cross-project observations in gateway
   alignment reports for other projects

### 6.5.5. Anti-Patterns to Avoid

| Anti-Pattern | Risk | Mitigation |
|-------------|------|------------|
| Compliance Theater | Gates become checkbox exercises | Focus on "does this help?" not "is this complete?" |
| Central Bottleneck | Projects blocked waiting for review | Asynchronous reviews; automate what possible |
| Over-Governance | Excessive controls slow projects | "Pull" not "push"; projects opt in to guidance |
| Stale Standards | Methodology falls behind practice | Fast feedback loops; projects can deviate with rationale |
| Lost Learning | Observations captured but never acted on | Schedule aggregation cycles at sprint boundaries |

Cross-reference: Section 6.4.5 (Project Feedback Deliverables), PM Guidelines
Template 8 (Sprint Plan with Cadence Guidance)

### 6.5.6. DSM as Central Project Hub

DSM Central serves a dual role in the ecosystem:

**Role 1: Methodology Framework** - How to execute data science and software projects (Sections 2-5, DSM 4.0).

**Role 2: Project Planning Hub** - Where new projects are defined, planned, and tracked to ensure DSM alignment from inception.

**How it works:**
1. New project ideas are captured as backlog items in `plan/backlog/developments/`
2. The backlog item defines scope, architecture, and DSM alignment
3. A dedicated repository is created with `.claude/CLAUDE.md` referencing DSM Central
4. The project follows DSM methodology, contributing feedback via Gateway Reviews

**Backlog classification** (see PM Guidelines, Project Change Tracking):
- `developments/` - External project definitions (repositories that follow DSM)
- `improvements/` - Internal DSM enhancements (new sections, templates, standards)

**Hub-and-Spoke Ecosystem:**

```
                    +---------------------------+
                    |     DSM Central (Hub)     |
                    |  Methodology + Project Hub|
                    +-----------+---------------+
                                |
            +-------------------+-------------------+
            |                   |                   |
    +-------v-------+   +-------v-------+   +-------v-------+
    | Development   |   | Development   |   | Development   |
    | Projects      |   | Projects      |   | Projects      |
    | (DSM 4.0)     |   | (DSM 1.0)     |   | (Hybrid)      |
    +-------+-------+   +-------+-------+   +-------+-------+
            |                   |                   |
            +-------------------+-------------------+
                                |
                    +-----------v-----------+
                    |  Feedback to DSM      |
                    |  Gateway Review (6.5) |
                    +-----------------------+
```

---

# 7. Progressive Execution with the Agent

## 7.1. Cell-by-Cell Development

### 7.1.1. Progressive Pattern

**Recommended Workflow:**
1. Write one cell (or one section)
2. Execute and validate output
3. Use output to inform next cell
4. Iterate based on results

**Why This Works:**
- Catches errors immediately
- Validates assumptions step-by-step
- Allows data-driven decisions
- Builds confidence in approach
- Easier debugging (small increments)

**Example Progression:**
```python
# Cell 1: Load data
df = pd.read_csv('data.csv')
print(f"Loaded {df.shape[0]:,} rows, {df.shape[1]} columns")
print(df.head())
# â†’ Validate: Is shape expected? Are columns correct?

# Cell 2: Check for duplicates (informed by Cell 1 output)
duplicates = df.duplicated().sum()
print(f"Duplicates: {duplicates:,}")
# â†’ Decide: Do we need to remove duplicates?

# Cell 3: Handle duplicates (decision based on Cell 2)
if duplicates > 0:
    df = df.drop_duplicates()
    print(f"OK: Removed {duplicates:,} duplicates")
# â†’ Validate: Confirm duplicates removed
```

### 7.1.2. Output Validation

**Every Cell Should Answer:**
- Did it work? (No errors)
- Is output expected? (Shape, values make sense)
- What do I learn? (Insights inform next step)
- What to do next? (Clear next action)

**Validation Questions:**
```python
# After data loading
print(f"Rows: {df.shape[0]:,}, Columns: {df.shape[1]}")
# â†’ Expected row count? Expected columns present?

# After filtering
print(f"Before: {len(df_before):,}, After: {len(df_after):,}")
# â†’ Reasonable filter rate? Too many removed?

# After aggregation
print(f"Unique customers: {df['customer_id'].nunique():,}")
# â†’ Matches expected cohort size?
```

### 7.1.3. Feedback Loop Best Practices

**Effective Feedback to Agent:**
- "Output shows 5,765 customers. Expected ~6,000. Let's investigate why 235 are missing."
- "This doesn't look right."

- "Correlation between X and Y is 0.95, which seems too high. Let's check if there's a calculation error."
- "Something is wrong."

- "K=3 shows silhouette score 0.38. Let's also test K=4 and K=5 to compare."
- "Try more values."

**Agent Responds Better When You:**
- Share specific observations from outputs
- State what you expected vs. what you got
- Ask targeted questions
- Provide context on business meaning
- Reference previous work in session

---

## 7.2. Validation Patterns

### 7.2.1. Immediate Validation

**After Every Transformation:**
```python
# Before transformation
print(f"Before: shape {df.shape}, nulls {df.isnull().sum().sum()}")

# Transform
df_transformed = transform_function(df)

# After transformation - validate
print(f"After: shape {df_transformed.shape}, nulls {df_transformed.isnull().sum().sum()}")
assert df_transformed.shape[0] == df.shape[0], "Row count changed unexpectedly"
```

**Sanity Checks:**
```python
# Check ranges
assert df['age'].min() >= 0, "Negative age found"
assert df['age'].max() <= 120, "Unrealistic age found"

# Check completeness
assert df['customer_id'].isnull().sum() == 0, "Missing customer IDs"

# Check business logic
assert (df['revenue'] >= 0).all(), "Negative revenue found"
```

### 7.2.2. Checkpoint Creation

**After Major Steps:**
```python
# Checkpoint: Save progress
df.to_csv('../data/processed/customers_cleaned_v1.0.csv', index=False)
print(f"OK: Checkpoint saved - {df.shape[0]:,} customers")
```

**Benefits:**
- Can restart from checkpoint if needed
- Version control of intermediate data
- Easier debugging (revert to known good state)
- Share intermediate data with stakeholders

### 7.2.3. Rollback Strategies

**When Things Go Wrong:**
```python
# Keep copy before risky operation
df_backup = df.copy()

# Try operation
try:
    df = risky_transformation(df)
except Exception as e:
    print(f"ERROR: Transformation failed: {e}")
    df = df_backup  # Rollback
    print("Rolled back to previous state")
```

**Notebook Rollback:**
- Save intermediate CSV files
- Use Git for notebook versions
- Keep "last known good" notebook copy
- Document what state each file represents

---

## 7.3. Collaboration Best Practices

### 7.3.1. Clear Communication

**Effective Prompts to Agent:**
- "Create a scatter plot of CLV vs. trip_frequency, colored by cluster, with axis labels and title."
- "Make a chart."

- "Calculate cancellation propensity as: (total_cancelled_bookings / total_bookings). Handle zero bookings with 0."
- "Calculate cancellation propensity."

- "Load users.csv, filter for users with last_booking_date >= '2023-01-01', print resulting count."
- "Load and filter users."

**Context Sharing:**
- Explain business context when relevant
- Reference previous work ("As we calculated in Cell 5...")
- Note assumptions ("Assuming no booking means no cancellation risk...")
- State preferences ("I prefer histograms over box plots for this...")

### 7.3.2. Context Maintenance

**Help Agent Remember:**
- Reference earlier findings: "We found 3 clusters earlier..."
- Cite decision log: "As per DEC-003, we're using K=3..."
- Mention file locations: "We saved features in ../data/features/..."
- Note column names: "The cluster column is called 'segment_id'..."

**Update Agent on Changes:**
- "I manually edited the CSV to fix encoding issues."
- "Stakeholder changed requirement: now need 4 segments instead of 3."
- "We're pivoting from classification to clustering approach."

### 7.3.3. Iterative Refinement

**Progressive Improvement:**
```
Iteration 1: "Create basic histogram of customer lifetime value"
â†’ Review output â†’

Iteration 2: "Add bin edges at [0, 1000, 5000, 10000, 50000] and format y-axis with commas"
â†’ Review output â†’

Iteration 3: "Add vertical lines for cluster mean CLV values, with legend"
â†’ Final output
```

**Benefits of Iteration:**
- Start simple, add complexity
- Validate each addition
- Easier to identify issues
- More control over final result

**When to Iterate:**
- Initial output close but needs refinement
- Complex visualization or calculation
- Uncertain about best approach
- Learning new technique

---

# 8. Version History & Closing

## 8.1. Version History

**v1.1.1 (November 2025):**
- File consolidation for better maintainability
- Getting started files consolidated: 3→1 (`0_START_HERE_Complete_Guide.md`)
- Appendices consolidated: 5→1 (`1.0_Methodology_Appendices.md`)
- Repository files reduced from 20 to 13 (-35%)
- All cross-references and content preserved
- Section numbering unchanged for backward compatibility

**v1.1 (November 2025):**
- Reorganized with 4-level hierarchical numbering (# ## ### ####)
- Split into main document (~1,400 lines) + 5 appendices (~800 lines)
- Enhanced navigation without Table of Contents
- Added comprehensive cross-referencing system
- Improved section findability and maintainability
- All v1.0 content preserved, better organized

**Content Structure Changes:**
- Main doc: Core workflow, essential practices, advanced practices overview
- Appendix A: Environment setup details
- Appendix B: Phase deep dives with examples
- Appendix C: Advanced practices detailed implementation
- Appendix D: Domain-specific adaptations
- Appendix E: Quick reference tables

**v1.0 (November 2025):**
- Initial academic edition release
- Based on TravelTide Customer Segmentation project experience
- Integrated 4-phase workflow (Phases 0-4)
- Essential Tier 1 practices (decision log, pivot criteria, stakeholder communication)
- Advanced practices (Tiers 2-4) for selective use
- Comprehensive stakeholder communication framework
- Progressive execution patterns with the agent

---

## 8.2. Using This Methodology

### 8.2.1. Getting Started

**For New Projects:**
1. Read Section 1 (Introduction) to understand when this methodology applies
2. Review Section 2 (Core Workflow) to understand the 4-phase process
3. Check Section 3 (Working Standards) for notebook and code standards
4. Execute Phase 0 (Section 2.1) to set up your environment
5. Begin Phase 1 (Section 2.2) with exploratory data analysis

**For Experienced Users:**
- Reference Section 4 for decision log, pivots, stakeholder communication
- Consult Section 5 when project complexity increases
- Use Section 6 for quality assurance and session management
- Refer to Section 7 for effective agent collaboration patterns

**When Stuck:**
- Check Section 6.3 (Troubleshooting) for common issues
- Review Appendix B for detailed phase guidance
- Consult Appendix C for advanced practice implementations
- Reference decision log examples (Section 4.1.4)

### 8.2.2. Customization Guidelines

**Adapt This Methodology:**
- Phase names and lengths (adjust to your domain)
- Advanced practices selection (activate as needed)
- Stakeholder communication frequency (match your project)
- File naming conventions (if organizational standards differ)

**Don't Change:**
- Core principle of documentation (decision logs, feature dictionaries)
- Progressive execution pattern (cell-by-cell validation)
- Data-driven decision making (let data guide pivots)
- Quality standards (reproducibility, clear outputs)

### 8.2.3. Domain Adaptations

**For domain-specific guidance:**
- Time Series: See Appendix D.1
- NLP: See Appendix D.2
- Computer Vision: See Appendix D.3
- Clustering: See Appendix D.4
- Regression/Classification: See Appendix D.5

**Common Adaptations:**
- Different feature engineering for different domains
- Domain-specific validation metrics
- Specialized visualization requirements
- Domain literature and best practices

---

## 8.3. Extensibility

**This Methodology Supports:**
- Addition of domain-specific practices
- Integration with organizational standards
- Extension to production environments
- Scaling to team collaboration

**Future Enhancement Areas:**
- Automated testing frameworks
- CI/CD pipeline integration
- Model monitoring and maintenance
- MLOps tooling integration
- Advanced deployment patterns

**Contributing:**
This methodology is open for feedback and contributions. Suggested additions or improvements welcome through project repository.

---

## 8.4. Appendix References

**Complete methodology system includes:**
- **This document:** Core methodology (~3,400 lines)
- **Appendices (consolidated):** `1.0_Methodology_Appendices.md` (~4,010 lines)
  - Appendix A: Environment Setup Details
  - Appendix B: Phase Deep Dives
  - Appendix C: Advanced Practices Detailed
  - Appendix D: Domain Adaptations
  - Appendix E: Quick Reference + File Naming Standards

**Related Documents:**
- `0_START_HERE_Complete_Guide.md`: Complete getting started guide
- `2_0_ProjectManagement_Guidelines_v2_v1.1.md`: Project planning framework
- `3_Methodology_Implementation_Guide_v1.1.md`: Step-by-step implementation

---

## 8.5. Future Enhancements

**Planned Additions:**
- Case study examples from multiple domains
- Video walkthroughs of methodology application
- Template notebooks for each phase
- Automated project setup scripts
- Integration with popular ML platforms
- Domain-specific deep dives

**Community Feedback:**
- Submit issues and suggestions via repository
- Share your project experiences
- Contribute domain adaptations
- Propose methodology improvements

---

**End of Main Methodology Document**

**Version:** 1.3.0 (Academic Edition)
**Last Updated:** January 2026
**Next Review:** Quarterly updates based on project learnings

**For complete details on advanced topics, see appendices A-E.**

