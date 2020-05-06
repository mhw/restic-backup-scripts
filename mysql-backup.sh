#!/bin/bash -x

TAG=mysql

for DB in $(mysql -u$USER -BNe 'show databases' | grep -Ev 'mysql|information_schema|performance_schema')
do
	mysqldump -u$USER --force $DB | \
		restic backup \
			--stdin --stdin-filename mysql/$DB.sql \
		       	--tag "$TAG" \
		       	--tag "$DB" \
			--quiet
done
