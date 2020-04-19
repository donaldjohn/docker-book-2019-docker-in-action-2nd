#!/bin/bash
set -x # echo on

# port 8000
docker service create --name echo --publish '8000:8' busybox:1.29 \
  nc -v -lk -p 8 -e /bin/cat

echo "Hello netcat my old friend, I've come to test connections again." |
  nc -v -w 3 "$(hostname)" 8000
# Hello netcat my old friend, I've come to test connections again.

# Clients should connect to shared services by using a port published by that service.
# The api service needs to connect to the port published by the echo service at the cluster’s edge, just like processes running outside the Swarm cluster.
# The only route to the echo service is through the ingress network.
docker container run --rm -it --network multi-tier-app_private \
    alpine:3.8 sh

# echo service’s name doesn’t resolve when attached to the multi-tier-app_private network.
ping -c 1 echo
# ping: bad address 'echo'

nslookup echo
# nslookup: can't resolve '(null)': Name does not resolve

# We can say a few good things about this design.
# - First, all clients reach the echo ser- vice in a uniform way, through a published port.
# - Second, because we didn’t join the echo service to any networks (besides the implicit ingress network join), it is isolated and cannot connect to other services, except for those that are published.
# - Third, Swarm has pushed application authentication responsibilities into the application layer, where they belong.
