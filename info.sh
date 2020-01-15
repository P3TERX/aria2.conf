#!/bin/bash
#============================================================
# https://github.com/P3TERX/aria2.conf
# File name：info.sh
# Description: Display Aria2 download information when paused
# Lisence: MIT
# Version: 1.3
# Author: P3TERX
# Blog: https://p3terx.com
#============================================================

downloadpath='/root/Download'

filepath=$3
rdp=${filepath#${downloadpath}/}
path=${downloadpath}/${rdp%%/*}

if [ $2 -eq 0 ]
    then
        exit 0
elif [ "$path" = "$filepath" ] && [ $2 -eq 1 ]
    then
        uploadpath=$filepath
        aria2file="$filepath".aria2
elif [ "$path" != "$filepath" ] && [ -e "$filepath".aria2 ]
    then
        uploadpath=$filepath
        aria2file="$filepath".aria2
elif [ "$path" != "$filepath" ] && [ -e "$path".aria2 ]
    then
        uploadpath=$path
        aria2file="$path".aria2
fi

echo
echo
echo -e "[\033[1;32m暂停\033[0m] 下载任务信息："
echo -e "-------------------------- [\033[1;33m信息\033[0m] --------------------------"
echo -e "\033[1;35m文件数：\033[0m$2"
echo -e "\033[1;35m下载路径：\033[0m${downloadpath}"
echo -e "\033[1;35m文件路径：\033[0m${filepath}"
echo -e "\033[1;35m上传路径：\033[0m${uploadpath}"
echo -e "\033[1;35m.aria2 文件路径：\033[0m${aria2file}"
echo -e "-------------------------- [\033[1;33m信息\033[0m] --------------------------"
echo
echo
echo -e "[\033[1;32mPAUSE\033[0m] Download task information:"
echo -e "-------------------------- [\033[1;33mINFO\033[0m] --------------------------"
echo -e "\033[1;35mNumber of files: \033[0m$2"
echo -e "\033[1;35mDownload path：\033[0m${downloadpath}"
echo -e "\033[1;35mFile path: \033[0m${filepath}"
echo -e "\033[1;35mUpload path: \033[0m${uploadpath}"
echo -e "\033[1;35m.aria2 file path: \033[0m${aria2file}"
echo -e "-------------------------- [\033[1;33mINFO\033[0m] --------------------------"
echo
echo
