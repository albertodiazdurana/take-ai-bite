Guide the user through the DSM Version Update Workflow.

**Audience (BL-236e):** Run only in DSM Central. This skill versions the DSM methodology itself; standalone TAB and other spokes consume DSM versions but do not author them.

**Early-stop:** If no `DSM_0.0_*.md` file exists in the current working directory, refuse with: `"Run only in DSM Central; this skill versions DSM methodology files which are absent here."` Do not proceed.

**Heuristic limitation (documented):** The early-stop catches non-mirror spokes but does NOT catch mirror clones (e.g., TAB) that have a synced `DSM_0.0_*.md` copy. The Audience note above is the primary guard; user attentiveness is the backstop. If a misclick on a mirror clone becomes a recurring issue, file a follow-up BL to add a stronger `scripts/take-ai-bite-sync.txt`-based check (BL-236e narrowed scope chose option (a), accept + document, per Tier-2 protocol T2b finding).

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

### Step 4b: Mirror Release Tag to Mirror Repos (BL-376)

**Temporal ordering:** This sub-step runs AFTER CLAUDE.md Version Update Workflow Step 9 (Mirror sync) has completed for all mirrors. Do not push the tag before the file sync has landed on the mirror's `main`; the tag must reference the sync commit, not a stale pre-sync commit.

**Semantic note (tag points to sync commit, not release commit):** A `vX.Y.Z` tag on a mirror points to that mirror's sync commit at the time of this release, not to Central's release commit. Mirror commit history is separate; the tag means "mirror at the sync point that mirrors Central vX.Y.Z", not "mirror at Central's vX.Y.Z commit". Users should not expect 1:1 commit alignment across Central and its mirrors.

For each entry in `.claude/dsm-ecosystem.md` with `Mirror = true`:

1. Resolve `{mirror-path}` from the ecosystem registry.
2. Verify the Step 9 file sync landed on the mirror's `main`. If sync failed or was skipped earlier for this mirror, **do NOT push a tag**; warn and skip this mirror (prevents tagging a stale pre-sync commit).
3. Check whether `vX.Y.Z` already exists on the mirror:
   `git -C {mirror-path} rev-parse --verify refs/tags/vX.Y.Z 2>/dev/null`
   If it exists, **do NOT overwrite**. Report: "Tag vX.Y.Z already exists on {mirror-name} at {sha}. Will not overwrite. Resolve manually, then re-run tag push." Skip this mirror.
4. Create and push the tag:
   `git -C {mirror-path} tag vX.Y.Z && git -C {mirror-path} push origin vX.Y.Z`
5. If push fails (auth, network, branch protection on tags), report the failure loudly. Do NOT revert the file sync; the mirror ends up at the new content without the tag. Recovery: fix auth/network/protection, then re-run Step 4b for the affected mirror.

**Skip conditions (report and continue):**
- Ecosystem registry has no `Mirror = true` entries: report "No mirror repos configured; skipping tag-mirror step."
- Step 9 file sync failed or was not run for a specific mirror: skip that mirror only.

**Not in scope (BL-376):**
- `/dsm-wrap-up` silent-drift mirror sync does NOT trigger this sub-step; tag push fires only at version-bump events.
- Backfill of historical Central tags onto mirrors is out of scope; CHANGELOG is the history record.

**Why here and not in CLAUDE.md Step 9:** Step 9 is invoked by both `/dsm-version-update` (version releases) and `/dsm-wrap-up` (silent-drift sync between releases). Tag push must fire only at version-release events; placing the tag logic in Step 4b of this skill satisfies that constraint structurally rather than via a conditional inside Step 9.

## Policy Reference

Per DSM_2.0 version bump cadence: batch per session, one bump per session, 3+ improvements = patch bump.
