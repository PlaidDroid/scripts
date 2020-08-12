#!/bin/bash
ACCOUNT=juce-framework
APPLICATION=JUCE
APP_URL=https://github.com/$ACCOUNT/$APPLICATION/releases
CHECK_URL=$APP_URL/latest
LATEST_RELEASE=$(curl -L -s -H 'Accept: application/json' $CHECK_URL)
LATEST_VERSION=$(echo $LATEST_RELEASE | sed -e 's/.*"tag_name":"\([^"]*\)".*/\1/')
FILE_NAME=juce-"$LATEST_VERSION"-linux.zip
ARTIFACT_URL=$APP_URL/download/$LATEST_VERSION/$FILE_NAME
FILE_DIR=~/Documents/Programs/$APPLICATION/
FILE="$FILE_DIR$FILE_NAME"
if [ -f "$FILE" ]; then
	echo "$APPLICATION from $ACCOUNT is in latest version: v$LATEST_VERSION"
else
	echo "Downloading $APPLICATION v$LATEST_VERSION from $ACCOUNT..."
	cd "$FILE_DIR"
	wget "$ARTIFACT_URL"
	unzip "$FILE_NAME" -d "$APPLICATION-$LATEST_VERSION"
	cd /home/plaiddroid/.local/share/applications
	touch "$APPLICATION.desktop"
	echo "[Desktop Entry]
Type=Application
Name=Projucer
Version=$LATEST_VERSION
Comment=Audio Application Framework
Exec=$FILE_DIR$APPLICATION-$LATEST_VERSION/$APPLICATION/Projucer
Categories=Development;Audio;" > $APPLICATION.desktop
fi

