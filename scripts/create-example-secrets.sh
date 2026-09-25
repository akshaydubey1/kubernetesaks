#!/usr/bin/env bash
set -euo pipefail

: "${DB_USERNAME:?Set DB_USERNAME in the environment}"
: "${DB_PASSWORD:?Set DB_PASSWORD in the environment}"
: "${HELLOWORLD_USERNAME:?Set HELLOWORLD_USERNAME in the environment}"
: "${HELLOWORLD_PASSWORD:?Set HELLOWORLD_PASSWORD in the environment}"
: "${HELLOWORLD_ROOT_PASSWORD:?Set HELLOWORLD_ROOT_PASSWORD in the environment}"
: "${HELLOWORLD_DATABASE:?Set HELLOWORLD_DATABASE in the environment}"

temp_dir="$(mktemp -d)"
chmod 700 "$temp_dir"
trap 'rm -rf "$temp_dir"' EXIT

printf 'username=%s\npassword=%s\n' "$DB_USERNAME" "$DB_PASSWORD" > "$temp_dir/db.env"
printf 'username=%s\npassword=%s\nrootPassword=%s\ndatabase=%s\n' \
  "$HELLOWORLD_USERNAME" "$HELLOWORLD_PASSWORD" \
  "$HELLOWORLD_ROOT_PASSWORD" "$HELLOWORLD_DATABASE" > "$temp_dir/helloworld.env"
chmod 600 "$temp_dir"/*.env

kubectl create secret generic db-secrets --namespace default \
  --from-env-file="$temp_dir/db.env" --dry-run=client -o yaml | kubectl apply -f -
kubectl create secret generic helloworld-secrets --namespace default \
  --from-env-file="$temp_dir/helloworld.env" --dry-run=client -o yaml | kubectl apply -f -
