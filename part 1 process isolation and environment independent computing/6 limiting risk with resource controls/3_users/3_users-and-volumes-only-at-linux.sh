#!/bin/bash
set -x # echo on

# Cannot verify in MacOS as it is not running Docker natively

logFiles="/tmp/logFiles"

mkdir "${logFiles}"

sudo chown 2000:2000 "${logFiles}"

docker container run --rm -v "${logFiles}":/logFiles \
  -u 2000:2000 ubuntu:16.04 \
  /bin/bash -c "echo This is important info > /logFiles/important.log"

# Appends to log from another container
docker container run --rm -v "${logFiles}":/logFiles \
  -u 2000:2000 ubuntu:16.04 \
  /bin/bash -c "echo More info >> /logFiles/important.log"

sudo rm -r logFiles
