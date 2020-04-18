#!/bin/bash
set -x # echo on

docker stack rm greetings_dev

export DEPLOY_ENV=dev
docker stack deploy --compose-file ./ch12_greetings/docker-compose.yml greetings_dev

# http://localhost:8080/
# Welcome to the Greetings API Server!
# Container with id 4ce1c93586a7 responded at 2020-04-17 05:57:20.0484278 +0000 UTC
# DEPLOY_ENV: dev

# http://localhost:8080/greeting
# config.dev.yml properties are merged with config.common.yml

docker config inspect greetings_dev_env_specific_config

docker service inspect \
  --format '{{ json .Spec.TaskTemplate.ContainerSpec.Configs }}' \
  greetings_dev_api | jq
