#!/bin/bash
set -x # echo on

docker ps
docker restart web
docker restart mailer
docker restart agent

docker logs web # docker logs web -f # --follow
docker logs mailer
docker logs agent

docker stop web
docker logs mailer
# Sending email: To: admin@work  Message: The service is down!
