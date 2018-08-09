FROM ruby:2.5.1-slim
LABEL maintainer="Oleg Dianov <odidoit@gmail.com>"

RUN mkdir -p /opt/knife

WORKDIR /opt/knife
VOLUME /opt/knife

COPY scripts ./scripts
COPY conf/knife.rb ./knife.rb

ENV DEBIAN_FRONTEND=noninteractive \
  CHEF_SERVER_URL='' \
  CHEF_USER='' \
  CHEF_CLIENT_KEY=''

RUN set -ex \
    && buildDeps='libgmp3-dev gcc make'                           \
    && apt-get update                                             \
    && apt-get install -y --no-install-recommends git $buildDeps  \
    && gem install chef                                           \
    && apt-get purge -y --auto-remove $buildDeps                  \
    && apt-get clean                                              \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["/opt/knife/scripts/run_knife.sh"]
CMD ["usage"]
