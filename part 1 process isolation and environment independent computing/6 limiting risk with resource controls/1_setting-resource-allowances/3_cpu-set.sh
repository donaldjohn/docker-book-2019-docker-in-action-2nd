#!/bin/bash
set -x # echo on

docker rm -vf ch6_stresser

# --cpuset-cpus 0: Restricts to CPU number 0
# Start a container limited to a single CPU and run a load generator
# container will stop run- ning after 30 seconds
docker container run -d \
  --cpuset-cpus 0 \
  --name ch6_stresser \
  dockerinaction/ch6_stresser

# Start a container to watch the load on the CPU under load
docker container run -it --rm dockerinaction/ch6_htop
