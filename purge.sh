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
	echo forget non-transient files
	restic forget $DRY_RUN $COMPACT \
		--tag mysql \
		--tag postgresql \
		--tag files \
		--keep-tag transient \
		--keep-daily 14 \
		--keep-weekly 5 \
		--keep-monthly 4

	echo forget transient files
	restic forget $DRY_RUN $COMPACT \
		--tag transient \
		--keep-daily 2
}

if [ "$1" = '--really' ]
then
	forget >$LOG
	egrep '^(forget|Applying|(keep|remove) \d+ snapshot)' $LOG
	restic prune
else
	forget
fi
