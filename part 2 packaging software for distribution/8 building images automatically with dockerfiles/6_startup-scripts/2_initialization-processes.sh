#!/bin/bash
set -x # echo on

# The --init option can be used to add an init process to an existing image.
docker container run -it --init alpine:3.6 nc -l -p 3000

# ps -ef
# Docker ran /dev/init -- nc -l -p 3000
# Docker uses the tini program as an init process by default
