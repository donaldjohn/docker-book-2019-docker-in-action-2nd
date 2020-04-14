#!/bin/bash
set -x # echo on

docker run --rm debian:stretch find / -perm /u=s -type f

docker container run --rm debian:stretch find / -perm /g=s -type f
