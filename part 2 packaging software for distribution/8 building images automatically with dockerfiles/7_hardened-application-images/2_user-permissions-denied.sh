#!/bin/bash
set -x # echo on

docker image build \
  -t dockerinaction/ch8_perm_denied \
  -f Denied.df \
  .

docker container run dockerinaction/ch8_perm_denied
# nc: bind: Permission denied
