#!/bin/bash
set -x # echo on

# --device /dev/video0:/dev/video0: Mounts video0
docker container run -it --rm \
  --device /dev/video0:/dev/video0 \
  ubuntu:16.04 ls -al /dev
