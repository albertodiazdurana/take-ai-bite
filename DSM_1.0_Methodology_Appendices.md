# Methodology Appendices - Complete Reference

**Part of:** Data Science Collaboration Methodology v1.3.0
**Main Document:** `1.0_Data_Science_Collaboration_Methodology_v1.1.md`
**Purpose:** Consolidated detailed guidance for all methodology aspects

**Version:** 1.3.0 (Consolidated)
**Last Updated:** 2026-01-22

---

## Appendices Overview

This document consolidates all five appendices for the Data Science Collaboration Methodology:

- **Appendix A:** Environment Setup Details (Package specifications, troubleshooting)
- **Appendix B:** Phase Deep Dives (Detailed guidance with examples)
- **Appendix C:** Advanced Practices Detailed (Implementation guides)
- **Appendix D:** Domain Adaptations (Time series, NLP, CV, clustering)
- **Appendix E:** Quick Reference (Checklists, templates, commands)

**Cross-references to main methodology:** Use "Section X.Y" format (e.g., "See Section 2.2")

---

# Appendix A: Environment Setup Details

**Part of:** Data Science Collaboration Methodology v1.1  
**Main Document:** `1.0_Data_Science_Collaboration_Methodology.md` â†’ Section 2.1  
**Purpose:** Detailed environment setup guidance, package rationale, and troubleshooting

---

## A.1. Base Environment (Minimal)

### A.1.1. Package List and Rationale

**Core Data Science Stack (5 packages):**

**jupyter (latest)**
- **Purpose:** Notebook interface for interactive analysis
- **Why Essential:** Primary development environment for data science
- **Components:** JupyterLab, Jupyter Notebook, IPython
- **Size:** ~10 MB

**ipykernel (latest)**
- **Purpose:** Jupyter kernel for Python
- **Why Essential:** Enables notebook execution with Python
- **Use:** Registers Python environment as Jupyter kernel
- **Size:** ~2 MB

**pandas (>=2.0.0)**
- **Purpose:** Data manipulation and analysis
- **Why Essential:** Core tool for tabular data operations
- **Key Features:** DataFrame operations, groupby, merging, time series
- **Size:** ~30 MB

**numpy (>=1.24.0)**
- **Purpose:** Numerical computing foundation
- **Why Essential:** Underlies pandas, enables efficient array operations
- **Key Features:** N-dimensional arrays, mathematical functions
- **Size:** ~20 MB

**matplotlib (>=3.7.0)**
- **Purpose:** Data visualization library
- **Why Essential:** Foundation for plotting in Python
- **Key Features:** Static plots, customizable visualizations
- **Size:** ~15 MB

**seaborn (>=0.12.0)**
- **Purpose:** Statistical data visualization
- **Why Essential:** High-level interface for attractive plots
- **Built on:** matplotlib
- **Key Features:** Distribution plots, categorical plots, heatmaps
- **Size:** ~5 MB

**Total Minimal Setup:** ~82 MB

### A.1.2. Installation Steps

**Step 1: Create Virtual Environment**
```bash
# From project root directory
python -m venv .venv

# Verify creation
# Windows
dir .venv

# Mac/Linux
ls -la .venv
```

**Step 2: Activate Virtual Environment**
```bash
# Windows
.venv\Scripts\activate

# Mac/Linux
source .venv/bin/activate

# Verify activation (prompt should show (.venv))
```

**Step 3: Upgrade pip**
```bash
python -m pip install --upgrade pip

# Verify pip version
pip --version
# Should show pip 23.x or higher
```

**Step 4: Install Base Packages**
```bash
pip install jupyter ipykernel pandas numpy matplotlib seaborn

# Or from requirements file
pip install -r requirements_base.txt
```

**Expected Output:**
```
Collecting jupyter
  Downloading jupyter-1.0.0-py2.py3-none-any.whl
Collecting ipykernel
  Downloading ipykernel-6.25.0-py3-none-any.whl
...
Successfully installed jupyter-1.0.0 ipykernel-6.25.0 pandas-2.0.3 numpy-1.24.3 matplotlib-3.7.2 seaborn-0.12.2
```

**Step 5: Register Jupyter Kernel**
```bash
python -m ipykernel install --user --name=project_base_kernel --display-name="Python (project_base)"

# Verify kernel registration
jupyter kernelspec list
```

**Expected Output:**
```
Available kernels:
  project_base_kernel    C:\Users\...\jupyter\kernels\project_base_kernel
  python3                /usr/share/jupyter/kernels/python3
```

### A.1.3. Verification Procedures

**Test 1: Kernel Registration**
```bash
jupyter kernelspec list | grep project_base_kernel
# Should return kernel path
```

**Test 2: Package Imports**
```python
# Create test notebook or Python script
import sys
print(f"Python: {sys.version}")
print(f"Executable: {sys.executable}")

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

print(f"pandas: {pd.__version__}")
print(f"numpy: {np.__version__}")
print(f"matplotlib: {plt.matplotlib.__version__}")
print(f"seaborn: {sns.__version__}")

print("OK: All packages imported successfully")
```

**Expected Output:**
```
Python: 3.10.x
Executable: /path/to/project/.venv/bin/python
pandas: 2.0.3
numpy: 1.24.3
matplotlib: 3.7.2
seaborn: 0.12.2
OK: All packages imported successfully
```

**Test 3: Basic Operations**
```python
# Test DataFrame creation
df = pd.DataFrame({'A': [1, 2, 3], 'B': [4, 5, 6]})
print(df)

# Test plotting
plt.plot([1, 2, 3], [1, 4, 9])
plt.title("Test Plot")
plt.show()

print("OK: Basic operations functional")
```

---

## A.2. Base Environment (Full with Code Quality)

### A.2.1. Additional Packages

**Code Quality Tools (4 additional packages):**

**black (latest)**
- **Purpose:** Code formatter
- **Why Useful:** Automatic PEP 8 compliance
- **When to Use:** Team projects, production code
- **When to Skip:** Academic work (can be annoying)
- **Size:** ~5 MB

**flake8 (latest)**
- **Purpose:** Linting (style checking)
- **Why Useful:** Catches style issues and potential bugs
- **When to Use:** Code reviews, team standards
- **When to Skip:** Exploratory analysis
- **Size:** ~2 MB

**isort (latest)**
- **Purpose:** Import statement sorting
- **Why Useful:** Consistent import organization
- **When to Use:** Team projects with standards
- **When to Skip:** Individual projects
- **Size:** ~1 MB

**autopep8 (latest)**
- **Purpose:** Automatic PEP 8 fixes
- **Why Useful:** Quick style corrections
- **When to Use:** Cleaning up code before sharing
- **When to Skip:** Early exploration
- **Size:** ~2 MB

**Total Full Setup:** ~92 MB

### A.2.2. When to Use Full Setup

**Use Full Setup If:**
- Working in team environment
- Code will be reviewed by others
- Production deployment planned
- Organizational standards require it
- Learning professional practices

**Skip Full Setup If:**
- Individual academic project
- Exploratory analysis only
- No code review expected
- Prefer flexibility over standards
- Find linting distracting

### A.2.3. Configuration Details

**VS Code settings.json:**
```json
{
  "python.defaultInterpreterPath": "./.venv/Scripts/python.exe",
  "jupyter.jupyterServerType": "local",
  "python.formatting.provider": "black",
  "python.linting.flake8Enabled": true,
  "python.linting.enabled": true,
  "editor.formatOnSave": true,
  "python.sortImports.args": [
    "--profile",
    "black"
  ]
}
```

**Optional: .flake8 Configuration**
```ini
[flake8]
max-line-length = 100
exclude = .venv,__pycache__
ignore = E203, W503
```

---

## A.3. Domain-Specific Extensions

### A.3.1. Time Series Packages

**statsmodels (>=0.14.0)**
- **Purpose:** Statistical models (ARIMA, VAR, etc.)
- **Use Cases:** Time series forecasting, econometric models
- **Size:** ~20 MB

**prophet (>=1.1)**
- **Purpose:** Facebook's forecasting library
- **Use Cases:** Business time series with seasonality
- **Size:** ~15 MB

**Installation:**
```bash
pip install statsmodels prophet
```

**Verification:**
```python
import statsmodels.api as sm
from prophet import Prophet
print("OK: Time series packages installed")
```

### A.3.2. NLP Packages

**nltk (>=3.8)**
- **Purpose:** Natural Language Toolkit
- **Use Cases:** Tokenization, stemming, POS tagging
- **Size:** ~10 MB (+ data downloads)

**spacy (>=3.6)**
- **Purpose:** Industrial-strength NLP
- **Use Cases:** Named entity recognition, dependency parsing
- **Size:** ~20 MB (+ model downloads)

**scikit-learn (>=1.3.0)**
- **Purpose:** ML library (includes TF-IDF, clustering)
- **Use Cases:** Text classification, vectorization
- **Size:** ~30 MB

**Installation:**
```bash
pip install nltk spacy scikit-learn
python -m spacy download en_core_web_sm  # Small English model
```

**Verification:**
```python
import nltk
import spacy
from sklearn.feature_extraction.text import TfidfVectorizer
print("OK: NLP packages installed")
```

### A.3.3. Deep Learning Packages

**tensorflow (>=2.13.0) OR pytorch (>=2.0.0)**
- **Purpose:** Deep learning frameworks
- **Use Cases:** Neural networks, complex ML models
- **Size:** ~400 MB (large!)

**Installation (TensorFlow):**
```bash
pip install tensorflow
```

**Installation (PyTorch):**
```bash
# CPU version
pip install torch torchvision torchaudio

# GPU version (CUDA 11.8)
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
```

**WARNING:** Deep learning packages are large. Only install if needed for project.

### A.3.4. Computer Vision Packages

**opencv-python (>=4.8.0)**
- **Purpose:** Computer vision library
- **Use Cases:** Image processing, transformation
- **Size:** ~30 MB

**Pillow (>=10.0.0)**
- **Purpose:** Python Imaging Library
- **Use Cases:** Image loading, basic processing
- **Size:** ~5 MB

**Installation:**
```bash
pip install opencv-python Pillow
```

**Verification:**
```python
import cv2
from PIL import Image
print("OK: Computer vision packages installed")
```

### A.3.5. Extension Script Generation

**Create Domain-Specific Requirements:**
```bash
# After installing domain packages
pip freeze > requirements_domain.txt

# Or create manually
cat > requirements_timeseries.txt << EOF
statsmodels>=0.14.0
prophet>=1.1
EOF
```

**Install Domain Requirements:**
```bash
# Base + domain
pip install -r requirements_base.txt
pip install -r requirements_timeseries.txt
```

---

## A.4. Troubleshooting Environment Issues

### A.4.1. Common Installation Errors

**Error: "pip is not recognized"**
- **Cause:** Python not in PATH or pip not installed
- **Solution:** Reinstall Python with "Add to PATH" option
- **Verification:** `python --version` and `pip --version`

**Error: "No module named 'pip'"**
- **Cause:** pip not installed in environment
- **Solution:** `python -m ensurepip --upgrade`

**Error: "Could not find a version that satisfies the requirement"**
- **Cause:** Package name misspelled or not available for Python version
- **Solution:** Check package name, verify Python version compatibility
- **Example:** Some packages require Python 3.8+

**Error: "Microsoft Visual C++ 14.0 or greater is required"**
- **Cause:** Missing C++ build tools (Windows)
- **Solution:** Install Microsoft C++ Build Tools
- **Alternative:** Use pre-compiled wheels

**Error: Long path issues (Windows)**
- **Cause:** Windows MAX_PATH limitation
- **Solution:** Enable long path support in registry
- **Alternative:** Use shorter project path

### A.4.2. Platform-Specific Issues

**Windows:**
- Use `Scripts\activate` not `bin/activate`
- Use backslashes `\` in paths
- May need admin rights for some installations
- Long path names can cause issues

**Mac/Linux:**
- Use `bin/activate`
- Use forward slashes `/` in paths
- May need `sudo` for system-wide installations
- Prefer virtual environments over system Python

**Mac (Apple Silicon M1/M2):**
- Some packages need Rosetta 2
- TensorFlow requires specific versions
- Use miniforge for better ARM support

### A.4.3. Dependency Conflicts

**Symptom:** Package installation fails due to version conflicts
```
ERROR: pip's dependency resolver does not currently take into account all the packages that are installed.
```

**Solution 1: Create Fresh Environment**
```bash
# Deactivate current
deactivate

# Remove old environment
rm -rf .venv  # Mac/Linux
rmdir /s .venv  # Windows

# Create new
python -m venv .venv
```

**Solution 2: Use Constraints File**
```bash
# Pin compatible versions
pip install pandas==2.0.3 numpy==1.24.3
```

**Solution 3: Install in Order**
```bash
# Install dependencies first
pip install numpy
pip install pandas
# Then higher-level packages
pip install scikit-learn
```

### A.4.4. Jupyter Kernel Issues

**Issue: Kernel not found in VS Code**
- **Check:** Is kernel registered? `jupyter kernelspec list`
- **Solution:** Re-register kernel with install command
- **VS Code:** Reload window (Ctrl+Shift+P â†’ "Reload Window")

**Issue: Wrong Python version in kernel**
- **Check:** Which Python is registered?
```bash
jupyter kernelspec list
cat /path/to/kernel/kernel.json
```
- **Solution:** Remove old kernel, re-register correct one
```bash
jupyter kernelspec uninstall project_base_kernel
python -m ipykernel install --user --name=project_base_kernel
```

**Issue: Kernel dies immediately**
- **Check:** Environment activation worked?
- **Check:** All packages installed?
- **Solution:** Test Python directly in terminal first
```bash
.venv\Scripts\activate
python
>>> import pandas
>>> import numpy
```

### A.4.5. Environment Maintenance

**Update Packages:**
```bash
# Update single package
pip install --upgrade pandas

# Update all packages
pip list --outdated
pip install --upgrade pip setuptools wheel
pip install --upgrade -r requirements_base.txt
```

**Check for Security Issues:**
```bash
pip install pip-audit
pip-audit
```

**Clean Environment:**
```bash
# Remove unused packages
pip uninstall package_name

# Or recreate environment from scratch
deactivate
rm -rf .venv
python -m venv .venv
.venv\Scripts\activate
pip install -r requirements_base.txt
```

**Export Current Environment:**
```bash
# All packages
pip freeze > requirements_full.txt

# Or manually maintain requirements
pip list --format=freeze > requirements.txt
```

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

**Purpose:** Guide for transitioning between development environments (e.g., Windows to WSL2/Linux for GPU training).

**Source:** Favorita Demand Forecasting Project
- Development: Windows 11, CPU-only TensorFlow
- Production: WSL2 Ubuntu 22.04, GPU-enabled TensorFlow
- Transition required careful planning to avoid path and package issues

### A.6.1. When Environment Transition Is Needed

**Common Transition Scenarios:**
- Windows development to Linux production server
- CPU training to GPU training (cloud or local)
- Local development to Docker container
- Single machine to distributed computing
- Academic laptop to HPC cluster

**Signs You Need to Plan Transition:**
- Dataset exceeds local memory (need cloud/HPC)
- Training time exceeds acceptable threshold (need GPU)
- Deployment target differs from development OS
- Team members use different operating systems

### A.6.2. Pre-Transition Checklist

**Before Starting Transition:**

```markdown
## Environment Transition Planning

**Source Environment:**
- OS: [e.g., Windows 11]
- Python: [e.g., 3.11.5]
- Key packages: [e.g., TensorFlow 2.20.0 CPU]
- Working directory: [e.g., D:\projects\forecasting]

**Target Environment:**
- OS: [e.g., Ubuntu 22.04 on WSL2]
- Python: [e.g., 3.11.x]
- Key packages: [e.g., TensorFlow 2.20.0 GPU]
- Working directory: [e.g., /mnt/d/projects/forecasting]

**Transition Checklist:**
- [ ] Requirements file is current (`pip freeze > requirements.txt`)
- [ ] All code uses relative paths from project root
- [ ] No hardcoded Windows paths (C:\, D:\, backslashes)
- [ ] Data files accessible from target environment
- [ ] Model artifacts are portable (no absolute paths in pickles)
- [ ] Tests exist to validate pipeline works end-to-end
```

### A.6.3. Path Handling for Cross-Platform Compatibility

**Use pathlib for All Paths:**

```python
# BAD: Windows-specific
data_path = "D:\\projects\\forecasting\\data\\train.csv"

# BAD: Unix-specific
data_path = "/home/user/projects/forecasting/data/train.csv"

# GOOD: Cross-platform
from pathlib import Path

PROJECT_ROOT = Path(__file__).parent.parent  # Or define explicitly
DATA_DIR = PROJECT_ROOT / "data"
TRAIN_PATH = DATA_DIR / "train.csv"

# Works on both Windows and Linux
df = pd.read_csv(TRAIN_PATH)
```

**Constants Pattern for Notebooks:**

```python
# Cell 1: Environment Configuration (works on both platforms)
from pathlib import Path
import os

# Detect environment
IS_WSL = 'microsoft' in os.uname().release.lower() if hasattr(os, 'uname') else False
IS_WINDOWS = os.name == 'nt'

# Set project root (adjust based on notebook location)
if IS_WSL:
    PROJECT_ROOT = Path("/mnt/d/projects/forecasting")
elif IS_WINDOWS:
    PROJECT_ROOT = Path("D:/projects/forecasting")
else:
    PROJECT_ROOT = Path.cwd().parent

# Define all paths relative to root
DATA_DIR = PROJECT_ROOT / "data"
RAW_DIR = DATA_DIR / "raw"
PROCESSED_DIR = DATA_DIR / "processed"
ARTIFACTS_DIR = PROJECT_ROOT / "artifacts"
OUTPUTS_DIR = PROJECT_ROOT / "outputs"

print(f"Environment: {'WSL' if IS_WSL else 'Windows' if IS_WINDOWS else 'Other'}")
print(f"Project root: {PROJECT_ROOT}")
print(f"Project root exists: {PROJECT_ROOT.exists()}")
```

### A.6.4. GPU Environment Setup (WSL2 Example)

**WSL2 + CUDA Setup Checklist:**

```bash
# 1. Check WSL version
wsl --version

# 2. Check NVIDIA driver (from Windows PowerShell)
nvidia-smi

# 3. In WSL2 Ubuntu, verify CUDA access
nvidia-smi  # Should work if driver is installed

# 4. Create Python environment in WSL2
python3 -m venv .venv_gpu
source .venv_gpu/bin/activate

# 5. Install TensorFlow with GPU support
pip install tensorflow[and-cuda]

# 6. Verify GPU is detected
python -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"
```

**Common GPU Setup Issues:**

| Issue | Symptom | Solution |
|-------|---------|----------|
| No GPU detected | Empty list from TensorFlow | Update NVIDIA driver in Windows |
| CUDA version mismatch | cuDNN errors | Match TensorFlow version to CUDA |
| Out of memory | OOM during training | Reduce batch size, enable memory growth |
| WSL memory limit | Training killed | Increase WSL memory in .wslconfig |

**Memory Growth Configuration:**

```python
# Add to notebook start to prevent OOM
import tensorflow as tf

gpus = tf.config.list_physical_devices('GPU')
if gpus:
    try:
        for gpu in gpus:
            tf.config.experimental.set_memory_growth(gpu, True)
        print(f"OK: GPU memory growth enabled for {len(gpus)} GPU(s)")
    except RuntimeError as e:
        print(f"WARNING: GPU memory growth failed: {e}")
```

### A.6.5. Transition Validation Script

**Run This After Environment Transition:**

```python
#!/usr/bin/env python3
"""
validate_environment_transition.py
Run after transitioning to new environment to verify setup.
"""

import sys
from pathlib import Path

def validate_transition():
    """Validate environment transition was successful."""

    results = []

    # 1. Python version
    py_version = sys.version_info
    results.append({
        'check': 'Python version',
        'status': 'OK' if py_version >= (3, 9) else 'WARNING',
        'detail': f"{py_version.major}.{py_version.minor}.{py_version.micro}"
    })

    # 2. Core packages
    packages = ['pandas', 'numpy', 'sklearn', 'tensorflow', 'xgboost']
    for pkg in packages:
        try:
            module = __import__(pkg.replace('sklearn', 'sklearn'))
            version = getattr(module, '__version__', 'unknown')
            results.append({
                'check': f'Package: {pkg}',
                'status': 'OK',
                'detail': version
            })
        except ImportError as e:
            results.append({
                'check': f'Package: {pkg}',
                'status': 'ERROR',
                'detail': str(e)
            })

    # 3. GPU availability (if TensorFlow)
    try:
        import tensorflow as tf
        gpus = tf.config.list_physical_devices('GPU')
        results.append({
            'check': 'GPU availability',
            'status': 'OK' if gpus else 'WARNING',
            'detail': f"{len(gpus)} GPU(s) detected" if gpus else "No GPU (CPU only)"
        })
    except Exception as e:
        results.append({
            'check': 'GPU availability',
            'status': 'ERROR',
            'detail': str(e)
        })

    # 4. Project paths
    project_root = Path.cwd()
    critical_paths = [
        project_root / "data",
        project_root / "notebooks",
        project_root / "artifacts"
    ]

    for path in critical_paths:
        results.append({
            'check': f'Path: {path.name}/',
            'status': 'OK' if path.exists() else 'ERROR',
            'detail': str(path)
        })

    # 5. Data file access
    data_dir = project_root / "data" / "raw"
    if data_dir.exists():
        file_count = len(list(data_dir.glob("*")))
        results.append({
            'check': 'Data files accessible',
            'status': 'OK' if file_count > 0 else 'WARNING',
            'detail': f"{file_count} files in data/raw/"
        })

    # Print results
    print("\n" + "=" * 60)
    print("ENVIRONMENT TRANSITION VALIDATION")
    print("=" * 60)

    for r in results:
        status_icon = {'OK': 'OK:', 'WARNING': 'WARNING:', 'ERROR': 'ERROR:'}[r['status']]
        print(f"{status_icon} {r['check']}: {r['detail']}")

    print("=" * 60)

    errors = [r for r in results if r['status'] == 'ERROR']
    warnings = [r for r in results if r['status'] == 'WARNING']

    if errors:
        print(f"\nERROR: {len(errors)} critical issue(s) found. Fix before proceeding.")
        return False
    elif warnings:
        print(f"\nWARNING: {len(warnings)} warning(s). Review but can proceed.")
        return True
    else:
        print("\nOK: Environment transition validated successfully!")
        return True

if __name__ == "__main__":
    success = validate_transition()
    sys.exit(0 if success else 1)
```

### A.6.6. Best Practices for Smooth Transitions

**DO:**
- Test transition early (Sprint 2-3, not Sprint 4)
- Keep requirements.txt synchronized
- Use pathlib for all file operations
- Document environment-specific configurations
- Run validation script after each transition

**DON'T:**
- Wait until production to test GPU environment
- Hardcode absolute paths
- Assume packages behave identically across platforms
- Forget to update .gitignore for platform-specific files
- Skip end-to-end pipeline validation after transition

**Transition Documentation Template:**

```markdown
## Environment Transition Log

**Date:** [YYYY-MM-DD]
**From:** [Source environment]
**To:** [Target environment]

### Pre-Transition
- [ ] Requirements exported
- [ ] Paths verified cross-platform
- [ ] Data accessible from target

### Transition Steps
1. [Step 1]
2. [Step 2]
...

### Post-Transition Validation
- [ ] Validation script passed
- [ ] Pipeline runs end-to-end
- [ ] Model training completes
- [ ] Predictions match expected format

### Issues Encountered
- [Issue 1]: [Resolution]
- [Issue 2]: [Resolution]

### Notes for Future Transitions
- [Lesson learned]
```

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

Large model downloads (embeddings, transformers, NLTK data) can consume
significant disk space. Document and manage these to avoid storage surprises.

### A.8.1. Common Cache Locations

| Library | Default Cache Path | Typical Size |
|---------|-------------------|-------------|
| gensim | `~/gensim-data/` | 500MB-2GB |
| HuggingFace | `~/.cache/huggingface/` | 500MB-5GB+ |
| NLTK | `~/nltk_data/` | 50-500MB |
| spaCy | Python site-packages | 50-500MB per model |
| PyTorch | `~/.cache/torch/` | Varies |
| TensorFlow | `~/.keras/` (legacy) or `~/.cache/` | Varies |

### A.8.2. Size Checking

```bash
# Check all common cache locations
du -sh ~/gensim-data/ ~/.cache/huggingface/ ~/nltk_data/ 2>/dev/null

# Check specific model sizes
du -sh ~/gensim-data/glove-twitter-200/
du -sh ~/.cache/huggingface/hub/sentence-transformers*/
```

### A.8.3. Cleanup Commands

```bash
# Remove specific library caches
rm -rf ~/gensim-data/              # All gensim models
rm -rf ~/.cache/huggingface/hub/   # All HuggingFace models
rm -rf ~/nltk_data/                # All NLTK data

# Selective cleanup (keep some models)
rm -rf ~/gensim-data/fasttext-wiki-news-subwords-300/  # Remove one model
```

### A.8.4. Best Practices

- **Document downloads:** Note large model downloads in project README with expected sizes
- **Clean after project:** Remove domain-specific caches not needed for other work
- **Share awareness:** If using shared compute, coordinate cache management
- **Gitignore caches:** Ensure cache directories are in `.gitignore`

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
**Main Document:** `1.0_Data_Science_Collaboration_Methodology.md` â†’ Section 2  
**Purpose:** Detailed implementation guidance and examples for each project phase

---

## B.1. Phase 0 Deep Dive: Environment Setup

### B.1.1. Setup Script Walkthrough

**Minimal Setup Script Structure:**
```python
#!/usr/bin/env python3
"""
setup_base_environment_minimal.py
Creates virtual environment with essential data science packages
"""

import subprocess
import sys
import os
from pathlib import Path

def run_command(cmd, description):
    """Execute shell command with status reporting"""
    print(f"\n{description}...")
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    if result.returncode == 0:
        print(f"OK: {description} complete")
        return True
    else:
        print(f"ERROR: {description} failed")
        print(result.stderr)
        return False

def main():
    # Step 1: Create virtual environment
    if not run_command("python -m venv .venv", "Creating virtual environment"):
        sys.exit(1)
    
    # Step 2: Activate and upgrade pip
    activate_cmd = ".venv\\Scripts\\activate" if os.name == 'nt' else "source .venv/bin/activate"
    pip_cmd = ".venv\\Scripts\\pip" if os.name == 'nt' else ".venv/bin/pip"
    
    if not run_command(f"{pip_cmd} install --upgrade pip", "Upgrading pip"):
        sys.exit(1)
    
    # Step 3: Install packages
    packages = "jupyter ipykernel pandas numpy matplotlib seaborn"
    if not run_command(f"{pip_cmd} install {packages}", "Installing base packages"):
        sys.exit(1)
    
    # Step 4: Register kernel
    python_cmd = ".venv\\Scripts\\python" if os.name == 'nt' else ".venv/bin/python"
    kernel_cmd = f"{python_cmd} -m ipykernel install --user --name=project_base_kernel"
    if not run_command(kernel_cmd, "Registering Jupyter kernel"):
        sys.exit(1)
    
    # Step 5: Generate requirements.txt
    if not run_command(f"{pip_cmd} freeze > requirements_base.txt", "Generating requirements"):
        sys.exit(1)
    
    # Step 6: Create VS Code settings
    create_vscode_settings()
    
    print("\nOK: Environment setup complete!")
    print("Next steps:")
    print("1. Activate environment")
    print(f"   {activate_cmd}")
    print("2. Open VS Code in this directory")
    print("3. Create first notebook with project_base_kernel")

def create_vscode_settings():
    """Create .vscode/settings.json"""
    vscode_dir = Path(".vscode")
    vscode_dir.mkdir(exist_ok=True)
    
    settings = {
        "python.defaultInterpreterPath": "./.venv/Scripts/python.exe" if os.name == 'nt' else "./.venv/bin/python",
        "jupyter.jupyterServerType": "local"
    }
    
    import json
    with open(vscode_dir / "settings.json", "w") as f:
        json.dump(settings, f, indent=2)
    print("OK: VS Code settings created")

if __name__ == "__main__":
    main()
```

### B.1.2. VS Code Configuration Details

**Recommended Extensions:**
- Python (Microsoft)
- Jupyter (Microsoft)
- Pylance (Microsoft)

**Workspace Settings (`.vscode/settings.json`):**
```json
{
  "python.defaultInterpreterPath": "./.venv/Scripts/python.exe",
  "jupyter.jupyterServerType": "local",
  "jupyter.notebookFileRoot": "${workspaceFolder}",
  "files.exclude": {
    "**/__pycache__": true,
    "**/.venv": true,
    "**/*.pyc": true
  },
  "python.analysis.extraPaths": [
    "${workspaceFolder}"
  ]
}
```

### B.1.3. Kernel Management

**List All Kernels:**
```bash
jupyter kernelspec list
```

**Remove Old Kernel:**
```bash
jupyter kernelspec uninstall old_kernel_name
```

**Change Kernel Display Name:**
```bash
# Find kernel location
jupyter kernelspec list

# Edit kernel.json
# Change "display_name" field
```

**Multiple Project Kernels:**
```bash
# Project 1
python -m ipykernel install --user --name=project1 --display-name="Project 1"

# Project 2
python -m ipykernel install --user --name=project2 --display-name="Project 2"
```

---

## B.2. Phase 1 Deep Dive: Exploration

### B.2.1. Data Quality Assessment Techniques

**Comprehensive Quality Check:**
```python
def assess_data_quality(df, name="Dataset"):
    """Comprehensive data quality assessment"""
    print(f"=== {name} Quality Assessment ===\n")
    
    # Basic structure
    print(f"Shape: {df.shape[0]:,} rows x {df.shape[1]} columns")
    print(f"Memory: {df.memory_usage(deep=True).sum() / 1024**2:.2f} MB\n")
    
    # Duplicates
    dup_count = df.duplicated().sum()
    print(f"Duplicates: {dup_count:,} ({dup_count/len(df)*100:.2f}%)")
    
    # Missing values
    missing = df.isnull().sum()
    missing_pct = (missing / len(df) * 100).round(2)
    missing_df = pd.DataFrame({
        'Missing': missing,
        'Percent': missing_pct
    })
    missing_df = missing_df[missing_df['Missing'] > 0].sort_values('Missing', ascending=False)
    
    if len(missing_df) > 0:
        print(f"\nMissing Values:\n{missing_df}")
    else:
        print("\nOK: No missing values")
    
    # Data types
    print(f"\nData Types:\n{df.dtypes.value_counts()}")
    
    # Numeric column statistics
    numeric_cols = df.select_dtypes(include=[np.number]).columns
    if len(numeric_cols) > 0:
        print(f"\nNumeric Columns ({len(numeric_cols)}):")
        print(df[numeric_cols].describe())
    
    # Categorical unique counts
    cat_cols = df.select_dtypes(include=['object', 'category']).columns
    if len(cat_cols) > 0:
        print(f"\nCategorical Unique Values:")
        for col in cat_cols:
            print(f"  {col}: {df[col].nunique():,} unique")
    
    return missing_df
```

**Outlier Detection:**
```python
def detect_outliers(df, column, method='iqr'):
    """Detect outliers using IQR or z-score method"""
    if method == 'iqr':
        Q1 = df[column].quantile(0.25)
        Q3 = df[column].quantile(0.75)
        IQR = Q3 - Q1
        lower_bound = Q1 - 1.5 * IQR
        upper_bound = Q3 + 1.5 * IQR
        outliers = df[(df[column] < lower_bound) | (df[column] > upper_bound)]
    else:  # z-score
        from scipy import stats
        z_scores = np.abs(stats.zscore(df[column].dropna()))
        outliers = df[z_scores > 3]
    
    print(f"Outliers in {column}: {len(outliers):,} ({len(outliers)/len(df)*100:.2f}%)")
    return outliers
```

### B.2.2. Cohort Definition Strategies

**Example: TravelTide Active User Cohort**
```python
# Define cohort with clear criteria
def define_active_cohort(users_df, sessions_df, ref_date='2023-01-01'):
    """
    Active User Cohort Definition:
    - At least 1 session in 2023
    - Account created before 2023
    - Has complete profile data
    """
    print("=== Cohort Definition ===\n")
    
    # Start with all users
    cohort = users_df.copy()
    print(f"Starting users: {len(cohort):,}")
    
    # Filter 1: Has 2023 activity
    active_users = sessions_df[sessions_df['session_date'] >= ref_date]['user_id'].unique()
    cohort = cohort[cohort['user_id'].isin(active_users)]
    print(f"After activity filter: {len(cohort):,}")
    
    # Filter 2: Account created before 2023
    cohort = cohort[cohort['signup_date'] < ref_date]
    print(f"After signup filter: {len(cohort):,}")
    
    # Filter 3: Complete profile
    required_fields = ['user_id', 'signup_date', 'home_country']
    cohort = cohort.dropna(subset=required_fields)
    print(f"After completeness filter: {len(cohort):,}")
    
    print(f"\nFinal cohort: {len(cohort):,} users")
    return cohort
```

### B.2.3. EDA Best Practices

**Distribution Analysis:**
```python
def analyze_distribution(df, column, bins=50):
    """Comprehensive distribution analysis"""
    fig, axes = plt.subplots(1, 3, figsize=(15, 4))
    
    # Histogram
    df[column].hist(bins=bins, ax=axes[0])
    axes[0].set_title(f'{column} Distribution')
    axes[0].set_xlabel(column)
    axes[0].set_ylabel('Frequency')
    
    # Box plot
    df[column].plot(kind='box', ax=axes[1])
    axes[1].set_title(f'{column} Box Plot')
    
    # Q-Q plot
    from scipy import stats
    stats.probplot(df[column].dropna(), dist="norm", plot=axes[2])
    axes[2].set_title(f'{column} Q-Q Plot')
    
    plt.tight_layout()
    plt.show()
    
    # Statistics
    print(f"{column} Statistics:")
    print(df[column].describe())
```

### B.2.4. EDA Techniques by Data Type

**Numeric Data:**

| Technique | Purpose | Code Pattern |
|-----------|---------|--------------|
| 5-number summary | Distribution overview | `df.describe()` |
| Histogram + KDE | Shape visualization | `sns.histplot(kde=True)` |
| Box plot | Outlier detection | `sns.boxplot()` |
| Q-Q plot | Normality check | `scipy.stats.probplot()` |
| Correlation heatmap | Relationships | `sns.heatmap(df.corr())` |

**Categorical Data:**

| Technique | Purpose | Code Pattern |
|-----------|---------|--------------|
| Value counts | Category distribution | `df['col'].value_counts()` |
| Bar chart | Visual distribution | `sns.countplot()` |
| Crosstab | Category interactions | `pd.crosstab()` |
| Chi-square | Independence test | `scipy.stats.chi2_contingency()` |

**Temporal Data:**

| Technique | Purpose | Code Pattern |
|-----------|---------|--------------|
| Time series plot | Trend visualization | `df.plot()` with datetime index |
| Rolling statistics | Smoothed trends | `df.rolling(window).mean()` |
| Seasonal decomposition | Pattern separation | `statsmodels.tsa.seasonal_decompose()` |
| Autocorrelation | Lag relationships | `plot_acf()`, `plot_pacf()` |

**Text Data:**

| Technique | Purpose | Code Pattern |
|-----------|---------|--------------|
| Length distribution | Text size patterns | `df['text'].str.len()` |
| Word frequency | Common terms | `Counter` or `sklearn.CountVectorizer` |
| Word cloud | Visual frequency | `wordcloud.WordCloud()` |
| Language detection | Multi-language check | `langdetect` |

### B.2.5. Business Understanding Integration

**Domain Briefing Template (Before EDA):**

```markdown
### Domain Briefing

**Business Context:**
- What problem is the business trying to solve?
- How is this handled today (without ML)?
- What would a successful outcome look like?

**Domain Knowledge:**
- What do domain experts expect to see in the data?
- What relationships should exist based on domain knowledge?
- What would be surprising or concerning?

**Historical Context:**
- Has this been attempted before? Results?
- What's changed in the business/environment?
- Any known data quality issues?

**Terminology:**
- [Term 1]: [Definition in business context]
- [Term 2]: [Definition in business context]
```

**EDA Validation Checklist (After EDA):**

Before moving to Feature Engineering, validate findings with domain expert:
- [ ] Shared Layer 1-3 summaries with stakeholder
- [ ] Confirmed entity definitions match business understanding
- [ ] Validated surprising findings (expected or investigate?)
- [ ] Agreed on analysis direction
- [ ] Documented any domain knowledge gained

### B.2.6. References

**EDA Framework Foundations:**

This section draws from established data science practices with DSM-specific adaptations:

- **Three-Layer Framework:** Adapted from DIKW hierarchy (Ackoff, 1989) and general BI principles (Facts → Insights → Actions). Simplified for practical EDA workflow.
- **Exploratory Data Analysis Philosophy:** Based on John Tukey's seminal work (1977) emphasizing letting data speak through visualization and systematic questioning.
- **Business Understanding Integration:** Inspired by CRISP-DM (Chapman et al., 1999) but implemented as iterative dialogue rather than sequential phase.
- **Layer Summary Templates:** Original DSM contribution combining documentation standards with structured understanding capture.

**Key References:**
- Tukey, J. W. (1977). *Exploratory Data Analysis*. Addison-Wesley.
- Chapman, P., et al. (1999). *CRISP-DM 1.0: Step-by-step data mining guide*. SPSS Inc.
- Ackoff, R. L. (1989). From data to wisdom. *Journal of Applied Systems Analysis*, 16(1), 3-9.

---

## B.3. Phase 2 Deep Dive: Feature Engineering

### B.3.1. Feature Generation Strategies

**Behavioral Aggregation Pattern:**
```python
def create_behavioral_features(transactions_df, users_df):
    """Generate behavioral features from transactions"""
    
    # Aggregations
    user_features = transactions_df.groupby('user_id').agg({
        'booking_id': 'count',                    # trip_count
        'booking_value': ['sum', 'mean', 'std'],  # spend metrics
        'booking_date': ['min', 'max'],           # first/last trip
        'hotel_nights': ['sum', 'mean'],          # accommodation usage
        'cancelled': 'sum'                        # cancellation count
    })
    
    # Flatten multi-level columns
    user_features.columns = [
        'trip_count', 'total_spend', 'avg_spend', 'std_spend',
        'first_trip_date', 'last_trip_date', 'total_nights', 'avg_nights',
        'cancellation_count'
    ]
    
    # Derived features
    user_features['cancellation_rate'] = (
        user_features['cancellation_count'] / user_features['trip_count']
    )
    
    ref_date = pd.Timestamp('2023-12-31')
    user_features['days_since_last_trip'] = (
        (ref_date - user_features['last_trip_date']).dt.days
    )
    
    user_features['customer_tenure_days'] = (
        (ref_date - user_features['first_trip_date']).dt.days
    )
    
    return user_features.reset_index()
```

**Propensity Modeling:**
```python
def calculate_propensities(user_features):
    """Calculate behavioral propensities"""
    
    # Discount propensity
    user_features['discount_propensity'] = (
        user_features['discount_bookings'] / user_features['trip_count']
    ).fillna(0)
    
    # Luxury propensity (high-value bookings)
    luxury_threshold = user_features['avg_spend'].quantile(0.75)
    user_features['luxury_propensity'] = (
        (user_features['avg_spend'] > luxury_threshold).astype(int)
    )
    
    # Weekend trip propensity
    user_features['weekend_propensity'] = (
        user_features['weekend_trips'] / user_features['trip_count']
    ).fillna(0)
    
    return user_features
```

### B.3.2. Feature Selection Methods

**Correlation-Based Selection:**
```python
def select_features_by_correlation(df, target=None, threshold=0.95):
    """Remove highly correlated features"""
    
    # Calculate correlation matrix
    corr_matrix = df.corr().abs()
    
    # Find pairs with correlation > threshold
    upper = corr_matrix.where(
        np.triu(np.ones(corr_matrix.shape), k=1).astype(bool)
    )
    
    # Identify features to drop
    to_drop = [column for column in upper.columns if any(upper[column] > threshold)]
    
    print(f"Dropping {len(to_drop)} highly correlated features:")
    for feature in to_drop:
        correlations = upper[feature][upper[feature] > threshold]
        print(f"  {feature}: corr > {threshold} with {correlations.index.tolist()}")
    
    return df.drop(columns=to_drop)
```

### B.3.3. Feature Ablation Study Methodology

**Purpose:** Systematically validate which features improve model performance

**When to Use:**
- After Sprint 2 (feature engineering complete)
- Before Sprint 3 final model training
- When feature count is high (>30 features)
- When concerned about overfitting

**Why It Matters:**
"More features != better performance" - Redundant or low-value features can hurt generalization.

---

#### Case Study: Retail Forecasting Feature Reduction

**Starting Point:**
- Features: 45 engineered features (Sprint 2 output)
- Baseline RMSE: 7.21 (XGBoost with all 45 features)

**Goal:** Identify which features to keep vs remove

**Method:** Three-stage validation

---

#### Stage 1: Permutation Importance (Quick Filter)

**How it Works:**
1. Train model with all features
2. For each feature:
   - Randomly shuffle its values
   - Measure performance drop
   - Higher drop = more important
3. Rank features by importance

**Implementation:**
```python
from sklearn.inspection import permutation_importance

# Train baseline model
model = xgb.XGBRegressor(**params)
model.fit(X_train, y_train)
baseline_score = mean_squared_error(y_test, model.predict(X_test))

# Permutation importance
perm_importance = permutation_importance(
    model, X_test, y_test,
    n_repeats=10,
    random_state=42,
    scoring='neg_mean_squared_error'
)

# Rank features
importance_df = pd.DataFrame({
    'feature': X_train.columns,
    'importance': perm_importance.importances_mean,
    'std': perm_importance.importances_std
}).sort_values('importance', ascending=False)

# Identify low-value features
threshold = 0.01  # Importance < 1% of baseline score
low_value = importance_df[importance_df['importance'] < threshold]
```

**Results (Retail Project):**

Low-importance features identified:
- Rolling std (3 features): importance < 0.005
- Oil features (6 features): importance < 0.01
- Some promotion interactions (3 features): importance < 0.008

---

#### Stage 2: Ablation Study (Confirm Removal)

**How it Works:**
1. Remove suspected low-value features
2. Retrain model
3. Measure performance change
4. Keep removed if performance improves or stays same

**Implementation:**
```python
# Test removal of low-importance features
features_to_remove = ['oil_price', 'oil_price_lag7', ...] # 12 features

X_train_reduced = X_train.drop(columns=features_to_remove)
X_test_reduced = X_test.drop(columns=features_to_remove)

# Retrain
model_reduced = xgb.XGBRegressor(**params)
model_reduced.fit(X_train_reduced, y_train)

# Evaluate
baseline_rmse = np.sqrt(mean_squared_error(y_test, model.predict(X_test)))
reduced_rmse = np.sqrt(mean_squared_error(y_test, model_reduced.predict(X_test_reduced)))

print(f"Baseline (45 features): RMSE = {baseline_rmse:.4f}")
print(f"Reduced (33 features): RMSE = {reduced_rmse:.4f}")
print(f"Improvement: {(baseline_rmse - reduced_rmse) / baseline_rmse * 100:.2f}%")
```

**Results (Retail Project):**
- Baseline (45 features): RMSE = 7.2127
- Reduced (33 features): RMSE = 6.8852
- **Improvement: +4.54%** (removing features IMPROVED performance)

---

#### Stage 3: SHAP Values (Deep Validation - Optional)

**How it Works:**
Use SHAP (SHapley Additive exPlanations) to understand feature contributions

**Implementation:**
```python
import shap

# Train model with final feature set
model_final = xgb.XGBRegressor(**params)
model_final.fit(X_train_reduced, y_train)

# SHAP analysis
explainer = shap.TreeExplainer(model_final)
shap_values = explainer.shap_values(X_test_reduced)

# Visualize
shap.summary_plot(shap_values, X_test_reduced, plot_type="bar")

# Validate removed features had low SHAP importance
# (confirmation that removal was justified)
```

**Note:** SHAP is computationally expensive. Use for final validation, not initial screening.

---

#### Decision Framework: Which Features to Remove?

```
FOR each feature:
    IF permutation_importance < 0.01:
        Mark as "candidate for removal"

    ELSE IF highly correlated with another feature (r > 0.9):
        Mark as "redundant, candidate for removal"

    ELSE:
        Mark as "keep"

THEN:
    Remove candidates
    Retrain model

    IF performance improves OR stays same:
        Confirm removal

    ELSE IF performance drops >5%:
        Reject removal (feature was valuable despite low permutation score)
```

---

#### Features Removed (DEC-014 Example)

**Category 1: Rolling Std (3 features)**
- `unit_sales_7d_std`, `14d_std`, `30d_std`
- **Reason:** Permutation importance < 0.005, highly correlated with rolling mean
- **Validation:** Ablation showed no performance drop

**Category 2: Oil Features (6 features)**
- `oil_price`, `oil_price_lag7/14/30`, `oil_price_change7/14`
- **Reason:** Weak granular correlation (r ~ 0.01), permutation importance < 0.01
- **Note:** Kept in Sprint 2 despite weak correlation, removed in Sprint 3 based on importance

**Category 3: Promotion Interactions (3 features)**
- `promo_holiday_category`, `promo_item_avg`, `promo_cluster`
- **Reason:** Low importance, redundant with base `onpromotion` flag

**Total Removed:** 12 features
**Final Set:** 33 features
**Performance:** +4.54% improvement (7.21 -> 6.89 RMSE)

---

#### Implementation Checklist

**Sprint 2 (Feature Engineering):**
- [ ] Create all candidate features (cast wide net)
- [ ] Document each feature in feature dictionary
- [ ] Note: Some features may be redundant or low-value

**Sprint 3 Day 1-2 (Feature Validation):**
- [ ] Compute permutation importance on all features
- [ ] Identify candidates for removal (importance < threshold)
- [ ] Run ablation study (retrain without candidates)
- [ ] Validate performance impact
- [ ] Document decision (DEC-XXX)

**Sprint 3 Day 3+ (Model Training):**
- [ ] Train final models with reduced feature set
- [ ] (Optional) SHAP analysis for deep validation
- [ ] Update feature dictionary (mark removed features)

---

#### Common Pitfalls to Avoid

**Pitfall 1: Removing features based on correlation alone**
- ERROR: "Oil has r=0.01, remove it"
- OK: "Oil has r=0.01 AND low permutation importance AND ablation confirms no impact, remove it"

**Pitfall 2: Keeping all features "just in case"**
- ERROR: "Maybe the model will find a use for it"
- OK: "Less is more - simpler models generalize better"

**Pitfall 3: Removing features without validation**
- ERROR: "This feature seems useless, delete it"
- OK: "Run ablation study to confirm removal doesn't hurt performance"

**Pitfall 4: Ignoring domain knowledge**
- ERROR: "The model says it's not important, remove it"
- OK: "The model says it's not important, but business logic says it should matter - investigate why"

---

#### Documentation Template

```markdown
## DEC-XXX: Feature Reduction Based on Ablation

**Context:**
Baseline model with [N] features showed [metric]. Concerned about overfitting.

**Method:**
1. Permutation importance analysis
2. Ablation study (retrain without low-importance features)
3. (Optional) SHAP validation

**Features Removed ([M] total):**
- [Feature 1]: Importance [X], Reason: [Why]
- [Feature 2]: Importance [Y], Reason: [Why]
...

**Alternatives Considered:**
1. Keep all features - Rejected: Overfitting risk, no performance benefit
2. Use L1 regularization - Rejected: Less interpretable than explicit removal
3. More aggressive cuts - Rejected: Removed valuable features, hurt performance

**Impact:**
- Features: [N] -> [N-M] ([percentage]% reduction)
- Performance: [metric before] -> [metric after] ([percentage]% improvement)
- Interpretability: Simpler model, easier to explain
- Generalization: Reduced overfitting risk

**Validation:**
- Ablation study confirmed no performance loss
- SHAP analysis validated low contribution of removed features
```

---

#### Best Practice Summary

1. **Create first, validate later:** Sprint 2 = generate features, Sprint 3 = validate
2. **Use multiple validation methods:** Permutation + Ablation + (optional) SHAP
3. **Document removals:** Explain what was removed and why
4. **Update feature dictionary:** Mark removed features with Sprint/reason
5. **Celebrate simplicity:** Fewer features = better generalization + easier interpretation

**Portfolio Value:**
Demonstrates systematic feature validation methodology, not just "throw features at model and hope for best."

---

## B.4. Phase 3 Deep Dive: Analysis

### B.4.1. Algorithm Selection (Clustering Example)

**K-Means vs. Hierarchical Comparison:**
```python
def compare_clustering_methods(X, k_range=range(2, 8)):
    """Compare K-Means and Hierarchical clustering"""
    from sklearn.cluster import KMeans, AgglomerativeClustering
    from sklearn.metrics import silhouette_score, davies_bouldin_score
    
    results = []
    
    for k in k_range:
        # K-Means
        kmeans = KMeans(n_clusters=k, random_state=42, n_init=10)
        kmeans_labels = kmeans.fit_predict(X)
        
        # Hierarchical
        hierarchical = AgglomerativeClustering(n_clusters=k)
        hierarchical_labels = hierarchical.fit_predict(X)
        
        # Metrics
        results.append({
            'k': k,
            'kmeans_silhouette': silhouette_score(X, kmeans_labels),
            'kmeans_db': davies_bouldin_score(X, kmeans_labels),
            'hierarchical_silhouette': silhouette_score(X, hierarchical_labels),
            'hierarchical_db': davies_bouldin_score(X, hierarchical_labels)
        })
    
    results_df = pd.DataFrame(results)
    print(results_df)
    
    # Plot comparison
    fig, axes = plt.subplots(1, 2, figsize=(14, 5))
    
    axes[0].plot(results_df['k'], results_df['kmeans_silhouette'], 'o-', label='K-Means')
    axes[0].plot(results_df['k'], results_df['hierarchical_silhouette'], 's-', label='Hierarchical')
    axes[0].set_xlabel('Number of Clusters (k)')
    axes[0].set_ylabel('Silhouette Score')
    axes[0].set_title('Silhouette Score Comparison')
    axes[0].legend()
    axes[0].grid(True)
    
    axes[1].plot(results_df['k'], results_df['kmeans_db'], 'o-', label='K-Means')
    axes[1].plot(results_df['k'], results_df['hierarchical_db'], 's-', label='Hierarchical')
    axes[1].set_xlabel('Number of Clusters (k)')
    axes[1].set_ylabel('Davies-Bouldin Index')
    axes[1].set_title('Davies-Bouldin Index Comparison (lower is better)')
    axes[1].legend()
    axes[1].grid(True)
    
    plt.tight_layout()
    plt.show()
    
    return results_df
```

### B.4.2. Validation Techniques

**Cross-Validation for Clustering:**
```python
def validate_clustering_stability(X, n_clusters=3, n_trials=10):
    """Test clustering stability across random initializations"""
    from sklearn.cluster import KMeans
    from sklearn.metrics import silhouette_score, adjusted_rand_score
    
    scores = []
    label_sets = []
    
    for trial in range(n_trials):
        kmeans = KMeans(n_clusters=n_clusters, random_state=trial, n_init=10)
        labels = kmeans.fit_predict(X)
        score = silhouette_score(X, labels)
        scores.append(score)
        label_sets.append(labels)
    
    # Check consistency across trials
    ari_scores = []
    for i in range(len(label_sets)-1):
        ari = adjusted_rand_score(label_sets[i], label_sets[i+1])
        ari_scores.append(ari)
    
    print(f"Silhouette Score: {np.mean(scores):.4f} Â± {np.std(scores):.4f}")
    print(f"Adjusted Rand Index (consistency): {np.mean(ari_scores):.4f}")
    
    if np.mean(ari_scores) > 0.9:
        print("OK: Clustering is stable")
    else:
        print("WARNING: Clustering shows variation across runs")
    
    return scores, ari_scores
```

### B.4.3. Scale-Dependent Validation Protocol

**Critical Finding:** Model selection at sample scale may not hold at production scale.

**Source:** Favorita Demand Forecasting Project (2025)
- LSTM won by 4.5% on 300K sample (RMSE 6.26 vs 6.49)
- At 4.8M production scale, LSTM failed to converge
- XGBoost proved more stable and was used for production

**Why This Happens:**
- Neural networks: Hyperparameters tuned on sample may not generalize
- Tree models: Different computational patterns at scale
- Memory/batch dynamics: Change behavior with dataset size
- Convergence: Small datasets may find local optima that don't scale

**Scale Validation Protocol:**

**Stage 1: Sample Development (10-30% of data)**
```python
# Development phase - fast iteration
sample_size = int(len(df) * 0.1)  # 10% sample
df_sample = df.sample(n=sample_size, random_state=42)

# Train and compare models on sample
models = {
    'xgboost': XGBRegressor(**sample_params),
    'lstm': build_lstm_model(**sample_params),
    'random_forest': RandomForestRegressor(**sample_params)
}

sample_results = {}
for name, model in models.items():
    model.fit(X_train_sample, y_train_sample)
    pred = model.predict(X_test_sample)
    sample_results[name] = {
        'rmse': np.sqrt(mean_squared_error(y_test_sample, pred)),
        'converged': True  # Track convergence
    }
    print(f"{name} (sample): RMSE = {sample_results[name]['rmse']:.4f}")
```

**Stage 2: Scale Validation (50-100% of data)**
```python
# Before finalizing model choice, validate at scale
print("=" * 50)
print("SCALE VALIDATION - Testing top models at production scale")
print("=" * 50)

# Take top 2-3 models from sample phase
top_models = sorted(sample_results.items(), key=lambda x: x[1]['rmse'])[:3]

scale_results = {}
for name, _ in top_models:
    try:
        model = models[name]
        model.fit(X_train_full, y_train_full)
        pred = model.predict(X_test_full)
        scale_results[name] = {
            'rmse': np.sqrt(mean_squared_error(y_test_full, pred)),
            'converged': True,
            'status': 'SUCCESS'
        }
    except Exception as e:
        scale_results[name] = {
            'rmse': float('inf'),
            'converged': False,
            'status': f'FAILED: {str(e)}'
        }

    print(f"{name} (full scale): {scale_results[name]['status']}")
    if scale_results[name]['converged']:
        print(f"  RMSE = {scale_results[name]['rmse']:.4f}")
```

**Stage 3: Compare and Document**
```python
# Create comparison table
comparison = pd.DataFrame({
    'Model': list(sample_results.keys()),
    'Sample_RMSE': [r['rmse'] for r in sample_results.values()],
    'Scale_RMSE': [scale_results.get(k, {'rmse': None})['rmse']
                   for k in sample_results.keys()],
    'Scale_Status': [scale_results.get(k, {'status': 'Not tested'})['status']
                     for k in sample_results.keys()]
})

comparison['RMSE_Change'] = (
    (comparison['Scale_RMSE'] - comparison['Sample_RMSE'])
    / comparison['Sample_RMSE'] * 100
)

print("\nSCALE VALIDATION RESULTS:")
print(comparison.to_string(index=False))

# Alert if sample winner changed
sample_winner = comparison.loc[comparison['Sample_RMSE'].idxmin(), 'Model']
scale_winner = comparison.loc[comparison['Scale_RMSE'].idxmin(), 'Model']

if sample_winner != scale_winner:
    print(f"\nWARNING: Model selection changed at scale!")
    print(f"  Sample winner: {sample_winner}")
    print(f"  Scale winner: {scale_winner}")
    print("  Document this finding in decision log.")
```

**Decision Log Template for Scale Findings:**
```markdown
## DEC-XXX: Scale-Dependent Model Selection

**Context:** Model comparison showed different results at sample vs production scale

**Sample Results (N=300K):**
- Model A: RMSE 6.26 (winner)
- Model B: RMSE 6.49

**Scale Results (N=4.8M):**
- Model A: FAILED (did not converge)
- Model B: RMSE 6.52 (stable)

**Decision:** Use Model B for production despite sample results

**Rationale:**
- Production stability outweighs sample performance
- Model A optimization was sample-specific
- Business requires reliable predictions

**Validation:** Monitor production metrics for first 30 days
```

**When to Apply This Protocol:**
- Production dataset >10x sample size
- Models with many hyperparameters (neural networks)
- Time-sensitive production requirements
- When sample winner has narrow margin (<5% improvement)

**Best Practices:**
- Always test top 2-3 models at scale before finalizing
- Document scale validation in decision log
- Consider scale stability as a selection criterion
- Plan for GPU/memory requirements at scale early

---

## B.5. Phase 4 Deep Dive: Communication

### B.5.1. Notebook Consolidation Strategy

**Consolidation Process:**

1. **Identify Essential Code:**
   - Remove exploratory dead ends
   - Keep only successful approaches
   - Consolidate similar analyses

2. **Add Narrative:**
   - Clear markdown headers
   - Explain rationale for choices
   - Interpret results in context

3. **Clean Outputs:**
   - Remove excessive print statements
   - Keep key visualizations
   - Add result summaries

**Example Structure:**
```markdown
# Customer Segmentation Analysis - Consolidated

## 1. Setup & Data Loading
[Essential imports and data loading only]

## 2. Data Quality & Cohort Definition
[Key quality checks, final cohort definition]

## 3. Feature Engineering
[Core features with business interpretation]

## 4. Clustering Analysis
[Model selection, validation, final clusters]

## 5. Segment Interpretation
[Cluster profiles, business insights]

## 6. Recommendations
[Actionable recommendations by segment]

## 7. Implementation Considerations
[Next steps, limitations, monitoring]
```

### B.5.2. Report Writing Guidelines

**Executive Summary Template:**
```markdown
# Executive Summary: [Project Name]

## Key Findings
1. [Most important finding with impact]
2. [Second most important finding]
3. [Third finding]

## Recommended Actions
1. [Specific action with expected outcome]
2. [Specific action with expected outcome]
3. [Specific action with expected outcome]

## Business Impact
- [Quantified benefit if possible]
- [Risk mitigation]
- [Strategic alignment]

## Next Steps
- [Immediate next steps]
- [Timeline]
- [Resources needed]
```

**Technical Report Structure:**
```markdown
# Technical Report: [Project Name]

## 1. Business Context
- Problem statement
- Objectives
- Success criteria

## 2. Data Overview
- Data sources
- Cohort definition
- Data quality assessment

## 3. Methodology
- Approach rationale
- Feature engineering
- Model selection
- Validation strategy

## 4. Results
- Key findings with statistical support
- Visualizations
- Performance metrics

## 5. Interpretation
- Business meaning of results
- Actionable insights
- Segment profiles (if applicable)

## 6. Limitations & Assumptions
- Data limitations
- Methodological assumptions
- Caveats

## 7. Recommendations
- Specific actions
- Implementation considerations
- Monitoring approach

## Appendices
- Technical details
- Code repository
- Data dictionary
- Feature dictionary
```

### B.5.3. Presentation Design

**Slide Deck Structure:**

**Slide 1: Title**
- Project name
- Date
- Presenter

**Slide 2-3: Executive Summary**
- Key findings (3-5 bullets)
- Bottom-line recommendation

**Slides 4-5: Business Context**
- Problem statement
- Objectives
- Success criteria

**Slides 6-7: Approach**
- Methodology overview (simplified)
- Data sources
- Key techniques

**Slides 8-12: Results**
- Main findings (1 per slide)
- Visualizations (clear, labeled)
- Business interpretation

**Slides 13-14: Recommendations**
- Actionable recommendations
- Expected impact
- Next steps

**Slide 15: Q&A / Appendix**
- Technical details available
- Contact information

---

**End of Appendix B**

Return to main document: **Section 2: Core Workflow**
-e 
---

# Appendix C: Advanced Practices Detailed

**Part of:** Data Science Collaboration Methodology v1.1  
**Main Document:** `1.0_Data_Science_Collaboration_Methodology.md` â†’ Section 5  
**Purpose:** Detailed implementation guidance for advanced practices (Tiers 2-4)

---

## C.1. Experiment Tracking Implementation

**When to Use:** ML projects with multiple model iterations, parameter tuning, or algorithm comparisons.

### C.1.1. Manual Experiment Tracking

**Simple CSV-Based Tracking:**
```python
import pandas as pd
from datetime import datetime

def log_experiment(experiment_name, params, metrics, notes=""):
    """Log experiment to CSV file"""
    log_entry = {
        'timestamp': datetime.now(),
        'experiment_name': experiment_name,
        'notes': notes,
        **params,
        **metrics
    }
    
    log_file = 'experiments_log.csv'
    
    # Append to existing log or create new
    try:
        df = pd.read_csv(log_file)
        df = pd.concat([df, pd.DataFrame([log_entry])], ignore_index=True)
    except FileNotFoundError:
        df = pd.DataFrame([log_entry])
    
    df.to_csv(log_file, index=False)
    print(f"OK: Experiment logged - {experiment_name}")

# Usage
log_experiment(
    experiment_name="kmeans_k3",
    params={'k': 3, 'random_state': 42, 'n_init': 10},
    metrics={'silhouette': 0.38, 'db_index': 1.2},
    notes="Using all 89 features"
)
```

### C.1.2. MLflow Implementation

**Setup:**
```bash
pip install mlflow
```

**Basic Usage:**
```python
import mlflow
from sklearn.cluster import KMeans
from sklearn.metrics import silhouette_score

mlflow.set_experiment("customer_segmentation")

with mlflow.start_run(run_name="kmeans_k3"):
    # Log parameters
    mlflow.log_param("k", 3)
    mlflow.log_param("algorithm", "k-means")
    mlflow.log_param("n_features", 89)
    
    # Train model
    kmeans = KMeans(n_clusters=3, random_state=42)
    labels = kmeans.fit_predict(X_scaled)
    
    # Log metrics
    silhouette = silhouette_score(X_scaled, labels)
    mlflow.log_metric("silhouette_score", silhouette)
    
    # Log model
    mlflow.sklearn.log_model(kmeans, "model")
    
    print(f"Logged run with silhouette: {silhouette:.4f}")
```

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

**RAGAS Quick Reference:**

```python
from ragas import evaluate
from ragas.metrics import (
    faithfulness,
    context_precision,
    context_recall,
    answer_relevancy
)

# Prepare evaluation dataset
eval_dataset = Dataset.from_dict({
    "question": questions,
    "answer": answers,
    "contexts": contexts,
    "ground_truth": ground_truths
})

# Run evaluation
results = evaluate(
    eval_dataset,
    metrics=[
        faithfulness,        # Is answer grounded in context?
        context_precision,   # Is retrieved context relevant?
        context_recall,      # Is all needed info retrieved?
        answer_relevancy     # Does answer address the question?
    ]
)

print(results)
# {'faithfulness': 0.87, 'context_precision': 0.92, ...}
```

**RAGBench TRACe Metrics:**

| Metric | Definition |
|--------|------------|
| **Utility** | Does the response help accomplish the user's task? |
| **Relevance** | Is the response pertinent to the query? |
| **Adherence** | Does the response stick to retrieved context (no hallucination)? |
| **Completeness** | Does the response cover all aspects of the query? |

**Best Practice - Combined Evaluation:**

```markdown
## Evaluation Strategy

1. **Baseline Quantitative (Required)**
   - RAGAS: faithfulness, context_precision, context_recall
   - Efficiency: latency, cost-per-query

2. **Extended Quantitative (Recommended)**
   - RAGBench TRACe metrics
   - Traditional: ROUGE/BERTScore for ground truth comparison

3. **Qualitative Capability (Required)**
   - Use C.1.3 template for behavioral tests
   - Document pass/fail/partial for edge cases

4. **Safety Evaluation (For Production)**
   - Adversarial prompt testing
   - PII/privacy checks
   - Factuality under conflicting sources
```

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
| `docs/experiments/` | Documentation | Detailed reports, methodology discussions |

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
**Formal:** [Statistical hypothesis, e.g., "H1: Î¼_high_clv > Î¼_low_clv for exclusive_perk_preference"]
**Plain Language:** [Business hypothesis, e.g., "High CLV customers prefer exclusive perks over discounts"]

## Background
Why we believe this hypothesis might be true.
- Prior evidence
- Domain knowledge
- Stakeholder input

## Variables
**Independent:** [What we're testing]
**Dependent:** [What we're measuring]
**Controls:** [What we're holding constant]

## Pre-Registration
**Test Method:** [Statistical test to use, e.g., t-test, chi-square]
**Sample Size:** [Required sample]
**Significance Level:** [Î± = 0.05]
**Expected Effect Size:** [If known]

## Test Results
**Test Date:** YYYY-MM-DD
**Sample Size:** [Actual n]
**Test Statistic:** [Value]
**P-Value:** [Value]
**Effect Size:** [Value]
**Conclusion:** [Reject/Fail to Reject null]

## Business Interpretation
[What this means for stakeholders]

## Next Steps
[Action items based on results]
```

### C.2.2. Statistical Testing

**T-Test Example:**
```python
from scipy import stats

def test_hypothesis(group1, group2, hypothesis_name):
    """Test difference between two groups"""
    # Descriptive statistics
    print(f"=== {hypothesis_name} ===")
    print(f"Group 1: n={len(group1)}, mean={group1.mean():.2f}, std={group1.std():.2f}")
    print(f"Group 2: n={len(group2)}, mean={group2.mean():.2f}, std={group2.std():.2f}")
    
    # T-test
    t_stat, p_value = stats.ttest_ind(group1, group2)
    
    # Effect size (Cohen's d)
    pooled_std = np.sqrt((group1.std()**2 + group2.std()**2) / 2)
    cohens_d = (group1.mean() - group2.mean()) / pooled_std
    
    print(f"\nResults:")
    print(f"t-statistic: {t_stat:.4f}")
    print(f"p-value: {p_value:.4f}")
    print(f"Cohen's d: {cohens_d:.4f}")
    
    if p_value < 0.05:
        print(f"OK: Hypothesis supported (p < 0.05)")
    else:
        print(f"WARNING: Hypothesis not supported (p >= 0.05)")
    
    return {'t_stat': t_stat, 'p_value': p_value, 'cohens_d': cohens_d}
```

---

## C.3. Performance Baseline Implementation

**When to Use:** Evaluating model improvements or justifying approach complexity.

### C.3.1. Baseline Establishment

**Naive Baseline:**
```python
def create_naive_baseline(y_true):
    """Simplest possible prediction: majority class or mean"""
    if y_true.dtype == 'object' or len(np.unique(y_true)) < 10:
        # Classification: predict majority class
        baseline_pred = [y_true.mode()[0]] * len(y_true)
        from sklearn.metrics import accuracy_score
        score = accuracy_score(y_true, baseline_pred)
        print(f"Naive Baseline (majority class): Accuracy = {score:.4f}")
    else:
        # Regression: predict mean
        baseline_pred = [y_true.mean()] * len(y_true)
        from sklearn.metrics import mean_squared_error
        score = mean_squared_error(y_true, baseline_pred)
        print(f"Naive Baseline (mean): MSE = {score:.4f}")
    
    return baseline_pred, score
```

**Simple Model Baseline:**
```python
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import cross_val_score

def create_simple_baseline(X, y):
    """Simple linear model baseline"""
    model = LogisticRegression(random_state=42)
    scores = cross_val_score(model, X, y, cv=5)
    print(f"Simple Baseline (Logistic Regression): {scores.mean():.4f} Â± {scores.std():.4f}")
    return scores.mean()
```

---

## C.4. Ethics & Bias Implementation

**When to Use:** Models affecting people, sensitive attributes, or regulated industries.

### C.4.1. Bias Audit

```python
def audit_for_bias(df, sensitive_attrs, outcome_var):
    """Check for bias in outcomes across sensitive attributes"""
    print("=== Bias Audit ===\n")
    
    for attr in sensitive_attrs:
        print(f"Attribute: {attr}")
        group_outcomes = df.groupby(attr)[outcome_var].agg(['mean', 'count'])
        print(group_outcomes)
        
        # Statistical test
        groups = [group[outcome_var].values for name, group in df.groupby(attr)]
        if len(groups) == 2:
            from scipy import stats
            stat, p_value = stats.ttest_ind(*groups)
            print(f"T-test p-value: {p_value:.4f}")
            if p_value < 0.05:
                print(f"WARNING: Significant difference detected (p < 0.05)")
        print()
```

### C.4.2. Fairness Metrics

```python
def calculate_fairness_metrics(y_true, y_pred, sensitive_attr):
    """Calculate demographic parity and equalized odds"""
    from sklearn.metrics import confusion_matrix
    
    # Demographic Parity: P(Å·=1 | A=a) for all a
    for group in sensitive_attr.unique():
        mask = sensitive_attr == group
        positive_rate = y_pred[mask].mean()
        print(f"Group {group}: Positive prediction rate = {positive_rate:.4f}")
    
    # Equalized Odds: TPR and FPR should be equal across groups
    for group in sensitive_attr.unique():
        mask = sensitive_attr == group
        tn, fp, fn, tp = confusion_matrix(y_true[mask], y_pred[mask]).ravel()
        tpr = tp / (tp + fn) if (tp + fn) > 0 else 0
        fpr = fp / (fp + tn) if (fp + tn) > 0 else 0
        print(f"Group {group}: TPR = {tpr:.4f}, FPR = {fpr:.4f}")
```

---

## C.5. Testing Strategy Implementation

**When to Use:** Production deployments, team collaboration, or code reuse.

### C.5.1. Data Validation Tests

```python
import pytest

def test_data_schema(df):
    """Test that DataFrame has expected structure"""
    expected_columns = ['user_id', 'signup_date', 'total_spend']
    assert all(col in df.columns for col in expected_columns), "Missing required columns"
    
def test_data_types(df):
    """Test that columns have expected types"""
    assert df['user_id'].dtype == 'int64', "user_id should be integer"
    assert pd.api.types.is_datetime64_any_dtype(df['signup_date']), "signup_date should be datetime"
    
def test_data_ranges(df):
    """Test that values are in expected ranges"""
    assert (df['total_spend'] >= 0).all(), "Negative spend detected"
    assert (df['signup_date'] <= pd.Timestamp.now()).all(), "Future signup dates detected"
```

### C.5.2. Function Unit Tests

```python
def calculate_clv(transactions, revenue):
    """Calculate customer lifetime value"""
    return transactions * revenue

def test_calculate_clv():
    """Test CLV calculation"""
    assert calculate_clv(10, 100) == 1000
    assert calculate_clv(0, 100) == 0
    assert calculate_clv(5, 0) == 0
```

---

## C.6. Data Versioning Implementation

**When to Use:** Multiple data versions, reproducibility critical, or team data sharing.

### C.6.1. Simple File Versioning

```python
def save_versioned_data(df, base_name, version=None):
    """Save data with version and date"""
    from datetime import datetime
    
    if version is None:
        # Auto-increment version
        import glob
        existing = glob.glob(f"{base_name}_v*.csv")
        if existing:
            versions = [int(f.split('_v')[1].split('_')[0].replace('.', '')) for f in existing]
            version = max(versions) + 1
        else:
            version = 1.0
    
    date_str = datetime.now().strftime('%Y%m%d')
    filename = f"{base_name}_v{version}_{date_str}.csv"
    df.to_csv(filename, index=False)
    print(f"OK: Saved {filename}")
    return filename
```

### C.6.2. DVC (Data Version Control)

**Setup:**
```bash
pip install dvc
dvc init
```

**Track Data File:**
```bash
dvc add data/users.csv
git add data/users.csv.dvc data/.gitignore
git commit -m "Track users data with DVC"
```

---

## C.7. Technical Debt Register Implementation

**When to Use:** Long-term projects (>6 months), growing codebases, or team projects.

### C.7.1. Debt Documentation

```markdown
# Technical Debt Register

## TD-001: Hardcoded File Paths

**Created:** 2025-11-15
**Priority:** High
**Effort:** 2 hours

### Current State
File paths hardcoded in 5 notebooks:
- `01_EDA.ipynb`: line 23
- `02_EDA.ipynb`: line 15
- `03_FE.ipynb`: line 10, 45, 67

### Ideal State
Path constants defined in config file or notebook start.

### Impact
- **Maintenance:** High - changes require editing multiple files
- **Portability:** High - notebooks break on different machines
- **Risk:** Medium - easy to miss when updating paths

### Paydown Plan
1. Create `config.py` with path constants
2. Update all notebooks to import config
3. Test on different machine
**Estimated time:** 2 hours

### Status
- [ ] Planned
- [ ] In Progress
- [ ] Complete
```

---

## C.8. Scalability Implementation

**When to Use:** Data growth expected, user base expansion, or performance issues.

### C.8.1. Resource Estimation

```python
def estimate_memory_requirements(n_rows, n_cols, dtype='float64'):
    """Estimate memory for DataFrame"""
    bytes_per_value = {'float64': 8, 'int64': 8, 'object': 50}
    total_bytes = n_rows * n_cols * bytes_per_value.get(dtype, 8)
    total_mb = total_bytes / 1024**2
    print(f"Estimated memory: {total_mb:,.2f} MB")
    
    if total_mb > 1000:
        print("WARNING: Consider chunking or Dask")
    return total_mb
```

---

## C.9. Literature Review Implementation

**When to Use:** Novel problems, research projects, or no established best practices.

### C.9.1. Information Extraction

```markdown
# Literature Review: Customer Segmentation Methods

## Paper 1: "K-Means vs Hierarchical Clustering"

**Citation:** Smith et al. (2023). Journal of ML, 45(2), 123-145.

### Problem Addressed
Comparing clustering methods for customer segmentation.

### Approach
- Tested K-Means, Hierarchical, DBSCAN on 5 datasets
- Used silhouette score, Davies-Bouldin index
- Sample sizes: 1K - 100K customers

### Key Findings
- K-Means faster but assumes spherical clusters
- Hierarchical better for non-spherical
- DBSCAN good for noise handling

### Metrics & Results
- K-Means: silhouette 0.35 Â± 0.05
- Hierarchical: silhouette 0.32 Â± 0.08
- Speed: K-Means 10x faster on 100K samples

### Relevant to Our Project
- Similar dataset size (5K customers)
- Confirms K-Means appropriate choice
- Validates silhouette score usage

### Limitations
- Only tested B2C, not B2B
- No feature engineering comparison
```

---

## C.10. Risk Management Implementation

**When to Use:** High-stakes decisions, multiple dependencies, or uncertain requirements.

### C.10.1. Risk Register

```markdown
# Risk Register

## Risk R-001: Stakeholder Requirements Change

**Probability:** Medium (40%)
**Impact:** High (could require re-analysis)
**Risk Score:** Medium-High

### Description
Marketing stakeholder may change segment requirements mid-project based on business priorities.

### Mitigation
- Sprint check-ins with stakeholder
- Document requirements formally
- Design flexible clustering approach
- Keep decision log of all changes

### Contingency
- Build 2-3 day buffer in timeline
- Have alternative K values ready
- Document pivot criteria upfront

### Owner
The data scientist

### Status
- [x] Identified
- [x] Mitigation in place
- [ ] Triggered
- [ ] Resolved
```

---

**End of Appendix C**

Return to main document: **Section 5: Advanced Practices**
-e 
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

**Phase 1: Exploration**
- Focus on temporal patterns, trends, seasonality
- Decomposition analysis (trend, seasonal, residual)
- Stationarity testing (ADF test, KPSS test)
- Autocorrelation analysis (ACF, PACF plots)

**Phase 2: Feature Engineering**
- Lag features (t-1, t-2, ... t-n)
- Rolling statistics (moving averages, moving std)
- Seasonal indicators (month, day of week, holidays)
- Time-based aggregations

**Phase 3: Analysis**
- Model selection: ARIMA, Prophet, LSTM, XGBoost
- Train/test split: respect temporal order (no random shuffle)
- Cross-validation: time series CV (forward chaining)
- Forecast horizon: define clearly

**Phase 4: Communication**
- Forecast vs actual plots
- Confidence intervals
- Forecast horizon limitations
- Model updating strategy

### D.1.2. Key Techniques

**Stationarity Testing:**
```python
from statsmodels.tts.stattools import adfuller

def test_stationarity(series):
    result = adfuller(series.dropna())
    print(f"ADF Statistic: {result[0]:.4f}")
    print(f"p-value: {result[1]:.4f}")
    if result[1] < 0.05:
        print("OK: Series is stationary")
    else:
        print("WARNING: Series is non-stationary, consider differencing")
```

**Seasonal Decomposition:**
```python
from statsmodels.tsa.seasonal import seasonal_decompose

decomposition = seasonal_decompose(series, model='additive', period=12)
decomposition.plot()
```

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

---

#### Case Study: Training Period Selection

**Hypothesis:**
More training data (full 2013) will improve March 2014 forecast accuracy.

**Test Results:**

| Training Period | Samples | Seasonal Coverage | Test RMSE | vs Q1-only |
|-----------------|---------|-------------------|-----------|-----------|
| **Q1 2014 only** | 12K | Jan-Feb (winter) | 7.21 | 0% baseline |
| **Full 2013 + Jan-Feb 2014** | 50K | All seasons (Jan-Dec) | 14.88 | **+106% WORSE** |
| **Q4 2013 + Q1 2014** | 19K | Fall-Winter (Oct-Feb) | 6.84 | **+5% BETTER** |

**Findings:**

1. **More data != better performance** (50K worse than 12K)
2. **Seasonal alignment matters more than volume** (19K beats both)
3. **Catastrophic failure possible** (106% worse with "more" data)

---

#### Why Full 2013 Failed

**Problem:** Seasonal mismatch between training and test

**Training period (Full 2013):**
- Includes summer (May-Aug): Different demand patterns, irrelevant for March forecast
- Includes extreme holidays (Nov-Dec): Black Friday (1,332 units max), Christmas peaks
- Pattern learned: "Normal sales" = summer, "High sales" = Nov-Dec holidays

**Test period (March 2014):**
- Spring season: Different from summer AND winter
- No extreme holidays: March sales max = 222 units (6x LOWER than training max)
- Reality: "Normal" March sales look like "low outliers" to model trained on Nov-Dec

**Result:** Model learned extreme patterns that don't exist in March -> terrible generalization

---

#### Why Q4+Q1 Succeeded

**Seasonal Alignment:**
- Training: Oct-Nov-Dec (fall/early winter) + Jan-Feb (late winter)
- Test: March (early spring)
- Smooth transition: Training ends Feb 28, test starts Mar 1 (continuous season)

**Pattern Matching:**
- Q4+Q1 range: 0-222 units (matches March range)
- No extreme holiday spikes (Christmas excluded from training for March test)
- Captures: Post-holiday normalization (Jan-Feb) relevant for March baseline

**Data Volume Trade-off:**
- Sacrificed: 31K samples (summer irrelevant months)
- Gained: Seasonal coherence + stable range alignment
- **Net result:** +54% better than full year despite 2.6x less data

---

#### Decision Framework: Training Period Selection

**Step 1: Identify test period seasonality**
```
Test period: March 2014 (early spring, no major holidays)
```

**Step 2: Find RECENT periods with SIMILAR seasonality**
```
Candidates:
- January-February 2014 (same year, winter -> spring transition) OK
- October-February 2013-2014 (fall -> winter -> early spring) OK
- March 2013 (same month last year, spring) WARNING: (only 1 month, too small)
- Full 2013 (all seasons) ERROR: (includes irrelevant summer, extreme holidays)
```

**Step 3: Validate range alignment**
```
Training range should match test range (avoid extrapolation)

Q4+Q1: Max = 222 units OK (matches March test max)
Full 2013: Max = 1,332 units ERROR (6x higher, model learns unrealistic peaks)
```

**Step 4: Choose most recent, seasonally-aligned period**
```
Winner: Q4 2013 + Q1 2014 (Oct-Feb, 5 months, 19K samples)
```

---

#### When to Use Full Year vs Seasonal Subset

**Use Full Year Training When:**
- Test period is "average" month (no strong seasonality)
- Data is stationary (no seasonal patterns exist)
- Very small dataset (need all data to train)
- Forecasting annual totals (not specific months)

**Use Seasonal Subset When:**
- Strong seasonality present (retail, tourism, energy)
- Test period has known seasonal characteristics
- Sufficient data in relevant season (>=1000 samples minimum)
- Extrapolation risk exists (holiday extremes, summer vs winter)

---

#### Implementation Guidelines

**For Seasonal Time Series:**

```python
# DON'T: Use all available data blindly
train = df[df['date'] < test_start]  # All historical data

# DO: Filter to seasonally-relevant periods
test_month = 3  # March
test_year = 2014

# Option 1: Same season last year + current year up to test
train = df[
    ((df['date'].dt.month >= 10) & (df['date'].dt.year == test_year - 1)) |  # Q4 last year
    ((df['date'].dt.month <= 2) & (df['date'].dt.year == test_year))         # Q1 this year
]

# Option 2: Rolling N-month window
train = df[
    (df['date'] >= test_start - pd.DateOffset(months=6)) &  # Last 6 months
    (df['date'] < test_start)
]

# Validate: Check training max ~ test max
print(f"Training max: {train['target'].max()}")
print(f"Test max: {test['target'].max()}")
# If training max >> test max -> seasonal mismatch risk!
```

**Document Decision:**

```markdown
## DEC-XXX: Training Period Selection

**Context:**
Forecasting March 2014 sales (early spring, no major holidays).
Full year 2013 available but includes summer and extreme Nov-Dec holidays.

**Decision:**
Use Q4 2013 + Q1 2014 (Oct 1 - Feb 28) for training (5 months, 19K samples).

**Rationale:**
- Seasonal alignment: Fall/winter -> early spring matches test period
- Range alignment: Training max (222) matches test max (no extrapolation)
- Excludes irrelevant summer patterns and extreme holiday spikes
- Recent data: Captures current trends better than older data

**Alternatives Considered:**
1. Full 2013 + Jan-Feb 2014 (50K samples) -> REJECTED: Includes summer (irrelevant) and Nov-Dec extremes (6x test max)
2. Q1 2014 only (12K samples) -> Smaller, less robust
3. March 2013 (same month last year) -> Too small (1 month)

**Impact:**
- RMSE: 6.84 vs 14.88 (full year) -> 54% improvement
- Training time: Faster (19K vs 50K samples)
- Generalization: Better (avoids learning irrelevant patterns)

**Validation:**
- RMSE improved 5% vs Q1-only baseline
- No extrapolation warnings (training/test ranges aligned)
- Model metrics stable (no overfitting to specific season)
```

---

#### Key Takeaways

1. **More data != better** (quality > quantity for seasonal series)
2. **Seasonal relevance > recency** (2-year-old relevant data beats 6-month-old irrelevant)
3. **Range alignment critical** (training max should match test max +/-20%)
4. **Validate assumptions** (test on seasonal subset before full year)
5. **Document rationale** (stakeholders will ask "why not use all data?")

**Portfolio Value:**
This demonstrates deep time series understanding beyond basic ML. Many practitioners default to "use all data" without considering seasonal coherence. This finding shows analytical maturity and domain expertise.

### D.1.5. Aggregation Level Impacts Correlation

**Critical Finding from Retail Forecasting Project:**

Correlation coefficients are HIGHLY sensitive to aggregation level in time series data. Results can:
- Change magnitude dramatically (97% drop observed)
- Flip sign (negative -> positive)
- Mislead about feature utility

---

#### Case Study: Oil Price Correlation

**Sprint 1 (Aggregate level):**
- Data: Daily sales aggregated across all stores and items
- Correlation: r = -0.55 (moderate negative)
- Interpretation: "When oil prices rise, sales fall"
- Business logic: Makes sense for oil-dependent economy

**Sprint 2 (Granular level):**
- Data: Daily sales per store-item combination (300K rows)
- Correlation: r = +0.01 (negligible positive)
- Result: 97% magnitude drop + sign flip!

---

#### Why This Happens

1. **Simpson's Paradox:** Aggregate correlation != disaggregate correlation
2. **Sparse data dilution:** 99.1% of store-item-date combinations have zero sales
3. **Confounding variables:** Store/item effects dominate oil price signal at granular level
4. **Measurement level mismatch:** National oil price vs local store sales

---

#### Implications for Feature Engineering

**DON'T:**
- ERROR: Reject features based on correlation at wrong aggregation level
- ERROR: Assume correlation stability across aggregation levels
- ERROR: Use Sprint 1 aggregate correlations to guide Sprint 2 granular feature selection

**DO:**
- OK: Compute correlations at MODELING granularity (not aggregate)
- OK: Use feature importance (permutation, SHAP) instead of correlation
- OK: Keep features with weak correlation if business logic supports (tree models find non-linear patterns)
- OK: Document aggregation level in correlation reports

---

#### Decision Framework

```
IF aggregate correlation strong (|r| > 0.5)
AND granular correlation weak (|r| < 0.1)
THEN:
  1. Document finding (don't panic)
  2. Keep feature (tree models may find non-linear patterns)
  3. Validate in Sprint 3 via:
     - Permutation importance
     - Ablation study (remove feature, measure impact)
     - SHAP values
  4. Drop feature only if ALL validation methods show no impact
```

---

#### Example (Oil Features - DEC-012)

Despite granular correlation of r = 0.01:
- OK: Kept all 6 oil features
- Rationale: Tree models can find non-linear relationships correlation misses
- Different products may respond to different oil price timescales
- Sprint 3 feature importance will validate utility

Result (Sprint 3): Oil features removed in DEC-014 (low permutation importance), but decision was evidence-based, not correlation-based.

---

#### Best Practice

Always report correlation WITH aggregation level:
- ERROR: "Oil price correlation: r = -0.55"
- OK: "Oil price correlation (aggregate): r = -0.55"
- OK: "Oil price correlation (granular store-item): r = +0.01"
- OK: "Correlation magnitude and sign are aggregation-dependent"

---

## D.2. NLP Projects

### D.2.1. Phase Adaptations

**Phase 1: Exploration**
- Text distribution analysis (length, vocabulary)
- Token frequency analysis
- Language detection
- Data quality (encoding issues, special characters)

**Phase 2: Feature Engineering**
- Text cleaning (lowercase, punctuation, stopwords)
- Tokenization strategies
- Feature extraction: TF-IDF, word embeddings
- Document representation

**Phase 3: Analysis**
- Model selection: Naive Bayes, SVM, BERT, etc.
- Text classification or clustering
- Topic modeling (LDA, NMF)
- Sentiment analysis

**Phase 4: Communication**
- Word clouds for interpretability
- Example documents per class/topic
- Confusion matrices
- Error analysis (misclassified examples)

### D.2.2. Key Techniques

**Text Preprocessing:**
```python
import re
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize

def preprocess_text(text):
    # Lowercase
    text = text.lower()
    # Remove special characters
    text = re.sub(r'[^a-zA-Z0-9\s]', '', text)
    # Tokenize
    tokens = word_tokenize(text)
    # Remove stopwords
    tokens = [t for t in tokens if t not in stopwords.words('english')]
    return ' '.join(tokens)
```

**TF-IDF Vectorization:**
```python
from sklearn.feature_extraction.text import TfidfVectorizer

vectorizer = TfidfVectorizer(max_features=1000, min_df=5, max_df=0.8)
X = vectorizer.fit_transform(documents)
```

### D.2.3. Common Challenges

- High dimensionality of text features
- Class imbalance
- Out-of-vocabulary words
- Domain-specific terminology
- Multilingual data

### D.2.4. NLP EDA Checklist

Extends Section 2.2 (Exploration) with text-specific patterns. Use alongside
the Three-Layer EDA Framework.

**Text-Specific EDA:**

| Check | What to Look For | Why It Matters |
|-------|-----------------|----------------|
| Class distribution | Balance/imbalance ratio | Drives sampling strategy |
| Text length distribution | Characters, words, sentences per sample | Short vs. long text affects method choice |
| Vocabulary size | Unique tokens before/after preprocessing | Indicates feature space complexity |
| Word frequency distribution | Zipf's law shape, long tail | Informs min_df/max_df settings |
| Missing/empty text | Null values, empty strings, whitespace-only | Must handle before vectorization |
| Special character patterns | URLs, mentions, hashtags, emojis | Informs cleaning pipeline decisions |
| Language detection | Single vs. multilingual data | Determines preprocessing tools |

**Classification-Specific EDA:**

| Check | What to Look For | Why It Matters |
|-------|-----------------|----------------|
| Top N-grams per class | Unigrams, bigrams distinctive to each class | Reveals discriminative features |
| Text length vs. class | Length differences between classes | Length alone may be a signal (or bias) |
| Duplicate text detection | Exact or near-duplicates across classes | Duplicates inflate metrics if split across train/test |
| Label quality assessment | Ambiguous cases, annotation disagreement | Sets realistic accuracy ceiling |
| Word overlap between classes | Shared vs. unique vocabulary per class | Low overlap suggests easier task |

**Preprocessing Impact Assessment:**

After each preprocessing step, verify:
- Vocabulary size change (before → after)
- Empty text count introduced
- Information loss estimation (compare sample texts before/after)
- Class distribution stability (preprocessing should not change class balance)

Cross-reference: Section 2.2 (Three-Layer EDA Framework), Appendix B.2.4 (EDA Techniques by Data Type)

### D.2.5. NLP Preprocessing & Vectorization Guide

Extends Section 2.3 (Feature Engineering) with NLP-specific parameter guidance
and common configurations.

**Text Cleaning Pipeline (Recommended Order):**

| Step | Operation | Decision Point |
|------|-----------|---------------|
| 1 | Lowercase conversion | Skip for case-sensitive tasks (NER, acronym detection) |
| 2 | URL removal (`http\S+`) | Almost always remove for classification |
| 3 | HTML tag removal | Required for web-scraped text |
| 4 | Special character handling | Keep: hashtags if meaningful. Remove: most punctuation |
| 5 | Number handling | Keep, remove, or replace with `<NUM>` token (task-dependent) |
| 6 | Stopword removal | Helps TF-IDF; skip for embeddings/transformers |
| 7 | Lemmatization vs. stemming | Lemmatization preferred (preserves meaning); stemming faster |

**TF-IDF Parameter Guide:**

| Parameter | Typical Range | Start With | Notes |
|-----------|--------------|-----------|-------|
| `max_features` | 5,000-50,000 | 10,000 | Increase if large vocabulary; decrease for short texts |
| `ngram_range` | (1,1) to (1,3) | (1,2) | Bigrams often help classification |
| `min_df` | 2-5 | 2 | Remove terms appearing in fewer than N documents |
| `max_df` | 0.9-0.95 | 0.95 | Remove near-universal terms (alternative to stopwords) |
| `sublinear_tf` | True/False | True | Log-scale TF; usually improves classification |

**Edge Case Handling:**

| Issue | Detection | Resolution |
|-------|-----------|-----------|
| Empty strings after preprocessing | `df[df['clean_text'].str.strip() == '']` | Remove from dataset or flag for review |
| Encoding issues | `chardet.detect()` on sample | Standardize to UTF-8 before processing |
| Very short texts (< 3 words after cleaning) | Length filter post-cleaning | Keep but monitor performance separately |
| Duplicate texts with different labels | Group by text, check label variance | Resolve or remove conflicting labels |

WARNING: Apply Section 2.3.7 (Data Leakage Prevention) to all text preprocessing.
Fit vectorizers on training data only; transform validation/test sets.

Cross-reference: Section 2.3 (Feature Engineering), Section 2.3.7 (Data Leakage Prevention)

### D.2.6. NLP Performance Expectations

Guides realistic expectations for NLP model selection. "More advanced" does not
mean "better for every task." Empirical comparison is always required (Section 2.4).

**Method Selection by Task Characteristics:**

| Task Characteristic | TF-IDF + Classical ML | Word Embeddings | Transformers |
|--------------------|----------------------|-----------------|-------------|
| Short text (< 50 words) | Strong | Moderate | Strong |
| Long documents | Moderate | Good | Strong |
| Small dataset (< 5K samples) | Strong | Weak-Moderate | Weak (without fine-tuning data) |
| Large dataset (> 50K samples) | Good | Good | Strong |
| Keyword-driven task | Strong | Moderate | Strong |
| Semantic similarity | Weak | Strong | Strong |
| Context-dependent meaning | Weak | Moderate | Strong |
| Compute-limited environment | Strong | Moderate | Weak |

**When TF-IDF Typically Wins:**
- Short text classification (tweets, titles, headlines)
- Tasks where word presence matters more than meaning
- Small datasets where pretrained embeddings may add noise
- Keyword-heavy domains (disaster detection, spam filtering)

**When Embeddings Typically Win:**
- Semantic similarity and matching tasks
- Longer documents where word relationships matter
- Cross-domain transfer (pretrained embeddings capture general knowledge)
- Tasks requiring synonym and paraphrase understanding

**When Transformers Typically Win:**
- Context-dependent meaning ("fire" as disaster vs. slang)
- Nuanced sentiment analysis
- Tasks where word order and surrounding context are critical
- Large datasets with sufficient compute resources

**Baseline Expectations by Task:**

| Task Type | Reasonable Baseline (F1) | Good Performance (F1) | Notes |
|-----------|--------------------------|----------------------|-------|
| Binary text classification | 0.70-0.80 | 0.85+ | Depends on class separability |
| Multi-class (3-5 classes) | 0.60-0.75 | 0.80+ | Per-class performance varies |
| Multi-class (10+ classes) | 0.50-0.65 | 0.75+ | Some classes inherently harder |
| Sentiment (pos/neg) | 0.75-0.85 | 0.90+ | Well-studied task |
| Topic classification | 0.70-0.80 | 0.85+ | Clear topic boundaries help |

NOTE: These ranges are approximate starting points. Actual performance depends on
data quality, class separability, and domain specifics. Always establish your own
baseline before comparing to these ranges.

**Key Principle:** Start with the simplest method that could work (TF-IDF + Logistic Regression).
Add complexity only when empirical results justify it.

Cross-reference: Section 2.4 (Analysis), Section 2.3.7 (Data Leakage Prevention)

### D.2.7. Embedding Visualization

When comparing multiple text representation methods (TF-IDF, word embeddings, sentence
transformers), 2D projections of the embedding spaces provide visual evidence for why
certain methods produce better classification results.

**When to Visualize:**
- Comparing multiple representation methods
- Debugging unexpectedly poor model performance
- Understanding cluster structure before or after classification
- Communicating results to non-technical stakeholders (2D plots are intuitive)

**Techniques:**

| Technique | Best For | Key Parameter | Speed |
|-----------|----------|---------------|-------|
| PCA | Quick overview, preserves global variance | `n_components=2` | Fast |
| t-SNE | Local structure, cluster visualization | `perplexity` (5-50, try multiple) | Moderate |
| UMAP | Global + local structure, large datasets | `n_neighbors`, `min_dist` | Fast |

**Standard Approach:**

1. Generate embeddings for each method using the same dataset
2. Apply dimensionality reduction (same technique and parameters across methods)
3. Color points by class label
4. Plot in a grid layout for side-by-side comparison
5. Look for: class separation, cluster tightness, overlap regions

**Interpretation Guidelines:**
- Well-separated clusters suggest the representation captures class-relevant features
- Overlapping regions indicate ambiguous samples -- cross-reference with error analysis
- Scattered distributions suggest the representation does not capture task-relevant structure
- Compare cluster separation across methods to explain performance differences

**Comparison Layout:**
Use a grid of subplots (one per representation method) with consistent axis ranges
and color schemes. This enables direct visual comparison of how each method organizes
the data in the embedding space.

NOTE: t-SNE and UMAP are stochastic -- set `random_state` for reproducibility.
Perplexity/neighbor choices affect t-SNE/UMAP output significantly; try multiple
values and document which was used.

Cross-reference: Section 2.4.6 (Model Comparison), Section 2.4.7 (Error Analysis),
Appendix D.2.6 (NLP Performance Expectations)

---

## D.3. Computer Vision Projects

### D.3.1. Phase Adaptations

**Phase 1: Exploration**
- Image quality assessment (corrupted files, artifacts)
- Resolution and format checks (consistent dimensions, color channels)
- Class distribution analysis (imbalance detection)
- Visual inspection of samples per class
- Dataset size assessment for training strategy

**Phase 2: Feature Engineering**
- Image preprocessing (resize, normalize to [0,1] or [-1,1])
- Data augmentation as model layers (modern approach)
- Input size decisions (native vs upscaled for pre-trained models)
- Transfer learning preparation (base model selection)

**Phase 3: Analysis**
- Model architecture: CNN from scratch vs transfer learning
- Training strategy: frozen layers → fine-tuning (two-phase)
- Learning rate scheduling (ReduceLROnPlateau, cosine decay)
- Validation strategy (see D.3.4)
- VRAM management (batch size optimization)

**Phase 4: Communication**
- Visual results (predictions on test images)
- Confusion matrix with class-wise metrics
- Model interpretability (Grad-CAM attention maps)
- Performance analysis by class and image characteristics
- Training curves (loss, accuracy, learning rate)

### D.3.2. Key Techniques

**Data Augmentation (Modern Layer-Based Approach):**
```python
# Modern approach: Augmentation as model layers
# Benefits: GPU-accelerated, applied only during training
import tensorflow as tf
from tensorflow.keras import layers

data_augmentation = tf.keras.Sequential([
    layers.RandomFlip("horizontal"),
    layers.RandomRotation(0.1),      # 10% rotation
    layers.RandomZoom(0.1),          # 10% zoom
    layers.RandomContrast(0.1),      # Optional: contrast variation
])

# Integrate into model
model = tf.keras.Sequential([
    layers.Input(shape=(32, 32, 3)),
    data_augmentation,               # Applied only during training
    base_model,
    layers.GlobalAveragePooling2D(),
    layers.Dense(128, activation='relu'),
    layers.Dense(num_classes, activation='softmax')
])
```

**Transfer Learning (Two-Phase Training):**
```python
from tensorflow.keras.applications import ResNet50

# Phase 1: Frozen base layers
base_model = ResNet50(
    weights='imagenet',
    include_top=False,
    input_shape=(224, 224, 3)  # Or native size if appropriate
)
base_model.trainable = False

# Train custom head with higher learning rate
model.compile(optimizer=tf.keras.optimizers.Adam(1e-3), ...)
model.fit(train_data, epochs=10, ...)

# Phase 2: Fine-tuning (unfreeze and train with lower LR)
base_model.trainable = True
model.compile(optimizer=tf.keras.optimizers.Adam(1e-5), ...)  # Lower LR
model.fit(train_data, epochs=10, ...)
```

**Learning Rate Scheduling:**
```python
from tensorflow.keras.callbacks import ReduceLROnPlateau

lr_scheduler = ReduceLROnPlateau(
    monitor='val_loss',
    factor=0.5,          # Reduce LR by half
    patience=3,          # Wait 3 epochs before reducing
    min_lr=1e-7,
    verbose=1
)

# Use in training
model.fit(train_data, callbacks=[lr_scheduler], ...)
```

**Grad-CAM Implementation:**
```python
import numpy as np
import tensorflow as tf

def make_gradcam_heatmap(img_array, model, last_conv_layer_name, pred_index=None):
    """Generate Grad-CAM heatmap for model interpretability."""
    # Create model that outputs conv layer activations and predictions
    grad_model = tf.keras.models.Model(
        [model.inputs],
        [model.get_layer(last_conv_layer_name).output, model.output]
    )

    # Compute gradients
    with tf.GradientTape() as tape:
        conv_outputs, predictions = grad_model(img_array)
        if pred_index is None:
            pred_index = tf.argmax(predictions[0])
        class_channel = predictions[:, pred_index]

    # Gradient pooling and heatmap generation
    grads = tape.gradient(class_channel, conv_outputs)
    pooled_grads = tf.reduce_mean(grads, axis=(0, 1, 2))
    conv_outputs = conv_outputs[0]
    heatmap = conv_outputs @ pooled_grads[..., tf.newaxis]
    heatmap = tf.squeeze(heatmap)
    heatmap = tf.maximum(heatmap, 0) / tf.math.reduce_max(heatmap)
    return heatmap.numpy()

# Usage
heatmap = make_gradcam_heatmap(
    img_array=np.expand_dims(image, axis=0),
    model=model,
    last_conv_layer_name='conv5_block3_out'  # ResNet50 last conv layer
)
```

**Comprehensive Evaluation:**
```python
from sklearn.metrics import confusion_matrix, classification_report
import seaborn as sns
import matplotlib.pyplot as plt

# Predictions
y_pred = model.predict(X_test)
y_pred_classes = np.argmax(y_pred, axis=1)
y_true_classes = np.argmax(y_test, axis=1)

# Confusion Matrix
cm = confusion_matrix(y_true_classes, y_pred_classes)
plt.figure(figsize=(10, 8))
sns.heatmap(cm, annot=True, fmt='d', cmap='Blues',
            xticklabels=class_names, yticklabels=class_names)
plt.xlabel('Predicted')
plt.ylabel('True')
plt.title('Confusion Matrix')
plt.show()

# Classification Report (precision, recall, F1 per class)
print(classification_report(y_true_classes, y_pred_classes,
                           target_names=class_names))
```

### D.3.3. Common Challenges

**Memory Constraints:**
- Start with smaller batch sizes (16-32) on limited VRAM
- Use `tf.keras.backend.clear_session()` between experiments
- Monitor GPU memory: `nvidia-smi` or `tf.config.experimental.get_memory_info('GPU:0')`

**Input Size Mismatch:**
- Pre-trained models (ResNet, VGG) expect 224x224 input
- Options: (a) Resize images to 224x224, (b) Use native size with modified architecture
- Document decision and rationale

**Class Imbalance:**
- Use class weights: `class_weight={0: 1.0, 1: 2.5, ...}`
- Or oversample minority classes in data generator
- Monitor per-class metrics, not just overall accuracy

**Overfitting on Small Datasets:**
- Aggressive data augmentation
- Dropout layers in custom head
- Early stopping callback
- Regularization (L2 weight decay)

**Transfer Learning Domain Mismatch:**
- ImageNet features may not transfer well to specialized domains
- Consider domain-specific pre-trained models when available
- Fine-tuning usually improves over frozen-only training

**Computational Requirements:**
- Use mixed precision training: `tf.keras.mixed_precision.set_global_policy('mixed_float16')`
- Gradient checkpointing for very deep models
- Consider cloud GPU for large-scale training

### D.3.4. Validation Strategy for CV Projects

**Why Validation Strategy Matters:**
- Prevents overfitting detection issues
- Ensures reliable performance estimates
- Critical for model selection decisions

**Standard Split (Most Common):**
```python
# Option 1: Use provided test set as holdout
# Training data split for validation during training
from sklearn.model_selection import train_test_split

X_train_full, X_test, y_train_full, y_test = load_data()  # Test = holdout
X_train, X_val, y_train, y_val = train_test_split(
    X_train_full, y_train_full,
    test_size=0.2,
    stratify=y_train_full,  # Maintain class distribution
    random_state=42
)

# Use X_val for validation_data during training
# Use X_test only for final evaluation
```

**Validation Options:**

| Strategy | When to Use | Implementation |
|----------|-------------|----------------|
| **Train/Val/Test Split** | Standard approach, sufficient data | Split training into train+val, keep test as holdout |
| **K-Fold Cross-Validation** | Small datasets, need robust estimates | `sklearn.model_selection.StratifiedKFold` |
| **Validation Split in fit()** | Quick experiments | `model.fit(..., validation_split=0.2)` |
| **Separate Val Set** | When provided by dataset | Use directly |

**Key Principles:**
1. **Never use test set during training** - only for final evaluation
2. **Stratify splits** - maintain class distribution in all subsets
3. **Document your choice** - include in project plan and notebook
4. **Use same split for all experiments** - enables fair comparison

**Validation Strategy Documentation Template:**
```markdown
## Validation Strategy

**Approach:** [Train/Val/Test Split | K-Fold | etc.]

**Data Allocation:**
- Training: X,XXX images (XX%)
- Validation: X,XXX images (XX%)
- Test (Holdout): X,XXX images (XX%)

**Stratification:** Yes/No (maintain class distribution)

**Random Seed:** 42 (for reproducibility)

**Rationale:** [Why this approach was chosen]
```

### D.3.5. CV Project Checklist

**Phase 1 Completion:**
- [ ] Dataset loaded and shapes verified
- [ ] Class distribution analyzed
- [ ] Sample images visualized per class
- [ ] Data quality issues identified (if any)
- [ ] Input size decision documented

**Phase 2 Completion:**
- [ ] Preprocessing pipeline implemented (normalize, resize)
- [ ] Data augmentation configured
- [ ] Validation strategy documented
- [ ] Base model loaded (if transfer learning)
- [ ] Model architecture finalized and compiled

**Phase 3 Completion:**
- [ ] Training completed (all phases)
- [ ] Training curves saved (loss, accuracy)
- [ ] Best model saved/checkpointed
- [ ] Hyperparameters documented

**Phase 4 Completion:**
- [ ] Final test evaluation completed
- [ ] Confusion matrix generated
- [ ] Per-class metrics calculated
- [ ] Grad-CAM visualizations created
- [ ] Results documented with interpretation

---

## D.4. Clustering Projects

### D.4.1. Phase Adaptations

**Phase 1: Exploration**
- Feature distribution analysis
- Correlation analysis
- Dimensionality assessment
- Initial cluster hypothesis

**Phase 2: Feature Engineering**
- Feature scaling (standardization critical for K-Means)
- Dimensionality reduction (PCA, t-SNE for visualization)
- Feature selection (remove highly correlated)
- Domain-specific propensities

**Phase 3: Analysis**
- Algorithm selection (K-Means, Hierarchical, DBSCAN)
- Optimal K selection (elbow, silhouette, business logic)
- Cluster validation (silhouette, Davies-Bouldin, Calinski-Harabasz)
- Cluster interpretation

**Phase 4: Communication**
- Cluster profiles (mean values per cluster)
- Segment personas (business descriptions)
- 2D visualizations (PCA, t-SNE)
- Assignment strategy (hard vs fuzzy)

### D.4.2. Key Techniques

**Optimal K Selection:**
```python
from sklearn.cluster import KMeans
from sklearn.metrics import silhouette_score

scores = []
for k in range(2, 11):
    kmeans = KMeans(n_clusters=k, random_state=42)
    labels = kmeans.fit_predict(X_scaled)
    score = silhouette_score(X_scaled, labels)
    scores.append({'k': k, 'silhouette': score})
    print(f"K={k}: Silhouette={score:.4f}")
```

**Cluster Profiling:**
```python
def profile_clusters(df, cluster_col, features):
    """Create cluster profile summary"""
    profiles = df.groupby(cluster_col)[features].agg(['mean', 'std', 'count'])
    return profiles
```

### D.4.3. Common Challenges

- Determining optimal number of clusters
- Interpreting clusters in business terms
- Handling mixed data types (numeric + categorical)
- Scaling features appropriately
- Validating cluster quality

### D.4.4. TravelTide Example

**Project:** Customer segmentation for personalized rewards program

**Approach:**
- 89 features engineered from booking and user data
- K-Means clustering with K=3 (data-driven pivot from K=5)
- Silhouette score validation (0.38 - moderate separation)
- Fuzzy perk assignment across segments

**Key Decision:** Pivoted from business-requested K=5 to statistical optimum K=3, implemented creative perk distribution strategy.

---

## D.5. Regression/Classification Projects

### D.5.1. Phase Adaptations

**Phase 1: Exploration**
- Target variable distribution
- Class balance (classification)
- Feature-target relationships
- Outlier impact on target

**Phase 2: Feature Engineering**
- Encoding categorical variables (one-hot, target encoding)
- Handling missing values
- Feature interactions
- Polynomial features

**Phase 3: Analysis**
- Model selection: Linear, Tree-based, Ensemble
- Train/validation/test split
- Cross-validation strategy
- Hyperparameter tuning
- Feature importance analysis

**Phase 4: Communication**
- Performance metrics (accuracy, precision, recall, F1, ROC-AUC)
- Feature importance charts
- Prediction examples (correct and incorrect)
- Business impact of predictions

### D.5.2. Key Techniques

**Classification Metrics:**
```python
from sklearn.metrics import classification_report, confusion_matrix, roc_auc_score

def evaluate_classifier(y_true, y_pred, y_pred_proba=None):
    print("Confusion Matrix:")
    print(confusion_matrix(y_true, y_pred))
    print("\nClassification Report:")
    print(classification_report(y_true, y_pred))
    if y_pred_proba is not None:
        auc = roc_auc_score(y_true, y_pred_proba)
        print(f"\nROC-AUC: {auc:.4f}")
```

**Regression Metrics:**
```python
from sklearn.metrics import mean_squared_error, mean_absolute_error, r2_score

def evaluate_regressor(y_true, y_pred):
    mse = mean_squared_error(y_true, y_pred)
    rmse = np.sqrt(mse)
    mae = mean_absolute_error(y_true, y_pred)
    r2 = r2_score(y_true, y_pred)
    
    print(f"RMSE: {rmse:.4f}")
    print(f"MAE: {mae:.4f}")
    print(f"RÂ²: {r2:.4f}")
```

### D.5.3. Common Challenges

- Class imbalance (classification)
- Feature leakage
- Overfitting
- Hyperparameter tuning
- Model interpretability vs accuracy trade-off

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
-e 
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
| Report | `[Project]_[Type]_[Audience].ext` | `TravelTide_Executive_Summary.pdf` |

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

**Example (Real Project):**

```markdown
## DEC-014: Feature Reduction Based on Ablation (45 -> 33 features)

**Date:** 2025-11-18
**Notebook:** s03_d02_MODEL_mlflow-features.ipynb
**Status:** Active

**Context:**
Baseline XGBoost model with 45 engineered features showed RMSE = 7.2127.
Permutation importance analysis revealed some features contributed negligibly or hurt performance.
Need to determine which features to keep for optimal generalization.

**Decision:**
Remove 12 low-value features, retaining 33 high-impact features:

Removed:
- Rolling std (3): unit_sales_7d_std, 14d_std, 30d_std
- Oil features (6): oil_price, oil_price_lag7/14/30, oil_price_change7/14
- Promotion interactions (3): promo_holiday_category, promo_item_avg, promo_cluster

**Rationale:**
Ablation study showed:
- 33-feature model: RMSE = 6.8852 (4.54% improvement)
- Removed features had low permutation importance (<0.01)
- Simpler model reduces overfitting risk
- Correlation analysis: oil features showed r ~ 0.01 (negligible linear relationship)

**Alternatives Considered:**
1. Keep all 45 features - Rejected: Led to overfitting (validation RMSE worse)
2. Remove only oil features (39 total) - Rejected: Still included low-value rolling std
3. More aggressive cuts (25 features) - Rejected: Removed valuable lag features, hurt performance
4. Use L1 regularization instead - Rejected: Feature removal more interpretable than penalization

**Impact:**
- **Scope:** Feature set reduced 27% (45 -> 33)
- **Timeline:** Faster training (marginal, <1 sec difference)
- **Quality:** +4.54% RMSE improvement (7.21 -> 6.89)
- **Interpretability:** Simpler model easier to explain to stakeholders
- **Risk:** Mitigated overfitting, improved generalization

**Validation Plan:**
- Sprint 3 Day 3: Validate on temporal split (Q4+Q1 training)
- Sprint 3 Day 4: Test with LSTM architecture
- Sprint 3 Day 5: Final production validation
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

**Source:** Favorita Demand Forecasting Project
- DEC-012 (Sprint 2): "Include oil price features based on macro correlation"
- DEC-014 (Sprint 3): "Remove oil features based on ablation study"
- The arc from DEC-012 to DEC-014 represents a decision invalidation

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

**Example: Oil Features Invalidation Arc (Favorita)**

```markdown
## DEC-014: Remove Oil Features from Model

**Date:** 2025-12-10
**Status:** Active
**Invalidates:** DEC-012 (Include oil price features)

### Invalidation Context

**Original Decision (DEC-012):**
- Date: 2025-12-05
- Decision: Include 6 oil price features (price, lags, changes)
- Rationale at the time: Ecuador's oil-dependent economy shows macro correlation (r=0.23 at aggregated level)

**New Evidence:**
- Permutation importance: Oil features ranked 40-45 out of 45 (near zero)
- Granular correlation: r ~ 0.01 at store-item-day level
- Ablation study: Removing oil improved RMSE by 3.14%
- Discovered in Sprint 3, Day 2 during feature validation

### Current Decision

**Decision:**
Remove all 6 oil features from the final model.

**Rationale:**
- Simpson's Paradox: Aggregate correlation doesn't hold at granular level
- Oil affects macro economy, not individual product demand
- Features added noise, not signal
- Model performs better without them

### Arc Analysis

**What We Learned:**
Macro-economic correlations rarely translate to granular forecasting. Always validate features at the prediction granularity.

**Was DEC-012 Wrong?**
[ ] Yes - Should have been caught earlier
[X] No - Made sense with available information at the time
[ ] Partially - Some aspects were incorrect

Note: DEC-012 was reasonable given macro correlation. The invalidation came from Sprint 3 validation that wasn't possible until features were engineered.

**Process Improvement:**
Add early granular correlation check in Sprint 2 before committing to feature engineering effort.

### Decision Chain
DEC-012 (Sprint 2) -> [Granular validation failed] -> DEC-014 (Sprint 3)
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
"Continuing [project]. Last completed [X]. Next: [Y]. Review handoff in docs/handoffs/."
```

**Note:** Store in `docs/handoffs/` within the project repository for continuity across sessions.

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

### E.10.4. Sprint Transition Verification Script

**Purpose:** Automated check that sprint is complete before proceeding to next sprint

**When to Run:** End of each sprint, before starting next sprint

**Location:** Create as `verify_sprint[N]_complete.py` in project root

**Template:**

```python
"""
Sprint [N] Completion Verification Script
Project: [Project Name]
Purpose: Verify all deliverables present and valid before Sprint [N+1]
"""

from pathlib import Path
import pandas as pd
import sys

print("=" * 70)
print(f"Sprint [N] Completion Verification")
print("=" * 70)

# Track errors
errors = []
warnings = []

# ============================================================================
# Check 1: Required Files Exist
# ============================================================================
print("\nCheck 1: Required Files")
print("-" * 70)

required_files = [
    'data/processed/sprint[N]_final_dataset.pkl',
    'docs/feature_dictionary_v[N].txt',
    'docs/checkpoints/s0[N]_d05_checkpoint.md',
    'docs/Sprint[N]_to_Sprint[N+1]_Handoff.md'
]

missing = []
for file_path in required_files:
    if not Path(file_path).exists():
        missing.append(file_path)
        errors.append(f"Missing required file: {file_path}")
    else:
        print(f"  OK: {file_path}")

if missing:
    print(f"\n  ERROR: {len(missing)} required files missing")
else:
    print("  OK: All required files present")

# ============================================================================
# Check 2: Dataset Quality
# ============================================================================
print("\nCheck 2: Dataset Quality")
print("-" * 70)

try:
    df = pd.read_pickle('data/processed/sprint[N]_final_dataset.pkl')

    # Expected shape
    expected_rows = 300896  # Adjust for your project
    expected_cols_min = 28  # Minimum expected

    actual_rows, actual_cols = df.shape

    print(f"  Shape: {actual_rows:,} rows x {actual_cols} columns")

    # Validate shape
    if actual_rows != expected_rows:
        warnings.append(f"Row count mismatch: {actual_rows:,} (expected {expected_rows:,})")
        print(f"  WARNING: Row count differs from expected")
    else:
        print(f"  OK: Row count matches expected")

    if actual_cols < expected_cols_min:
        errors.append(f"Too few columns: {actual_cols} (expected >={expected_cols_min})")
        print(f"  ERROR: Column count below minimum")
    else:
        print(f"  OK: Column count acceptable")

    # Check target variable
    target_col = 'unit_sales'  # Adjust for your project
    if target_col not in df.columns:
        errors.append(f"Target variable '{target_col}' not found")
        print(f"  ERROR: Target variable missing")
    else:
        target_nulls = df[target_col].isnull().sum()
        print(f"  OK: Target variable present")
        print(f"    Missing values: {target_nulls} ({target_nulls/len(df)*100:.2f}%)")

        if target_nulls > 0:
            errors.append(f"Target has {target_nulls} missing values")

    # Check date range (if applicable)
    if 'date' in df.columns:
        date_min = df['date'].min()
        date_max = df['date'].max()
        print(f"  OK: Date range: {date_min.date()} to {date_max.date()}")

except Exception as e:
    errors.append(f"Failed to load dataset: {str(e)}")
    print(f"  ERROR: Cannot load dataset")

# ============================================================================
# Check 3: Documentation Complete
# ============================================================================
print("\nCheck 3: Documentation Completeness")
print("-" * 70)

try:
    # Check checkpoint has no incomplete items
    checkpoint_path = Path('docs/checkpoints/s0[N]_d05_checkpoint.md')
    if checkpoint_path.exists():
        checkpoint_text = checkpoint_path.read_text()

        # Look for incomplete checklist items
        incomplete_items = checkpoint_text.count('[ ]')
        if incomplete_items > 0:
            warnings.append(f"Checkpoint has {incomplete_items} incomplete items")
            print(f"  WARNING: {incomplete_items} incomplete checklist items")
        else:
            print(f"  OK: All checklist items complete")

    # Check handoff document exists and has key sections
    handoff_path = Path('docs/Sprint[N]_to_Sprint[N+1]_Handoff.md')
    if handoff_path.exists():
        handoff_text = handoff_path.read_text()
        required_sections = [
            'Executive Summary',
            'Deliverables',
            'Next Sprint Starting Point',
            'Quick Start Code'
        ]

        missing_sections = []
        for section in required_sections:
            if section not in handoff_text:
                missing_sections.append(section)

        if missing_sections:
            warnings.append(f"Handoff missing sections: {missing_sections}")
            print(f"  WARNING: Missing handoff sections: {', '.join(missing_sections)}")
        else:
            print(f"  OK: Handoff document complete")

except Exception as e:
    warnings.append(f"Documentation check failed: {str(e)}")

# ============================================================================
# Summary
# ============================================================================
print("\n" + "=" * 70)
print("Verification Summary")
print("=" * 70)

if errors:
    print(f"\nERRORS ({len(errors)}):")
    for i, error in enumerate(errors, 1):
        print(f"  {i}. {error}")

if warnings:
    print(f"\nWARNINGS ({len(warnings)}):")
    for i, warning in enumerate(warnings, 1):
        print(f"  {i}. {warning}")

if not errors and not warnings:
    print("\nOK: All checks passed - Sprint [N] complete!")
    print(f"OK: Ready to proceed to Sprint [N+1]")
    sys.exit(0)
elif not errors:
    print(f"\nWARNING: Sprint [N] complete with {len(warnings)} warnings")
    print(f"WARNING: Review warnings before proceeding to Sprint [N+1]")
    sys.exit(0)
else:
    print(f"\nERROR: Sprint [N] verification FAILED")
    print(f"ERROR: Fix {len(errors)} errors before proceeding")
    sys.exit(1)
```

**Usage:**

```bash
# At end of Sprint 1
python verify_sprint1_complete.py

# Expected output:
# ==================================================================
# Sprint 1 Completion Verification
# ==================================================================
#
# Check 1: Required Files
# ----------------------------------------------------------------------
#   OK: data/processed/sprint1_final_dataset.pkl
#   OK: docs/feature_dictionary_v1.txt
#   OK: docs/checkpoints/s01_d05_checkpoint.md
#   OK: docs/Sprint1_to_Sprint2_Handoff.md
#   OK: All required files present
#
# Check 2: Dataset Quality
# ----------------------------------------------------------------------
#   Shape: 300,896 rows x 28 columns
#   OK: Row count matches expected
#   OK: Column count acceptable
#   OK: Target variable present
#     Missing values: 0 (0.00%)
#   OK: Date range: 2013-01-02 to 2017-08-15
#
# Check 3: Documentation Completeness
# ----------------------------------------------------------------------
#   OK: All checklist items complete
#   OK: Handoff document complete
#
# ==================================================================
# Verification Summary
# ==================================================================
#
# OK: All checks passed - Sprint 1 complete!
# OK: Ready to proceed to Sprint 2
```

**Benefits:**
- Catches incomplete work before sprint transition
- Automated vs manual checklist review (faster, less error-prone)
- Clear pass/fail criteria
- Documents exact state at handoff
- Prevents starting next sprint with missing prerequisites

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
└── docs/
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
of `docs/feedback/methodology.md` rather than a separate file. The template
below is retained as reference for the scoring format.

### E.12.2. Template Structure (Reference)

**File Location:** `docs/feedback/methodology.md` (integrated with project methodology record)

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
- **DSM Reference:** DSM_0.2 (Untrusted Input Protocol), DSM 4.0 Section 10

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
- **DSM Reference:** DSM 4.0 Section 10

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
- **DSM Reference:** DSM 4.0 Section 10

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
- **DSM Reference:** DSM_0.2 (Untrusted Input Protocol), DSM 4.0 Section 10

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
