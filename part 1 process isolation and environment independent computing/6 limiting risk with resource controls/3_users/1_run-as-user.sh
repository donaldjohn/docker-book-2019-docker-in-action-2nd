#!/bin/bash
set -x # echo on

docker image pull busybox:1.29

# Displays all of busybox’s metadata
docker image inspect busybox:1.29

# Shows only the run- as user defined by the busybox image
docker image inspect --format "{{.Config.User}}" busybox:1.29

# Outputs: root
docker container run --rm --entrypoint "" busybox:1.29 whoami

# Outputs: uid=0(root) gid=0(root) groups=10(wheel)
docker container run --rm --entrypoint "" busybox:1.29 id

docker container run --rm busybox:1.29 awk -F: '$0=$1' /etc/passwd

# Sets run-as user to nobody
# Outputs: uid=65534(nobody) gid=65534(nogroup)
docker container run --rm \
  --user nobody \
  busybox:1.29 id

# Sets run-as user to nobody and group to nogroup
# Outputs: uid=65534(nobody) gid=65534(nogroup)
docker container run --rm \
  -u nobody:nogroup \
  busybox:1.29 id

# Sets UID and GID
# Outputs: uid=10000 gid=20000
docker container run --rm \
  -u 10000:20000 \
  busybox:1.29 id
