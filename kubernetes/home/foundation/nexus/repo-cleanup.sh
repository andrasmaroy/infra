#!/bin/bash
#
# Script to clean up Nexus repositories, with the aim of only keeping the
# latest configured number of artifacts in each repository.

set -euo pipefail

readonly IMAGE_RETENTION="${IMAGE_RETENTION:-2}"
readonly NEXUS_USER="${NEXUS_USER:-admin}"
readonly NEXUS_PASSWORD="${NEXUS_PASSWORD}"
readonly NEXUS_HOST="${NEXUS_HOST:-nexus-nexus3}"
readonly NEXUS_PORT="${NEXUS_PORT:-8081}"

if [ -z "${NEXUS_PASSWORD}" ]; then
  echo "Error: PASSWORD is not set."
  exit 1
fi

readonly CURL_ARGS=(
  --silent
  --show-error
  --location
  --fail
  --user "${NEXUS_USER}:${NEXUS_PASSWORD}"
)

deletion_ids=()
# Only proxy repositories are considered for cleanup
repositories=$(curl "${CURL_ARGS[@]}" --header 'Accept: application/json' "http://${NEXUS_HOST}:${NEXUS_PORT}/service/rest/v1/repositories" | jq -r '.[] | select(.type == "proxy") | .name')

for repo in ${repositories}; do
  components=$(curl "${CURL_ARGS[@]}" --header 'Accept: application/json' "http://${NEXUS_HOST}:${NEXUS_PORT}/service/rest/v1/components?repository=${repo}")

  while [[ "$(echo "${components}" | jq -r '.continuationToken')" != "null" ]]; do
    # Received continuation token, fetch next page
    components_next=$(curl "${CURL_ARGS[@]}" --header 'Accept: application/json' "http://${NEXUS_HOST}:${NEXUS_PORT}/service/rest/v1/components?repository=${repo}&continuationToken=$(echo "${components}" | jq -r '.continuationToken')")
    # Merge the current components with the next page while keeping the continuation token
    components=$(jq --argjson arr1 "${components}" --argjson arr2 "${components_next}" -n '$arr2 | .items = $arr1.items + $arr2.items')
  done
  names=$(echo "${components}" | jq -r '.items[].name' | sort -u)

  # Go through each component by name
  for name in ${names}; do
    items=$(echo "${components}" | jq -c --arg name "${name}" '.items[] | select(.name == $name)')

    semver=true
    # Check if all versions are semver compliant
    while read -r item; do
      version=$(echo "${item}" | jq -r '.version')
      if [[ "${version}" == 'latest' ]]; then
        continue
      fi
      if [[ ! "${version}" =~ ^(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*) ]]; then
        semver=false
        break
      fi
    done < <(echo "${items}")

    latest=$(echo "${items}" | jq -c 'select(.version == "latest")')
    versions_to_sort=$(echo "${items}" | jq -c 'select(.version != "latest")')
    if [ "${semver}" = true ]; then
      sorted=$(echo "${versions_to_sort}" | jq -s 'sort_by(.version | split(".") | map(tonumber)) | reverse | .[]')
    else
      # Sort by creation date as fallback
      sorted=$(echo "${versions_to_sort}" | jq -s 'sort_by(.assets[0].blobCreated) | reverse | .[]')
    fi

    sorted_items=$( (echo "${latest}"; echo "${sorted}") | jq -s 'flatten')

    total=$(echo "${sorted_items}" | jq 'length')

    if ((total > IMAGE_RETENTION)); then
      delete_count=$((total - IMAGE_RETENTION))
      to_delete=$(echo "${sorted_items}" | jq --argjson count "${delete_count}" '.[-1 * $count:] | .[]')
      while read -r ID; do
        deletion_ids+=("${ID}")
        echo "Marking for deletion: ${repo}/${name}:$(echo "${to_delete}" | jq -r --arg id "${ID}" '. | select(.id == $id) | .version')"
      done < <(echo "${to_delete}" | jq -r '.id')

    fi

  done
done

for id in "${deletion_ids[@]}"; do
  echo "Deleting ${id}"
  curl "${CURL_ARGS[@]}" --request DELETE "http://${NEXUS_HOST}:${NEXUS_PORT}/service/rest/v1/components/${id}"
done

