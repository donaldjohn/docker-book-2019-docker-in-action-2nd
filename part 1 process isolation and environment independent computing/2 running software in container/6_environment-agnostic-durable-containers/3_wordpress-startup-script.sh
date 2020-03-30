#!/bin/bash
set -x # echo on

docker run wordpress:5.0.0-php7.2-apache \
  cat /usr/local/bin/docker-entrypoint.sh

# alternative
# use cat as the entrypoint
docker run --entrypoint="cat" \
  wordpress:5.0.0-php7.2-apache \
  /usr/local/bin/docker-entrypoint.sh # full path of the default entrypoint script as an argument to cat
