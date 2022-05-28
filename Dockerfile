FROM alpine:edge
COPY start-wg /usr/local/bin/
RUN apk upgrade --no-cache && \
	apk add --no-cache ca-certificates wireguard-tools libqrencode netcat-openbsd && \
	chmod 755 /usr/local/bin/start-wg && \
	mkdir -p /etc/wireguard/ && \
	rm -rf /var/cache/apk/* /tmp/* /var/tmp/* /var/log/*
ENV WG_ENDPOINT_RESOLUTION_RETRIES="infinity"
ENV DNS="192.168.1.1"
ENV ENDPOINT="my.dyn.dns"
HEALTHCHECK --start-period=15s --interval=120s --timeout=15s CMD nc -z -v -u 127.0.0.1 48651 >/dev/null 2>&1 || exit 1
CMD ["/usr/local/bin/start-wg"]
