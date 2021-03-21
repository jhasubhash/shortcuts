#!/bin/sh
#Function
cdp(){
    TEMP_PWD=`pwd`
    while ! [ -d .git ]; do
    cd ..
    done
    OLDPWD=$TEMP_PWD
}

pr(){
    id=$1
    if [ -z $id]; then
        echo "Need PR number as argument"
        return 1
    fi
    git fetch origin pull/${id}/head:pr_${id}
    git checkout pr_${id}
}