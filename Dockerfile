FROM ghcr.io/jonohill/docker-overmind:2.5.1 AS overmind

FROM alpine:3.22.0

RUN apk add --no-cache \
    jq \
    mariadb \
    rclone \
    tailscale \
    tmux

COPY --from=overmind /usr/local/bin/overmind /usr/local/bin/overmind

COPY ./Procfile /Procfile
COPY ./entrypoint.sh /entrypoint.sh

VOLUME [ "/config" ]
VOLUME [ "/data" ]

ENV RCLONE_REMOTE=
ENV TAILSCALE_HOSTNAME=
ENV TAILSCALE_AUTH_KEY=

ENTRYPOINT [ "/entrypoint.sh" ]
