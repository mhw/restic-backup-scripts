#!/bin/bash

cd `dirname $0`

. ./common.sh

TAG=mysql

for DB in $(mysql -u$LOGNAME -BNe 'show databases' | grep -Ev 'mysql|information_schema|performance_schema')
do
	mysqldump -u$LOGNAME --skip-dump-date --force $DB | \
		gzip --rsyncable | \
		restic backup \
			--stdin --stdin-filename mysql/$DB.sql.gz \
		       	--tag "$TAG" \
		       	--tag "$DB"
done
