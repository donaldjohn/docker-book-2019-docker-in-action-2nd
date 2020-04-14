#!/bin/bash
set -x # echo on

docker container rm -vf ftp-server
rm -R ./ftp-server
docker network rm ch9_ftp

docker network create ch9_ftp
docker run -d \
  --name ftp-server \
  --network=ch9_ftp \
  --restart=always \
  -v "$(pwd)/ftp-server/data":/var/ftp/pub/incoming \
  -v "$(pwd)/ftp-server/log":/var/log \
  shijiansu/ch9_ftpd

# Problem,
# after lftp put file to ftp server, and exit, the vsftpd also exits.
# it cause the container to stop because no front ground process is running.
# Hotfix solution,
# now put "--restart=always"