#!/bin/bash
set -x # echo on

VOLUME_ID=$(docker volume create --driver=local)
# Outputs:
# 462d0bb7970e47512cd5ebbbb283ed53d5f674b9069b013019ff18ccee37d75d

docker volume remove ${VOLUME_ID}
# Outputs:
# 462d0bb7970e47512cd5ebbbb283ed53d5f674b9069b013019ff18ccee37d75d
