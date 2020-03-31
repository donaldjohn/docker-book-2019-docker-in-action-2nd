#!/bin/bash
set -x # echo on

#  [REGISTRYHOST:PORT/][USERNAME/]NAME[:TAG]
docker pull quay.io/dockerinaction/ch3_hello_registry:latest

docker rmi quay.io/dockerinaction/ch3_hello_registry
