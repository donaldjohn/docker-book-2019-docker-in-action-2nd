#!/bin/bash
set -x # echo on

docker run -d --name namespaceA \
  busybox:1.29 /bin/sh -c "sleep 30000"
docker run -d --name namespaceB \
  busybox:1.29 /bin/sh -c "nc -l 0.0.0.0 -p 80"

docker exec namespaceA ps
docker exec namespaceB ps # docker exec is to execute antoher process

# optionally create containers without their own PID namespace
docker run --pid host busybox:1.29 ps
