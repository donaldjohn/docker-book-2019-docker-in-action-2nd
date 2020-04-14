#!/bin/bash
set -e
if [ -n "$WEB_PORT_80_TCP" ]; then
  if [ -z "$WEB_HOST" ]; then
    WEB_HOST='web'
  else
    echo >&2 '[WARN]: Linked container, "web" overridden by $WEB_HOST.'
    echo >&2 "===> Connecting to WEB_HOST ($WEB_HOST)"
  fi
fi
if [ -z "$WEB_HOST" ]; then
  echo >&2 '[ERROR]: specify container to link; "web" or WEB_HOST env var'
  exit 1
fi
exec "$@" # run the default command
