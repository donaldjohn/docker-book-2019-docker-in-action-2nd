#!/bin/bash
set -x # echo on

# pull from Docker Hub
docker image pull dockerinaction/ch9_registry_bound

docker image ls -f "label=dia_excercise=ch9_registry_bound"

docker image tag dockerinaction/ch9_registry_bound \
  localhost:5000/dockerinaction/ch9_registry_bound

# push to local registry
docker image push localhost:5000/dockerinaction/ch9_registry_bound
