#!/bin/bash
root="/run/media/plaiddroid"
windows="$root/Windows"
if [ ! -d "$root" ]; then
	sudo mkdir "$root"
fi
sudo mkdir "$windows"
sudo mount -t ntfs /dev/sda3 $windows
cd /home/plaiddroid/Documents/Programs
./Obsidian-0.9.2.AppImage
sudo umount $windows
sudo rmdir $windows
