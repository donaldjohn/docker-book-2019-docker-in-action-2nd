#!/bin/bash
set -x # echo on

docker container run -it --rm \
  -v "$(pwd)":/project/ \
  -w /project/ \
  maven:3.6-jdk-11 \
  mvn clean verify

ls -la target/ch10-0.1.0.jar

docker image build \
  -t dockerinaction/ch10:multi-stage-runtime-debug \
  -f MultiStageDockerfile.df \
  --target=app-image-debug .

# How to run this image?
