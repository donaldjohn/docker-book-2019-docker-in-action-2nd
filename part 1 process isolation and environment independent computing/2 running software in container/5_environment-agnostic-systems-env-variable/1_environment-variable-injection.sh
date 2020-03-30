#!/bin/bash
set -x # echo on

docker run --env MY_ENVIRONMENT_VAR="this is a test" busybox:latest env

# PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
# HOSTNAME=36d029e8826c
# MY_ENVIRONMENT_VAR=this is a test
# HOME=/root
