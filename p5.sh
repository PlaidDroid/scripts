#!/bin/bash
HOME=~/Documents/Programs/processing
P5_HOME=$HOME/p5
if [ ! -d "$P5_HOME" ]
then
	echo "Setting up..."
	echo "Creating P5_HOME directory..."
	mkdir "$HOME/p5"
	cd "$P5_HOME"
	echo "Downloading p5js"
	wget "https://cdnjs.cloudflare.com/ajax/libs/p5.js/1.1.9/p5.min.js"
	wget "https://cdnjs.cloudflare.com/ajax/libs/p5.js/1.1.9/addons/p5.sound.min.js"
fi	
	
function init()
{
	echo "Enter project name: (eg. worly-waves)"
	read prjname

	html="<!DOCTYPE html>
	<html>
	<head>
	  <meta charset=\"utf-8\">
	  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
	  <title>$prjname</title>

	  <!-- PLEASE NO CHANGES BELOW THIS LINE (UNTIL I SAY SO) -->
	  <script language=\"javascript\" type=\"text/javascript\" src=\"libraries/p5.min.js\"></script>
	  <script language=\"javascript\" type=\"text/javascript\" src=\"libraries/p5.sound.min.js\"></script>
	  <script language=\"javascript\" type=\"text/javascript\" src=\"sketch.js\"></script>
	  <!-- OK, YOU CAN MAKE CHANGES BELOW THIS LINE AGAIN -->

	  <!-- This line removes any default padding and style.
	       You might only need one of these values set. -->
	  <style> body { padding: 0; margin: 0; } </style>
	</head>

	<body>
	</body>
	</html>"
	md="# $prjname"
	sketch='function setup(){
		
	}

	function draw(){
		
	}'

	if [ -d "$prjname" ]
	then
	echo "**warning** Project exists!"
	else
	echo "Creating project..."
	mkdir "$prjname"
	cd "$prjname"
	mkdir libraries assets
	touch index.html README.md sketch.js
	echo "$html" > index.html
	echo "$sketch" > sketch.js
	echo "$md" > README.md
	cd libraries
	`cp $P5_HOME/p5.min.js .`
	`cp $P5_HOME/p5.sound.min.js .`
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
		init
		;;
	serve)
		serve
		;;
	*)
		echo "*** ** * ** ***
`basename ${0}`
  v1.0
  a script by plaiddroid
Uses:
  server.py
Commands:
  p5 init : initialises project
  p5 serve : serves webpage
*** ** * ** ***"
        exit 1
        ;;
esac
