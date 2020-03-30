#!/bin/bash
set -x # echo on

# --rm: automatically remove the container as soon as it enters the exited state
docker run --rm --name auto-exit-test busybox:1.29 echo Hello World
docker ps -a | grep auto-exit-test
