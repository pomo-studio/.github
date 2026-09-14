#!/usr/bin/env bash
# Fail when a relative Markdown link points at a file that does not exist.
# Run from the repository root. External links and anchors are ignored.
set -uo pipefail

status=0

while IFS= read -r file; do
  dir=$(dirname "$file")
  while IFS= read -r target; do
    case "$target" in
      http*|mailto:*|tel:*|'#'*|'') continue ;;
    esac
    path=${target%%#*}
    [ -z "$path" ] && continue
    case "$path" in
      /*) resolved=".$path" ;;
      *) resolved="$dir/$path" ;;
    esac
    if [ ! -e "$resolved" ]; then
      echo "::error file=$file::broken relative link: $target"
      status=1
    fi
  done < <(grep -oE '\]\([^)]+\)' "$file" | sed -E 's/^\]\(//; s/\)$//')
done < <(git ls-files '*.md')

if [ "$status" -eq 0 ]; then
  echo "doc links ok"
fi
exit "$status"
