#!/bin/bash
downloadpath='/root/Download' #Aria2下载目录
filepath=$3
rdp=${filepath#${downloadpath}/}
path=${downloadpath}/${rdp%%/*}

if [ $2 -eq 0 ]
	then
	exit 0
fi

if [ "$path" = "$filepath" ] && [ $2 -eq 1 ]
	then
	rm -vf "$filepath".aria2
	exit 0
elif [ "$path" != "$filepath" ]
	then
	rm -vf "$path".aria2
	exit 0
fi