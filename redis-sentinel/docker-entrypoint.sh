#!/usr/bin/env bash

set -e

REDIS_PARAMS=(
  REDIS_SENTINEL_PORT
  REDIS_SENTINEL_QUORUM
  REDIS_SENTINEL_DOWN_AFTER
  REDIS_SENTINEL_FAILOVER_TIMEOUT
  REDIS_MASTER_GROUP
  REDIS_MASTER_IP
  REDIS_MASTER_PORT
)

for param in "${REDIS_PARAMS[@]}"; do
  param_value="$(eval printf %s \"\$$param\")"
  sed -i "s|\$$param|$param_value|g" "$REDIS_SENTINEL_CONF_PATH"
done

chown -R redis /etc/redis
exec su-exec redis redis-server "$REDIS_SENTINEL_CONF_PATH" --sentinel "$@"

exec "$@"
