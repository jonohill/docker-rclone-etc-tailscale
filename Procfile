etcd: etcd --data-dir=/data/etc --log-level=warn
rclone: rclone serve webdav --config=/data/rclone/rclone.conf --addr :8080 "$RCLONE_REMOTE"
tailscaled: tailscaled --tun=userspace-networking --statedir=/data/tailscale
