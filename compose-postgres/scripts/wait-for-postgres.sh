#!/bin/sh
set -e

apt-get update && apt-get install postgresql-client -y

until psql -h postgres -U postgres -c "select 1" > /dev/null 2>&1; do
  echo "Waiting for postgres server, sleeping ..."
  sleep 2
done

echo >&2 "Postgres is up - executing command [$@]"
exec "$@"