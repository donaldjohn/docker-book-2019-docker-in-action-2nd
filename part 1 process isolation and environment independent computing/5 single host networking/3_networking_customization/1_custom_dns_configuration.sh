#!/bin/bash
set -x # echo on

# not really working as expected

# Sets the container hostname
docker run --rm \
  --hostname barker \
  busybox:1 \
  nslookup barker 8.8.8.8
# Resolves the hostname to an IP address
# Server:    8.8.8.8
# Address 1: 8.8.8.8 dns.google
#
# Name:      barker
# Address 1: 172.17.0.3 barker

# Sets primary DNS server --dns 8.8.8.8
docker run --rm \
  --dns 8.8.8.8 \
  busybox:1 \
  nslookup docker.com
# Resolves IP address of docker.com
# nslookup: can't resolve '(null)': Name does not resolve
#
# Name:      docker.com
# Address 1: 3.212.25.17 ec2-3-212-25-17.compute-1.amazonaws.com
# Address 2: 3.223.190.6 ec2-3-223-190-6.compute-1.amazonaws.com
# Address 3: 54.80.30.136 ec2-54-80-30-136.compute-1.amazonaws.com

# Sets search domain
docker run --rm \
  --dns-search docker.com \
  busybox:1 \
  nslookup hub
# Looks up shortcut for hub.docker.com

# Sets search domain
docker run --rm \
  --dns-search docker.com \
  --dns 1.1.1.1 \
  busybox:1 cat /etc/resolv.conf
# Sets primary DNS server

# Note dev prefix.
docker run --rm \
  --dns-search dev.mycompany \
  busybox:1 \
  nslookup myservice
# Resolves to myservice.dev.mycompany

# Note test prefix.
docker run --rm \
  --dns-search test.mycompany \
  busybox:1 \
  nslookup myservice
# Resolves to myservice.test.mycompany

# Adds host entry
docker run --rm \
  --add-host test:10.10.10.255 \
  busybox:1 \
  nslookup test
# Resolves to 10.10.10.255

# Sets hostname
docker run --rm \
  --hostname mycontainer \
  --add-host docker.com:127.0.0.1 \
  --add-host test:10.10.10.2 \
  busybox:1 \
  cat /etc/hosts
# Views all entries
