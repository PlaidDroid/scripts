#!/bin/bash
P5_HOME=~/Documents/Programs/processing/p5
echo "Enter project name: (eg. worly-waves)"
read prjname

html = "<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>$prjname</title>

  <!-- PLEASE NO CHANGES BELOW THIS LINE (UNTIL I SAY SO) -->
  <script language="javascript" type="text/javascript" src="libraries/p5.min.js"></script>
  <script language="javascript" type="text/javascript" src="libraries/p5.sound.min.js"></script>
  <script language="javascript" type="text/javascript" src="sketch.js"></script>
  <!-- OK, YOU CAN MAKE CHANGES BELOW THIS LINE AGAIN -->

  <!-- This line removes any default padding and style.
       You might only need one of these values set. -->
  <style> body { padding: 0; margin: 0; } </style>
</head>

<body>
</body>
</html>"
md = "# $prjname"
sketch = "function setup(){
	
}

function draw(){
	
}"

if [ -d "$prjname" ]
then
echo "**warning** Project exists!"
else
echo "Creating project..."
`mkdir $prjname`
`cd $prjname`
`mkdir libraries assets`
`touch index.html README.md sketch.js`
`echo $html > index.html`
`echo $sketch > sketch.js`
`echo $md > README.md`
`cd libraries`
`cp $P5_HOME/p5.min.js .`
`cp $P5_HOME/addons/p5.sound.min.js .`
echo "**success** Project created!"
fi
