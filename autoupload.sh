#!/bin/bash
#Description: Aria2 download completes calling Rclone upload
#Version: 1.0
#Author: P3TERX
#Blog: https://p3terx.com

downloadpath='/root/Download' #Aria2下载目录
name='Onedrive' #配置Rclone时填写的name
folder='/DRIVEX/Download' #网盘里的文件夹，留空为整个网盘。
MinSize='10k' #限制最低上传大小，默认10k，BT下载时可防止上传其他无用文件。会删除文件，谨慎设置。
MaxSize='15G' #限制最高文件大小，默认15G，OneDrive上传限制。

#=================下面不需要修改===================
filepath=$3 #Aria2传递给脚本的原始路径，如果是单文件为/root/Download/1.mp4，如果是文件夹则该值为文件夹内第一个文件，如/root/Download/a/b/1.mp4
rdp=${filepath#${downloadpath}/} #路径转换，去掉开头的下载路径。
path=${downloadpath}/${rdp%%/*} #下载文件夹时为顶层文件夹路径。下载单个文件时为文件路径。

if [ $2 -eq 0 ]
	then
		exit 0
elif [ "$path" = "$filepath" ] && [ $2 -eq 1 ] #如果下载的是单个文件
	then
		rclone move -v "$filepath" ${name}:${folder} --min-size $MinSize --max-size $MaxSize #移动文件到设定的网盘文件夹
		rm -vf "$filepath".aria2 #删除残留的.aria.2文件（.aria2 文件在下载目录）
		exit 0
elif [ "$path" != "$filepath" ] && [ -e "$filepath".aria2 ] #如果下载的是文件夹，且 .aria2 文件在文件夹中。
	then
		rclone move -v "$filepath" ${name}:"${folder}"/"${rdp%%/*}" --min-size $MinSize --max-size $MaxSize #移动文件到设定的网盘文件夹下的同名文件夹
		rm -vf "$filepath".aria2 #删除残留的.aria2文件（.aria2 文件在文件夹中）
		rclone delete -v "$path" --max-size $MinSize #删除多余的文件
		rclone rmdirs -v "$downloadpath" --leave-root #删除空目录
		exit 0
elif [ "$path" != "$filepath" ] && [ -e "$path".aria2 ] #如果下载的是文件夹，且 .aria2 文件在下载目录中。（BT下载）
	then
		rclone move -v "$path" ${name}:"${folder}"/"${rdp%%/*}" --min-size $MinSize --max-size $MaxSize #移动整个文件夹到设定的网盘文件夹
		rclone delete -v "$path" --max-size $MinSize #删除多余的文件
		rclone rmdirs -v "$downloadpath" --leave-root #删除空目录
		rm -vf "$path".aria2 #删除残留的.aria2文件（.aria2 文件在下载目录中）
		exit 0
fi