#!/bin/bash
set -x # echo on

# Remove by tag
docker image rm \
  dockerinaction/ch9_registry_bound \
  localhost:5000/dockerinaction/ch9_registry_bound

# Not exists now
docker image ls -f "label=dia_excercise=ch9_registry_bound"

# Pull from local registry
docker image pull localhost:5000/dockerinaction/ch9_registry_bound

docker image ls -f "label=dia_excercise=ch9_registry_bound"

docker container rm -vf local-registry
