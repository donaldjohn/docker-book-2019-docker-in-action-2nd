#!/bin/bash
set -x # echo on

docker stop wp && docker rm wp && sleep 1s
docker run -d --name wp --read-only \
    wordpress:5.0.0-php7.2-apache

sleep 3s # wait to complete
docker inspect --format "{{.State.Running}}" wp # false, the container is not running

docker logs wp # Unable to create lock file
# Sun Mar 29 13:42:27 2020 (1): Fatal Error Unable to create lock file: Bad file descriptor (9)
# When running WordPress with a read-only filesystem, the Apache web server process reports that it is unable to create a lock file.
