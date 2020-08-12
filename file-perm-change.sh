#!/bin/bash
if [ -e $1 ]
then
    echo "File Exists!"
    if [ -r $1 -a -w $1 ]
    then
        chmod 777 $1
        echo "File Permission has been changed"
    fi
else
    echo "File does not Exist"
fi
