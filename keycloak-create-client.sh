#!/bin/bash

set -ex

script_dir=$(cd "$(dirname "$0")" ; pwd -P)

admin_user=admin
admin_password=admin
keycloak_host="http://localhost:8081"

result=$(curl --data "username=${admin_user}&password=${admin_password}&grant_type=password&client_id=admin-cli" ${keycloak_host}/auth/realms/master/protocol/openid-connect/token)
token=$(echo ${result} | jq -r .access_token)
#token=`echo $RESULT | sed 's/.*access_token":"//g' | sed 's/".*//g'`
#create user

curl -X POST \
  --data-binary '@keycloak-create-client.json' \
  -H "Content-Type:application/json" \
  -H "Authorization: Bearer ${token}" \
  ${keycloak_host}/auth/realms/master/clients-registrations/default