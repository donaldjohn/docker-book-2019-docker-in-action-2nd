#!/bin/bash
set -x # echo on

# Adds new file to busybox
docker container run --name tweak-a \
  busybox:latest touch /HelloWorld

docker container diff tweak-a
# Output:
# A /HelloWorld

# Removes existing file from busybox
docker container run --name tweak-d \
  busybox:latest rm /bin/vi

docker container diff tweak-d
# Output:
# C/bin
# D /bin/vi

# Changes existing file in busybox
docker container run --name tweak-c \
  busybox:latest touch /bin/vi

docker container diff tweak-c
# Output:
# C/bin
# C /bin/busybox

docker container rm -vf tweak-a
docker container rm -vf tweak-d
docker container rm -vf tweak-c
