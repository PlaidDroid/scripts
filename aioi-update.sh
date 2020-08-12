#!/bin/bash
ACCOUNT=MAKIO135
APPLICATION=aioi
APP_URL=https://github.com/$ACCOUNT/$APPLICATION
LATEST_RELEASE=$(curl -L -s -H 'Accept: application/json' $APP_URL/releases/latest)
LATEST_VERSION=$(echo $LATEST_RELEASE | sed -e 's/.*"tag_name":"\([^"]*\)".*/\1/')
ROOT=~/Documents/Programs
DIR=$ROOT/$APPLICATION
APP_DIR=$DIR/$APPLICATION

desktop () {
	cd /home/plaiddroid/.local/share/applications
	touch "$APPLICATION.desktop"
	echo "[Desktop Entry]
Type=Application
Name=$APPLICATION
Version=$LATEST_VERSION
Comment=A companion app for ORCΛ
Exec=$DIR/Aioi-linux-x64/Aioi
Icon=$APP_DIR/desktop/icon.ico
Categories=UDP;OSC;" > $APPLICATION.desktop
}

build () {
	cd desktop
	npm install
	node ./node_modules/electron-packager/bin/electron-packager.js . Aioi --platform=linux  --arch=x64 --out "$DIR" --overwrite --icon=icon.png ; echo 'Built for LINUX'
	desktop
}

clone () {
	git clone "$APP_URL.git"
	cd "$APP_DIR"
	build
}

if [ -d "$DIR" ]; then
	if [ -d "$APP_DIR" ]; then
		cd "$APP_DIR"
		result=$(git pull)
		msg="Already up-to-date."
		if [ "$result" != "$msg" ]
		then
			build		
		else
			echo "$result"
		fi
	else
		clone
	fi
else
	mkdir "$DIR"
	cd "$DIR"
	clone
fi

