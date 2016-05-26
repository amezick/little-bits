#!/bin/sh

# A script to loop through a list of servers, running a script on each one.

HOSTS="[SERVER1] [SERVER2] [SERVER3]"

for HOST in $HOSTS ; do
        echo -en "Rebuilding to $HOST..."
        ssh -i [USER_PUBLIC_KEY] [USER_NAME]@$HOST sudo /usr/local/bin/rebuildServer.sh
        sleep 15
done

cd [PROJECT_DIR]
CURRENT_TAG=`git tag |tail -n 1`
PREV_TAG=`git tag|tail -n 2 |head -n 1`

echo 'Build done.' >git.mail
echo ' '>>git.mail
git log  --pretty=format:"%B%n     %h %cn %ad%n     -------" $PREV_TAG..$CURRENT_TAG  >>git.mail

mail -s "BUILD: Complete for  $CURRENT_TAG" -r [FROM_EMAIL] [TO_EMAIL]<git.mail
rm -f git.mail
cd -

