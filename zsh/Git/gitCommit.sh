#!/bin/sh

REPO=$(basename `git rev-parse --show-toplevel`)
#echo $REPO

if [ "$REPO" = "photoshop" ]
then
    open "https://git.corp.adobe.com/photoshop/photoshop/commit/$1" 
elif [ "$REPO" = "acpl-model" ]
then
   open "https://git.corp.adobe.com/torq/acpl-model/commit/$1"
else
	echo "Not a valid git repo"
fi