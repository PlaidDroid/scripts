#!/bin/sh
#
# Display commands for xrandr
# 
# Usage:
#  display hdmi up
#  display vga left
#
# Author: plaiddroid
#

opt1="${1}"
opt2="${2}"
op1=""
op2=""

function info(){
	echo "**********
`basename ${0}`
********** 
  v1.0
  a script by plaiddroid
        
Uses:
  xrandr

Commands:
  display [hdmi|vga] [up|down|left|right]"
}

case ${opt1} in
    hdmi)
    	op1="HDMI-A-0"
        ;;
    vga)
    	op1="DisplayPort-0"
        ;;
    *)	
  		info      
        exit 1
        ;; 
esac

case ${opt2} in
	up)
		op2="--above"
		;;
	down)
		op2="--below"
		;;
	left)
		op2="--left-of"
		;;
	right)
		op2="--right-of"
		;;
	off)
		op2="--off"
		;;
   	*)
		info
   		exit 1
esac

if [ ${op2} = "--off" ]; then
	`xrandr --output ${op1} ${op2}`
else
	`xrandr --output ${op1} --auto ${op2} eDP`
fi
