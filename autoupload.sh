#!/bin/bash
downloadpath='/root/Download' #Aria2下载目录
name='Onedrive' #配置Rclone时填写的name
folder='/DRIVEX/Download' #网盘里的文件夹，留空为整个网盘。
MinSize='10k' #限制最低上传大小，默认10k，BT下载时可防止上传其他无用文件。会删除文件，谨慎设置。
MaxSize='15G' #限制最高文件大小，默认15G，OneDrive上传限制。

filepath=$3 #Aria2传递给脚本的原始路径，如果是单文件则为/root/Download/1.mp4，如果是文件夹则该值为文件夹内第一个文件比如/root/Download/a/b/1.mp4
rdp=${filepath#${downloadpath}/} #路径转换，去掉开头的下载路径。
path=${downloadpath}/${rdp%%/*} #文件或文件夹路径。如果是单个文件，应与原始路径一致。

if [ $2 -eq 0 ]
	then
		exit 0
fi

while true; do
if [ "$path" = "$filepath" ] && [ $2 -eq 1 ] #如果下载的是单个文件
	then
	rclone move -v "$filepath" ${name}:${folder} --min-size $MinSize --max-size $MaxSize
	rm -vf "$filepath".aria2 #删除残留的.aria.2文件
	exit 0
elif [ "$path" != "$filepath" ] #如果下载的是文件夹
	then
	while [[ "`ls -A "$path/"`" != "" ]]; do
	rclone move -v "$path" ${name}:"${folder}"/"${rdp%%/*}" --min-size $MinSize --max-size $MaxSize --delete-empty-src-dirs
	rclone delete -v "$path" --max-size $MinSize #删除多余的文件
	rclone rmdirs -v "$downloadpath" --leave-root #删除空目录，--delete-empty-src-dirs参数已实现，加上无所谓。
	done
	rm -vf "$path".aria2 #删除残留的.aria2文件
	exit 0
fi
done