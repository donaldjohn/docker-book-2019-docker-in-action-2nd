#!/bin/bash
set -x # echo on

version=0.6

docker image build \
  -t dockerinaction/mailer-base:${version} \
  -f mailer-base.df \
  --build-arg VERSION=${version} \
  .

docker image inspect \
  --format '{{ json .Config.Labels }}' \
  dockerinaction/mailer-base:0.6 | jq
# {
#   "base.name": "Mailer Archetype",
#   "base.version": "0.6",
#   "maintainer": "dia@allingeek.com"
# }
