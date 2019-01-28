# Copyright (C) 2019 LinkedData.Center - All Rights Reserved
# Permission to copy and modify is granted under the MIT license
FROM  lyrasis/blazegraph:2.1.5

LABEL authors="enrico@linkeddata.center"

USER root

COPY helpers/* /

RUN apk --no-cache add \
	unzip \
	sudo

# unpack and rename the blazegraph webapp
RUN unzip ${JETTY_WEBAPPS}/bigdata.war -d ${JETTY_WEBAPPS}/sdaas; \
	rm -f ${JETTY_WEBAPPS}/bigdata.war

COPY html /var/lib/jetty/webapps/sdaas/
CMD /sdaas-start --foreground