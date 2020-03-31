#!/bin/bash
set -x # echo on

# --driver local: Specifies the local volume plugin
docker volume create \
  --driver local \
  --label example=location \
  location-example

# volume location on the host
docker volume inspect \
  --format "{{json .Mountpoint}}" \
  location-example
# /var/lib/docker/volumes/location-example/_data
