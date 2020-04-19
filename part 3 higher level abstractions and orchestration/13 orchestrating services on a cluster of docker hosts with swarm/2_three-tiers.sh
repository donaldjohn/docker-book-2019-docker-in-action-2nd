#!/bin/bash
set -x # echo on

docker node ls

# ----------------------------------------
# ch13_multi_tier_app-POSTGRES_PASSWORD
# ----------------------------------------
docker secret rm ch13_multi_tier_app-POSTGRES_PASSWORD
echo 'mydbpass72' | docker secret create ch13_multi_tier_app-POSTGRES_PASSWORD -
docker secret ls --format "table {{.ID}} {{.Name}} {{.CreatedAt}}"

# ----------------------------------------
# Stack
# ----------------------------------------
docker stack rm multi-tier-app

docker stack deploy \
  --compose-file ./ch13_multi_tier_app/docker-compose.yml \
  multi-tier-app

docker service logs --follow multi-tier-app_api

docker service ps \
  --format "table {{.ID}} {{.Name}} {{.Node}} {{.CurrentState}}" \
  multi-tier-app_api
# ID NAME NODE CURRENT STATE
# zb51iw7mw3t3 multi-tier-app_api.1 docker-desktop Running 5 minutes ago
# pminyzaqf3i2 multi-tier-app_api.2 docker-desktop Running 5 minutes ago

docker container ps --format "table {{.ID}} {{.Names}} {{.Status}}"

curl http://localhost:8080

# Response from 2 servers
for i in $(seq 1 4); do
  curl http://localhost:8080
  sleep 1
done

docker service inspect --format="{{json .Endpoint.Spec.Ports}}" \
  multi-tier-app_api | jq

docker service inspect --format '{{ json .Endpoint.VirtualIPs }}' \
  multi-tier-app_api | jq

docker container run --rm -it --network multi-tier-app_private \
  alpine:3.8 sh # because attachable: true
ping -c 1 postgres
# PING postgres (10.0.3.2): 56 data bytes
# 64 bytes from 10.0.3.2: seq=0 ttl=64 time=0.217 ms
#
# --- postgres ping statistics ---
# 1 packets transmitted, 1 packets received, 0% packet loss
# round-trip min/avg/max = 0.217/0.217/0.217 ms
ping -c 1 api
# PING api (10.0.3.5): 56 data bytes
# 64 bytes from 10.0.3.5: seq=0 ttl=64 time=0.149 ms
#
# --- api ping statistics ---
# 1 packets transmitted, 1 packets received, 0% packet loss
# round-trip min/avg/max = 0.149/0.149/0.149 ms
printf 'GET / HTTP/1.0\nHost: api\n\n' | nc api 80
nc -vz postgres 5432
