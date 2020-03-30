#!/bin/bash
set -x # echo on

/bin/bash 1_run-nginx.sh
/bin/bash 2_run-mailer.sh
# -i = --interactive; -t = --tty
docker stop agent && docker rm agent && sleep 1s
docker run -it --name agent \
  --link web:insideweb \
  --link mailer:insidemailer \
  dockerinaction/ch2_agent
# Ctrl+P or Ctrl+Q
# $INSIDEWEB_PORT_80_TCP_ADDR # docker env variable?
# $INSIDEWEB_PORT_80_TCP_PORT
