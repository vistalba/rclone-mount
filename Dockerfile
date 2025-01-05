FROM alpine:latest as builder

ENV GOPATH="/go" \
    AccessFolder="/mnt" \
    RemotePath="mediaefs:" \
    MountPoint="/mnt/mediaefs" \
    ConfigDir="/config" \
    ConfigName=".rclone.conf" \
    MountCommands="--allow-other --allow-non-empty" \
    UnmountCommands="-u -z"

## Alpine with Go Git
RUN apk add --no-cache --update alpine-sdk ca-certificates go git fuse fuse-dev tree
RUN go install github.com/rclone/rclone@latest

FROM alpine:latest

ENV GOPATH="/go" \
    AccessFolder="/mnt" \
    RemotePath="mediaefs:" \
    MountPoint="/mnt/mediaefs" \
    ConfigDir="/config" \
    ConfigName=".rclone.conf" \
    MountCommands="--allow-other --allow-non-empty" \
    UnmountCommands="-u -z"

COPY --from=builder /go/bin/rclone  /usr/sbin/rclone
RUN apk add --no-cache --update ca-certificates fuse fuse-dev tree

ADD start.sh /start.sh
RUN chmod +x /start.sh 

VOLUME ["/mnt"]

CMD ["/start.sh"]

# Use this docker Options in run
# --cap-add SYS_ADMIN --device /dev/fuse --security-opt apparmor:unconfined
# -v /path/to/config/.rclone.conf:/config/.rclone.conf
# -v /mnt/mediaefs:/mnt/mediaefs:shared
