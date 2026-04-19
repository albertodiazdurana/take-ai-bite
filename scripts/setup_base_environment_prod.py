"""
Generic Base Environment Setup for Data Science Projects (With Progress Display)
==================================================================================

This script creates a universal Python virtual environment for any data science project.
It installs core packages needed across all domains and configures VS Code.

Version: 2.0 (Shows installation progress)

Usage:
    python setup_base_environment.py

After running:
    1. Open VS Code in project folder
    2. Select interpreter: .venv
    3. Select Jupyter kernel: project_base_kernel
    4. Run domain-specific extension script if needed (generated based on project requirements)

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

# Base packages: Universal for ALL data science projects
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
    
    # Code quality and formatting
    "black",
    "flake8",
    "isort",
    "autopep8",
]

# VS Code settings optimized for data science work
VSCODE_SETTINGS = {
    # Python interpreter
    "python.terminal.activateEnvironment": True,
    "python.defaultInterpreterPath": f"{VENV_NAME}/bin/python" if platform.system() != "Windows" else f"{VENV_NAME}\\Scripts\\python.exe",
    
    # Jupyter settings
    "jupyter.disableJupyterAutoStart": True,
    "jupyter.jupyterServerType": "local",
    "jupyter.askForKernelRestart": True,
    "jupyter.notebookFileRoot": "${workspaceFolder}",
    
    # Data Wrangler (disabled by default, enable manually if needed)
    "datawrangler.autoLoad": False,
    "datawrangler.enable": False,
    
    # Python formatting
    "python.formatting.provider": "black",
    "editor.formatOnSave": True,
    
    # Linting
    "python.linting.enabled": True,
    "python.linting.flake8Enabled": True,
    
    # Import sorting
    "python.sortImports.args": ["--profile", "black"],
    "editor.codeActionsOnSave": {
        "source.organizeImports": True
    },
    
    # Editor settings
    "editor.wordWrap": "on",
    "notebook.output.textLineLimit": 200,
    "editor.quickSuggestionsDelay": 50,
    
    # Terminal (Windows default)
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
    """Run command with minimal output (for quick operations)"""
    try:
        subprocess.check_call(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        print(f"OK: {description}")
        return True
    except subprocess.CalledProcessError as e:
        print(f"ERROR: {description} failed")
        print(f"Command: {' '.join(command)}")
        return False

def run_command_visible(command, description):
    """Run command with visible output (for package installation)"""
    try:
        print(f"\n{description}...")
        print(f"Command: {' '.join(command)}\n")
        # Show output in real-time
        subprocess.check_call(command)
        print(f"\nOK: {description} completed")
        return True
    except subprocess.CalledProcessError as e:
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
    
    print_section("Generic Base Environment Setup v2.0")
    print(f"Platform: {platform.system()}")
    print(f"Python: {sys.version}")
    print(f"\nThis will take 5-10 minutes for first-time installation.")
    print(f"You will see progress output for each step.\n")
    
    # Step 1: Create virtual environment
    print_step(1, total_steps, "Creating Virtual Environment")
    
    if os.path.exists(VENV_NAME):
        print(f"WARNING: Virtual environment '{VENV_NAME}' already exists")
        response = input("Continue anyway? (y/n): ").lower()
        if response != 'y':
            print("Setup cancelled")
            return
    else:
        if not run_command_silent(
            [sys.executable, "-m", "venv", VENV_NAME],
            f"Creating virtual environment '{VENV_NAME}'"
        ):
            return
    
    venv_python = get_venv_python()
    
    if not os.path.exists(venv_python):
        print(f"ERROR: Python executable not found at {venv_python}")
        return
    
    print(f"Virtual environment created: {venv_python}")
    
    # Step 2: Upgrade pip
    print_step(2, total_steps, "Upgrading pip")
    print("This ensures you have the latest package installer...\n")
    
    run_command_visible(
        [venv_python, "-m", "pip", "install", "--upgrade", "pip"],
        "Upgrading pip"
    )
    
    # Step 3: Install base packages (WITH PROGRESS)
    print_step(3, total_steps, "Installing Base Packages")
    print(f"Installing: {', '.join(BASE_PACKAGES)}")
    print("\nThis is the longest step - downloading ~500MB of packages + dependencies")
    print("You will see pip's progress bars below:")
    
    if not run_command_visible(
        [venv_python, "-m", "pip", "install"] + BASE_PACKAGES,
        "Installing base packages"
    ):
        print("WARNING: Some packages may have failed to install")
        print("Check error messages above")
    
    # Step 4: Register Jupyter kernel
    print_step(4, total_steps, "Registering Jupyter Kernel")
    
    run_command_silent(
        [
            venv_python, "-m", "ipykernel", "install",
            "--user", "--name", KERNEL_NAME, 
            "--display-name", f"Python ({KERNEL_NAME})"
        ],
        f"Registering Jupyter kernel '{KERNEL_NAME}'"
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
            f.write("# Base environment packages\n")
            f.write("# Generated by setup_base_environment.py\n\n")
            f.write(result.stdout)
        
        # Count packages
        package_count = len([line for line in result.stdout.split('\n') if line and not line.startswith('#')])
        print(f"OK: requirements_base.txt created ({package_count} packages)")
        
    except subprocess.CalledProcessError as e:
        print(f"ERROR: Failed to generate requirements.txt: {e}")
    
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
            print("Found existing settings.json - merging with new settings")
        except json.JSONDecodeError:
            print("WARNING: Existing settings.json is invalid, will be replaced")
    
    # Merge settings (new settings take precedence)
    merged_settings = {**existing_settings, **VSCODE_SETTINGS}
    
    with open(settings_file, "w") as f:
        f.write("// VS Code Settings - Generated by setup_base_environment.py\n")
        f.write("// See Methodology Phase 0 for configuration details\n\n")
        json.dump(merged_settings, f, indent=4)
    
    print(f"OK: VS Code settings configured at {settings_file}")
    
    # Final summary
    print_section("Setup Complete!")
    
    print("\nEnvironment successfully created:")
    print(f"  Virtual environment: {VENV_NAME}")
    print(f"  Jupyter kernel: {KERNEL_NAME}")
    print(f"  Base packages: {len(BASE_PACKAGES)} installed")
    print(f"  Total packages: {package_count} (including dependencies)")
    print(f"  Requirements: requirements_base.txt")
    print(f"  VS Code config: .vscode/settings.json")
    
    print("\nNext steps:")
    print("  1. Open VS Code in this project folder")
    print("  2. Press Ctrl+Shift+P -> 'Python: Select Interpreter'")
    print(f"  3. Choose: {VENV_NAME}")
    print("  4. In notebooks, select kernel: Python ({KERNEL_NAME})")
    print("  5. Review project documentation for domain-specific packages")
    print("  6. Generate and run domain extension script if needed")
    
    print("\nRecommended VS Code Extensions:")
    print("  - ms-python.python (Python)")
    print("  - ms-toolsai.jupyter (Jupyter)")
    print("  - ms-python.black-formatter (Black Formatter)")
    print("  - njpwerner.autodocstring (autoDocstring)")
    print("  - ms-python.flake8 (Flake8)")
    
    print("\nVerify installation:")
    print("  Run: python -c \"import pandas, numpy, matplotlib, jupyter; print('OK')\"")
    
    print("\n" + "="*60)

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\n\nSetup interrupted by user")
        print("You can safely re-run the script to continue")
        sys.exit(1)
    except Exception as e:
        print(f"\nERROR: Unexpected error occurred: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)