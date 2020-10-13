#!/bin/bash

set -e -o pipefail

cd `dirname $0`

./mysql-backup.sh
./postgresql-backup.sh
./files-backup.sh

./purge.sh --really
# ./push.sh
