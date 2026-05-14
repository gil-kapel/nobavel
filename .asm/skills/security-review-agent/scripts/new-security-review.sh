#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 1 ]; then
  echo "Usage: $(basename "$0") <output-file.md>"
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="$1"

mkdir -p "$(dirname "$TARGET")"
cp "$SCRIPT_DIR/../assets/security-review-template.md" "$TARGET"
echo "Created $TARGET"
