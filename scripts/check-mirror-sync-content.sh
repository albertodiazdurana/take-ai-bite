#!/usr/bin/env bash
# check-mirror-sync-content.sh
#
# Pre-mirror-sync personal content scanner. Greps the list of files about to
# be mirror-synced for personal markers (names, credentials, contact info,
# user-specific framing) that should NOT propagate to public mirror repos.
#
# Usage:
#   scripts/check-mirror-sync-content.sh <file1> [file2 ...]
#   scripts/check-mirror-sync-content.sh --confirmed <file1> [file2 ...]
#
# Exit codes:
#   0  no personal markers found, safe to mirror
#   1  personal markers found, mirror sync should stop
#   2  bad arguments
#
# The --confirmed flag bypasses the gate and exits 0 even on hits. Use it
# only after a human has reviewed each hit and confirmed it is intentional
# (e.g., legitimate author attribution in a README, BL author field).
#
# Filed under BL-335 (DSM_0.2 §20 Change Propagation Protocol hardening).

set -euo pipefail

CONFIRMED=0
if [[ "${1:-}" == "--confirmed" ]]; then
  CONFIRMED=1
  shift
fi

if [[ $# -eq 0 ]]; then
  echo "usage: $0 [--confirmed] <file1> [file2 ...]" >&2
  exit 2
fi

# Personal markers. Case-insensitive. Word-boundary anchored where it matters
# to reduce false positives. Extend this list as new markers are identified.
#
# Categories:
#   - Personal name (Alberto, Diaz, Durana)
#   - Credentials specific to the user (PMP)
#   - External profiles (LinkedIn, github.com/albertodiazdurana)
#   - Engagement model framing (freelance, client engagement, cover letter)
#   - User-preference phrasing ("the user prefers", "the user is", "I am")
#
# Each pattern is an extended-regex fragment matched with grep -E -i.
PATTERNS=(
  '\balberto\b'
  '\bdiaz durana\b'
  '\bdurana\b'
  '\bpmp\b'
  '\blinkedin\b'
  'albertodiazdurana'
  '\bfreelance\b'
  '\bclient engagement'
  '\bcover letter'
  'the user prefers'
  'the user is'
  'the user wants'
  "user's freelance"
  "user's portfolio"
)

# Build a single -E pattern.
JOINED_PATTERN=$(IFS='|'; echo "${PATTERNS[*]}")

HITS=0
for f in "$@"; do
  if [[ ! -f "$f" ]]; then
    echo "skip (not a file): $f" >&2
    continue
  fi
  if grep -n -E -i "$JOINED_PATTERN" "$f" > /tmp/check-mirror-sync-content.hit 2>/dev/null; then
    HITS=$((HITS + 1))
    echo "PERSONAL CONTENT: $f"
    sed 's/^/  /' /tmp/check-mirror-sync-content.hit
    echo ""
  fi
done
rm -f /tmp/check-mirror-sync-content.hit

if [[ $HITS -eq 0 ]]; then
  echo "OK: no personal markers in $# file(s) about to mirror-sync."
  exit 0
fi

echo "FOUND personal markers in $HITS file(s)."
if [[ $CONFIRMED -eq 1 ]]; then
  echo "Bypassed by --confirmed flag. Proceeding."
  exit 0
fi

echo ""
echo "Mirror sync should stop. Options:"
echo "  1. Move the personal content to .claude/ (gitignored, local) or to"
echo "     auto-memory at ~/.claude/projects/<encoded>/memory/."
echo "  2. If the match is intentional and acceptable to mirror (e.g.,"
echo "     legitimate author attribution in README, BL author field),"
echo "     re-run with --confirmed."
echo ""
exit 1
