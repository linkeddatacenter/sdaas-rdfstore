# Copyright (C) 2019 LinkedData.Center - All Rights Reserved
# Permission to copy and modify is granted under the MIT license
FROM bash as build-stage

RUN apk --no-cache add unzip

RUN wget -O /blazegraph.war https://github.com/blazegraph/database/releases/download/BLAZEGRAPH_2_1_6_RC/blazegraph.war ;\
	unzip /blazegraph.war -d /sdaas

### production stage ###
FROM jetty:9.4-jdk17-eclipse-temurin

LABEL authors="enrico@linkeddata.center"

USER root

RUN apt-get update && apt-get -y upgrade && apt-get install -y curl

ENV SDAAS_STORE_NAME=rdfStore
ENV SDAAS_STORE_LOG=/var/log/${SDAAS_STORE_NAME}
ENV SDAAS_STORE_WAR=/opt/${SDAAS_STORE_NAME}
ENV SDAAS_STORE_DATA=/var/lib/${SDAAS_STORE_NAME}
ENV SDAAS_STORE_ETC=/etc/${SDAAS_STORE_NAME}

####### Create dirs
RUN mkdir -p "${SDAAS_STORE_WAR}" "${SDAAS_STORE_DATA}" "${SDAAS_STORE_LOG}" "${SDAAS_STORE_ETC}" ; \
	chown -R jetty.jetty "${SDAAS_STORE_DATA}" "${SDAAS_STORE_LOG}" 


####### Configure the override template for war.xml 
COPY helpers/readonly-template.xml "${SDAAS_STORE_ETC}/readonly-template.xml"

####### Install war and default override
COPY --from=build-stage /sdaas ${SDAAS_STORE_WAR}
COPY html/images/* ${SDAAS_STORE_WAR}/html/images
COPY html/favicon.ico ${SDAAS_STORE_WAR}/html/favicon.ico
COPY helpers/sdaas-template.xml ${JETTY_BASE}/webapps/sdaas.xml
RUN sed -i -e "s|__SDAAS_STORE_WAR__|${SDAAS_STORE_WAR}|g" "${JETTY_BASE}/webapps/sdaas.xml" ; \
	sed 's/__READONLY__/true/' "${SDAAS_STORE_ETC}/readonly-template.xml"  > "${JETTY_BASE}/readonly-override.xml" ;\
	chown jetty.jetty "${JETTY_BASE}/webapps/sdaas.xml" "${JETTY_BASE}/readonly-override.xml"


####### Configure RWStore.properties file
RUN sed "s|^com\.bigdata.journal\.AbstractJournal\.file=.*|com.bigdata.journal.AbstractJournal.file=${SDAAS_STORE_DATA}/${SDAAS_STORE_NAME}.jnl|" \
		"${SDAAS_STORE_WAR}/WEB-INF/RWStore.properties" \
		> "${JETTY_BASE}/RWStore.properties" ; \
	chown jetty.jetty "${JETTY_BASE}/RWStore.properties" 


####### Configure RWStore.properties file for lexical index and geospatial
ARG TEXT_INDEX=true
RUN if [ "$TEXT_INDEX" = "true" ]; then \
	sed -i -e 's/textIndex=false/textIndex=true/' "${JETTY_BASE}/RWStore.properties"; \
fi

ARG GEO_SPATIAL=true
RUN if [ "$GEO_SPATIAL" = "true" ]; then \
	echo "com.bigdata.rdf.store.AbstractTripleStore.geoSpatial=true" >> "${JETTY_BASE}/RWStore.properties"; \
fi


####### Configure startups scrips
COPY helpers/sdaas-st* /
RUN chown jetty.jetty /sdaas-st* ; \
	chmod +rx /sdaas-st* 
	
USER jetty
ENTRYPOINT ["/sdaas-start"]
CMD ["--size", "micro"]	