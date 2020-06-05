# Copyright (C) 2019 LinkedData.Center - All Rights Reserved
# Permission to copy and modify is granted under the MIT license
FROM bash as build-stage

ENV BLAZEGRAPH_VERSION_URL https://github.com/blazegraph/database/releases/download/BLAZEGRAPH_2_1_6_RC/blazegraph.war

RUN apk --no-cache add unzip

RUN apk add --no-cache openssl && \
    apk add --no-cache su-exec && \
    wget -O /blazegraph.war $BLAZEGRAPH_VERSION_URL

# unpack and rename the blazegraph webapp
RUN unzip /blazegraph.war -d /sdaas
COPY webapps/sdaas/html /sdaas/html

### production stage ###
FROM jetty:9.4-jdk13-slim

LABEL authors="enrico@linkeddata.center"

ENV JAVA_OPTS="-Xmx1g" \
    JETTY_WEBAPPS=/var/lib/jetty/webapps \
    BLAZEGRAPH_UID=888 \
    BLAZEGRAPH_GID=888


COPY helpers/sdaas-st* /
COPY helpers/*.xml ${JETTY_BASE}/
COPY --from=build-stage /sdaas ${JETTY_BASE}/webapps/sdaas
COPY webapps/shared ${JETTY_BASE}/webapps/shared

USER root
RUN chown jetty.jetty /sdaas-st* ; \
	chmod +rx /sdaas-st* ; \
	chown jetty.jetty ${JETTY_BASE}/webapps/sdaas/WEB-INF/web.xml
USER jetty

CMD /sdaas-start --foreground
