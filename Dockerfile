# Copyright (C) 2019 LinkedData.Center - All Rights Reserved
# Permission to copy and modify is granted under the MIT license
FROM bash as build-stage

ENV BLAZEGRAPH_VERSION=CANDIDATE_2_1_5 
ENV BLAZEGRAPH_VERSION_URL https://github.com/blazegraph/database/releases/download/BLAZEGRAPH_RELEASE_${BLAZEGRAPH_VERSION}/blazegraph.war

RUN apk --no-cache add unzip

RUN apk add --no-cache openssl && \
    apk add --no-cache su-exec && \
    wget -O /blazegraph.war $BLAZEGRAPH_VERSION_URL

# unpack and rename the blazegraph webapp
RUN unzip /blazegraph.war -d /sdaas
COPY webapps/sdaas/html /sdaas/html

### production stage ###
FROM jetty:9-jre8-alpine

LABEL authors="enrico@linkeddata.center"

ENV JAVA_OPTS="-Xmx1g" \
    JETTY_WEBAPPS=/var/lib/jetty/webapps \
    BLAZEGRAPH_UID=888 \
    BLAZEGRAPH_GID=888

USER root

COPY helpers/* /

RUN apk add --no-cache openssl bash su-exec sudo && \
    chmod +rx /sdaas-st* 
 
COPY --from=build-stage /sdaas ${JETTY_WEBAPPS}/sdaas
COPY webapps/shared ${JETTY_WEBAPPS}/shared


CMD /sdaas-start --foreground
