FROM redis:3.2.12-alpine
LABEL maintainer="Oleg Dianov <odidoit@gmail.com>"

RUN apk add --no-cache tini bash

ENV REDIS_SENTINEL_CONF_PATH=/etc/redis/sentinel.conf \
  REDIS_SENTINEL_PORT=26379 \
  REDIS_SENTINEL_QUORUM=2 \
  REDIS_SENTINEL_DOWN_AFTER=40000 \
  REDIS_SENTINEL_FAILOVER_TIMEOUT=10000 \
  REDIS_MASTER_GROUP=redis-master \
  REDIS_MASTER_IP=127.0.0.1 \
  REDIS_MASTER_PORT=6379

COPY sentinel.conf ${REDIS_SENTINEL_CONF_PATH}
COPY docker-entrypoint.sh /docker-entrypoint.sh

EXPOSE 26379

ENTRYPOINT ["/sbin/tini", "--", "/docker-entrypoint.sh"]
