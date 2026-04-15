@../DSM_0.2_Custom_Instructions_v1.1.md

<!-- BEGIN DSM_0.2 ALIGNMENT -->
## 1. DSM_0.2 Alignment (managed by /dsm-align)

**Project type:** Documentation / DSM Sample (standalone)
**Participation pattern:** Self-contained (no external DSM Central; methodology docs live at repo root)
**Version:** (resolved from this repo's DSM_0.2 docs)
**Alignment run:** 2026-04-15 (inline scaffold, not via full /dsm-align)

<!-- END DSM_0.2 ALIGNMENT -->

## 2. Project-specific

`take-ai-bite` is the public, self-contained DSM sample. Unlike a normal spoke, it ships the DSM methodology documents at the repo root rather than loading them from an external DSM Central. The `@` reference above points to the local `DSM_0.2_Custom_Instructions_v1.1.md`.

Cross-repo operations that assume an external DSM Central (feedback push to `{dsm-central}/_inbox/`, hook install from `{dsm-central}/.claude/hooks/`, version marker from `{dsm-central}/CHANGELOG.md`) do not apply to this project — they should either resolve to the local repo or be skipped.

## 3. Participation pattern

Standalone sample repo. Sessions run fully local. Feedback captured in `dsm-docs/feedback-to-dsm/` is retained here for the maintainer to review and upstream manually.

## 4. Branching

Three-level branching (`main` → `session-N/YYYY-MM-DD` → `bl-*` / `sprint-*`) applies
for structure, but this repo **never merges branches to `main`**. Every branch is:

1. Committed locally,
2. Pushed to `origin`,
3. Opened as a PR against `main`.

The PR diff is the review package for DSM Central maintainers. `main` stays aligned
with the upstream clone baseline; per-session / per-BL branches accumulate as open
(or closed-without-merge) review PRs. This overrides generic DSM_0.2 §20.2 and §20.3
merge rules for this repo (project-specific precedence, §17).
