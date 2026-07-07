#!/usr/bin/env bash
# Updates the k8s_version in config.tf to the latest version available via
# `doctl kubernetes options versions`.
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

CONFIG_FILE="config.tf"

latest_slug="$(doctl kubernetes options versions -o json | jq -r '.[0].slug')"

if [ -z "$latest_slug" ] || [ "$latest_slug" = "null" ]; then
  echo "Failed to determine latest Kubernetes version from doctl" >&2
  exit 1
fi

current_slug="$(grep -oE 'k8s_version *= *"[^"]+"' "$CONFIG_FILE" | grep -oE '"[^"]+"' | tr -d '"')"

if [ "$latest_slug" = "$current_slug" ]; then
  echo "k8s_version is already up to date ($current_slug)"
  exit 0
fi

sed -i.bak -E "s/(k8s_version *= *)\"[^\"]+\"/\1\"${latest_slug}\"/" "$CONFIG_FILE"
rm -f "${CONFIG_FILE}.bak"

echo "Updated k8s_version: ${current_slug} -> ${latest_slug}"

git add "$CONFIG_FILE"
git commit -m "feat(k8s): Update Kubernetes from ${current_slug} to ${latest_slug}"
