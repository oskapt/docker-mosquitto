#!/bin/bash

set -e

if [[ ! -f /mqtt/config/mosquitto.conf ]]; then
    # copy default config
    echo "Copying default configuration to /mqtt/config"
    cp -R /usr/share/mosquitto/config/* /mqtt/config/
fi

# Passing arguments
if [[ "${1:0:1}" = '-' ]]; then
  set -- /usr/sbin/mosquitto "$@"
fi

exec "$@"
