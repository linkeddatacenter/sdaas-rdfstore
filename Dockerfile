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

### production stage ###
FROM jetty:9.4-jdk13-slim

LABEL authors="enrico@linkeddata.center"

ENV SDAAS_WAR /sdaas-store

COPY --from=build-stage /sdaas ${SDAAS_WAR}
COPY helpers/sdaas-st* /
COPY helpers/sdaas-template.xml ${JETTY_BASE}/webapps/sdaas.xml
COPY helpers/readonly-template.xml ${JETTY_BASE}/readonly-template.xml

RUN sed -i "s|__SDAAS_WAR__|${SDAAS_WAR}|" ${JETTY_BASE}/webapps/sdaas.xml

USER root	
RUN chown jetty.jetty /sdaas-st* ${JETTY_BASE}/webapps/sdaas.xml; \
	chmod +rx /sdaas-st* 
USER jetty

ENTRYPOINT ["/sdaas-start"]
CMD ["--size", "micro"]	