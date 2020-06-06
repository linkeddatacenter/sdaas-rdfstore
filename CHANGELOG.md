# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).



## [unreleased]

### Changed

- doc typos
- JAVA_OPTS server optimization

## [2.0.0] 

### Added

- GDAAS_SIZE optimization

### Changed

- now based on debian 10 distribution
- updated to jetty 9.4 with jdk13 slim
- updated to Blazegraph 2.1.6RC
- updated readonly and writable helpers on new web.xml format
- the docker default user changed from root to Jetty

### Removed

- removed dependecies to getop in sdaas-start

## [1.1.0]

### Addedd

- customization of workbench UI
- static file serving in shared area

## 1.0.0

First release, aligned with Blazegraph 2.1.5


[Unreleased]:  https://github.com/linkeddatacenter/sdaas-rdfstore/compare/2.0.0...HEAD
[2.0.0]:  https://github.com/linkeddatacenter/sdaas-ce/compare/2.0.0...1.1.0
[1.1.0]:  https://github.com/linkeddatacenter/sdaas-ce/compare/1.1.0...1.0.0