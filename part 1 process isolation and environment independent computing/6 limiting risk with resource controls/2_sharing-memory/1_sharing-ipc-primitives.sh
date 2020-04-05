#!/bin/bash
set -x # echo on

docker container rm -v ch6_ipc_producer
docker container rm -v ch6_ipc_consumer

# Starts producer
docker container run -d \
  -u nobody \
  --name ch6_ipc_producer \
  --ipc shareable \
  dockerinaction/ch6_ipc -producer

# Starts consumer
# --ipc: Joins IPC namespace
docker container run -d \
  -u nobody \
  --name ch6_ipc_consumer \
  --ipc container:ch6_ipc_producer \
  dockerinaction/ch6_ipc -consumer

docker logs ch6_ipc_producer

slepp 3s

docker logs ch6_ipc_consumer
