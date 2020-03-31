#!/bin/bash
set -x # echo on

docker run --rm \
  --network none \
  alpine:3.8 ip -o addr

# Network is unreachable
docker run --rm \
  --network none \
  alpine:3.8 \
  ping -w 2 1.1.1.1
