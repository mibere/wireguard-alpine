FROM alpine:edge
COPY start-wg /usr/local/bin/
RUN apk upgrade --no-cache && \
	apk add --no-cache wireguard-tools libqrencode && \
  chmod 755 /usr/local/bin/start-wg && \
  mkdir -p /etc/wireguard/ && \
  rm -rf /var/cache/apk/* /tmp/* /var/tmp/* /var/log/*
VOLUME ["/etc/wireguard/"]
ENV WG_ENDPOINT_RESOLUTION_RETRIES="infinity"
ENV DNS="192.168.1.1"
ENV ENDPOINT="my.dyn.dns"
CMD ["/usr/local/bin/start-wg"]
