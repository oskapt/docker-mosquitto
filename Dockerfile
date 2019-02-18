FROM debian:stretch

ENV MQTT_CONFIG_DIR /mqtt/config
ENV MQTT_CONFIG $MQTT_CONFIG_DIR/mosquitto.conf
ENV MQTT_DATA_DIR /mqtt/data

RUN apt-get -qq update && apt-get install -qq -y mosquitto mosquitto-clients && \
    adduser --system --disabled-password --disabled-login mosquitto

RUN mkdir -p /mqtt/config /mqtt/data
COPY config $MQTT_CONFIG_DIR
RUN chown -R mosquitto:mosquitto $MQTT_CONFIG_DIR $MQTT_DATA_DIR
VOLUME ["$MQTT_CONFIG_DIR", "$MQTT_DATA_DIR"]

EXPOSE 1883 9001

ADD docker-entrypoint.sh /usr/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/usr/sbin/mosquitto", "-c", "$MQTT_CONFIG"]
