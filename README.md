![logo](http://linkeddata.center/resources/v4/logo/Logo-colori-trasp_oriz-640x220.png)

# sdaas-rdfstore
A dockerized blazegraph instance certified for sdaas. 

By default quadstore, text index and geo spatial features are enabled in the default namespace.

The sdaas-rdfstore requires [docker](https://www.docker.com/) 


### 🚀 Quickstart

```
docker compose up -d --build
sleep 3
curl -X POST --data-binary "ASK {}" --header "Content-Type: application/sparql-query" http://localhost/sdaas/sparql
# should result  true
curl -X POST --data-binary "LOAD <http://lp/data/milan.ttl>" --header "Content-Type: application/sparql-update" http://localhost/sdaas/sparql
# should result in  mutationCount=28036
```


Test workbench:

- point browser to http://localhost/sdaas to see workbench interface
- in the UPDATE tab, tray executing: `DROP ALL; LOAD <http://lp/data/lecco.ttl> INTO GRAPH <urn:graph:test>`. You should read `mutationCount=29241`
- in the QUERY tab, tray executing: `SELECT (COUNT(*) as ?n) {?s?p?o}`. You should read `1205` for "n" variable
- free docker resource typing `docker compose down`

## sdaas-start options

 To print sdaas-start usage:  `docker run --rm -t sdaas-rdfstore --help` 
	
	Smart Data as a Service (SDaaS) knowledge graph engine
	Copyright (C) 2018-2024 http://linkeddata.center/
	
	startup options:
	
	-d, --background
	execute the platform as a daemon
	
	--readonly
	   disallow mutations in graph database
	
	--size micro|small|medium|large|xlarge|xxlarge|custom


memory footprints and performances related to size:

| size value       | required RAM | edges (triples) |
|------------------|--------------|-----------------|
| micro (default)  | 512M         | <200K           |
| small            | 2GB          | <5M             |
| medium           | 4GB          | <10M            |
| large            | 8GB          | <50M            |
| xlarge           | 16GB         | <100M           |
| xxlarge          | 32GB         | <500M           |
| custom           | depends      |                 |


The *micro* size is suitable for test and development environment.

The *custom* size let to you setting up proper configurations, see https://github.com/blazegraph/database/wiki/Hardware_Configuration

To persist data and improve performances, you should mount as a fast volume the directory /var/lib/rdfStore



## Push to docker hub

To push a new docker image to docker hub:

```
docker login
NAME="linkeddatacenter/sdaas-rdfstore" MAJOR="2" MINOR="2" PATCH="0"
docker build -t $NAME:$MAJOR.$MINOR.$PATCH .
docker tag $NAME:$MAJOR.$MINOR.$PATCH $NAME:$MAJOR.$MINOR
docker tag $NAME:$MAJOR.$MINOR.$PATCH $NAME:$MAJOR 
docker tag $NAME:$MAJOR.$MINOR.$PATCH $NAME:latest 
docker push $NAME:$MAJOR.$MINOR.$PATCH
docker push $NAME:$MAJOR.$MINOR
docker push $NAME:$MAJOR
docker push $NAME:latest
```