#!/bin/bash
set -x # echo on

# --workdir , -w: Working directory inside the container
# build heelowworld.go to "hello"
docker container run --rm \
  -v "$(pwd)":/usr/src/hello \
  -w /usr/src/hello \
  golang:1.9 go build -v

# package "hello" in a tarball
tar -cf static_hello.tar hello

# Tar file streamed via UNIX pipe
# -c flag to specify a Dockerfile command. The command you use sets the entrypoint for the new image.
# - at the end of the fisrt line: indicates that the contents of the tarball will be streamed through stdin
docker import -c "ENTRYPOINT [\"/hello\"]" - \
  dockerinaction/ch7_static < static_hello.tar

# Outputs: hello, world!
docker container run dockerinaction/ch7_static

docker history dockerinaction/ch7_static
