#!/bin/bash
set -x # echo on

docker image build --tag ubuntu-git:auto .

docker image ls | grep ubuntu-git | grep auto

docker container run --rm ubuntu-git:auto --version
