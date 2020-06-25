#!/usr/bin/env bash
#
# Copyright (c) 2018-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/aria2.conf
# File name：delete.sh
# Description: Delete files after Aria2 download error
# Version: 2.1
#

DOWNLOAD_PATH='/root/Download'

FILE_PATH=$3
RELATIVE_PATH=${FILE_PATH#${DOWNLOAD_PATH}/}
TOP_PATH=${DOWNLOAD_PATH}/${RELATIVE_PATH%%/*}
LIGHT_GREEN_FONT_PREFIX="\033[1;32m"
FONT_COLOR_SUFFIX="\033[0m"
INFO="[${LIGHT_GREEN_FONT_PREFIX}INFO${FONT_COLOR_SUFFIX}]"

echo -e "$(date +"%m/%d %H:%M:%S") ${INFO} Download error or stop, start deleting files..."

if [ $2 -eq 0 ]; then
    exit 0
elif [ -e "${FILE_PATH}.aria2" ]; then
    rm -vf "${FILE_PATH}.aria2" "${FILE_PATH}"
elif [ -e "${TOP_PATH}.aria2" ]; then
    rm -vrf "${TOP_PATH}.aria2" "${TOP_PATH}"
fi
find "${DOWNLOAD_PATH}" ! -path "${DOWNLOAD_PATH}" -depth -type d -empty -exec rm -vrf {} \;
