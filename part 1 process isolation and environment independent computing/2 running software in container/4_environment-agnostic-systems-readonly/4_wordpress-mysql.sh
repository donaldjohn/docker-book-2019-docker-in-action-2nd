#!/bin/bash
set -x # echo on

docker stop wpdb && docker rm wpdb && sleep 1s
docker run -d --name wpdb \
    -e MYSQL_ROOT_PASSWORD=ch2demo \
    mysql:5.7

docker stop wp3 && docker rm wp3 && sleep 1s
# -p 8000:80: open 8000 in local to docker 80
docker run -d --name wp3 \
  --link wpdb:mysql \
  -p 8000:80 \
  --read-only \
  -v /run/apache2/ \
  --tmpfs /tmp \
  wordpress:5.0.0-php7.2-apache

sleep 3s # wait to complete
docker inspect --format "{{.State.Running}}" wp3 # true

# http://127.0.0.1:8000
