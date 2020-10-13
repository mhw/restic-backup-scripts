#!/bin/bash

cd `dirname $0`

. ./common.sh

TAG=mysql

use_archive_repository

for DB in $(mysql -u$LOGNAME -BNe 'show databases' | grep -Ev --line-regexp 'mysql|information_schema|performance_schema|sys')
do
	mysqldump -u$LOGNAME --skip-dump-date --force $DB | \
		gzip --rsyncable | \
		restic backup \
			--stdin --stdin-filename mysql/$DB.sql.gz \
			--tag "$TAG" \
			--tag "$DB"
done
