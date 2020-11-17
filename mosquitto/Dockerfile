FROM eclipse-mosquitto:1.6
COPY credentials /mosquitto/config
RUN mosquitto_passwd -U /mosquitto/config/credentials
RUN chown -R mosquitto:mosquitto /mosquitto/config/credentials
COPY config /mosquitto/config
RUN chown -R mosquitto:mosquitto /mosquitto/config
RUN apk add tree
RUN tree  -a ./mosquitto/config
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["mosquitto","-c","/mosquitto/config/mosquitto.conf"]
