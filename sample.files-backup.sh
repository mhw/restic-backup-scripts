#!/bin/bash

set -e -o pipefail

cd `dirname $0`

. ./common.sh

TAG=files

restic backup \
	--tag "$TAG" \
	/where/the/important/files/are
