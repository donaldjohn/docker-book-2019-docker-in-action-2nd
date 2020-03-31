#!/bin/bash
set -x # echo on

docker run --rm \
  --mount type=tmpfs,dst=/tmp \
  --entrypoint mount \
  alpine:latest -v
