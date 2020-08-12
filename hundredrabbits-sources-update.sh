#!/bin/bash
apps=(Left Marabu Orca Orca-c Pilot)
cd /home/plaiddroid/Documents/Programs/hundredrabbits/sources
for app in "${apps[@]}"
do
	echo "$app:" && cd "$app" && git pull && cd ..
done

