docker-mosquitto
================

Docker image for mosquitto, optimized for running under Kubernetes.

## Run

This container exposes Port 1883 (MQTT) and 9001 (Websocket MQTT)

```yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: mqtt
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mosquitto
  strategy:
    rollingUpdate:
      maxSurge: 0
      maxUnavailable: 1
    type: RollingUpdate
  template:
    metadata:
      labels:
        app: mosquitto
    spec:
      containers:
      - image: monachus/mosquitto:latest
        name: mqtt
        ports:
        - containerPort: 1883
          name: 1883tcp02
          protocol: TCP
        - containerPort: 9001
          name: 9001tcp02
          protocol: TCP
          name: mqtt-config
```


## Running with persistence

Persistence is enabled by default. 

### Local directories / External Configuration

Mount a volume under `/etc/mosquitto` for persistent configuration data.

Although the configuration data in this repository is copied in at build time, use a ConfigMap to change it at runtime:

```yaml
apiVersion: v1
metadata:
  name: mosquitto
kind: ConfigMap
data:
  mosquitto.conf: |-
    pid_file /var/run/mosquitto.pid
    persistence true
    persistence_location /var/lib/mosquitto/
    user mosquitto
    port 1883
    log_dest stdout

    listener 9001
    protocol websockets
```

Mount a volume under `/var/lib/mosquito` for persistent storage of the MQTT data.

## Logging

This container only logs to stdout.




