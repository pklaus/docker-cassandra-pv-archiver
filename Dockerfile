FROM alpine as download-extract

RUN apk update && apk add tar curl

# cpa = abbr. for cassandra-pv-archiver-server
WORKDIR /cpa

# https://oss.aquenos.com/cassandra-pv-archiver/#download
RUN curl -L \
  --output cpa-bin.tar.gz \
  https://oss.aquenos.com/cassandra-pv-archiver/download/cassandra-pv-archiver-server-3.2.6-bin.tar.gz

RUN tar -xf cpa-bin.tar.gz --strip-components=1

RUN rm cpa-bin.tar.gz

# RUN ls
# -> /cpa/{bin,conf,doc,lib}

FROM openjdk:16-slim-buster

# for easier interactive use
#RUN apt-get update && apt-get install -yq coreutils vim-nox iproute2

WORKDIR /cpa

COPY --from=download-extract /cpa/bin /cpa/bin
COPY --from=download-extract /cpa/lib /cpa/lib

COPY cassandra-pv-archiver.yaml /etc/cpa/

ENV JAVA_OPTS="-XX:+UseG1GC -Xms4G -Xmx4G -ea"

CMD ./bin/cassandra-pv-archiver-server \
    --config-file=/etc/cpa/cassandra-pv-archiver.yaml \
    --no-banner
