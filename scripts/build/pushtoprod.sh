#!/bin/sh

# Script to sync a directory across multiple servers.  I use this to stage the archive of a production build
# across all the production servers.  The buildprod.sh script then runs the deploy script on each server.

HOSTS="[SERVER1] [SERVER2] [SERVER3]"

for HOST in $HOSTS ; do
        echo -en "Pushing to $HOST..."
        rsync -e 'ssh -i [USER_PUBLIC_KEY]' --exclude=.* -rav --delete --stats [SRC_DIRECTORY] [USER_NAME]@$HOST:[TARGET_DIRECTORY] $*
done
