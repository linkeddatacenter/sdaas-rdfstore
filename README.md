![logo](http://linkeddata.center/resources/v4/logo/Logo-colori-trasp_oriz-640x220.png)

# sdaas-rdfstore
Run a dockerized blazegraph instance certified for sdaas

Derived from the [lyrasis/blazegraph project](https://github.com/lyrasis/docker-blazegraph) 


## Quickstart

Build local image:

	docker build -t sdaas-rdfstore .

Launch as a daemon:

	docker run --name blazegraph -d -p 8080:8080 sdaas-rdfstore
	docker logs -f blazegraph


Interactive section:
	
	docker run --rm blazegraph -ti -p 8080:8080 --entripoint bash sdaas-rdfstore
	/sdaas-start
	/sdaas-stop
	exit

sdaas-start options:
		
		--foreground
			execute the platform in foreground
		
		--readonly
		   disallow mutations in graph database



## Option

Size optimization are available throug env variable GDAAS_SIZE:

| GDAAS_SIZE value | required RAM | Edges (triples) |
|------------------|--------------|-----------------|
| micro (default)  | 1.5GB        | <1M             |
| small            | 2.5GB        | <5M             |
| medium           | 4.5GB        | <10M            |
| large            | 8.5GB        | <200M           |
| xlarge           | 16.5GB       | <500M           |

More info: https://github.com/blazegraph/database/wiki/Hardware_Configuration

## Push to docker hub

To push a new docker image to docker hub:

```
docker build -t linkeddatacenter/sdaas-rdfstore .
docker login
docker tag linkeddatacenter/sdaas-rdfstore linkeddatacenter/sdaas-rdfstore:x.x.x
docker push linkeddatacenter/sdaas-rdfstore
```
