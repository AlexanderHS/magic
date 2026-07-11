#!/usr/bin/env bash
set -euo pipefail

DEST="${1:-$HOME/.local/bin}/magic"

install -m 755 "$(dirname "$0")/magic" "$DEST"
echo "Installed: $DEST"

if ! echo "$PATH" | tr ':' '\n' | grep -qx "$(dirname "$DEST")"; then
    echo ""
    echo "Warning: $(dirname "$DEST") is not in your PATH."
    echo "Add this to your shell rc:"
    echo "  export PATH=\"$(dirname "$DEST"):\$PATH\""
fi
