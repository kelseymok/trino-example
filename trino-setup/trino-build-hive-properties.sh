#!/bin/bash

set -ex
role_arn=$(cat ./data-setup/terraform.tfstate | jq -r '.outputs."role-arn".value')
sed -i -e "s/hive.metastore.glue.iam-role.*/hive.metastore.glue.iam-role=${role_arn////\\/}/" /trino-setup/trino-catalog-hive.properties

# Mac version
#sed -i '.bak' -E "s/hive.metastore.glue.iam-role.*/hive.metastore.glue.iam-role=${role_arn////\\/}/" trino-catalog-hive.properties