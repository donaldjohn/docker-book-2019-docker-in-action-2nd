#!/bin/bash
set -x # echo on

for i in amazon google microsoft; do
  docker run --rm \
    --mount type=volume,src=$i,dst=/tmp \
    --entrypoint /bin/sh \
    alpine:latest -c "nslookup $i.com > /tmp/results.txt"
done

# only way to delete these named volumes
# no volume attached to any container in any state can be deleted
docker volume remove \
  amazon google microsoft
