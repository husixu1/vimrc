#!/bin/bash

# makedepend
tools=(vim git python curl gdb automake autoconf make)

System=Linux
export System

# _check necessary tools
for tool in ${tools[*]}
do
	if ! command -v $tool > /dev/null 2>&1
	then
		echo >&2 "$tool does not exist, install? [y/N]"
		read -r ans
		case $ans in
			"y")
				sudo pacman -S $tool || { echo "$tool installation failed. exiting ... "; exit 1; }
				;;
			*)
				exit 1
				;;
		esac
	fi
done

. ./deploy.comm
