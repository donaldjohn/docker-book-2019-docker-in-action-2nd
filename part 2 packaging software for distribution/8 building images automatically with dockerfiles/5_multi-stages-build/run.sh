#!/bin/bash
set -x # echo on

docker build -t dockerinaction/http-client \
  -f ../docker/ch8_multi_stage_build/http-client.df \
   ../docker/ch8_multi_stage_build

# output the http-client.go source
docker container run --rm -it dockerinaction/http-client:latest
