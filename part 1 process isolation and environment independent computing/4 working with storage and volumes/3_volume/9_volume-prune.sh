#!/bin/bash
set -x # echo on

# remove all or some of the volumes that can be removed
docker volume prune --filter example=cassandra

docker volume prune --filter example=location --force
