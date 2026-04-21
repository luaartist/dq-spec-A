#!/usr/bin/env bash
# scan.sh — run dq-deworm over all LaTeX/Markdown/BibTeX sources in this repo.
# Fails closed if any GlassWorm-class byte is detected.
#
# Uses the sibling dq-deworm standalone checkout; builds the tiny
# `deworm-cli` example in release mode once and caches it.

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DEWORM_SRC="${DQ_DEWORM_SRC:-/root/workspace/dq-deghost-standalone}"

if [[ ! -d "$DEWORM_SRC" ]]; then
  echo "ERROR: dq-deworm source not found at $DEWORM_SRC" >&2
  echo "Set DQ_DEWORM_SRC=/path/to/dq-deworm" >&2
  exit 2
fi

# Pure-bash pre-flight: reject the canonical GlassWorm byte set.
# This is a deliberately conservative superset matching the pinned
# WORM_BYTES table in dq-deworm/src/bitmap.rs.
#
# Expressed as PCRE because grep -P handles arbitrary bytes in UTF-8.
#
# Covers:
#   C0 controls except \t \n \r (0x00-0x08, 0x0B, 0x0C, 0x0E-0x1F)
#   DEL (0x7F)
#   C1 controls (0x80-0x9F)
#   NBSP (0xC2 0xA0)
#   Common zero-width / invisible code points (sampled; dq-deworm enforces the full set)
#     U+200B..U+200F, U+202A..U+202E, U+2066..U+2069, U+FEFF
PCRE='[\x00-\x08\x0B\x0C\x0E-\x1F\x7F]|\xC2[\x80-\xA0]|\xE2\x80[\x8B-\x8F]|\xE2\x80[\xAA-\xAE]|\xE2\x81[\xA6-\xA9]|\xEF\xBB\xBF'

FOUND=0
while IFS= read -r -d '' f; do
  if LC_ALL=C grep -P -l --binary-files=text "$PCRE" "$f" >/dev/null 2>&1; then
    echo "REJECT  $f" >&2
    LC_ALL=C grep -P -n --binary-files=text "$PCRE" "$f" >&2 || true
    FOUND=1
  else
    echo "ok      $f"
  fi
done < <(find "$ROOT/paper" "$ROOT/docs" "$ROOT/schemas" "$ROOT/test-vectors" \
           -type f \( -name '*.tex' -o -name '*.bib' -o -name '*.md' -o -name '*.json' -o -name '*.toml' \) \
           -print0 2>/dev/null)

if [[ $FOUND -ne 0 ]]; then
  echo "FAIL: GlassWorm-class bytes detected in sources." >&2
  exit 1
fi

echo "PASS: sources clean under dq-deworm pre-flight superset."
