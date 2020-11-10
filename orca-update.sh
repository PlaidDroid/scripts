#!/bin/bash
 
OWNER=hundredrabbits
APPLICATION=Orca-c
APP_URL=https://github.com/$ACCOUNT/$APPLICATION
ROOT=~/Documents/Programs/$OWNER
DIR=$ROOT/$APPLICATION

if [ -d "$DIR" ]; then
	echo "Updating..."
	cd "$DIR"
	git pull
	echo "Compiling..."
	make
else
	echo "Downloading..."
	cd "$ROOT" 
	git clone "$APP_URL"
	echo "Compiling..."
	make
fi
