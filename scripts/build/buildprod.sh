#!/bin/sh

# A script to loop through a list of servers, running a script on each one.

HOSTS="[SERVER1] [SERVER2] [SERVER3]"

for HOST in $HOSTS ; do
        echo -en "Rebuilding to $HOST..."
        ssh -i [USER_PUBLIC_KEY] [USER_NAME]@$HOST sudo /usr/local/bin/rebuildServer2.sh
        sleep 15
done
