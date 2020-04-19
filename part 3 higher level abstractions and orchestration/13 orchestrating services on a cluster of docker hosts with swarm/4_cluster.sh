#!/bin/bash
set -x # echo on

# Will use a five-node swarm cluster created from a Play with Docker template
# - Not idea how to complete the cluster setup

docker service scale multi-tier-app_api=5

docker service ps multi-tier-app_api \
  --filter 'desired-state=running' \
  --format 'table {{.ID}} {{.Name}} {{.Node}} {{.CurrentState}}'
# ID           NAME                 NODE     CURRENT STATE
# dekzyqgcc7fs multi-tier-app_api.1 worker1  Running 4 minutes ago
# 3el58dg6yewv multi-tier-app_api.2 manager1 Running 5 minutes ago
# qqc72ylzi34m multi-tier-app_api.3 manager3 Running about a minute ago
# miyugogsv2s7 multi-tier-app_api.4 manager2 Starting 4 seconds ago
# zrp1o0aua29y multi-tier-app_api.7 worker1  Running 17 minutes ago

docker service update multi-tier-app_api --reserve-cpu 1.0 --limit-cpu 1.0

docker service scale multi-tier-app_api=9
# Insufficient resources to create the 10th api task
docker service scale multi-tier-app_api=10

docker service ps multi-tier-app_api

# If you execute another rollback, Docker will restore the config with 10 service replicas, exhausting resources again.
# That is, Docker will roll back the rollback, leaving us where we started.
docker service rollback multi-tier-app_api

docker stack deploy --compose-file docker-compose.yml multi-tier-app

docker service ps multi-tier-app_api \
  --filter 'desired-state=running' \
  --format 'table {{.ID}} {{.Name}} {{.Node}} {{.CurrentState}}'
# ID           NAME                 NODE     CURRENT STATE
# h0to0a2lbm87 multi-tier-app_api.1 worker1  Running about a minute ago
# v6sq9m14q3tw multi-tier-app_api.2 manager2 Running about a minute ago

docker node update --availability drain manager1
docker node update --availability drain manager2
docker node update --availability drain manager3

docker node ls --format 'table {{ .ID }} {{ .Hostname }} {{ .Availability }}'
# ID                        HOSTNAME AVAILABILITY
# ucetqsmbh23vuk6mwy9itv3xo manager1 Drain
# b0jajao5mkzdd3ie91q1tewvj manager2 Drain
# kxfab99xvgv71tm39zbeveglj manager3 Drain
# rbw0c466qqi0d7k4niw01o3nc worker1  Active
# u2382qjg6v9vr8z5lfwqrg5hf worker2  Active

docker service ps multi-tier-app_api multi-tier-app_postgres \
  --filter 'desired-state=running' \
  --format 'table {{ .Name }} {{ .Node }}'
# NAME                      NODE
# multi-tier-app_postgres.1 worker2
# multi-tier-app_api.1      worker1
# multi-tier-app_api.2      worker2

docker node update --label-add zone=private worker1
# worker1
docker node update --label-add zone=public worker2
# worker2

docker service update \
  --constraint-add 'node.labels.zone == public' \
  multi-tier-app_api

ocker service ps multi-tier-app_api \
  --filter 'desired-state=running' \
  --format 'table {{ .Name }} {{ .Node }}'
# NAME NODE
# multi-tier-app_api.1 worker2
# multi-tier-app_api.2 worker2

for node_id in $(docker node ls -q | head); do
  docker node inspect \
    --format '{{.Description.Hostname}} {{.Spec.Role}} {{.Spec.Labels}}' \
    "${node_id}"
done

# manager1 manager map[]
# manager2 manager map[]
# manager3 manager map[]
# worker1 worker map[zone:private]
# worker2 worker map[zone:public]

curl http://127.0.0.1:8080/counter
# SERVER: c098f30dd3c4
# DB_ADDR: postgres
# DB_PORT: 5432
# ID: 1
# ID: 2
# ID: 3

docker service update --constraint-add 'node.labels.zone == private' \
  multi-tier-app_postgres

docker service ps multi-tier-app_postgres \
  --filter 'desired-state=running' \
  --format 'table {{ .Name }} {{ .Node }}'
# NAME                      NODE
# multi-tier-app_postgres.1 worker1

curl http://127.0.0.1:8080/counter
# SERVER: c098f30dd3c4
# DB_ADDR: postgres
# DB_PORT: 5432
# ID: 1

docker service update --constraint-add 'node.hostname == worker1' \
  multi-tier-app_postgres

docker service inspect \
  --format '{{json .Spec.TaskTemplate.Placement.Constraints }}' \
  multi-tier-app_postgres
# ["node.hostname == worker1","node.labels.zone == private"]

# Uses “global” instead of “replicated”
docker service create --name echo-global \
  --mode global \
  --publish '9000:8' \
  busybox:1.29 nc -v -lk -p 8 -e /bin/cat

docker service ps echo-global \
  --filter 'desired-state=running' \
  --format 'table {{ .Name }} {{ .Node }}'
# NAME                                  NODE
# echo-global.u2382qjg6v9vr8z5lfwqrg5hf worker2
# echo-global.rbw0c466qqi0d7k4niw01o3nc worker1

# [worker1] $
echo 'hello' |  nc 127.0.0.1 -w 3 9000

