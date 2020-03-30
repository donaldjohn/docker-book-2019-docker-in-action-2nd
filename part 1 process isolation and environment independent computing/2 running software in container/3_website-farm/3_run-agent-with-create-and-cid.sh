#!/bin/bash
set -x # echo on

# run mailer
MAILER_CID=$(docker run -d dockerinaction/ch2_mailer)

# create web
WEB_CID=$(docker create nginx)

# create agent
AGENT_CID=$(docker create \
  --link $WEB_CID:insideweb \
  --link $MAILER_CID:insidemailer \
  dockerinaction/ch2_agent)

# after manual verify containers are created, then start containers
docker ps -a # ps - running docker; -a - all docker
docker start "${WEB_CID}"
docker start "${AGENT_CID}" # dependencies, must start web first then agent
