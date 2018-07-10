#! /bin/sh

__FILES="
	i3/config
	polybar/config
	polybar/launch.sh
	kitty/kitty.conf
	compton.conf"

for file in $__FILES; do
    cp -r ~/.config/$file ./.config/$file
done
