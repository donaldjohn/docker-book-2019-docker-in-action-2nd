#!/bin/bash
set -x # echo on

docker container rm -vf mod_ubuntu
docker container rm -vf mod_busybox_delete
docker container rm -vf mod_busybox_change

# add a file
docker container run \
  --name mod_ubuntu \
  ubuntu:latest touch /mychange

docker container diff mod_ubuntu
# A /mychange

docker container run \
  --name mod_busybox_delete \
  busybox:latest rm /etc/passwd
docker container diff mod_busybox_delete
# C /etc
# D /etc/passwd

docker container run \
  --name mod_busybox_change \
  busybox:latest touch /etc/passwd
docker container diff mod_busybox_change
# C /etc
# C /etc/passwd
