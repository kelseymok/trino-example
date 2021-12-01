#!/bin/bash

set -ex
script_dir=$(cd "$(dirname "$0")" ; pwd -P)
health_dir="${script_dir}/../health"
rm -f "${health_dir}/trino-setup"

./${script_dir}/trino-build-hive-properties.sh

echo "OK" > "${health_dir}/trino-setup"