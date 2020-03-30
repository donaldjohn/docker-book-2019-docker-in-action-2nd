#!/bin/bash
set -x # echo on

source 2_wordpress-multi-clients-part1-cids.sh
for i in {1..5}; do
  export CLIENT_ID="dockerinaction-client-$i"
  /bin/bash 2_wordpress-multi-clients-part2-start.sh
done
