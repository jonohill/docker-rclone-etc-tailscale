#!/usr/bin/env sh

set -e

overmind start --processes tailscaled &
overmind_pid=$!

# Wait for tailscaled to start
while ! tailscale status --json | jq > /dev/null 2>&1; do
    sleep 1
done

# Login tailscale if needed
ts_state="$(tailscale status --json | jq -r '.BackendState')"
if [ "$ts_state" = "NeedsLogin" ]; then
    tailscale up --hostname="$TAILSCALE_HOSTNAME" --auth-key="$TAILSCALE_AUTH_KEY"
fi

kill -SIGINT $overmind_pid
# and wait for overmind to exit (socket file to disappear)
while [ -S .overmind.sock ]; do
    sleep 1
done

exec overmind start
