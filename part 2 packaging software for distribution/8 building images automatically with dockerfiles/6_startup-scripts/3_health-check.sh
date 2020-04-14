#!/bin/bash
set -x # echo on

docker image build \
  -f health-check-nginx.df \
  -t dockerinaction/healthcheck .

docker container run --name healthcheck_ex -d dockerinaction/healthcheck

docker ps --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}'

# NAMES               IMAGE                        STATUS
# healthcheck_ex      dockerinaction/healthcheck   Up 47 seconds (healthy)

# health check at runtime
docker container run --name=healthcheck_ex2 -d \
  --health-cmd='nc -vz -w 2 localhost 80 || exit 1' \
  nginx:1.13-alpine
