#!/usr/bin/env bash
# Informational structural check for module READMEs.
# Fails when the canonical bones are missing. Run from the repository root.
set -u

readme="${1:-README.md}"

if [ ! -f "$readme" ]; then
  echo "::error::$readme not found"
  exit 1
fi

status=0
report() { echo "::warning title=README::$1"; status=1; }

grep -qE '^# ' "$readme"                  || report "missing an H1 title"
grep -q 'BEGIN_TF_DOCS' "$readme"         || report "missing the generated reference block (BEGIN_TF_DOCS)"
grep -q 'END_TF_DOCS' "$readme"           || report "missing the generated reference block (END_TF_DOCS)"
grep -qiE '^#{2,3} (Usage|Using it|Quick ?start|What you get|What it creates|When to use)' "$readme" \
                                          || report "missing a usage/intro section"
grep -qiE '^## Design decisions' "$readme" || report "missing a design decisions section"

if [ "$status" -eq 0 ]; then
  echo "README structure ok"
fi
exit "$status"
