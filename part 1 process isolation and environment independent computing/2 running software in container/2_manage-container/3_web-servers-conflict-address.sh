#!/bin/bash
set -x # echo on

docker run -d --name webid nginx
docker run -d --name webid nginx # failed

docker rename webid webid-old
docker run -d --name webid nginx

# using container ID (CID)
# docker exec 7cb5d2b9a7eab87f07182b5bf58936c9947890995b1b94f412912fa822a9ecb5 ps
# docker stop 7cb5d2b9a7eab87f07182b5bf58936c9947890995b1b94f412912fa822a9ecb5
# docker exec 7cb5d2b9a7ea ps # same to take first 12 digits
# docker stop 7cb5d2b9a7ea
