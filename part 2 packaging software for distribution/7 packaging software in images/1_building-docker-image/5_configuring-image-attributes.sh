#!/bin/bash
set -x # echo on

# use docker container commit, you commit a new layer to an image

# all the following will carry forward with an image created from the container:
# - All environment variables
# - The working directory
# - The set of exposed ports
# - All volume definitions
# - The container entrypoint
# - Command and arguments

docker container rm -vf rich-image-example-2
docker container rm -vf rich-image-example

# Layer 1
# Creates environment variable specialization
docker container run \
  --name rich-image-example \
  -e ENV_EXAMPLE1=Rich \
  -e ENV_EXAMPLE2=Example \
  busybox:latest

# Commits image
docker container commit rich-image-example rie

# Outputs: Rich Example
docker container run --rm rie \
  /bin/sh -c "echo \$ENV_EXAMPLE1 \$ENV_EXAMPLE2"

# Layer 2
# Sets default entrypoint
# Sets default command
docker container run \
  --name rich-image-example-2 \
  --entrypoint "/bin/sh" \
  rie \
  -c "echo \$ENV_EXAMPLE1 \$ENV_EXAMPLE2"

# Commits image
docker container commit rich-image-example-2 rie

# Different command with same output
docker container run --rm rie
