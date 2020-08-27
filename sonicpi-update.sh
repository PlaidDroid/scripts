#!/bin/bash
ACCOUNT=sonic-pi-net
APPLICATION=sonic-pi
APP_URL=https://github.com/$ACCOUNT/$APPLICATION
LATEST_RELEASE=$(curl -L -s -H 'Accept: application/json' $APP_URL/releases/latest)
LATEST_VERSION=$(echo $LATEST_RELEASE | sed -e 's/.*"tag_name":"\([^"]*\)".*/\1/')
FILE="$LATEST_VERSION.zip"
RUN_OS=unix
RUN_FILE_1=$RUN_OS-prebuild.sh
RUN_FILE_2=$RUN_OS-config.sh
ROOT=~/Documents/Programs
DIR=$ROOT/$APPLICATION
CHK_DIR="$DIR/$APPLICATION-${LATEST_VERSION:1}"
APP_DIR=$CHK_DIR/app/gui/qt
EXEC=$CHK_DIR/bin/$APPLICATION
ICON=$APP_DIR/images/icon.ico

desktop () {
	cd /home/plaiddroid/.local/share/applications
	touch "$APPLICATION.desktop"
	echo "[Desktop Entry]
Type=Application
Name=$APPLICATION
Version=$LATEST_VERSION
Comment=Code. Music. Live.
Exec=$EXEC
Icon=$ICON
Categories=live-coding;music;synth" > $APPLICATION.desktop
}

build () {
	cd "$APP_DIR"
	if [ ! -f $RUN_FILE_1 && ! -f $RUN_FILE_2 ]; then
		RUN_OS=linux 
	fi
	chmod u+x $RUN_FILE_1 $RUN_FILE_2
	./$RUN_FILE_1 --build-aubio
	./$RUN_FILE_2
	cd build
	cmake --build .
	desktop
}

get () {
	cd "$DIR"
	wget "$APP_URL/archive/$FILE"
	unzip $FILE
	rm $FILE
	build
}

if [ -d "$DIR" ]; then
	if [ -d "$CHK_DIR" ]; then
		echo "$APPLICATION from $ACCOUNT is in latest version: $LATEST_VERSION"
	else
		get
	fi
else
	mkdir "$DIR"
	get
fi

