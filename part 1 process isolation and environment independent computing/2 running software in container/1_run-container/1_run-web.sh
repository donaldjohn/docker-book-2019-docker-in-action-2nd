#!/bin/bash
set -x # echo on

docker stop web && docker rm web && sleep 1s
docker run --detach --name web nginx:latest # detached container
