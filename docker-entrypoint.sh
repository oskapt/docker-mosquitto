#!/bin/bash

set -e

if [[ ! -f /mqtt/config/mosquitto.conf ]]; then
    # copy default config
    echo "Copying default configuration to /mqtt/config"
    cp -R /usr/share/mosquitto/config/* /mqtt/config/
fi

exec "$@"
