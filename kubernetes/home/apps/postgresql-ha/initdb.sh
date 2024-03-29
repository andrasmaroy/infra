#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

. /opt/bitnami/scripts/libpgpool.sh
eval "$(pgpool_env)"

pgpool_create_pg_users() {
    if is_boolean_yes "$PGPOOL_ENABLE_POOL_PASSWD"; then
        info "Creating custom users and their databases..."

        export PGPASSWORD="$PGPOOL_POSTGRES_PASSWORD"
        export PGUSER="$PGPOOL_POSTGRES_USERNAME"
        read -r -a nodes <<<"$(tr ',;' ' ' <<<"${PGPOOL_BACKEND_NODES}")"
        for node in "${nodes[@]}"; do
            read -r -a fields <<<"$(tr ':' ' ' <<<"${node}")"
            if [[ -n "${fields[1]:-}" ]]; then
                export PGHOST="$(psql -h ${fields[1]} -t -d repmgr -c "select conninfo from repmgr.nodes where type='primary';" | head -n 1 | sed -e 's/^.*host=\([^ ]*\) .*$/\1/')"
                if [ -n "$PGHOST" ]; then
                    break
                fi
            fi
        done
        if [ -z "$PGHOST" ]; then
          error "Error checking setting PGHOST, a backend must be set!"
          exit 1
        fi
        # Now that we have a database connection, override PGHOST with the primary node

        if [[ -n "${PGPOOL_POSTGRES_CUSTOM_USERS}" ]]; then
            read -r -a custom_users_list <<<"$(tr ',;' ' ' <<<"${PGPOOL_POSTGRES_CUSTOM_USERS}")"
            read -r -a custom_passwords_list <<<"$(tr ',;' ' ' <<<"${PGPOOL_POSTGRES_CUSTOM_PASSWORDS}")"

            local index=0
            for user in "${custom_users_list[@]}"; do
                echo "SELECT 'CREATE USER $user' WHERE NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = '$user')\gexec" | psql
                psql -c "ALTER USER $user WITH PASSWORD '${custom_passwords_list[$index]}';"
                echo "SELECT 'CREATE DATABASE $user OWNER $user' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = '$user')\gexec" | psql
                psql -c "GRANT ALL ON DATABASE $user TO $user;"
                ((index += 1))
            done
        fi
    else
        info "Skip creating custom users in db due to PGPOOL_ENABLE_POOL_PASSWD = no"
    fi
}

pgpool_create_pg_users
