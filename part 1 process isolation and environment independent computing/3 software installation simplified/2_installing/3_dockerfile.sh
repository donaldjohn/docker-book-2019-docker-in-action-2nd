#!/bin/bash
set -x # echo on

git clone https://github.com/dockerinaction/ch3_dockerfile.git
docker build -t dia_ch3/dockerfile:latest ch3_dockerfile
docker rmi dia_ch3/dockerfile
rm -rf ch3_dockerfile
