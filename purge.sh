#!/bin/bash

set -e -o pipefail

cd `dirname $0`

. ./common.sh

DRY_RUN=--dry-run
COMPACT=''

if [ "$1" = '--really' ]
then
	DRY_RUN=''
	COMPACT=--compact
fi

restic forget $DRY_RUN $COMPACT \
	--tag mysql \
	--tag postgresql \
	--tag files \
	--keep-tag transient \
	--keep-daily 14 \
	--keep-weekly 5 \
	--keep-monthly 4

restic forget $DRY_RUN $COMPACT \
	--tag transient \
	--keep-daily 2

if [ "$1" = '--really' ]
then
	restic prune
	restic check
fi
