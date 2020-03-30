#!/bin/bash
set -x # echo on

docker stop wp_writable && docker rm wp_writable && sleep 1s
docker run -d --name wp_writable \
  wordpress:5.0.0-php7.2-apache

sleep 3s # wait to complete
docker container diff wp_writable
# few files changed
# C /run
# C /run/apache2
# A /run/apache2/apache2.pid
