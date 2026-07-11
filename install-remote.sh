#!/usr/bin/env bash
set -euo pipefail

HOST="${1:?Usage: install-remote.sh <host>}"

echo "→ Setting up $HOST for magic sessions"

ssh "$HOST" 'bash -s' <<'REMOTE'
set -euo pipefail

if command -v dtach &>/dev/null; then
    echo "dtach already installed: $(which dtach)"
    exit 0
fi

if [[ -f /etc/arch-release ]]; then
    if command -v yay &>/dev/null; then
        yay -S --noconfirm dtach
    elif command -v paru &>/dev/null; then
        paru -S --noconfirm dtach
    else
        echo "Error: no AUR helper found (yay or paru required for Arch)"
        exit 1
    fi
elif command -v apt-get &>/dev/null; then
    sudo apt-get install -y dtach
elif command -v dnf &>/dev/null; then
    sudo dnf install -y dtach
elif command -v brew &>/dev/null; then
    brew install dtach
else
    echo "Error: unsupported package manager — install dtach manually"
    exit 1
fi

echo "dtach installed: $(which dtach)"
REMOTE

echo "Done. $HOST is ready for magic."
