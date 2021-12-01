#!/bin/bash

set -ex

#until $(curl --output /dev/null --silent --head --fail http://keycloak:8080/auth/realms/master/protocol/openid-connect/certs); do
#    >&2 echo 'Waiting for certs to become available'
#    sleep 2
#done

script_dir=$(cd "$(dirname "$0")" ; pwd -P)
health_dir="${script_dir}/../health"

until $(! -f ${health_dir}/trino-setup); do
    >&2 echo 'Waiting trino-setup to be done'
    sleep 2
done

>&2 echo "Executing main... ${@}"

exec "$@"