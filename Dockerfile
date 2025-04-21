FROM ghcr.io/jonohill/docker-overmind:2.5.1 AS overmind

FROM alpine:3.21.3

RUN apk add --no-cache \
    etcd \
    rclone \
    tailscale \
    tmux

COPY --from=overmind /usr/local/bin/overmind /usr/local/bin/overmind

COPY ./Procfile /Procfile

VOLUME [ "/config" ]
VOLUME [ "/data" ]

ENV RCLONE_REMOTE=
ENV TAILSCALE_HOSTNAME=
ENV TAILSCALE_AUTH_KEY=

ENTRYPOINT [ "overmind" ]
CMD [ "start" ]
