#!/bin/bash
set -x # echo on

docker image build \
  -t shijiansu/hello-dockerfile \
  -f HelloWorld.df \
  .

docker login

docker image push shijiansu/hello-dockerfile
