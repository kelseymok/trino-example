#!/bin/bash

set -ex

script_dir=$(cd "$(dirname "$0")" ; pwd -P)

admin_user=admin
admin_password=admin
keycloak_host="http://localhost:8081"


get_token() {
  result=$(curl --data "username=${admin_user}&password=${admin_password}&grant_type=password&client_id=admin-cli" ${keycloak_host}/auth/realms/master/protocol/openid-connect/token)
  token=$(echo ${result} | jq -r .access_token)
  echo ${token}
}

create_client() {
  token=$1
  curl -X POST \
    --data-binary '@keycloak-create-client.json' \
    -H "Content-Type:application/json" \
    -H "Authorization: Bearer ${token}" \
    "${keycloak_host}/auth/admin/realms/master/clients"
}

get_id_of_client() {
  token=$1
  client=$(curl -H "Authorization: Bearer ${token}" "${keycloak_host}/auth/admin/realms/master/clients?clientId=MyAwesomeClient")
  echo ${client} | jq -r .[0].id
}

gen_secret() {
  token=$1
  id=$2
  secret=$(curl -X POST -H "Authorization: Bearer ${token}" \
    "${keycloak_host}/auth/admin/realms/master/clients/${id}/client-secret")
  echo $secret | jq -r .value
}

token=$(get_token)
#create_client ${token}
id=$(get_id_of_client ${token})
sed -i '.bak' -E "s/http-server.authentication.oauth2.client-id.*/http-server.authentication.oauth2.client-id=${id}/" trino-config.properties


secret=$(gen_secret ${token} ${id})
sed -i '.bak' -E "s/http-server.authentication.oauth2.client-secret.*/http-server.authentication.oauth2.client-secret=${secret}/" trino-config.properties





