#!/bin/bash

cd `dirname $0`

. ./common.sh

TAG=postgresql

use_archive_repository

for DB in $(psql -l | \
	awk '{print $1}' | \
	grep -Ev "^(List|Name|-*\+|postgres|template|\||\(|$)")
do
	pg_dump --create --clean --if-exists --no-owner --no-privileges $DB | \
		gzip --rsyncable | \
		restic backup \
			--stdin --stdin-filename postgresql/$DB.sql.gz \
			--tag "$TAG" \
			--tag "$DB"
done
