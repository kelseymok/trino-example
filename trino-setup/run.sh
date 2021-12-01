#!/bin/bash

set -ex
script_dir=$(cd "$(dirname "$0")" ; pwd -P)
health_dir="${script_dir}/../health"
rm -f "${health_dir}/trino-setup"

while [ ! -f ${health_dir}/data-setup ]; do
    >&2 echo 'Waiting data-setup to be done'
    sleep 2
done

./${script_dir}/trino-build-hive-properties.sh

echo "OK" > "${health_dir}/trino-setup"