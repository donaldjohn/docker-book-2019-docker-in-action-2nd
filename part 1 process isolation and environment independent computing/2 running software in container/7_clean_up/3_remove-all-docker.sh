#!/bin/bash
set -x # echo on

docker rm -vf $(docker ps -a -q)
