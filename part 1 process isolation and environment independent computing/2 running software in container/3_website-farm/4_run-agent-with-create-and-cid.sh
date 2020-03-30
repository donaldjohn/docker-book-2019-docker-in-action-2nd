#!/bin/bash
set -x # echo on

# run mailer
MAILER_CID=$(docker run -d dockerinaction/ch2_mailer)

# run web
WEB_CID=$(docker run -d nginx)

# run agent
AGENT_CID=$(docker run -d \
    --link $WEB_CID:insideweb \
    --link $MAILER_CID:insidemailer \
    dockerinaction/ch2_agent)
