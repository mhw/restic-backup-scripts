#!/bin/bash

cd `dirname $0`

. ./common.sh

TAG=file

restic backup \
	--tag "$TAG" \
	/where/the/important/files/are
