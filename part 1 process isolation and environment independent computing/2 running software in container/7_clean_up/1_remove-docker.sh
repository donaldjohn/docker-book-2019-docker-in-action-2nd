#!/bin/bash
set -x # echo on

docker ps -a

# to delete the stopped container
docker rm wp

# The key difference is that when you stop a process by using the -f flag, Docker sends a SIG_KILL signal, which immediately terminates the receiving process.

# you should use docker kill or docker rm -f only if you must stop the container in less than the standard 30-second maximum stop time.
# docker kill wp
# docker rm -f wp
