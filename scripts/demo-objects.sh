#!/usr/bin/env bash

set -eou pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

if ! command -v docker >/dev/null 2>&1; then
  echo "docker is required for make demo-objects but is not installed or not on PATH" >&2
  exit 1
fi

passwords_file="$repo_root/inventory/vagrant/group_vars/all/passwords.yml"

if [[ ! -f "$passwords_file" ]]; then
  echo "Missing passwords file: $passwords_file" >&2
  exit 1
fi

drupal_password="$(
  awk -F': *' '$1 == "drupal_account_pass" {print $2}' "$passwords_file" | tail -n 1
)"

if [[ -z "$drupal_password" ]]; then
  echo "Could not read drupal_account_pass from $passwords_file" >&2
  exit 1
fi

if [ ! -d "islandora_workbench" ]; then
  git clone https://github.com/mjordan/islandora_workbench
fi

if [ ! -d "islandora_demo_objects" ]; then
  git clone https://github.com/Islandora-Devops/islandora_demo_objects islandora_demo_objects
fi

sed -i.bak \
  -e "s#^host.*#host: http://host.docker.internal:8000/#g" \
  -e "s#^username.*#username: admin#g" \
  -e "s#^password.*#password: ${drupal_password}#g" \
  -e "s#^input_csv.*#input_csv: /islandora_demo_objects/create_islandora_objects.csv#g" \
  -e "s#^input_dir.*#input_dir: /islandora_demo_objects/#g" \
  islandora_demo_objects/create_islandora_objects.yml

docker build \
  --build-arg USER_ID="$(id -u)" \
  --build-arg GROUP_ID="$(id -u)" \
  -t workbench-docker:latest \
  islandora_workbench

# see if we should pass -i or -it to docker
# based on pseudo tty
tty_flag=( -i )
[ -t 0 ] && tty_flag=( -it )

docker run \
  "${tty_flag[@]}" \
  --rm \
  --add-host=host.docker.internal:host-gateway \
  -v "$(pwd)/islandora_workbench":/workbench:z \
  -v "$(pwd)/islandora_demo_objects":/islandora_demo_objects:z \
  --name my-running-workbench \
  workbench-docker:latest \
  bash -lc "./workbench --config /islandora_demo_objects/create_islandora_objects.yml"
