#!/bin/bash
set -x # echo on

# conflict port -> Docker solve it
docker run -d --name webA nginx:latest
docker logs webA # should be empty
docker run -d --name webB nginx:latest
docker logs webB # should be empty
