#!/bin/bash
#Description: Aria2 variable display test
#Version: 1.0
#Author: P3TERX
#Blog: https://p3terx.com

downloadpath='/root/Download' #Aria2下载目录
filepath=$3
rdp=${filepath#${downloadpath}/}
path=${downloadpath}/${rdp%%/*}

if [ "$path" = "$filepath" ] && [ $2 -eq 1 ]
	then
		aria2file="$filepath".aria2
elif [ "$path" != "$filepath" ] && [ -e "$filepath".aria2 ]
	then
		aria2file="$filepath".aria2
elif [ "$path" != "$filepath" ] && [ -e "$path".aria2 ]
	then
		aria2file="$path".aria2
fi

echo "Aria2 变量显示测试: [$1] [$2] [$3]"
echo -------------------------- 测试 --------------------------
echo 文件数：$2
echo 下载路径：${downloadpath}
echo 文件路径：${filepath}
echo 文件或文件夹路径：${path}
echo 文件或文件夹名称：${rdp%%/*}
echo .aria2 文件路径：${aria2file}
echo -------------------------- 测试 --------------------------

echo "Aria2 variable display test: [$1] [$2] [$3]"
echo -------------------------- TEST --------------------------
echo Number of files: $2
echo Download path：${downloadpath}
echo File path: ${filepath}
echo File or folder path: ${path}
echo File or folder name: ${rdp%%/*}
echo .aria2 file path: ${aria2file}
echo -------------------------- TEST --------------------------