#!/bin/bash
set -x # echo on

docker run -d \
  --volume cass-shared:/var/lib/cassandra/data \
  --name cass2 \
  cassandra:2.2

docker logs -f cass2
sleep 10s

docker run -it --rm \
  --link cass2:cass \
  cassandra:2.2 \
  cqlsh cass

# select * from system.schema_keyspaces where keyspace_name = 'docker_hello_world';
# quit

# -v: also delete relates volume
docker rm -vf cass2 cass1
