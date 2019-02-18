FROM debian:stretch

ENV MQTT_CONFIG /mqtt/config/mosquitto.conf

RUN apt-get -qq update && apt-get install -qq -y mosquitto mosquitto-clients && \
    adduser --system --disabled-password --disabled-login mosquitto

RUN mkdir -p /usr/share/mosquitto/config /mqtt/config /mqtt/data /mqtt/log
COPY config /usr/share/mosquitto/config
RUN chown -R mosquitto:mosquitto /mqtt
VOLUME ["/mqtt/config", "/mqtt/data", "/mqtt/log"]

EXPOSE 1883 9001

ADD docker-entrypoint.sh /usr/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/usr/sbin/mosquitto", "-c", "$MQTT_CONFIG"]
