#!/usr/bin/env bash
#
# sync-commands.sh - Sync tracked DSM command sources to runtime locations
#
# Usage:
#   scripts/sync-commands.sh --check    # Report drift (default)
#   scripts/sync-commands.sh --deploy   # Copy tracked -> runtime
#
# Tracked source: scripts/commands/*.md (git-tracked in DSM Central)
# Runtime targets:
#   User-level:    ~/.claude/commands/    (dsm-align, dsm-go, dsm-wrap-up, etc.)
#   Project-level: .claude/commands/      (dsm-backlog, dsm-checkpoint, etc.)
#
# Reference: BACKLOG-130 (Phase A), BACKLOG-131 (Phase B)

# -E (errtrace) is required, not decorative: without it the ERR trap below is NOT
# inherited by shell functions, and nearly all of this script's logic lives in
# check_drift() and deploy(). A global trap without -E fires only at top level,
# which is the one place it must not fire and no place it must.
set -Eeuo pipefail

# Completion signal (BACKLOG-479). Without this, an unexpected mid-run abort is
# indistinguishable from a completed run: the summary line is the only evidence
# of completion and it is the first thing lost when the script dies early. A
# success-side counter cannot close that gap on its own, because it dies with
# the script. The signal therefore has to fire on the failure path.
#
# Exit codes: 0 = completed, no drift; 1 = completed, drift or missing found;
#             2 = did not complete.
#
# Drift is reported through CHECK_RC, never through check_drift's return value.
# An intentional `return 1` is indistinguishable from an accidental failure at a
# bare call site, so routing it through the trap made every drift-finding run
# claim it had aborted. Wrapping the call (`check_drift || rc=$?`, or an `if`)
# fixes the exit code but suppresses errexit for the WHOLE function body, which
# reopens exactly the run-past-errors hole this trap exists to close. Keeping the
# status out of the return value avoids both.
CHECK_RC=0

# Caveat: ERR traps still do not fire for commands inside `&&`/`||` lists or `if`
# conditions. With -E this is a backstop for unguarded statements anywhere in the
# script, but it is not total coverage.
on_err() {
    local rc=$?
    echo "ABORTED: sync-commands.sh exited unexpectedly (status ${rc}) near line ${BASH_LINENO[0]}" >&2
    echo "The run did NOT complete; results above are partial." >&2
    exit 2
}
trap on_err ERR

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
SOURCE_DIR="${SCRIPT_DIR}/commands"
USER_TARGET="${HOME}/.claude/commands"

# Legacy project-level location. NOTHING deploys here any more (BL-518); it is
# retained only so --check can report copies left behind by the old split.
#
# PRECEDENCE, measured 2026-08-25 (S254) and NOT the direction this file asserted
# until then. Claude Code resolves a name collision as enterprise > personal >
# project: https://code.claude.com/docs/en/skills.md , "Across levels, enterprise
# overrides personal, and personal overrides project", and "If you have files in
# `.claude/commands/`, those work the same way". So the USER-level copy wins, and
# a project-level leftover does NOT shadow it.
#
# What that means for a leftover here is conditional, which is why it is spelled
# out rather than reduced to a slogan:
#   - A user-level copy of the same name EXISTS -> the leftover is INERT. It is
#     not what the agent loads. Deleting it removes noise, not risk.
#   - No user-level copy exists (a fresh clone on another machine, a spoke that
#     has never run --deploy) -> the project-level copy is the ONLY copy and IS
#     what loads. There it is load-bearing, not residue.
#
# The URL is cited because this file previously stated the opposite with no source,
# and that assertion was read as fact and filed as BACKLOG-537.
LEGACY_PROJECT_TARGET="${REPO_DIR}/.claude/commands"

# BACKLOG-537 guard: fail --check if a project-level dsm-*.md copy exists AT
# CENTRAL specifically. Central has no legitimate reason to carry one (nothing
# has deployed here since BL-518); a mirror like take-ai-bite legitimately does
# (its own project-level commands, BL-528 scope) and must not be flagged. Central
# self-detection is the BL-407 primitive: scripts/take-ai-bite-sync.txt exists
# only in Central, never in a mirror clone.
IS_CENTRAL=0
[ -f "${REPO_DIR}/scripts/take-ai-bite-sync.txt" ] && IS_CENTRAL=1

# ALL commands deploy to USER_TARGET (BL-518, option A, decided 2026-08-20).
#
# WHY, because the next reader will otherwise re-derive the question: these
# commands are used in ALL projects, so "project command" was never a real
# category here. Five of them (dsm-backlog, dsm-backlog-done, dsm-checkpoint,
# dsm-review-feedback, dsm-version-update) used to deploy to
# "${REPO_DIR}/.claude/commands", which only a session running inside Central can
# resolve. A spoke fell through to the user-level copy that NO code path wrote,
# so those copies sat four months stale (measured 2026-08-20: mtimes 2026-03-20
# and 2026-04-22, all five differing from source). The spoke-visible
# /dsm-backlog had ZERO occurrences of "Risks" and "Test Execution Log" against
# two each in source, so spokes filed backlog items violating DSM_0.2 §21.2 and
# §21.3 while believing they had followed the skill.
#
# --check reported "20/20 | OK: 20" throughout, truthfully: it compared each
# command against its OWN designated target, and for those five that target was
# Central's folder, which was current. The file a spoke actually loads was
# outside the comparison. That is the property the orphan report below exists to
# close.

if [ ! -d "$SOURCE_DIR" ]; then
    echo "ERROR: Source directory not found: $SOURCE_DIR"
    exit 1
fi

mkdir -p "$USER_TARGET"

get_target() {
    echo "${USER_TARGET}/$1"
}

# Report copies at the legacy project-level path that nothing writes any more.
# The USER-level copy wins a name collision (see the precedence note above), so a
# leftover here is inert wherever a user-level copy of the same name exists, and
# is the loaded copy only where none does. Either way it is stale by construction,
# because nothing writes this path. Reported, never deleted , removing files with
# substantive content is a user decision (Destructive Action Protocol).
ORPHAN_COUNT=0

report_orphans() {
    [ -d "$LEGACY_PROJECT_TARGET" ] || return 0
    local -a orphans=()
    local f name
    for f in "$LEGACY_PROJECT_TARGET"/*.md; do
        [ -e "$f" ] || continue
        name="$(basename "$f")"
        orphans+=( "$name" )
    done
    ORPHAN_COUNT=${#orphans[@]}
    [ ${#orphans[@]} -eq 0 ] && return 0
    echo ""
    echo "ORPHANED project-level copies in ${LEGACY_PROJECT_TARGET}:"
    for name in "${orphans[@]}"; do
        if [ -f "${SOURCE_DIR}/${name}" ] && diff -q "${SOURCE_DIR}/${name}" "${LEGACY_PROJECT_TARGET}/${name}" > /dev/null 2>&1; then
            echo "  - ${name} (currently matches source, but nothing keeps it current)"
        else
            echo "  - ${name} (DIFFERS from source; loaded only if no user-level copy exists)"
        fi
    done
    if [ "$IS_CENTRAL" -eq 1 ]; then
        echo "  Central has none legitimately (nothing deploys here, BL-518). This is"
        echo "  shadow residue (BACKLOG-537) and --check will fail until it is removed."
    else
        echo "  Nothing deploys to this path any more (BL-518). The user-level copy"
        echo "  wins a name collision (personal overrides project), so these are inert"
        echo "  wherever a user-level copy of the same name exists , and are the copy"
        echo "  that loads only where none does. Delete once you have confirmed nothing"
        echo "  needs them."
    fi
}

check_drift() {
    local drifted=0
    local missing=0
    local ok=0
    local checked=0
    # One source of truth for the file set, so the count and the loop cannot
    # disagree. `ls -1 ... | wc -l` was both: a pipeline that dies under pipefail
    # when the glob matches nothing (ls exits 2, silent abort, zero output), and
    # a miscount for filenames containing newlines.
    local -a files=( "$SOURCE_DIR"/*.md )
    local total=${#files[@]}

    for src in "${files[@]}"; do
        local name
        name="$(basename "$src")"
        local tgt
        tgt="$(get_target "$name")"

        if [ ! -f "$tgt" ]; then
            echo "MISSING: $name (tracked source exists, no runtime copy)"
            missing=$((missing + 1))
        elif diff -q "$src" "$tgt" > /dev/null 2>&1; then
            ok=$((ok + 1))
        else
            echo "DRIFTED: $name"
            # BACKLOG-479: `diff` returns 1 whenever files differ. That is its
            # normal "found differences" code, not an error, and this branch is
            # only reached when the files are already known to differ, so it
            # returned 1 on every execution. Piped, `pipefail` promoted that to a
            # pipeline failure and `errexit` killed the loop at the FIRST drifted
            # file. Capture the status instead of discarding it, so a genuine
            # diff error (status 2: unreadable file, bad path) stays visible.
            #
            # `local` is declared separately: `local x="$(cmd)"` returns local's
            # status, not the command's, which would mask the value being read.
            local diff_out diff_rc
            diff_out="$(diff --unified=3 "$src" "$tgt")" && diff_rc=0 || diff_rc=$?
            if [ "$diff_rc" -gt 1 ]; then
                echo "  (diff failed with status ${diff_rc}; cannot render)"
            else
                # Herestring, not a pipe. `printf ... | head -20` would take a
                # genuine SIGPIPE on the left side once the diff exceeds the pipe
                # buffer (~64 KB; measured: 40 lines gives PIPESTATUS "0 0",
                # 100k lines gives "141 0"). Rare, but it manufactures for real
                # the failure mode this BL wrongly attributed to the original.
                head -20 <<< "$diff_out"
            fi
            echo ""
            drifted=$((drifted + 1))
        fi
        checked=$((checked + 1))
    done

    echo "---"
    echo "Checked: $checked/$total | OK: $ok | Drifted: $drifted | Missing: $missing"
    report_orphans

    if [ $drifted -gt 0 ] || [ $missing -gt 0 ]; then
        echo "Run 'scripts/sync-commands.sh --deploy' to sync tracked -> runtime"
        CHECK_RC=1
    elif [ "$IS_CENTRAL" -eq 1 ] && [ "$ORPHAN_COUNT" -gt 0 ]; then
        echo "Central-only guard (BACKLOG-537): delete the orphaned copies listed above."
        CHECK_RC=1
    else
        CHECK_RC=0
    fi
    return 0
}

deploy() {
    local user_count=0
    for src in "$SOURCE_DIR"/*.md; do
        local name
        name="$(basename "$src")"
        cp "$src" "$(get_target "$name")"
        user_count=$((user_count + 1))
    done
    echo "Deployed $user_count user-level commands to $USER_TARGET"
    report_orphans
}

case "${1:---check}" in
    --check)
        check_drift
        exit "$CHECK_RC"
        ;;
    --deploy)
        deploy
        ;;
    --help|-h)
        echo "Usage: $0 [--check|--deploy]"
        echo "  --check   Report drift between tracked and runtime (default)"
        echo "  --deploy  Copy tracked sources to runtime locations"
        ;;
    *)
        echo "Unknown option: $1"
        echo "Usage: $0 [--check|--deploy]"
        exit 1
        ;;
esac
