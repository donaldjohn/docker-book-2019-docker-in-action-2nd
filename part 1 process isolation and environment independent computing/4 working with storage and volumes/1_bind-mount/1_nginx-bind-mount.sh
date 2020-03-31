#!/bin/bash
set -x # echo on

docker stop diaweb && docker rm diaweb && sleep 1s

example_log=/tmp/example.log
example_conf=/tmp/example.conf

rm "$example_log"
rm "$example_conf"

touch "$example_log"
cat >"$example_conf" <<EOF
server {
  listen 80;
  server_name localhost;
  access_log /var/log/nginx/custom.host.access.log main;
  location / {
    root /usr/share/nginx/html;
    index index.html index.htm;
  }
}
EOF

CONF_SRC="$example_conf"
CONF_DST=/etc/nginx/conf.d/default.conf
LOG_SRC="$example_log"
LOG_DST=/var/log/nginx/custom.host.access.log

docker run -d --name diaweb \
  --mount type=bind,src=${CONF_SRC},dst=${CONF_DST},readonly=true \
  --mount type=bind,src=${LOG_SRC},dst=${LOG_DST} \
  -p 80:80 \
  nginx:latest

# writing the log to local log file
curl http://localhost/
cat "$example_log"

# failed as readonly=true
docker exec diaweb sed -i "s/listen 80/listen 8080/" /etc/nginx/conf.d/default.conf
