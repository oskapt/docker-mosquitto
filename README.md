docker-mosquitto
================

Docker image for mosquitto

## Run

    docker run -ti -p 1883:1883 -p 9001:9001 monachus/mosquitto

Exposes Port 1883 (MQTT) 9001 (Websocket MQTT)

## Running with persistence


### Local directories / External Configuration

Mount persistent volumes under `/mqtt/{config,data}` for configuration and persistence.

If mounting the configuration directory for the first time, the `entrypoint` script will
copy in the default configuration.

This container only logs to stdout.

    docker run -ti -p 1883:1883 -p 9001:9001 \
    -v /srv/mqtt/config:/mqtt/config:ro \
    -v /srv/mqtt/data/:/mqtt/data/ \
    --name mqtt monachus/mosquitto

Volumes: /mqtt/config, /mqtt/data 



