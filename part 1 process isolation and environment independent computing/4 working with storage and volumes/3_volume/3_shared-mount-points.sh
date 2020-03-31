#!/bin/bash
set -x # echo on

LOG_SRC=~/web-logs-example
mkdir ${LOG_SRC}

# from ch4_writers/writerA
docker run --name plath -d \
  --mount type=bind,src=${LOG_SRC},dst=/data \
  dockerinaction/ch4_writer_a

docker run --rm \
  --mount type=bind,src=${LOG_SRC},dst=/data \
  alpine:latest \
  head /data/logA

cat ${LOG_SRC}/logA

docker rm -f plath
rm -R ${LOG_SRC}
