#!/bin/bash
set -x # echo on

LOG_SRC=logging-example

docker volume create \
  --driver local \
  ${LOG_SRC}

docker run --name plath -d \
  --mount type=volume,src=${LOG_SRC},dst=/data \
  dockerinaction/ch4_writer_a

docker run --rm \
  --mount type=volume,src=${LOG_SRC},dst=/data \
  alpine:latest \
  head /data/logA

docker volume inspect ${LOG_SRC}

# No such file or directory
cat "$(docker volume inspect \
  --format "{{json .Mountpoint}}" ${LOG_SRC})"/logA

docker rm -fv plath
