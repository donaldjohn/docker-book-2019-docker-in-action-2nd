#!/bin/bash
set -x # echo on

docker rm -vf ch6_wordpress
docker rm -vf ch6_mariadb

# --memory 256m: Sets a memory constraint
docker container run -d --name ch6_mariadb \
  --memory 256m \
  --cpu-shares 1024 \
  --cap-drop net_raw \
  -e MYSQL_ROOT_PASSWORD=test \
  mariadb:5.5

# --cpus 0.75: Uses a maximum of 0.75 cpus
docker container run -d -P --name ch6_wordpress \
  --memory 512m \
  --cpus 0.75 \
  --cap-drop net_raw \
  --link ch6_mariadb:mysql \
  -e WORDPRESS_DB_PASSWORD=test \
  wordpress:5.0.0-php7.2-apache


