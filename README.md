# Trino Example
This is a WIP example of a single-node trino instance.

## Prerequisites
* docker-compose (version 2.1.1)
  * Fresh install: `brew install docker-compose`
  * Upgrade: `brew upgrade docker-compose`

## Quickstart
* `docker-compose up`
* `docker exec -it trino-cli trino --server trino:8080 --catalog hive-hadoop2 --schema default`

## Components
* trino
* trino-cli
* trino-setup
* data-setup



## References
### Trinio
* https://hub.docker.com/r/trinodb/trino
* https://github.com/trinodb/trino/blob/master/core/docker/README.md
* https://trino.io/docs/current/connector/hive-s3.html

### Keycloak
* https://www.keycloak.org/getting-started/getting-started-docker
* https://www.keycloak.org/docs-api/15.0/rest-api/index.html#_paths




