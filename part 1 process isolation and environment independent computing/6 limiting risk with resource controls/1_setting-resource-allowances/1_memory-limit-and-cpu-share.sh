#!/bin/bash
set -x # echo on

docker rm -vf ch6_wordpress
docker rm -vf ch6_mariadb

# use docker container run as it is the more modern way to run a container

# --memory 256m: Sets a memory constraint
docker container run -d --name ch6_mariadb \
  --memory 256m \
  --cpu-shares 1024 \
  --cap-drop net_raw \
  -e MYSQL_ROOT_PASSWORD=test \
  mariadb:5.5

# --cpu-shares 512: Sets a relative process weight
docker container run -d -P --name ch6_wordpress \
  --memory 512m \
  --cpu-shares 512 \
  --cap-drop net_raw \
  --link ch6_mariadb:mysql \
  -e WORDPRESS_DB_PASSWORD=test \
  wordpress:5.0.0-php7.2-apache
# The defaults won’t limit the container, and it will be able to use 100% of the CPU if the machine is otherwise idle.
