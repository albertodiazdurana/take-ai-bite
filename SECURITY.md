# Security Policy

## Scope

This repository contains documentation, templates, and methodology frameworks for data science projects. It does not contain executable applications or services that directly process user data.

## What This Repository Contains

- Markdown documentation files
- Python setup scripts (for environment configuration)
- Jupyter notebook templates
- Project management templates
- Methodology guidelines

## Security Considerations for Users

### When Using This Methodology

**Data Privacy:**
- WARNING: Never commit sensitive data to version control
- Review `.gitignore` to ensure data files are excluded
- Use environment variables for credentials, never hardcode
- Follow your organization's data governance policies

**AI Agent Interaction:**
- WARNING: Do not share proprietary or sensitive data in AI agent conversations
- Use AI agent projects with appropriate access controls
- Review your AI provider's data usage policies before uploading project knowledge
- Consider enterprise AI solutions for sensitive work

**Code Execution:**
- Review all generated code before execution
- Test in isolated environments first
- Validate data transformations thoroughly
- Follow secure coding practices in your implementations

### Environment Setup Scripts

The repository includes Python environment setup scripts:
- `scripts/setup_base_environment_prod.py`
- `scripts/setup_base_environment_minimal.py`

**Before Running:**
- Review script contents
- Ensure you trust the package sources
- Use virtual environments
- Keep packages updated for security patches

## Reporting Vulnerabilities

### What to Report

Please report if you discover:
- Security issues in example code or setup scripts
- Documentation that could lead to insecure practices
- Vulnerabilities in recommended packages or tools
- Privacy concerns in methodology recommendations

### What NOT to Report

Do NOT report:
- General methodology suggestions (use Issues instead)
- Documentation typos (use Pull Requests)
- Feature requests (use Issues)

### How to Report

**For Security Issues:**

1. **Do NOT** open a public issue
2. Contact repository maintainer privately via GitHub Security Advisories
3. Include:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if known)

**Response Timeline:**
- Initial acknowledgment: Within 48 hours
- Status update: Within 7 days
- Resolution target: Based on severity (critical: 48h, high: 7d, medium: 30d)

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 1.0.x   | :white_check_mark: |
| < 1.0   | :x:                |

## Security Best Practices

### For Data Science Projects

**1. Data Management**
```python
# OK: Use environment variables
import os
db_password = os.getenv('DB_PASSWORD')

# ERROR: Never hardcode credentials
db_password = 'my_secret_password'  # NEVER DO THIS
```

**2. File Handling**
```python
# OK: Validate file paths
from pathlib import Path
safe_path = Path('/project/data').resolve()

# WARNING: Be cautious with user inputs
# Validate and sanitize before using in file operations
```

**3. Model Serialization**
```python
# WARNING: Only load models from trusted sources
# Pickle files can execute arbitrary code
import joblib
model = joblib.load('trusted_model.pkl')  # Verify source first
```

### For AI Agent Integration

**Project Knowledge:**
- Only upload non-sensitive documentation
- Review all files before uploading
- Remove proprietary information
- Consider data classification policies

**Custom Instructions:**
- Avoid including credentials or API keys
- Keep business logic general, not implementation-specific
- Review what information persists across conversations

**Generated Code:**
- Review all generated code before execution
- Test in development environment first
- Validate data transformations
- Check for hardcoded values

## Dependencies

### Python Packages

The methodology recommends various Python packages. Users should:
- Keep packages updated: `pip list --outdated`
- Review security advisories: `pip-audit` or `safety check`
- Use virtual environments to isolate dependencies
- Pin versions in production: `requirements.txt`

### Recommended Security Tools

For projects using this methodology:
- `pip-audit` - Check for vulnerabilities in Python packages
- `bandit` - Python code security scanner
- `safety` - Check dependencies for known vulnerabilities
- `pre-commit` - Git hooks for security checks

## Compliance Considerations

### Academic Use
- Follow your institution's data policies
- Respect research ethics requirements
- Maintain data privacy standards
- Document data sources and permissions

### Industry Use
- Comply with GDPR, CCPA, or relevant regulations
- Follow organizational security policies
- Implement appropriate access controls
- Maintain audit trails

### Sensitive Data
- Use production PM Guidelines with governance section
- Implement ethics & bias review (Advanced Practice)
- Follow data versioning and lineage practices
- Maintain risk register

## Disclaimer

This methodology framework is provided "as is" without warranty. Users are responsible for:
- Implementing appropriate security measures
- Complying with applicable laws and regulations
- Protecting sensitive data
- Validating all generated code and recommendations

## Resources

**General Security:**
- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [Python Security Best Practices](https://python.readthedocs.io/en/stable/library/security_warnings.html)

**Data Science Specific:**
- [Secure Machine Learning](https://github.com/EthicalML/awesome-production-machine-learning#privacy-preserving-machine-learning)
- [AI Security Best Practices](https://github.com/commaai/openpilot/blob/master/docs/SECURITY.md)

**AI Provider Security:**
- Review your AI provider's security and privacy policies
- Understand data retention and usage terms before uploading project knowledge

---

Last Updated: November 13, 2025

For questions about this security policy, please open an issue or contact maintainers.
