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

COPY helpers/sdaas-st* /
COPY helpers/*.xml ${JETTY_BASE}/
COPY --from=build-stage /sdaas ${JETTY_BASE}/webapps/sdaas
COPY webapps/shared ${JETTY_BASE}/webapps/shared

USER root	
RUN chown jetty.jetty /sdaas-st* ; \
	chmod +rx /sdaas-st* ; \
	chown jetty.jetty ${JETTY_BASE}/webapps/sdaas/WEB-INF/web.xml ;\
	mkdir -p /var/lib/sdaas/data /var/lib/sdaas/logs ; \
	sed -i \
	  -e 's#file=bigdata.jnl#file=/var/lib/sdaas/data/blazegraph.jnl#' \
	  -e 's/textIndex=false/textIndex=true/' \
	  ${JETTY_BASE}/webapps/sdaas/WEB-INF/classes/RWStore.properties ; \
	sed -i \
	  -e 's/=WARN/=ERROR/g' \
	  -e 's/=INFO/=ERROR/g' \
	  -e 's#=rules\.log#=/var/lib/sdaas/logs/rules.log#' \
	  -e 's#=queryLog\.csv#=/var/lib/sdaas/logs/queryLog.csv#' \
	  -e 's#=queryRunState\.log#=/var/lib/sdaas/logs/queryRunState.log#' \
	  -e 's#=solutions\.csv#=/var/lib/sdaas/logs/solutions.csv#' \
	  -e 's#=sparql\.txt#=/var/lib/sdaas/logs/sparql.txt#' \
	  ${JETTY_BASE}/webapps/sdaas/WEB-INF/classes/log4j.properties ; \
	chown -R jetty.jetty /var/lib/sdaas ${JETTY_BASE}/webapps/sdaas/WEB-INF/classes ;
USER jetty

ENV GDAAS_SIZE="micro" 

ENTRYPOINT ["/sdaas-start"]
CMD ["--foreground", "--micro"]