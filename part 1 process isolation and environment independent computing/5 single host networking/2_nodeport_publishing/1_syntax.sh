#!/bin/bash
set -x # echo on

# the first example will map 8080 on the host to port 8080 in the container.
# What actually happens is the host operating system will select a random host port, and traffic will be routed to port 8080 in the container.
# The benefit to this design and default behavior is that ports are scarce resources, and choosing a random port allows the software and the tooling to avoid potential conflicts.
docker run --rm \
  -p 8080 \
  alpine:3.8 echo "forward ephemeral TCP -> container TCP 8080"


docker run --rm \
  -p 8088:8080/udp \
  alpine:3.8 echo "host UDP 8088 -> container UDP 8080"

docker run --rm \
  -p 127.0.0.1:8080:8080/tcp \
  -p 127.0.0.1:3000:3000/tcp \
  alpine:3.8 echo "forward multiple TCP ports from localhost"
