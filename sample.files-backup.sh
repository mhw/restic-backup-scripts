#!/bin/bash

cd `dirname $0`

. ./common.sh

TAG=files

use_archive_repository

restic backup \
	--tag "$TAG" \
	/where/the/important/files/are \
	--exclude .../shared/log/transient-log-files \
	--exclude-file .../shared/log/transient-log-files

use_transient_repository

test -n "$RESTIC_REPOSITORY" && \
	restic backup \
		--tag "$TAG" \
		--tag "transient" \
		--files-from .../shared/log/transient-log-files
