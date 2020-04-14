#!/bin/bash
set -x # echo on

docker container rm -vf local-registry

docker run -d -p 5000:5000 \
  -v "$(pwd)"/data:/tmp/registry-dev \
  --restart=always --name local-registry registry:2
