#!/bin/bash
set -x # echo on

docker image build -t dockerinaction/ch8_whoami \
  -f WhoAmI.df \
  .

docker run dockerinaction/ch8_whoami

# Container running as:          example
# Effectively running whoami as: root
