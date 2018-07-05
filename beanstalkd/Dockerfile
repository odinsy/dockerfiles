FROM alpine:latest
LABEL maintainer="Oleg Dianov <odidoit@gmail.com>"

RUN apk add --no-cache beanstalkd bash tini
COPY docker-entrypoint.sh /

ENV BEANSTALKD_LISTEN_ADDR=127.0.0.1 \
  BEANSTALKD_LISTEN_PORT=11300 \
  BEANSTALKD_JOB_SIZE=2097152 \
  BEANSTALKD_PERSIST=0

EXPOSE 11300
ENTRYPOINT ["/sbin/tini", "--", "/docker-entrypoint.sh"]
