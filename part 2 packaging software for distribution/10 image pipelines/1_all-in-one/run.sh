#!/bin/bash
set -x # echo on

docker image build \
  -t dockerinaction/ch10:all-in-one \
  --file AllInOneDockerfile.df .

docker container run --rm -it \
  -p 8080:8080 \
  dockerinaction/ch10:all-in-one
