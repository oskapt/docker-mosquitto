#!/bin/bash

set -e

: ${MQTT_CONFIG_DIR:=/etc/mosquitto}
: ${MQTT_CONFIG:=${MQTT_CONFIG_DIR}/mosquitto.conf}

# MQTT_DATA might be unset
if [[ -z $MQTT_DATA_DIR ]]; then
    MQTT_DATA_DIR=$(grep persistence_location $MQTT_CONFIG | awk '{ print $2 }')
fi

# Set permissions on $MQTT_DATA_DIR (if it is defined and exists)
if [[ -n $MQTT_DATA_DIR_DIR && -d $MQTT_DATA ]]; then
    # set permissions
    chmod -R mosquitto:mosquitto $MQTT_DATA_DIR
fi

# Passing arguments
if [[ "${1:0:1}" = '-' ]]; then
  set -- /usr/sbin/mosquitto "$@"
fi

exec "$@"
