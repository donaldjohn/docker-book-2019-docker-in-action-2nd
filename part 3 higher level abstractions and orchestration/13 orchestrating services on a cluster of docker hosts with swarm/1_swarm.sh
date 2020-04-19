#!/bin/bash
set -x # echo on

# ----------------------------------------
# ch12_greetings-svc-prod-TLS_PRIVATE_KEY_V1
# ----------------------------------------
docker secret rm ch12_greetings-svc-prod-TLS_PRIVATE_KEY_V1

# insecure.key - private key
# – (hyphen) character to indicate that the value will be provided via standard input
#cat ./ch12_greetings/api/config/insecure.key | docker secret create ch12_greetings-svc-prod-TLS_PRIVATE_KEY_V1 -
docker secret create ch12_greetings-svc-prod-TLS_PRIVATE_KEY_V1 - <./ch12_greetings/api/config/insecure.key
# sryn9nadqztxhcz6d2ag8kv01

docker secret inspect ch12_greetings-svc-prod-TLS_PRIVATE_KEY_V1
# Once you load a secret into Swarm, you cannot retrieve it by using the docker CLI. The secret is available only to services that use it.
# You may also notice that the secret’s spec does not contain any labels, as it is managed outside the scope of a stack.

# The ch12_greetings-svc-prod-TLS_PRIVATE_KEY_V1 secret will be mapped into the container, in the file cert_private_key.pem.
# The default location for secret files is /run/secrets/.
# This application looks for the location of its private key and certificate in environment variables, so those are also defined with fully qualified paths to the files.
# For example, the CERT_PRIVATE_KEY_FILE environment variable’s value is set to /run/secrets/cert_private_key.pem.

# ----------------------------------------
# ch12_greetings_svc- prod-TLS_CERT_V1
# ----------------------------------------
# This config resource contains the public, nonsensitive, x.509 certificate the greetings application will use to offer HTTPS services.
docker config create ch12_greetings_svc-prod-TLS_CERT_V1 ./ch12_greetings/api/config/insecure.crt

# ----------------------------------------
# Stack
# ----------------------------------------
docker stack rm greetings_prod

export DEPLOY_ENV=prod
docker stack deploy \
  --compose-file ./ch12_greetings/docker-compose.yml \
  --compose-file ./ch12_greetings/docker-compose.prod.yml \
  greetings_prod

docker service logs --since 1m greetings_prod_api

# https://localhost:8443
