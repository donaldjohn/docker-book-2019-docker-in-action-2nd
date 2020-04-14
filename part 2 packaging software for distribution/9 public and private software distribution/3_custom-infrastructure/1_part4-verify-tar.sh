#!/bin/bash
set -x # echo on

docker container run --rm -it \
  --network ch9_ftp \
  shijiansu/ch9_ftp_client \
  -e "cd pub/incoming; ls; exit" 'ftp-server'
