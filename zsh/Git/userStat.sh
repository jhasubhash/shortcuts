#!/bin/sh

SINCE=""
UNTIL=""
USER=""

if [ $1 ]
then
	USER=$1
else
	echo "Please provide user name"
	exit 1
fi

if [ $2 ]
then
	SINCE=$2
fi

if [ $3 ]
then
	UNTIL=$3
fi

if [ -z "$UNTIL" ]
then
	UNTIL=$(date '+%d-%h-%Y')
fi

if [ -z "$SINCE" ]
then
	SINCE="1-Jan-1980"
fi


git log --shortstat --author "$USER" --since "$SINCE" --until "$UNTIL" | egrep "file[s]* changed" | awk '{files+=$1; inserted+=$4; deleted+=$6} END {print "files changed", files, "lines inserted:", inserted, "lines deleted:", deleted}'
