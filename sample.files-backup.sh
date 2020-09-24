#!/bin/bash

set -e -o pipefail

cd `dirname $0`

. ./common.sh

TAG=files

restic backup \
	--tag "$TAG" \
	/where/the/important/files/are \
	--exclude .../shared/log/transient-log-files \
	--exclude-file .../shared/log/transient-log-files

restic backup \
	--tag "$TAG" \
	--tag "transient" \
	--files-from .../shared/log/transient-log-files
