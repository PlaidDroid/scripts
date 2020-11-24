#!/bin/bash
DIR=~/Documents/impdocs/dotfiles
`cp -uv ~/.bashrc ~/.dmenurc ~/.xprofile ~/.Xresources $DIR`
`cp -uvr ~/.config/morc_menu $DIR/.config/`
`cp -uvr ~/.config/i3status $DIR/.config/`
`cp -uvr ~/.i3 $DIR`
cd "$DIR"
count=`cat log`
let "count++"
git add .
git commit -m "Backup $count"
git push
echo "$count" > "$DIR/log"
