#!/bin/bash
set -x # echo on

# Executes bash command
docker container run --name image-dev2 \
  --entrypoint /bin/bash \
  ubuntu-git:latest -c "apt-get remove -y git"
# Removes Git

# Comimts image
docker container commit image-dev2 ubuntu-git:removed

# Reassigns lastest tag
docker image tag ubuntu-git:removed ubuntu-git:latest

# Examines image sizes
docker image ls

# Notice that even though you removed Git, the image actually increased in size.

docker image history ubuntu-git:removed
