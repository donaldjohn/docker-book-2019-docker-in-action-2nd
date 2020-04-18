#!/bin/bash
set -x # echo on

docker stack deploy -c 1_HelloWorldService.yml hello-world-2
# Creating network hello-world-2_default
# Creating service hello-world-2_hello-world-2

docker service ls
# ID                  NAME                          MODE                REPLICAS            IMAGE                               PORTS
# t0k7o76ytrtw        hello-world-2_hello-world-2   replicated          3/3                 dockerinaction/ch11_service_hw:v1   *:8080->80/tcp

docker container ps
# CONTAINER ID        IMAGE                               COMMAND             CREATED             STATUS                    PORTS               NAMES
# 981d3c7d6f42        dockerinaction/ch11_service_hw:v1   "/bin/service"      30 seconds ago      Up 29 seconds (healthy)                       hello-world-2_hello-world-2.2.1m7sl5tnj198189sb7wbphi9u
# 99f738c443e4        dockerinaction/ch11_service_hw:v1   "/bin/service"      30 seconds ago      Up 29 seconds (healthy)                       hello-world-2_hello-world-2.1.6p2cs3lu9r61pi6hyz8v54yw2
# 244f506a2012        dockerinaction/ch11_service_hw:v1   "/bin/service"      31 seconds ago      Up 29 seconds (healthy)                       hello-world-2_hello-world-2.3.95zuetxe13u03242trcjyglyk
