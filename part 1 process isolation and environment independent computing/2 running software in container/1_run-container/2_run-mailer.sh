#!/bin/bash
set -x # echo on

docker stop mailer && docker rm mailer && sleep 1s
# -d is --detach
docker run -d --name mailer dockerinaction/ch2_mailer # run docker from DockerHub
# /bin/bash docker/ch2_mailer.sh
# docker run -d --name mailer shijiansu/ch2_mailer # run docker from local, build image first
