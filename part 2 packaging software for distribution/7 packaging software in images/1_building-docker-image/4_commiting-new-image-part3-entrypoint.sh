#!/bin/bash
set -x # echo on

# Shows standard git help and exit
docker container run \
  --name cmd-git \
  --entrypoint git \
  ubuntu-git

# Commits new image to same name
docker container commit \
  -a "@shijiansu" \
  -m "Set CMD git" \
  cmd-git ubuntu-git

# Cleanup
docker container rm -vf cmd-git

# Test
docker container run --name cmd-git ubuntu-git version
