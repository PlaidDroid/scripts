#!/bin/bash
# write
if [ -w $1 ]
then
    echo "Write : Yes"
else
    echo "Write : No"
fi
# read
if [ -r $1 ]
then
    echo "Read : Yes"
else
    echo "Read : No"
fi
# execute
if [ -x $1 ]
then
    echo "Execute : Yes"
else
    echo "Execute : No"
fi
# directory
if [ -d $1 ]
then
    echo "Directory : Yes"
else
    echo "Directory : No"
fi
