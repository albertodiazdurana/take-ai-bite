# DSM 1.0 Module A: Core Workflow (The 4-Phase Process)

**Parent document:** `DSM_1.0_Data_Science_Collaboration_Methodology_v1.1.md`
**Module scope:** Section 2 (Phases 0-4)

---

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

**After base setup completes**, install domain-specific packages as needed for the project. Activate the base environment, install the required packages, and generate a project requirements file (`pip freeze > requirements_project.txt`).

Document all project-specific imports in the first notebook cell with version verification.

For domain-specific package lists, setup steps, and troubleshooting, see **Appendix A.3: Domain-Specific Packages**.

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

**Key Activities:** Check data quality (shape, duplicates, missing values), define analytical cohort with documented inclusion/exclusion criteria, analyze distributions and correlations.

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
- **Example:** Don't just filter `df[df['transactions'] > 0]` – explain why zero-transaction users are excluded

**Pitfall 2: Ignoring Missing Data Patterns**
- **Problem:** Proceeding without understanding why data is missing
- **Solution:** Investigate missing data mechanisms (MCAR, MAR, MNAR)
- **Example:** Missing cancellation data for no-booking users may have specific meaning (absence of activity, not data error)

**Pitfall 3: Over-committing to Initial Hypotheses**
- **Problem:** Forcing data to support predetermined conclusions
- **Solution:** Let data drive insights; pivot if necessary (See Section 4.2)
- **Example:** Statistical evidence may indicate fewer segments than stakeholders expected

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
- Ensure feature validity and avoid data leakage
- Document feature definitions for reproducibility

**Key Questions to Answer:**
- What features capture the relevant aspects of the data?
- Which transformations and aggregations make domain sense?
- Which temporal or structural patterns matter?
- Are features calculated correctly without leakage?

### 2.3.2. Key Activities

**Core Feature Generation:**
- Aggregate raw data to the analytical grain (e.g., entity-level summaries)
- Calculate domain-relevant metrics (frequency, recency, intensity, ratios)
- Generate temporal features (time since first/last event, intervals)
- Create interaction or derived features as needed

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
- **Example:** Don't calculate a rate metric using all records; use only records available at prediction time

**Pitfall 2: Poorly Documented Features**
- **Problem:** Features with unclear definitions or logic
- **Solution:** Maintain comprehensive feature dictionary
- **Example:** Not just "score_v2" but "7-day rolling average of daily interactions"

**Pitfall 3: Over-Engineering**
- **Problem:** Creating hundreds of features without validation
- **Solution:** Start with core features, expand only if needed
- **Example:** A well-scoped project may need 50-100 features, not 500

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

**Context:** Engineered features (lags, rolling windows, aggregations) naturally create NaN values at boundaries where insufficient history exists.

**Decision Framework:**

| Option | When to Use | Key Risk |
|--------|------------|----------|
| **Keep NaN** | Tree-based models that handle NaN natively | Linear models and some neural networks cannot handle NaN |
| **Fill with group mean** | Models requiring complete data, small NaN percentage (<5%) | Leakage risk if mean includes test data |
| **Fill with constant (0, median)** | Groups too small for reliable mean, conservative approach | Ignores group structure, may introduce bias |
| **Drop rows** | Rarely, only if NaN is very small (<1%) and random | Data loss, especially problematic for systematic NaN (lag features) |

**Default Strategy:**
1. Keep NaN if using tree models (they learn from missingness)
2. If model requires complete data, fill with group mean (computed on training data only)
3. Document NaN percentage per feature in the feature dictionary
4. Validate during Analysis phase (feature importance confirms utility)

**Always Document:**
- Which features have NaN and why (boundary effects, data gaps, merge mismatches)
- NaN percentage per feature
- Chosen strategy and rationale (use the Decision Log template from Section 4.1)
- Which models can/cannot handle the chosen strategy

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

#### Domain-Specific Leakage Considerations

Every domain has specific leakage risks. Common patterns:
- **Text data:** Fit vectorizers and embedding aggregations on training corpus only
- **Temporal data:** Respect temporal order; ensure rolling windows do not cross train/test boundaries
- **Tabular data:** Compute target encoding, frequency encoding, and group-level aggregations from training data only

#### Recommended Pattern: Pipelines

Use your framework's pipeline mechanism (e.g., scikit-learn `Pipeline`) to chain preprocessing and modeling steps. Pipelines enforce that each step's `.fit()` is called only on training data during `pipeline.fit()`, and only `.transform()` is called during prediction.

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

**Key Activities:** Select appropriate technique, define success metrics aligned with business goals, establish baseline performance, compare multiple approaches, and interpret results in domain context.

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
- **Example:** A high validation score doesn't mean results are useful to stakeholders

**Pitfall 2: Ignoring Model Assumptions**
- **Problem:** Applying techniques without checking prerequisites
- **Solution:** Validate assumptions (normality, independence, etc.)
- **Example:** Many techniques have implicit assumptions (e.g., normality, independence); check if appropriate

**Pitfall 3: Insufficient Validation**
- **Problem:** Trusting single metric or single run
- **Solution:** Use multiple validation approaches and robustness checks
- **Example:** Use multiple validation metrics AND business review, not just one score

**Pitfall 4: Poor Results Interpretation**
- **Problem:** Reporting statistics without business meaning
- **Solution:** Translate every finding to stakeholder language
- **Example:** Not "Group 2 has high PC1" but "Group 2 represents high-value frequent users"

**Pitfall 5: Not Planning for Pivots**
- **Problem:** Forcing predetermined approach despite data insights
- **Solution:** Be ready to pivot based on analysis (Section 4.2)
- **Example:** Pivoting from an initial approach to a simpler one based on statistical evidence

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

**Domain-Specific Considerations:** Each problem type has characteristic error patterns (e.g., boundary cases in classification, extreme value errors in regression, ambiguous assignments in clustering). Identify the error categories relevant to your domain and technique.

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
- `ProjectName_Presentation.pptx`
- `ProjectName_Executive_Summary.pdf`
- `ProjectName_Technical_Report.pdf`
- `ProjectName_QA_Document.md`

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
- **Solution:** Layer detail – executive summary, methodology, appendix
- **Example:** Don't explain the algorithm to business leadership; explain what the results mean

**Pitfall 2: Vague Recommendations**
- **Problem:** "Consider improving customer engagement"
- **Solution:** Specific, actionable recommendations
- **Example:** "Offer incentive X to Segment 3 (value-conscious users) to increase conversion"

**Pitfall 3: Unprepared for Questions**
- **Problem:** Unable to answer stakeholder concerns
- **Solution:** Develop comprehensive Q&A document (20-30 questions)
- **Example:** Prepare 20-30 anticipated questions before any stakeholder presentation

**Pitfall 4: No Clear Narrative**
- **Problem:** Presenting results without story
- **Solution:** Build narrative arc: problem → approach → findings → recommendations
- **Example:** "We identified 3 distinct segments, each requiring a different approach..."

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

**Step 7: Tracking** -- After publication, update `dsm-docs/blog/README.md` with the
publication date and platform status. Move all related files for the published post
to `dsm-docs/blog/done/`. See DSM_0.1 Blog Artifacts for the tracker table format and
the done/ convention.

**File Naming:** All blog artifacts use `YYYY-MM-DD_{type}-{scope}.md` and live
in `dsm-docs/blog/`. Types: `blog-materials-` (materials), `blog-` (draft),
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
