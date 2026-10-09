Bootstrap an uninitialized directory as a new DSM spoke of an existing hub. Scaffolds the canonical dsm-docs/ + _inbox/ structure, registers the hub as dsm-central (NOT self-registering), and runs the spoke /dsm-align path. Distinct from /dsm-go's Cloned-Mirror Kick-off, which self-registers a cloned mirror as its own hub and copies .claude/*.template files. $ARGUMENTS

## When to use

Use this skill when you have a fresh or uninitialized directory that should become a **new DSM spoke** of an existing hub. `/dsm-go` in such a directory offers only the Cloned-Mirror Kick-off path (Step 0.8), which does not fit a new spoke: Kick-off *self-registers* the directory as its own `dsm-central` and copies `.claude/*.template` files that a hand-created spoke does not have. This skill instead registers the **existing hub** as `dsm-central` and reuses the spoke `/dsm-align` scaffold path.

**Do NOT use this skill when:**

- The directory is a **cloned DSM mirror** (it ships `scripts/`, `.claude/*.template` files, and `scripts/take-ai-bite-sync.txt`). Run `/dsm-go` instead; its Step 0.8 Kick-off handles that case.
- The directory is **already a spoke** (`.claude/dsm-ecosystem.md` exists with `dsm-central` pointing at a hub). Run `/dsm-go`.

The spoke-vs-mirror choice is a **user intent, not a directory property** (an uninitialized spoke dir and a generic pre-Kick-off state both present as "no ecosystem file"), which is why this is a dedicated skill rather than a `/dsm-go` Step 0.8 auto-detection branch: the invocation is the intent signal. See DSM_0.2.A §25.7 and BACKLOG-578.

## Arguments

`/dsm-new-spoke <hub-path>` — `<hub-path>` is the filesystem path to the existing DSM hub (the `dsm-central` root, i.e. the directory that contains `DSM_0.2_Custom_Instructions_v1.1.md`). If omitted, the skill prompts for it.

## Steps

1. **Resolve and validate the hub path.**
   - If `$ARGUMENTS` contains a path, use its first token as `{HUB}`. Otherwise prompt: "Path to the existing DSM hub (the dsm-central root containing DSM_0.2_Custom_Instructions_v1.1.md)?"
   - Expand a leading `~` to `$HOME`; strip a trailing slash.
   - **Validate:** `{HUB}` exists AND `{HUB}/DSM_0.2_Custom_Instructions_v1.1.md` is a readable file. If not, **HALT** with: "Not a DSM hub: {HUB} does not contain DSM_0.2_Custom_Instructions_v1.1.md. Pass the hub's dsm-central root." Scaffold nothing on a failed validation.

2. **Guard against the wrong directory type (never clobber a hub, mirror, or existing spoke).** Evaluated against the current directory (the prospective spoke), top to bottom, first match halts:
   - If `scripts/take-ai-bite-sync.txt` exists at the repo root → this directory IS a hub or cloned mirror. **HALT:** "This directory is a DSM hub or cloned mirror, not a new spoke. Run /dsm-go (its Step 0.8 Kick-off handles a cloned mirror)."
   - If any `.claude/*.template` file exists → this is a cloned mirror awaiting Kick-off. **HALT** with the same `/dsm-go` pointer.
   - If `.claude/dsm-ecosystem.md` already exists with a `dsm-central` row whose path (after `~` expansion and trailing-slash strip) differs from the repo root → this is already a spoke. **HALT:** "Already a spoke of {that hub}. Run /dsm-go to start a session." (idempotent; no clobber)

3. **Ensure git is initialized (DSM requires a local git repository).**
   - Run `git rev-parse --is-inside-work-tree 2>/dev/null`. If NOT a repo: `git init`, `git branch -m main`, then ask "Remote repository? (GitHub URL or 'none' for local-only)" and `git remote add origin {url}` if a URL is given. The initial commit is deferred to step 9 (after scaffolding) so it captures the scaffold.

4. **Derive runtime values (no prompt):** `{REPO_ROOT}` from `git rev-parse --show-toplevel` (or `pwd`), `{project_name}` from `basename {REPO_ROOT}`, `{ISO_DATE}` from `date -I`.

5. **Write `.claude/dsm-ecosystem.md` pointing `dsm-central` at the REAL hub (never self).**
   - Create `.claude/` if missing. Write the registry (Ecosystem Pointers format from `/dsm-align`) with a `dsm-central` row: `Path` = `{HUB}` (absolute or `~`-based), `Description` = `Hub repository`, `Mirror` = `-`.
   - If `{HUB}/.claude/dsm-ecosystem.md` has a `portfolio` row, copy its path; otherwise write a `portfolio` placeholder row for the user to fill.
   - **This step is what makes the directory a SPOKE:** `/dsm-go` Step 0.8 reads this file and returns `SPOKE` because `dsm-central` ≠ repo root.

6. **Write a minimal `.claude/CLAUDE.md`.**
   - Line 1 is the discovery mechanism: `@{HUB}/DSM_0.2_Custom_Instructions_v1.1.md` (use the absolute/`~`-based hub path so it resolves from the spoke's own location, which is not the hub's parent).
   - Below it, a short project-specific stub naming the participation pattern (`Standard Spoke`) and a placeholder project-type line.
   - Do NOT hand-write the `<!-- BEGIN/END DSM_0.2 ALIGNMENT -->` section; `/dsm-align` Step 7b generates it in the next step.

7. **Run the spoke `/dsm-align`.**
   - Invoke `/dsm-align`. Because `.claude/dsm-ecosystem.md` now points `dsm-central` at `{HUB}` (≠ repo root) and this directory has no `scripts/commands/`, `/dsm-align` takes the **spoke path** (not the hub fast-path, not the EC fast-path). It scaffolds the canonical `dsm-docs/` folders (Step 3), creates `_inbox/` (Step 2), creates `.claude/reasoning-lessons.md` and `.claude/session-transcript.md` (Step 10), installs the transcript hooks and wires `settings.json` (Step 10b), and generates the CLAUDE.md alignment section from the §17.1 template for the detected project type (Step 7b).
   - This reuses all existing scaffold machinery; `/dsm-new-spoke` does not re-implement folder creation.

8. **What this skill does NOT do (anti-requirements; mirror of §25.3):**
   - Does NOT copy `.claude/*.template` files — those are the Cloned-Mirror Kick-off mechanism, not a spoke's.
   - Does NOT self-register the directory as `dsm-central`.
   - Does NOT write `.claude/kickoff-done.txt` — that is a hub/mirror marker that would make `/dsm-go` Step 0.8 skip detection.
   - Does NOT write to the hub repository. Reading the hub's registry (step 5) is a read; cross-repo inbox traffic is write-only and is not part of bootstrapping.

9. **Make the initial commit (only if this skill ran `git init` in step 3).**
   - `git add .` then `git commit -m "Initialize DSM spoke (scaffold + align)"`. If the repository already existed, leave committing to the user and the first `/dsm-go` session branch.

10. **Report and hand off.**
    - Report: project name, the hub registered as `dsm-central`, the `dsm-docs/` folders scaffolded, and that the CLAUDE.md alignment section was generated.
    - Next step: "Run `/dsm-go` to start the first session. Step 0.8 will now report `SPOKE`."

## Notes

- Idempotent and safe: step 2 halts rather than clobbering a hub, mirror, or existing spoke, so a mistaken invocation in the wrong directory is a no-op with a pointer, not a destructive write.
- This skill is the companion to `/dsm-go`'s Step 0.8 new-spoke guard: when `/dsm-go` meets an uninitialized directory with no `.claude/*.template` files, it stops the Kick-off and routes the user here.
- Reference: DSM_0.2.A §25.7 (New-Spoke Bootstrap Versus Cloned-Mirror Kick-off), DSM_0.1 (Canonical Spoke Folder Names), `/dsm-align`, BACKLOG-578.
