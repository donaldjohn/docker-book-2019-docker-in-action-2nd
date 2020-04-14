#!/bin/bash
set -x # echo on

docker image pull registry:2

docker image save -o ./registry.2.tar registry:2
