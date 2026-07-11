#!/usr/bin/env bash
set -euo pipefail

DEST="${1:-$HOME/.local/bin}/magic"

if [[ -f "$DEST" ]]; then
    rm "$DEST"
    echo "Removed: $DEST"
else
    echo "Not found: $DEST"
fi
