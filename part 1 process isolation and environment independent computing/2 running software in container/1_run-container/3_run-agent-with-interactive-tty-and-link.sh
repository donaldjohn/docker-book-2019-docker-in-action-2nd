#!/bin/bash
set -x # echo on

# need to docker run web first
/bin/bash 1_run-nginx.sh
# -i = --interactive; -t = --tty
# --interactive option tells Docker to keep the standard input stream (stdin) open for the container even if no terminal is attached.
# --tty option tells Docker to allocate a virtual terminal for the container, which will allow you to pass signals to the container.
docker stop web_test && docker rm web_test && sleep 1s
docker run --interactive --tty \
  --name web_test \
  --link web:web \
  busybox:1.29 /bin/sh
# insider docker terminal, execute
# wget -O - http://web:80/ # found it connect to web docker and get response
# exit
