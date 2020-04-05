#!/bin/bash
set -x # echo on

# -v: Binds docker.sock from host into container as a read-only file
docker container run --rm -it
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
  -u root  monitoringtool
# Container runs as root user, aligning with file permissions on host
