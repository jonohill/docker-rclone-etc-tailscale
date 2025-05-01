mariadb: mariadbd --datadir=/data/mariadb --user=root --skip-grant-tables --bind-address=127.0.0.1 --skip-socket
rclone: rclone serve webdav --config=/data/rclone/rclone.conf --addr :8080 "$RCLONE_REMOTE"
tailscaled: tailscaled --tun=userspace-networking --statedir=/data/tailscale
