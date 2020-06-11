![logo](http://linkeddata.center/resources/v4/logo/Logo-colori-trasp_oriz-640x220.png)

# sdaas-rdfstore
A dockerized blazegraph instance certified for sdaas

The sdaas-rdfstore requires [docker](https://www.docker.com/) 


## Build local image

	docker build -t sdaas-rdfstore .

## Smoke tests
	
	docker run --rm -ti --entrypoint bash sdaas-rdfstore
	/sdaas-start -d --size small --readonly || echo KO
	sleep 10 # some time to warmup
	test -f /var/log/rdfStore/rdfStore.log || echo KO
	test -f /var/lib/rdfStore/rdfStore.jnl || echo KO
	/sdaas-stop || echo KO
	exit
	
	docker run --name gdaas -d -p 8080:8080 sdaas-rdfstore
	docker logs -f gdaas
	# point browser to http://localhost:8080/sdaas to see workbench interface
	#..press ctrl-c to exit logs
	docker rm -f gdaas

## sdaas-start options

 To print sdaas-start usage:  `docker run --rm -t sdaas-rdfstore --help` 
	
	Smart Data as a Service (SDaaS) knowledge graph engine
	Copyright (C) 2018-2020 http://linkeddata.center/
	
	startup options:
	
	-d, --background
	execute the platform as a daemon
	
	--readonly
	   disallow mutations in graph database
	
	--size micro|small|medium|large|xlarge|xxlarge|custom


memory footprints and performances related to size:

| size value       | required RAM | edges (triples) |
|------------------|--------------|-----------------|
| micro (default)  | 512MB        | <200K           |
| small            | 2GB          | <1M             |
| medium           | 4GB          | <8M             |
| large            | 8GB          | <100M           |
| xlarge           | 16GB         | <500M           |
| xxlarge          | 32GB         | <1B             |
| custom           | depends      |                 |


The *micro* size is suitable for test and development environment.

The *custom* size let to you setting up proper configurations, see https://github.com/blazegraph/database/wiki/Hardware_Configuration

To persist data and improve performances, you should mount as a fast volume the directory /var/lib/sdaas



## Push to docker hub

To push a new docker image to docker hub:

```
docker build -t linkeddatacenter/sdaas-rdfstore .
docker login
docker tag linkeddatacenter/sdaas-rdfstore linkeddatacenter/sdaas-rdfstore:x.x.x
docker push linkeddatacenter/sdaas-rdfstore
```
