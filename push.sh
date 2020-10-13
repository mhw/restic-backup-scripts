#!/bin/bash

cd `dirname $0`

. ./common.sh

RCLONE=./rclone
OPTS='--transfers 32'

if [[ "$RESTIC_ARCHIVE_REPOSITORY" =~ ^/ ]] && \
	[[ -n "$RCLONE_ARCHIVE_REPOSITORY" ]]
then
	$RCLONE $OPTS sync $RESTIC_ARCHIVE_REPOSITORY $RCLONE_ARCHIVE_REPOSITORY \
		--create-empty-src-dirs
fi

if [[ "$RESTIC_TRANSIENT_REPOSITORY" =~ ^/ ]] && \
	[[ "$RESTIC_TRANSIENT_REPOSITORY" != "$RESTIC_ARCHIVE_REPOSITORY" ]] && \
	[[ -n "$RCLONE_TRANSIENT_REPOSITORY" ]]
then
	$RCLONE $OPTS sync $RESTIC_TRANSIENT_REPOSITORY $RCLONE_TRANSIENT_REPOSITORY \
		--create-empty-src-dirs
fi
