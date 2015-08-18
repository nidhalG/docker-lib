#!/bin/bash
set -e

if [ "$1" = 'postgres' ]; then
	echo "* starting postgres service"
	/etc/init.d/postgresql start

	echo "insert reviews"
	psql -h localhost -p 5432 -U onyme -d reviews -f "$2" -W
	psql -h localhost -p 5432 -U onyme -d reviews -W
fi

exec "$@"

