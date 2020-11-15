#!/bin/bash
#
# Project generator for three.js
# 
# Author: plaiddroid
#

HOME=~/Documents/Programs/three

function download(){
	cd "$HOME"
	echo "Downloading three.js..."
	wget "https://unpkg.com/three/build/three.min.js"
	if [ $? -eq 0 ]; then 
		echo "OK"
		return 0
	else
		echo "**error** Cannot download!"
		exit 1
	fi
}

# check and setup HOME
function setup(){
	if [ ! -d "$HOME" ]; then
		echo "Setting up..."
		echo "Creating THREE_HOME directory..."
		mkdir "$HOME"
		if [ $? -eq 0 ]; then 
			echo "OK" 
		fi
	fi
	if [ ! -e "$HOME/three.min.js" ]; then
		download
	fi					
}
	
function init()
{
	echo "Enter project name: (eg. worly-waves)"
	read prjname

	if [ "$prjname" = "" -o "$prjname" = " " ]; then
		echo "**error** No project name!"
		exit 1
	fi
	
	html="<!DOCTYPE html>
<html>
	<head>
	  <meta charset=\"utf-8\">
	  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
	  <title>$prjname</title>

	  <!-- PLEASE NO CHANGES BELOW THIS LINE (UNTIL I SAY SO) -->
	  <script language=\"javascript\" type=\"text/javascript\" src=\"libraries/three.min.js\"></script>
	  <script language=\"javascript\" type=\"text/javascript\" src=\"main.js\"></script>
	  <!-- OK, YOU CAN MAKE CHANGES BELOW THIS LINE AGAIN -->

	  <!-- This line removes any default padding and style.
	       You might only need one of these values set. -->
	  <style> body { padding: 0; margin: 0; } </style>
	</head>

	<body>
	</body>
</html>"
	md="# $prjname"
	
	if [ -d "$prjname" ]
	then
		echo "**error** Project exists!"
		exit 1
	else
		echo "Creating project..."
		mkdir "$prjname"
		cd "$prjname"
		mkdir libraries assets
		touch index.html README.md main.js
		echo "$html" > index.html
		# echo "$main" > main.js
		echo "$md" > README.md
		cd libraries
		`cp $HOME/three.min.js .`
		echo "**success** Project created!"
	fi
}

function serve()
{
	python -m http.server -d .
}

option="${1}"

case ${option} in
	init)
		setup
		if [ $? -eq 0 ]; then
			init
		fi
		exit 0
		;;
	serve)
		serve
		exit 0
		;;
	update)
		setup
		rm "$HOME"/*
		download
		exit 0
		;;
	*)
		echo "*** ** * ** ***
`basename ${0}`
  v1.7
  a script by plaiddroid
Uses:
  server.py
Commands:
  three init : initialises project
  three serve : serves webpage
  three update : download the latest update
*** ** * ** ***"
        exit 1
        ;;
esac
