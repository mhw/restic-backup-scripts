#!/bin/bash

cd `dirname $0`

. ./common.sh

DRY_RUN=--dry-run
COMPACT=''

if [ "$1" = '--really' ]
then
	DRY_RUN=''
	COMPACT=--compact
fi

forget() {
	use_archive_repository
	echo forget non-transient files
	restic forget $DRY_RUN $COMPACT \
		--tag mysql \
		--tag postgresql \
		--tag files \
		--keep-tag transient \
		--keep-daily 14 \
		--keep-weekly 5 \
		--keep-monthly 4

	use_transient_repository
	if [ -n "$RESTIC_REPOSITORY" ]
	then
		echo forget transient files
		restic forget $DRY_RUN $COMPACT \
			--tag transient \
			--keep-daily 2
	fi
}

prune() {
	use_archive_repository
	restic prune
	use_transient_repository
	test -n "$RESTIC_REPOSITORY" && restic prune
}

if [ "$1" = '--really' ]
then
	forget >$LOG
	egrep '^(forget|Applying|(keep|remove) \d+ snapshot)' $LOG
	prune
else
	forget
fi
