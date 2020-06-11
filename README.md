![logo](http://linkeddata.center/resources/v4/logo/Logo-colori-trasp_oriz-640x220.png)

# sdaas-rdfstore
A dockerized blazegraph instance certified for sdaas

The sdaas-rdfstore requires [docker](https://www.docker.com/) 


## Quickstart

Build local image:

	docker build -t sdaas-rdfstore .

Launch as a daemon:

	docker run --name gdaas -d -p 8080:8080 sdaas-rdfstore
	docker logs -f gdaas


Interactive section:
	
	docker run --rm -ti -p 8080:8080 --entrypoint bash sdaas-rdfstore
	/sdaas-start
	/sdaas-stop
	exit

sdaas-start options:

		-d, --background
			execute the platform as a daemon
		
		--readonly
		   disallow mutations in graph database
		   
		--size micro|small|medium|large|xlarge|xxlarge|custom


memory footprints and performances related to size

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
