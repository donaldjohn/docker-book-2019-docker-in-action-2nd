#!/bin/bash
set -x # echo on

# creates a new local bridge network named user-network.
# as attachable allows you to attach and detach containers to the networ.
# receive IP addresses in the range from 10.0.42.128 to 10.0.42.255
docker network create \
  --driver bridge \
  --label project=dockerinaction \
  --label chapter=5 \
  --attachable \
  --scope local \
  --subnet 10.0.42.0/24 \
  --ip-range 10.0.42.128/25 \
  user-network

docker rm -f network-explorer
# bridge network
docker run -it \
  --network user-network \
  --name network-explorer \
  alpine:3.8 \
  sh

# Get a list of the IPv4 addresses available
# ip -f inet -4 -o addr

# 1: lo    inet 127.0.0.1/8 scope host lo\       valid_lft forever preferred_lft forever
# 361: eth0    inet 10.0.42.129/24 brd 10.0.42.255 scope global eth0\       valid_lft forever preferred_lft forever

docker network create \
  --driver bridge \
  --label project=dockerinaction \
  --label chapter=5 \
  --attachable \
  --scope local \
  --subnet 10.0.43.0/24 \
  --ip-range 10.0.43.128/25 \
  user-network2

# Once the second network has been created, you can attach the network-explorer container (still running):
# user-network2: Network name (or ID); network-explorer: Target container name (or ID)
docker network connect \
  user-network2 \
  network-explorer

# After the container has been attached to the second network, reattach your terminal to continue your exploration:
# docker attach network-explorer
# ip -f inet -4 -o addr

# 1: lo    inet 127.0.0.1/8 scope host lo\       valid_lft forever preferred_lft forever
# 364: eth0    inet 10.0.42.129/24 brd 10.0.42.255 scope global eth0\       valid_lft forever preferred_lft forever
# 366: eth1    inet 10.0.43.129/24 brd 10.0.43.255 scope global eth1\       valid_lft forever preferred_lft forever

# Install the nmap package inside your running container by using this command:
# apk update && apk add nmap

# scan the 10.0.42.0/24 subnet that we defined for our bridge network:
# nmap -sn 10.0.42.* -sn 10.0.43.* -oG /dev/stdout | grep Status

# Host: 10.0.42.128 ()    Status: Up
# Host: 10.0.42.129 (d1a73c79239b)        Status: Up
# Host: 10.0.43.128 ()    Status: Up
# Host: 10.0.43.129 (d1a73c79239b)        Status: Up

# only two devices are attached to each of the bridge networks: the gateway adapters created by the bridge network driver and the currently running container.

docker run -d \
  --name lighthouse \
  --network user-network2 \
  alpine:3.8 \
sleep 1d

# reattach to your network-explorer container:
# docker attach network-explorer

# nmap -sn 10.0.42.* -sn 10.0.43.* -oG /dev/stdout | grep Status

# Host: 10.0.42.128 ()    Status: Up
# Host: 10.0.42.129 (d1a73c79239b)        Status: Up
# Host: 10.0.43.128 ()    Status: Up
# Host: 10.0.43.130 (lighthouse.user-network2)    Status: Up
# Host: 10.0.43.129 (d1a73c79239b)        Status: Up

# Discovering the lighthouse container on the network confirms that the network attachment works as expected, and demonstrates how the DNS-based service discov- ery system works.

# Running nslookup lighthouse inside the container. Container hostnames are based on the container name, or can be set manually at con- tainer creation time by specifying the --hostname flag.

# nslookup lighthouse

# nslookup: can't resolve '(null)': Name does not resolve
# Name:      lighthouse
# Address 1: 10.0.43.130 lighthouse.user-network2
