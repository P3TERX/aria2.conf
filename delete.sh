#!/bin/bash
#Description: Delete files after Aria2 download error
#Version: 1.1
#Author: P3TERX
#Blog: https://p3terx.com

downloadpath='/root/Download' #Aria2下载目录

filepath=$3
rdp=${filepath#${downloadpath}/}
path=${downloadpath}/${rdp%%/*}

if [ "$path" = "$filepath" ] && [ $2 -eq 1 ]
	then
	rm -vf "$filepath".aria2
	rm -vf "$filepath"
	exit 0
elif [ "$path" != "$filepath" ] && [ -e "$filepath".aria2 ]
	then
	rm -vf "$filepath".aria2
	rm -vf "$filepath"
	rmdir -v "${filepath%/*}"
	exit 0
elif [ "$path" != "$filepath" ] && [ -e "$path".aria2 ]
	then
	rm -vf "$path".aria2
	rm -vrf "$path"
	exit 0
fi