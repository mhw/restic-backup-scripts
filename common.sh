set -e -E -o pipefail

err_exit() {
	echo "$0: exit with error on line $1" >&2
}

trap 'err_exit $LINENO' ERR

[ -f "$HOME/.env.restic" ] && . $HOME/.env.restic

if [ -z "$LOGNAME" ]
then
	echo LOGNAME must contain the username
	exit 2
fi

if [ -z "$RESTIC_REPOSITORY" -a -z "$RESTIC_ARCHIVE_REPOSITORY" ]
then
	echo one of RESTIC_REPOSITORY and RESTIC_ARCHIVE_REPOSITORY
	echo must specify the restic repository.
	exit 2
fi

if [ -z "$RESTIC_PASSWORD_FILE" ]
then
	echo RESTIC_PASSWORD_FILE must specify the restic repository password.
	exit 2
fi

use_archive_repository() {
	if [ -n "$RESTIC_ARCHIVE_REPOSITORY" ]
	then
		export RESTIC_REPOSITORY=$RESTIC_ARCHIVE_REPOSITORY
	fi
}

use_transient_repository() {
	if [ -n "$RESTIC_TRANSIENT_REPOSITORY" ]
	then
		export RESTIC_REPOSITORY=$RESTIC_TRANSIENT_REPOSITORY
	fi
}

[ -d "log" ] || mkdir log

LOG="log/$(basename $0)-$(date +%Y-%m-%d).log"
