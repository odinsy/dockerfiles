#!/usr/bin/env bash

set -e

ulimit -n 1000000

BEANSTALKD="/usr/bin/beanstalkd"
BEANSTALKD_DAEMON_OPTS=""

if [[ -n "$BEANSTALKD_LISTEN_ADDR" ]]; then
  BEANSTALKD_DAEMON_OPTS+="-l $BEANSTALKD_LISTEN_ADDR"
fi

if [[ -n "$BEANSTALKD_LISTEN_PORT" ]]; then
  BEANSTALKD_DAEMON_OPTS+=" -p $BEANSTALKD_LISTEN_PORT"
fi

if [[ -n "$BEANSTALKD_JOB_SIZE" ]]; then
  BEANSTALKD_DAEMON_OPTS+=" -z $BEANSTALKD_JOB_SIZE"
fi

if [[ "$BEANSTALKD_PERSIST" -ne 0 ]]; then
  BEANSTALKD_DAEMON_OPTS+=" -b /var/lib/beanstalkd"
fi

exec ${BEANSTALKD} ${BEANSTALKD_DAEMON_OPTS} "$@"
