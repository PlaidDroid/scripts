#!/bin/bash
windows="/run/media/plaiddroid/Windows"
sudo mkdir "$windows"
sudo mount -t ntfs /dev/sda3 $windows
cd /home/plaiddroid/Documents/Programs
./Obsidian-0.9.2.AppImage
sudo umount $windows
sudo rmdir $windows
