"""
Minimal Base Environment Setup for Data Science Projects
=========================================================

This script creates a minimal Python virtual environment with only essential packages.
NO code formatting or linting tools - pure data science focus.

Usage:
    python setup_base_environment_minimal.py
    python3 setup_base_environment_minimal.py (in ubuntu/macOS)

To activate the environment:
    Windows:
        .venv\Scripts\activate
    macOS/Linux:
        source .venv/bin/activate

After running:
    1. Open VS Code in project folder
    2. Select interpreter: .venv
    3. Select Jupyter kernel: project_base_kernel
    4. Run domain-specific extension script if needed

Cross-platform: Works on Windows, macOS, and Linux
"""

import os
import sys
import json
import subprocess
import platform
from pathlib import Path

# ================== CONFIGURATION ==================

VENV_NAME = ".venv"
KERNEL_NAME = "project_base_kernel"

# MINIMAL base packages: Only essential data science tools
BASE_PACKAGES = [
    # Jupyter ecosystem
    "jupyter",
    "ipykernel",
    
    # Core data science
    "pandas",
    "numpy",
    
    # Visualization
    "matplotlib",
    "seaborn",
]

# VS Code settings - MINIMAL (no formatting/linting)
VSCODE_SETTINGS = {
    # Python interpreter
    "python.terminal.activateEnvironment": True,
    "python.defaultInterpreterPath": f"{VENV_NAME}/bin/python" if platform.system() != "Windows" else f"{VENV_NAME}\\Scripts\\python.exe",
    
    # Jupyter settings
    "jupyter.disableJupyterAutoStart": True,
    "jupyter.jupyterServerType": "local",
    "jupyter.askForKernelRestart": True,
    "jupyter.notebookFileRoot": "${workspaceFolder}",
    
    # Data Wrangler (disabled by default)
    "datawrangler.autoLoad": False,
    "datawrangler.enable": False,
    
    # Editor settings
    "editor.wordWrap": "on",
    "notebook.output.textLineLimit": 200,
    
    # Terminal
    "terminal.integrated.defaultProfile.windows": "PowerShell",
}

# ================== UTILITY FUNCTIONS ==================

def print_section(title):
    """Print formatted section header"""
    print(f"\n{'='*60}")
    print(f"  {title}")
    print(f"{'='*60}")

def print_step(step_num, total_steps, description):
    """Print step progress"""
    print(f"\n[Step {step_num}/{total_steps}] {description}")
    print("-" * 60)

def run_command_silent(command, description):
    """Run command with minimal output"""
    try:
        subprocess.check_call(
            command, 
            stdout=subprocess.PIPE, 
            stderr=subprocess.PIPE
        )
        print(f"OK: {description}")
        return True
    except subprocess.CalledProcessError:
        print(f"ERROR: {description} failed")
        return False

def run_command_visible(command, description):
    """Run command with visible output"""
    try:
        print(f"\n{description}...")
        subprocess.check_call(command)
        print(f"\nOK: {description} completed")
        return True
    except subprocess.CalledProcessError:
        print(f"\nERROR: {description} failed")
        return False

def get_venv_python():
    """Get path to Python executable in virtual environment"""
    if platform.system() == "Windows":
        return os.path.join(VENV_NAME, "Scripts", "python.exe")
    else:
        return os.path.join(VENV_NAME, "bin", "python")

# ================== MAIN SETUP ==================

def main():
    total_steps = 6
    
    print_section("Minimal Base Environment Setup")
    print(f"Platform: {platform.system()}")
    print(f"Python: {sys.version}")
    print(f"\nInstalling ONLY essential data science packages")
    print(f"NO formatting or linting tools included")
    print(f"\nThis will take 3-5 minutes.\n")
    
    # Step 1: Create virtual environment
    print_step(1, total_steps, "Creating Virtual Environment")
    
    if os.path.exists(VENV_NAME):
        print(f"WARNING: '{VENV_NAME}' already exists")
        response = input("Continue? (y/n): ").lower()
        if response != 'y':
            print("Setup cancelled")
            return
    else:
        if not run_command_silent(
            [sys.executable, "-m", "venv", VENV_NAME],
            f"Creating '{VENV_NAME}'"
        ):
            return
    
    venv_python = get_venv_python()
    
    if not os.path.exists(venv_python):
        print(f"ERROR: Python not found at {venv_python}")
        return
    
    print(f"Virtual environment: {venv_python}")
    
    # Step 2: Upgrade pip
    print_step(2, total_steps, "Upgrading pip")
    
    run_command_visible(
        [venv_python, "-m", "pip", "install", "--upgrade", "pip"],
        "Upgrading pip"
    )
    
    # Step 3: Install minimal base packages
    print_step(3, total_steps, "Installing Essential Packages")
    print(f"Packages: {', '.join(BASE_PACKAGES)}")
    print("\nYou will see pip progress below:")
    
    if not run_command_visible(
        [venv_python, "-m", "pip", "install"] + BASE_PACKAGES,
        "Installing packages"
    ):
        print("WARNING: Some packages may have failed")
    
    # Step 4: Register Jupyter kernel
    print_step(4, total_steps, "Registering Jupyter Kernel")
    
    run_command_silent(
        [
            venv_python, "-m", "ipykernel", "install",
            "--user", "--name", KERNEL_NAME, 
            "--display-name", f"Python ({KERNEL_NAME})"
        ],
        f"Registering kernel '{KERNEL_NAME}'"
    )
    
    # Step 5: Generate requirements.txt
    print_step(5, total_steps, "Generating requirements.txt")
    
    try:
        result = subprocess.run(
            [venv_python, "-m", "pip", "freeze"],
            capture_output=True,
            text=True,
            check=True
        )
        
        with open("requirements_base.txt", "w") as f:
            f.write("# Minimal base environment\n")
            f.write("# Generated by setup_base_environment_minimal.py\n")
            f.write("# No formatting/linting tools included\n\n")
            f.write(result.stdout)
        
        pkg_count = len([
            line for line in result.stdout.split('\n') 
            if line and not line.startswith('#')
        ])
        print(f"OK: requirements_base.txt created ({pkg_count} packages)")
        
    except subprocess.CalledProcessError as e:
        print(f"ERROR: Failed to generate requirements.txt")
    
    # Step 6: Create VS Code settings
    print_step(6, total_steps, "Configuring VS Code")
    
    vscode_folder = Path(".vscode")
    vscode_folder.mkdir(exist_ok=True)
    
    settings_file = vscode_folder / "settings.json"
    
    # Read existing settings if present
    existing_settings = {}
    if settings_file.exists():
        try:
            with open(settings_file, "r") as f:
                existing_settings = json.load(f)
            print("Merging with existing settings.json")
        except json.JSONDecodeError:
            print("WARNING: Existing settings.json invalid, replacing")
    
    # Merge settings
    merged_settings = {**existing_settings, **VSCODE_SETTINGS}
    
    with open(settings_file, "w") as f:
        f.write("// Minimal VS Code Settings\n")
        f.write("// No formatting/linting configured\n\n")
        json.dump(merged_settings, f, indent=4)
    
    print(f"OK: VS Code settings at {settings_file}")
    
    # Final summary
    print_section("Setup Complete!")
    
    print("\nMinimal environment created:")
    print(f"  Virtual environment: {VENV_NAME}")
    print(f"  Jupyter kernel: {KERNEL_NAME}")
    print(f"  Packages installed: {len(BASE_PACKAGES)} (core only)")
    print(f"  Requirements: requirements_base.txt")
    print(f"  VS Code config: .vscode/settings.json")
    
    print("\nWhat's INCLUDED:")
    print("  - Jupyter notebooks")
    print("  - Pandas, NumPy (data analysis)")
    print("  - Matplotlib, Seaborn (visualization)")
    
    print("\nWhat's NOT included:")
    print("  - Black (code formatter)")
    print("  - Flake8 (linter)")
    print("  - isort, autopep8 (formatters)")
    
    print("\nNext steps:")
    print("  1. Open VS Code in this folder")
    print("  2. Ctrl+Shift+P -> 'Python: Select Interpreter'")
    print(f"  3. Choose: {VENV_NAME}")
    print("  4. In notebooks: Python ({KERNEL_NAME})")
    print("  5. Generate domain extension script if needed")
    
    print("\nRecommended VS Code Extensions:")
    print("  - ms-python.python (Python support)")
    print("  - ms-toolsai.jupyter (Jupyter notebooks)")
    
    print("\nVerify installation:")
    activate_cmd = ".venv\\Scripts\\activate" if platform.system() == "Windows" else "source .venv/bin/activate"
    print(f"  {activate_cmd}")
    print('  python -c "import pandas, numpy, matplotlib; print(\'OK\')"')
    
    print("\n" + "="*60)

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\n\nSetup interrupted")
        print("Re-run script to continue")
        sys.exit(1)
    except Exception as e:
        print(f"\nERROR: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)
