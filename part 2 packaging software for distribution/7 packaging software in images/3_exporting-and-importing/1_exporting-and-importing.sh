#!/bin/bash
set -x # echo on

docker container create --name export-test \
  dockerinaction/ch7_packed:latest ./echo For Export

# Exports filesystem contents
# --output (or -o for short)
docker container export --output contents.tar export-test

docker container rm export-test

# Shows archive contents
tar -tf contents.tar
