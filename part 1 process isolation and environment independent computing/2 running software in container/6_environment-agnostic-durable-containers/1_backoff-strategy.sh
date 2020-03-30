#!/bin/bash
set -x # echo on

# every time it starts print date
# because busybox completed then it will stop, so by below restart setting,
# it auto restart
docker run -d --name backoff-detector --restart always busybox:1.29 date

docker logs -f backoff-detector

docker exec backoff-detector echo Just a Test
# Error response from daemon: Container e75d38e69229ce1555a2fdf125151c4b4a054cc3c896ec0993c1a9f051123d79 is not running

