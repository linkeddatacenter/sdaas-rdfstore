![logo](http://linkeddata.center/resources/v4/logo/Logo-colori-trasp_oriz-640x220.png)

# sdaas-rdfstore
Run a dockerized blazegraph instance certified for sdaas

Derived from the [lyrasis/blazegraph project](https://github.com/lyrasis/docker-blazegraph) 

**Changes respect to standard distribution:**

- uses /sdaas-start  with followingstartup options:
		
		--foreground
			execute the platform in foreground
		
		--readonly
		   disallow mutations in graph database

small changes to web worbench

## Quickstart

```bash
docker build -t sdaas-rdfstore .
docker run --name blazegraph -d -p 8080:8080 sdaas-rdfstore
docker logs -f blazegraph
```



## Push to docker hub

To push a new docker image to docker hub:

```
docker build -t linkeddatacenter/sdaas-rdfstore .
docker login
# input the docker hub credentials...
docker tag linkeddatacenter/sdaas-rdfstore linkeddatacenter/sdaas-rdfstore:x.x.x
docker tag linkeddatacenter/sdaas-rdfstore linkeddatacenter/sdaas-rdfstore:latest
docker push linkeddatacenter/sdaas-rdfstore
```
