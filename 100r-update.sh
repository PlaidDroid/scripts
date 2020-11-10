#!/bin/bash
# apps=(Left Marabu Orca Orca-c Pilot)
# cd /home/plaiddroid/Documents/Programs/hundredrabbits/sources

apps=(Orca-c)
cd /home/plaiddroid/Documents/Programs/hundredrabbits/

for app in "${apps[@]}"
do
	echo "$app:" && cd "$app" && git pull && make
done

