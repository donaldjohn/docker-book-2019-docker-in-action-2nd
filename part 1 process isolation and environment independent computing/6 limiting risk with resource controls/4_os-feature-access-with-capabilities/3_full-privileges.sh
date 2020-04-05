#!/bin/bash
set -x # echo on

# Checks out IDs
docker container run --rm \
  --privileged \
  ubuntu:16.04 id

# Checks out Linux capabilities
docker container run --rm \
  --privileged \enhanced tools
  ubuntu:16.04 id

# Checks out list of mounted devices
docker container run --rm \
  --privileged \
  ubuntu:16.04 ls /dev

# Examines network configuration
docker container run --rm \
  --privileged \
  ubuntu:16.04 networkctl
