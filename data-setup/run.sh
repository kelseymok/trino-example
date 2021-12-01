#!/bin/bash

set -ex
script_dir=$(cd "$(dirname "$0")" ; pwd -P)
health_dir="${script_dir}/../health"
rm -f "${health_dir}/data-setup"

cd $script_dir
terraform init
terraform apply -var "bucket-name=${BUCKET_NAME}" -auto-approve

echo "OK" > "${health_dir}/data-setup"