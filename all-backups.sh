#!/bin/bash

cd `dirname $0`

./mysql-backup.sh
./postgresql-backup.sh
./files-backup.sh
