![logo](http://linkeddata.center/resources/v4/logo/Logo-colori-trasp_oriz-640x220.png)

# sdaas-rdfstore
Run a dockerized blazegraph instance certified for sdaas

Derived from the [lyrasis/blazegraph project](https://github.com/lyrasis/docker-blazegraph) 

## Quickstart

```bash
docker build -t sdaas-rdfstore .
docker run --name blazegraph -d -p 8889:8080 sdaas-rdfstore
docker logs -f blazegraph
```
