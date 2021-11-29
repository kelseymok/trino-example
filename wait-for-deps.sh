#!/bin/bash

set -ex
#shift
until $(curl --output /dev/null --silent --head --fail http://keycloak:8080/auth/realms/master/protocol/openid-connect/certs); do
    >&2 echo 'Waiting for certs to become available'
    sleep 2
done

>&2 echo "EXECUTING MAIN ${@}"

exec "$@"