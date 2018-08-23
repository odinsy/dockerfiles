#!/usr/bin/env bash
set -e

GRAFANA="/usr/sbin/grafana-server"
GRAFANA_OPTS="--homepath=/usr/share/grafana \
              --config=${GRAFANA_PATHS_CONF}/grafana.ini \
              cfg:default.paths.data=${GRAFANA_PATHS_DATA} \
              cfg:default.paths.logs=${GRAFANA_PATHS_LOG} \
              cfg:default.paths.provisioning=${GRAFANA_PATHS_CONF}/provisioning"

chown -R grafana: ${GRAFANA_PATHS_CONF} ${GRAFANA_PATHS_DATA} ${GRAFANA_PATHS_LOG}

exec ${GRAFANA} ${GRAFANA_OPTS} "$@"
