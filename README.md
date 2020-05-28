Rclone Mount Container
---

Lightweight and simple Container Image (`alpine:edge`) with compiled rclone (https://github.com/ncw/rclone). Mount your cloudstorage like amazon cloud drive inside a container and make it available to other containers like your Plex Media Server or on your hostsystem (mountpoint on host is shared). You need a working rclone.conf (from another host or create it inside the container). all rclone remotes can be used.


The Container uses a tiny trap function, to handle docker stop/restart ( fusermount -uz $MountPoint is applied on SIGTERM signal or app crashes also) on PID 1.
