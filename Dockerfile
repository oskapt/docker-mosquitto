FROM debian:stretch

RUN apt-get -qq update && apt-get install -qq -y mosquitto mosquitto-clients

COPY config /etc/mosquitto
VOLUME ["/etc/mosquitto"]

EXPOSE 1883 9001

ADD docker-entrypoint.sh /usr/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/usr/sbin/mosquitto", "-c", "/etc/mosquitto/mosquitto.conf"]
