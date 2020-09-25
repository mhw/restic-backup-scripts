[ -f "$HOME/.env.restic" ] && . $HOME/.env.restic

if [ -z "$LOGNAME" ]
then
	echo LOGNAME must contain the username
	exit 2
fi

if [ -z "$RESTIC_REPOSITORY" ]
then
	echo RESTIC_REPOSITORY must specify the restic repository.
	echo The scripts do not pass the repository as a parameter.
	exit 2
fi

if [ -z "$RESTIC_PASSWORD_FILE" ]
then
	echo RESTIC_PASSWORD_FILE must specify the restic repository password.
	echo The scripts do not pass the password as a parameter.
	exit 2
fi

[ -d "log" ] || mkdir log

LOG="log/$(basename $0)-$(date +%Y-%m-%d).log"
