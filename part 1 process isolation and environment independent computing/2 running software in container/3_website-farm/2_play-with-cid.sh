#!/bin/bash
set -x # echo on

# docker create nginx # the container is created in a stopped state, else same as docker run
# (1)
CID=$(docker create nginx:latest)
echo "${CID}"

# (2)
rm /tmp/web.cid
docker create --cidfile /tmp/web.cid nginx # cid write out to local file /tmp/web.cid
#cat /tmp/web.cid

# (3)
CID=$(docker ps --latest) # full information of last created container
echo "${CID}"

CID=$(docker ps --latest --quiet) # truncated ID of the last created container
echo "${CID}"

CID=$(docker ps -l -q) # --latest --quiet # truncated ID
echo "${CID}"

CID=$(docker ps --latest --no-trunc --quiet) # full cid
echo "${CID}"
