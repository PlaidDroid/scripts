#!/bin/bash
ACCOUNT=processing
APPLICATION=processing
APP_URL=https://github.com/$ACCOUNT/$APPLICATION/releases
CHECK_URL=$APP_URL/latest
LATEST_RELEASE=$(curl -L -s -H 'Accept: application/json' $CHECK_URL)
LATEST_VERSION_TAG=$(echo $LATEST_RELEASE | sed -e 's/.*"tag_name":"\([^"]*\)".*/\1/')
LATEST_VERSION=$(echo "$LATEST_VERSION_TAG" | awk -F- '{print $3}')
FILE_NAME="$APPLICATION-$LATEST_VERSION"-linux64.tgz
ARTIFACT_URL=$APP_URL/download/$LATEST_VERSION_TAG/$FILE_NAME
FILE_DIR=~/Documents/Programs/processing/
FILE="$FILE_DIR$FILE_NAME"
if [ -f "$FILE" ]; then
	echo "$APPLICATION from $ACCOUNT.org is in latest version: v$LATEST_VERSION"
else
	echo "Downloading $APPLICATION v$LATEST_VERSION from $ACCOUNT.org..."
	cd "$FILE_DIR"
	wget "$ARTIFACT_URL"
	tar -xzvf "$FILE_NAME"
	cd "$APPLICATION-$LATEST_VERSION"
	bash install.sh
fi

