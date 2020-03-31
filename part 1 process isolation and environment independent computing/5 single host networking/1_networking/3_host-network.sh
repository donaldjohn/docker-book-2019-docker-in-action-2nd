#!/bin/bash
set -x # echo on

docker run --rm \
  --network host \
  alpine:3.8 ip -o addr
