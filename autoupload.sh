#!/bin/bash
#Description: Aria2 download completes calling Rclone upload
#Version: 1.3
#Author: P3TERX
#Blog: https://p3terx.com

downloadpath='/root/Download' #Aria2下载目录
name='Onedrive' #配置Rclone时填写的name
folder='/DRIVEX/Download' #网盘里的文件夹，留空为整个网盘。
MinSize='10k' #限制最低上传大小，仅BT下载时有效，用于过滤无用文件。默认10k，低于此大小的文件不会被上传，并删除文件。
MaxSize='15G' #限制最高上传大小。默认15G（OneDrive上传限制），超过此大小的文件不会被上传，文件会被保留。

#=================下面不需要修改===================
filepath=$3 #Aria2传递给脚本的文件路径。BT下载有多个文件时该值为文件夹内第一个文件，如/root/Download/a/b/1.mp4
rdp=${filepath#${downloadpath}/} #路径转换，去掉开头的下载路径。
path=${downloadpath}/${rdp%%/*} #路径转换，下载文件夹时为顶层文件夹路径。普通单文件下载时与文件路径相同。

if [ $2 -eq 0 ]
	then
		exit 0
fi

echo && echo -e "  \033[1;33m前方高能！！！开始上传！！！\033[0m" && echo
echo && echo -e "  \033[1;32m前方高能！！！开始上传！！！\033[0m" && echo
echo && echo -e "  \033[1;35m前方高能！！！开始上传！！！\033[0m" && echo

if [ "$path" = "$filepath" ] && [ $2 -eq 1 ] #普通单文件下载
	then
		echo && echo -e "[\033[1;32m上传\033[0m] $filepath" && echo
		rclone move -v "$filepath" ${name}:${folder} --max-size $MaxSize #移动文件到设定的网盘文件夹
		rm -vf "$filepath".aria2 #删除.aria.2文件（在下载目录中）
		exit 0
elif [ "$path" != "$filepath" ] && [ -e "$filepath".aria2 ] #子文件夹或多级目录等情况下的单文件下载
	then
		echo && echo -e "[\033[1;32m上传\033[0m] $filepath"
		rclone move -v "$filepath" ${name}:"${folder}"/"${rdp%/*}" --max-size $MaxSize #移动文件到设定的网盘文件夹下的相同路径文件夹
		rm -vf "$filepath".aria2 #删除.aria2文件（在文件夹中）
		rclone rmdirs -v "$downloadpath" --leave-root #删除空目录
		exit 0
elif [ "$path" != "$filepath" ] && [ -e "$path".aria2 ] #文件夹下载（BT下载）
	then
		echo && echo -e "[\033[1;32m上传\033[0m] $path"
		rclone move -v "$path" ${name}:"${folder}"/"${rdp%%/*}" --min-size $MinSize --max-size $MaxSize #移动整个文件夹到设定的网盘文件夹
		rclone delete -v "$path" --max-size $MinSize #删除多余的文件
		rclone rmdirs -v "$downloadpath" --leave-root #删除空目录
		rm -vf "$path".aria2 #删除.aria2文件（在下载目录中）
		exit 0
fi