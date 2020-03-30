#!/bin/bash
set -x # echo on

docker stop wp2 && docker rm wp2 && sleep 1s
# -v /run/apache2/: Mounts a writable directory from the host
# --tmpfs: Provides container an in-memory temp filesystem
docker run -d --name wp2 \
  --read-only \
  -v /tmp/wp2:/run/apache2/ \
  --tmpfs /tmp \
  wordpress:5.0.0-php7.2-apache

sleep 3s # wait to complete
docker inspect --format "{{.State.Running}}" wp2 # true

docker logs wp2

cat /tmp/wp2/apache2.pid # pid: 1 as inside docker
