#!/bin/bash
set -x # echo on

# SYS_ADMIN is not included
docker container run --rm -u nobody \
  ubuntu:16.04 \
  /bin/bash -c "capsh --print | grep sys_admin"

# Adds SYS_ADMIN
docker container run --rm -u nobody \
  --cap-add sys_admin \
  ubuntu:16.04 \
  /bin/bash -c "capsh --print | grep sys_admin"
