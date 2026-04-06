Guide the user through the DSM Version Update Workflow.

## Prerequisites

Before starting, verify there are uncommitted changes that warrant a version bump. Check `git status` and `git log` to understand what changed.

## Version Update Steps

Walk through each step, showing the user what to do and waiting for confirmation before proceeding:

### Step 1: Determine Version Number
- Read current version from `DSM_0.0_START_HERE_Complete_Guide.md` header
- Suggest next patch version (e.g., 1.3.21 -> 1.3.22)
- Ask user to confirm or specify different version

### Step 2: Update CHANGELOG.md
- Add new version entry at the top (after the header)
- Follow Keep a Changelog format with Added/Changed/Deprecated/Removed/Fixed sections
- Reference BACKLOG-### numbers for implemented items

### Step 2b: Update FEATURES.md (if applicable)
- For each new CHANGELOG entry, assess: **Is this a user-facing capability?**
  - New protocol or feature → Yes (add F-entry)
  - New command or skill → Yes (add F-entry)
  - Template or format change with user-visible impact → Yes
  - Internal refactor, rename, audit → No (skip)
  - Bug fix with user-visible impact → Judgment call
- If yes, add entry to `FEATURES.md`:
  - Format: `- **F-NNN (YYYY-MM-DD) Short title** — One-sentence benefit-focused description.`
  - Assign next F-number (increment from current highest)
  - Add entry at the top of the current month section (create month section if needed)
  - Update the "Current count" in the FEATURES.md header
- New F-entries trigger blog-poster notification at wrap-up (DSM_0.2.A §2)

### Step 3: Update DSM_0
- Update version number and date in the header
- Update line counts if significant additions were made
- Update document descriptions if new sections were added

### Step 4: Commit and Tag
- Stage changed files (CHANGELOG, README, DSM_0, plus any methodology changes)
- Commit with descriptive message (no co-author line)
- Create git tag: `git tag vX.Y.Z`
- Remind user to push: `git push && git push --tags`

## Policy Reference

Per DSM_2.0 version bump cadence: batch per session, one bump per session, 3+ improvements = patch bump.
