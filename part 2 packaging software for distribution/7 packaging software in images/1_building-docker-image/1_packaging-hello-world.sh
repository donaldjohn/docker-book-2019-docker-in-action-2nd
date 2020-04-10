#!/bin/bash
set -x # echo on

# Modifies file in container
docker container run \
  --name hw_container \
  ubuntu:latest \
  touch /HelloWorld

# Commits change to new image
docker container commit hw_container hw_image

# Removes changed container
docker container rm -vf hw_container

# Examines file in new container
docker container run --rm \
  hw_image \
  ls -l /HelloWorld
