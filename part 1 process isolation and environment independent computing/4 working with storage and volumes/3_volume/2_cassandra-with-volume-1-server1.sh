#!/bin/bash
set -x # echo on

# create a single-node Cassandra cluster,
# create a keyspace, delete the container,
# and then recover that keyspace on a new node in another container.

# This volume is not associated with any containers
docker volume create \
  --driver local \
  --label example=cassandra \
  cass-shared

#  use this volume when you create a new container running Cassandra
# cass-shared is created volume above
docker run -d \
  --volume cass-shared:/var/lib/cassandra/data \
  --name cass1 \
  cassandra:2.2
