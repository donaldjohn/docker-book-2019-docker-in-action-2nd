#!/bin/bash
set -x # echo on

docker run -d -p 80:80 --name lamp-test tutum/lamp

docker top lamp-test

# test the supervisord restart functionality by manually stopping one of the processes inside the container.

# The problem is that to kill a process inside a container from within that container, you need to know the PID in the container’s PID namespace.

