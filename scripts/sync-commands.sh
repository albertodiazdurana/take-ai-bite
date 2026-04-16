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

set -euo pipefail

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

    for src in "$SOURCE_DIR"/*.md; do
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
            diff --unified=3 "$src" "$tgt" | head -20
            echo ""
            drifted=$((drifted + 1))
        fi
    done

    echo "---"
    echo "OK: $ok | Drifted: $drifted | Missing: $missing"

    if [ $drifted -gt 0 ] || [ $missing -gt 0 ]; then
        echo "Run 'scripts/sync-commands.sh --deploy' to sync tracked -> runtime"
        return 1
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
