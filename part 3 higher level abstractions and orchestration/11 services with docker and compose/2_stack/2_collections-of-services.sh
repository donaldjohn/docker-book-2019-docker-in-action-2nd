#!/bin/bash
set -x # echo on

docker stack deploy -c 2_CollectionsOfServices.yml my-databases

docker service ls

# ID                  NAME                          MODE                REPLICAS            IMAGE                               PORTS
# qek40i5e1i3h        my-databases_adminer          replicated          1/1                 dockerinaction/adminer:4            *:8081->8080/tcp
# 9j3vsnnjy9h2        my-databases_mariadb          replicated          1/1                 dockerinaction/mariadb:10-bionic
# 6nsp80gs394z        my-databases_postgres         replicated          1/1                 dockerinaction/postgres:11-alpine

# after put deploy: replicas: 3 into adminer

#ID                  NAME                          MODE                REPLICAS            IMAGE                               PORTS
# qek40i5e1i3h        my-databases_adminer          replicated          3/3                 dockerinaction/adminer:4            *:8081->8080/tcp
# 9j3vsnnjy9h2        my-databases_mariadb          replicated          1/1                 dockerinaction/mariadb:10-bionic
# 6nsp80gs394z        my-databases_postgres         replicated          1/1                 dockerinaction/postgres:11-alpine

docker stack ps --format '{{.Name}}\t{{.CurrentState}}' my-databases
# my-databases_postgres.1 Running 14 minutes ago
# my-databases_adminer.1  Running 14 minutes ago
# my-databases_mariadb.1  Running 14 minutes ago
# my-databases_adminer.2  Running 4 minutes ago
# my-databases_adminer.3  Running 4 minutes ago

# Scaling down and removing servies
docker stack deploy -c 2_CollectionsOfServices2.yml my-databases

docker stack ps --format '{{.Name}}\t{{.CurrentState}}' my-databases
# my-databases_postgres.1 Running 28 minutes ago
# my-databases_adminer.1  Running 28 minutes ago
# my-databases_mariadb.1  Running 28 minutes ago
# my-databases_adminer.2  Running 18 minutes ago

# Still keeping the "my-databases_mariadb"

# docker service remove
# To remove "my-databases_mariadb": using --prune
docker stack deploy -c 2_CollectionsOfServices2.yml --prune my-databases

docker stack ps --format '{{.Name}}\t{{.CurrentState}}' my-databases
# my-databases_postgres.1 Running 34 minutes ago
# my-databases_adminer.1  Running 34 minutes ago
# my-databases_adminer.2  Running 23 minutes ago

# Stateful services and preserving data
docker stack deploy -c 2_CollectionsOfServices3-volume.yml --prune my-databases

docker volume ls

# http://localhost:8081
# System: PostgreSQL; Server: postgres; Username/password: postgres/example

docker service remove my-databases_postgres

docker stack deploy -c 2_CollectionsOfServices3-volume.yml --prune my-databases

# Port publishing for a service is different from publishing a port on a container
# Whereas containers directly map the port on the host interface to an interface for a specific container,
# services might be made up of many replica containers.
# Docker accommodates services by creating virtual IP (VIP) addresses
# and balancing requests for a specific service between all of the associated replicas.

# Network
# When you’re using services, you’re using at least two Docker networks.
# The first network is named ingress and handles all port forwarding from the host interface to services.
# The second network is shared between all of the services in your stack.
# you'll see that Docker will create a network for your stack named default.
# All services in your stack will be attached to this network by default

docker service inspect my-databases_postgres

docker stack deploy -c 2_CollectionsOfServices4-network.yml --prune my-databases

# There are several occasions to model networks with Compose. For example, if you manage multiple stacks and want to communicate on a shared network, you would declare that network as shown previously, but instead of specifying the driver, you would use the external: true property and the network name.
