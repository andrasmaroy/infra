#!/bin/sh
#
# Script that checks if the provided config folder is wriable by the specified
# user and group. If it is not it will change the owner and group for the.
# Additionally it will remove files specified in `CFG_PRUNE`.
# Based on: https://github.com/spritsail/sonarr/blob/master/entrypoint.sh
#
# Configuration:
# Config folder path: CFG_DIR (default: /config)
# User ID: SUID
# Group ID: SGID
# Files to remove: $CFG_PRUNE
set -e

export CFG_DIR="${CFG_DIG:-/config}"

if ! su-exec -e touch "$CFG_DIR/.write-test"; then
    2>&1 echo "Warning: No permission to write in '$CFG_DIR' directory."
    2>&1 echo "         Correcting permissions to prevent a crash"
    2>&1 echo
    (
    set -x
    chown $SUID:$SGID "$CFG_DIR"
    chmod o+rw "$CFG_DIR"
    )
fi
# Remove temporary file
rm -f "$CFG_DIR/.write-test"

if printenv CFG_PRUNE >/dev/null; then
    for elem in $CFG_PRUNE; do
      2>&1 echo "Removing '$elem' from '$CFG_DIR' directory"
      rm -rf "${CFG_DIR:?}/${elem:?}"
    done
    2>&1 echo
fi
