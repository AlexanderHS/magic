#!/usr/bin/env bash
set -euo pipefail

HOST="${1:?Usage: uninstall-remote.sh <host>}"

echo "→ Cleaning up $HOST"

ssh "$HOST" 'bash -s' <<'REMOTE'
set -euo pipefail

sockets=$(ls /tmp/magic-*.sock 2>/dev/null || true)
if [[ -n "$sockets" ]]; then
    echo "Removing sockets:"
    echo "$sockets" | while read -r sock; do
        rm -f "$sock"
        echo "  removed $sock"
    done
else
    echo "No active magic sessions."
fi
REMOTE

echo "Done. To also remove dtach, run: ssh $HOST 'sudo <packagemanager> remove dtach'"
