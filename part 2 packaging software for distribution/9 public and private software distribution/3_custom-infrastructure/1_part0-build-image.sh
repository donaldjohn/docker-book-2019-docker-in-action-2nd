#!/bin/bash
set -x # echo on

docker image build \
  -t shijiansu/ch9_ftpd \
  -f ../docker/ch9_ftpd/Dockerfile ../docker/ch9_ftpd

docker image build \
  -t shijiansu/ch9_ftp_client \
  -f ../docker/ch9_ftp_client/Dockerfile ../docker/ch9_ftp_client
