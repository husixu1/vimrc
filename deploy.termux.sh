#!/bin/bash

currentDir=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd )

# makedepend
tools=(vim git python curl gdb automake autoconf make cmake)

System=Termux
export System

# _check necessary tools
for tool in ${tools[*]}
do
	if ! command -v $tool > /dev/null 2>&1
	then
		echo >&2 "$tool does not exist, install? [Y/n]"
		read -r ans
		case $ans in
			"n")
				exit 1
				;;
			*)
				apt install $tool || { echo "$tool installation failed. exiting ... "; exit 1; }
				;;
		esac
	fi
done

. $currentDir/deploy.comm
