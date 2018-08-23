FROM debian:stretch-slim
LABEL maintainer="Oleg Dianov <odidoit@gmail.com>"

ENV GRAFANA_VERSION=5.2.2 \
  GRAFANA_PATHS_CONF=/etc/grafana \
  GRAFANA_PATHS_DATA=/var/lib/grafana \
  GRAFANA_PATHS_LOG=/var/log/grafana

RUN apt-get update && \
    apt-get -qq -y install curl libfontconfig wget openssl ca-certificates && \
    wget https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana_${GRAFANA_VERSION}_amd64.deb -O /tmp/grafana.deb && \
    dpkg -i /tmp/grafana.deb && \
    rm /tmp/grafana.deb && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists

COPY docker-entrypoint.sh /

CMD ["/docker-entrypoint.sh"]
