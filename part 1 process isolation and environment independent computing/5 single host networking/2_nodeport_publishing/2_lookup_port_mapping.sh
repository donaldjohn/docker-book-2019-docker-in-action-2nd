#!/bin/bash
set -x # echo on

docker run -d -p 8080 --name listener alpine:3.8 sleep 300
# Run the docker port subcom- mand to see the ports forwarded to any given container:
docker port listener
# 8080/tcp -> 0.0.0.0:32777

sleep 3s

# Publishes multiple ports
docker run -d \
  -p 8080 \
  -p 3000 \
  -p 7500 \
  --name multi-listener \
  alpine:3.8 sleep 300
# Looks up the host port mapped to container port 3000
docker port multi-listener 3000 # 0.0.0.0:32780
