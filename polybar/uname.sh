#!/bin/bash

DISTRO_ICON=""

if [[ $(uname -n) == "archlinux" ]]
then
	DISTRO_ICON="󰣇" 
else 
	DISTRO_ICON="" 

	# DISTRO_ICON=""
	# DISTRO_ICON="󱄅"
	# DISTRO_ICON=""
	# DISTRO_ICON=""
fi

echo $DISTRO_ICON $(whoami)@$(uname -r)

