#!/bin/bash
set -x # echo on

docker pull dockerinaction/ch3_myapp
docker pull dockerinaction/ch3_myotherapp

docker images    # @docker1.13.0 change to "docker image list"

docker images -a # every installed intermediate image or layer

# rmi: specify a space-separated list of images to be removed
docker rmi \
  dockerinaction/ch3_myapp \
  dockerinaction/ch3_myotherapp
