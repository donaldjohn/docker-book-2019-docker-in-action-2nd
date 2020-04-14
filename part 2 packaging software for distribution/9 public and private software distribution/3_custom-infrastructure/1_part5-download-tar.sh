#!/bin/bash
set -x # echo on

rm registry.2.tar
docker image rm registry:2
docker image ls registry

docker container run --rm -it \
  --network ch9_ftp \
  -v "$(pwd)":/data \
  dockerinaction/ch9_ftp_client \
  -e 'cd pub/incoming; get registry.2.tar; exit' ftp-server
