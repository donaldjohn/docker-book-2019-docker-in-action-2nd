#!/bin/bash
set -x # echo on

docker container run --rm -it \
  --network ch9_ftp \
  -v "$(pwd)":/data \
  shijiansu/ch9_ftp_client \
  -e 'cd pub/incoming; put registry.2.tar; exit' ftp-server

# /data: container working dir
# /var/ftp/pub/incoming: the ftp folder
# -e 'cd pub/incoming; put registry.2.tar; exit' ftp-server: use for lftp
