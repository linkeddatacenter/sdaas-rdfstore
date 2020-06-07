# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).


## [unreleased]

## [2.1.0]

### Changed

- changed service startup options
- revised the available size options to match the typical RAM configurations

### Added

- addes xxlarge size


### Fixed

- doc typos

### Removed 

- GDAAS_SIZE environment variable
- removed webapp shared


## [2.0.0] 

### Added

- size  optimization based on GDAAS_SIZE env var

### Changed

- based on debian 10 distribution
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


[Unreleased]:  https://github.com/linkeddatacenter/sdaas-rdfstore/compare/2.1.0...HEAD
[2.1.0]:  https://github.com/linkeddatacenter/sdaas-rdfstore/compare/2.1.0...2.0.0
[2.0.0]:  https://github.com/linkeddatacenter/sdaas-rdfstore/compare/2.0.0...1.1.0
[1.1.0]:  https://github.com/linkeddatacenter/sdaas-rdfstore/compare/1.1.0...1.0.0