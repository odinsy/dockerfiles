FROM hseeberger/scala-sbt
LABEL maintainer="Oleg Dianov <odidoit@gmail.com>"

ARG KAFKA_MANAGER_VERSION=1.3.3.18

ENV ZK_HOSTS=localhost:2181 \
     KM_VERSION=$KAFKA_MANAGER_VERSION

RUN mkdir -p /tmp && \
    cd /tmp && \
    wget https://github.com/yahoo/kafka-manager/archive/${KM_VERSION}.tar.gz && \
    tar xxf ${KM_VERSION}.tar.gz && \
    cd /tmp/kafka-manager-${KM_VERSION} && \
    sbt clean dist && \
    unzip  -d / ./target/universal/kafka-manager-${KM_VERSION}.zip && \
    rm -rf /tmp/${KM_VERSION} /tmp/kafka-manager-${KM_VERSION} && \
    ln -s /kafka-manager-${KM_VERSION} /kafka-manager

WORKDIR /kafka-manager-${KM_VERSION}

EXPOSE 9000
ENTRYPOINT ["./bin/kafka-manager","-Dconfig.file=conf/application.conf"]
