#!/bin/bash
filepath=$3
path=${3%/*}
downloadpath='/root/Download'	#Aria2下载目录

if [ $2 -eq 0 ]
	then
	exit 0
fi

if [ "$path" = "$downloadpath" ] && [ $2 -eq 1 ]
	then
	rm -vf "$filepath".aria2
	rm -vrf "$filepath"
	exit 0
elif [ "$path" != "$downloadpath" ]
	then
	rm -vf "$path".aria2
	rm -vrf "$path"
	exit 0
fi