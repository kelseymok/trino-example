#!/bin/bash

set -ex

script_dir=$(cd "$(dirname "$0")" ; pwd -P)
health_dir="${script_dir}/../health"

wait_for_setup() {
  name=$1
  echo "Waiting for ${name} to complete..."
  while [ ! -f ${health_dir}/${name} ]; do
      >&2 echo "Waiting ${name} to be done"
      sleep 2
  done
  echo "${name} complete"
}

wait_for_setup data-setup
wait_for_setup trino-setup

>&2 echo "Executing main... ${@}"

exec "$@"