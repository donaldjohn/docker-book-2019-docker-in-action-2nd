#!/bin/bash
set -x # echo on

docker run -d -p 80:80 --name lamp-test tutum/lamp

sleep 3s
docker top lamp-test

# test the supervisord restart functionality by manually stopping one of the processes inside the container.

# The problem is that to kill a process inside a container from within that container, you need to know the PID in the container’s PID namespace.

# manually kill apache2
# docker exec lamp-test kill 11394

# docker logs lamp-test

# When apache2 stops, the supervisord process will log the event and restart the process.
# 2020-03-30 13:42:41,110 INFO supervisord started with pid 1



