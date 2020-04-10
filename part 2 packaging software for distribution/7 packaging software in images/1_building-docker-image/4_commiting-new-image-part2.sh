#!/bin/bash
set -x # echo on

# -a: auther
# -m: message
# image-dev: new image from this container
# ubuntu-git: new image name
docker container commit \
  -a "@shijiansu" \
  -m "Added git" \
  image-dev ubuntu-git

docker images | grep ubuntu-git

# git version 2.17.1
docker container run --rm ubuntu-git git version

# get nothing
docker container run --rm ubuntu-git

# That's because the command you started the original container with was committed with the new image. The command you used to start the container that the image was created by was `/bin/bash`.

# When you create a container from this image by using the default command, it will start a shell and immediately exit. That's not a terribly useful default command.

# It would be better to set an entrypoint on the image to git. An entrypoint is the program that will be executed when the container starts.
