# Backup Scripts

These scripts expect the configuration data to come from the environment:

```
# Backblaze B2 application key details
export B2_ACCOUNT_ID='...'
export B2_ACCOUNT_KEY='...'

export RESTIC_REPOSITORY='b2:bucket:path'
export RESTIC_PASSWORD_FILE='/home/restic/.restic.pwd'
```

This assumes Backblaze B2 is being used as restic storage provider.
Replace as appropriate for other providers.
