#!/usr/bin/env sh

set -e

overmind start -D tailscaled

# Wait for tailscaled to start
while ! tailscale status > /dev/null 2>&1; do
    sleep 1
done

# Login tailscale if needed
ts_state="$(tailscale status --json | jq -r '.BackendState')"
if [ "$ts_state" = "NeedsLogin" ]; then
    tailscale up --hostname="$TAILSCALE_HOSTNAME" --auth-key="$TAILSCALE_AUTH_KEY"
fi

overmind quit

exec overmind start
