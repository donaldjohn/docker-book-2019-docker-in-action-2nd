#!/bin/bash
set -x # echo on

docker pull busybox:latest # pull image
docker save -o myfile.tar busybox:latest # save image as file
docker rmi busybox # ensure there is no image anymore
docker load -i myfile.tar # load file
rm myfile.tar # remove file as testing
