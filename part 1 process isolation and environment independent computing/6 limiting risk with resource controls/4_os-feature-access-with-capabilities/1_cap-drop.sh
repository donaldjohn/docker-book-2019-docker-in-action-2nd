#!/bin/bash
set -x # echo on

# When you create a new container, Docker drops all capabilities except for an explicit list of capabilities that are necessary and safe to run most applications.

# If you wanted to be a bit more careful than the default configuration, you could drop NET_RAW from the list of capabilities.

docker container run --rm -u nobody \
  ubuntu:16.04 \
  /bin/bash -c "capsh --print | grep net_raw"

# docker container run --rm -u nobody \
#   ubuntu:16.04 \
#   /bin/bash -c "capsh --print | grep -o net_raw"

# Drops NET_RAW capability
docker container run --rm -u nobody \
  --cap-drop net_raw \
  ubuntu:16.04 \
  /bin/bash -c "capsh --print | grep net_raw"
# now cannot find the capabilities
