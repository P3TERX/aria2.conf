#!/bin/bash
#=====================================================
# https://github.com/P3TERX/aria2.conf
# File name：delete.sh
# Description: Delete files after Aria2 download error
# Lisence: MIT
# Version: 1.9
# Author: P3TERX
# Blog: https://p3terx.com
#=====================================================

# Aria2下载目录
# TIPS：一键脚本推荐使用选项进行修改，Docker 无需修改。
downloadpath='/root/Download'

#=====================================================

filepath=$3
rdp=${filepath#${downloadpath}/}
path=${downloadpath}/${rdp%%/*}

if [ $2 -eq 0 ]
    then
        exit 0
elif [ "$path" = "$filepath" ] && [ $2 -eq 1 ]
    then
        [ -e "$filepath".aria2 ] && rm -vf "$filepath".aria2 "$filepath"
        exit 0
elif [ "$path" != "$filepath" ] && [ $2 -gt 1 ]
    then
        [ -e "$path".aria2 ] && rm -vrf "$path".aria2 "$path"
        exit 0
elif [ "$path" != "$filepath" ] && [ $2 -eq 1 ]
    then
        [ -e "$filepath".aria2 ] && rm -vf "$filepath".aria2 "$filepath"
        find "${downloadpath}" ! -path "${downloadpath}" -depth -type d -empty -exec rm -vrf {} \;
        exit 0
fi
