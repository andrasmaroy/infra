#!/bin/sh
#
# Custom connect script for [rad|son]arr to notify tdarr of a new file
# Based on https://github.com/hollanbm/tdarr_autoscan

set -e

if [ -n "${sonarr_eventtype}" ]; then
  FILE_PATH="${sonarr_episodefile_path}"
  EVENT_TYPE="${sonarr_eventtype}"
  DOWNLOAD_CLIENT="${sonarr_download_client}"
elif [ -n "${radarr_eventtype}" ]; then
  FILE_PATH="${radarr_moviefile_path}"
  EVENT_TYPE="${radarr_eventtype}"
  DOWNLOAD_CLIENT="${radarr_download_client}"
fi

if [ -n "${TDARR_PATH_TRANSLATE}" ]; then
  FILE_PATH="$(echo "${FILE_PATH}" | sed "s|${TDARR_PATH_TRANSLATE}|")"
fi

PAYLOAD="{\"data\": {\"scanConfig\": {\"dbID\": \"${TDARR_DB_ID}\", \"arrayOrPath\": [\"${FILE_PATH}\"], \"mode\": \"scanFolderWatcher\" }}}"

# debug logs - payload is most important
echo "EVENT_TYPE: ${EVENT_TYPE}"
echo "TDARR_URL: ${TDARR_URL}"
echo "DOWNLOAD_CLIENT: ${DOWNLOAD_CLIENT}"
echo "PAYLOAD: ${PAYLOAD}"

# don't call tdarr when testing
if [ -n "$EVENT_TYPE" ] && [ "$EVENT_TYPE" != "Test" ]; then
  # Don't call tdarr when download client is blackhole
  if [ -z "$BLACKHOLE_CLIENT_NAME" ] || [ "$BLACKHOLE_CLIENT_NAME" != "$DOWNLOAD_CLIENT" ]; then
    curl \
      --data "${PAYLOAD}" \
      --fail \
      --header 'content-type: application/json' \
      --location \
      --request POST \
      --show-error \
      --silent \
      "${TDARR_URL}/api/v2/scan-files"
  fi
fi
