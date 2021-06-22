![logo](http://linkeddata.center/resources/v4/logo/Logo-colori-trasp_oriz-640x220.png)

# sdaas-rdfstore
A dockerized blazegraph instance certified for sdaas

The sdaas-rdfstore requires [docker](https://www.docker.com/) 


## Build local image

	docker build -t sdaas-rdfstore .

## Smoke tests

*Note on windows user: define `export MSYS_NO_PATHCONV=1` to avoid unwanted path conversion [see this note](https://stackoverflow.com/questions/7250130/how-to-stop-mingw-and-msys-from-mangling-path-names-given-at-the-command-line#34386471)*
	
```bash
docker run -d --name rdfstore -p 8080:8080 sdaas-rdfstore
sleep 10;docker exec rdfstore test -f /var/lib/rdfStore/rdfStore.jnl || echo KO
curl -X POST \
 --data-binary "LOAD <http://wifo5-03.informatik.uni-mannheim.de/benchmarks-200801/homepages-fixed.nt.gz>" \
 --header "Content-Type: application/sparql-update" \
 http://localhost:8080/sdaas/sparql  || echo KO
```

Test workbench:

- point browser to http://localhost:8080/sdaas to see workbench interface
- in the UPDATE tab, tray executing: `DROP ALL; LOAD <http://wifo5-03.informatik.uni-mannheim.de/benchmarks-200801/homepages-fixed.nt.gz>`
- free docker resource typing `docker rm -f rdfstore`

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

	docker login
	docker build -t linkeddatacenter/sdaas-rdfstore .
	docker tag linkeddatacenter/sdaas-rdfstore linkeddatacenter/sdaas-rdfstore:2.1.5
	docker push linkeddatacenter/sdaas-rdfstore
	docker push linkeddatacenter/sdaas-rdfstore:2.1.5

