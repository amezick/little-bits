#!/bin/sh
cd [PROJECT_DIR]
CURRENT_TAG=`git tag |tail -n 1`
PREV_TAG=`git tag|tail -n 2 |head -n 1`

git log $PREV_TAG..$CURRENT_TAG  >git.mail
echo ' '>>git.mail
echo ' '>>git.mail
git diff $PREV_TAG $CURRENT_TAG --stat>>git.mail
echo ' '>>git.mail
echo ' '>>git.mail
git diff $PREV_TAG $CURRENT_TAG>>git.mail

mail -s "Changes for $CURRENT_TAG" -r [FROM_EMAIL] [TO_EMAIL]<git.mail
rm -f git.mail
cd ..
