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
PROJECT_TARGET="${REPO_DIR}/.claude/commands"

# Commands that deploy to project-level .claude/commands/
PROJECT_COMMANDS="dsm-backlog.md dsm-backlog-done.md dsm-checkpoint.md dsm-review-feedback.md dsm-version-update.md"

if [ ! -d "$SOURCE_DIR" ]; then
    echo "ERROR: Source directory not found: $SOURCE_DIR"
    exit 1
fi

mkdir -p "$USER_TARGET"
mkdir -p "$PROJECT_TARGET"

is_project_command() {
    local name="$1"
    echo "$PROJECT_COMMANDS" | grep -qw "$name"
}

get_target() {
    local name="$1"
    if is_project_command "$name"; then
        echo "${PROJECT_TARGET}/${name}"
    else
        echo "${USER_TARGET}/${name}"
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

    if [ $drifted -gt 0 ] || [ $missing -gt 0 ]; then
        echo "Run 'scripts/sync-commands.sh --deploy' to sync tracked -> runtime"
        CHECK_RC=1
    else
        CHECK_RC=0
    fi
    return 0
}

deploy() {
    local user_count=0
    local project_count=0
    for src in "$SOURCE_DIR"/*.md; do
        local name
        name="$(basename "$src")"
        local tgt
        tgt="$(get_target "$name")"
        cp "$src" "$tgt"
        if is_project_command "$name"; then
            project_count=$((project_count + 1))
        else
            user_count=$((user_count + 1))
        fi
    done
    echo "Deployed $user_count user-level commands to $USER_TARGET"
    echo "Deployed $project_count project-level commands to $PROJECT_TARGET"
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
