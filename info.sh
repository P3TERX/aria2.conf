#!/usr/bin/env bash
#============================================================
# https://github.com/P3TERX/aria2.conf
# File name：info.sh
# Description: Display Aria2 download information when paused
# Lisence: MIT
# Version: 2.0
# Author: P3TERX
# Blog: https://p3terx.com
#============================================================

DOWNLOAD_PATH='/root/Download'

FILE_PATH=$3
REMOVE_DOWNLOAD_PATH=${FILE_PATH#${DOWNLOAD_PATH}/}
TOP_PATH=${DOWNLOAD_PATH}/${REMOVE_DOWNLOAD_PATH%%/*}
LIGHT_GREEN_FONT_PREFIX="\033[1;32m"
YELLOW_FONT_PREFIX="\033[1;33m"
LIGHT_PURPLE_FONT_PREFIX="\033[1;35m"
FONT_COLOR_SUFFIX="\033[0m"
INFO="[${LIGHT_GREEN_FONT_PREFIX}INFO${FONT_COLOR_SUFFIX}]"

if [ -e "${FILE_PATH}.aria2" ]; then
    DOT_ARIA2_FILE="${FILE_PATH}.aria2"
elif [ -e "${TOP_PATH}.aria2" ]; then
    DOT_ARIA2_FILE="${TOP_PATH}.aria2"
fi

if [ "${TOP_PATH}" = "${FILE_PATH}" ] && [ $2 -eq 1 ]; then
    UPLOAD_PATH="${FILE_PATH}"
    REMOTE_PATH="${DRIVE_NAME}:${DRIVE_PATH}"
elif [ "${TOP_PATH}" != "${FILE_PATH}" ] && [ $2 -gt 1 ]; then
    UPLOAD_PATH="${TOP_PATH}"
    REMOTE_PATH="${DRIVE_NAME}:${DRIVE_PATH}/${REMOVE_DOWNLOAD_PATH%%/*}"
elif [ "${TOP_PATH}" != "${FILE_PATH}" ] && [ $2 -eq 1 ]; then
    UPLOAD_PATH="${FILE_PATH}"
    REMOTE_PATH="${DRIVE_NAME}:${DRIVE_PATH}/${REMOVE_DOWNLOAD_PATH%/*}"
fi

echo
echo -e "
$(date +"%m/%d %H:%M:%S") ${INFO} Task pause.
-------------------------- [${YELLOW_FONT_PREFIX}TASK INFO${FONT_COLOR_SUFFIX}] --------------------------
${LIGHT_PURPLE_FONT_PREFIX}Number of files:${FONT_COLOR_SUFFIX} $2
${LIGHT_PURPLE_FONT_PREFIX}Download path:${FONT_COLOR_SUFFIX} ${DOWNLOAD_PATH}
${LIGHT_PURPLE_FONT_PREFIX}File path:${FONT_COLOR_SUFFIX} ${FILE_PATH}
${LIGHT_PURPLE_FONT_PREFIX}.aria2 file path:${FONT_COLOR_SUFFIX} ${DOT_ARIA2_FILE}
${LIGHT_PURPLE_FONT_PREFIX}Upload path:${FONT_COLOR_SUFFIX} ${UPLOAD_PATH}
${LIGHT_PURPLE_FONT_PREFIX}Remote path:${FONT_COLOR_SUFFIX} ${REMOTE_PATH}
-------------------------- [${YELLOW_FONT_PREFIX}TASK INFO${FONT_COLOR_SUFFIX}] --------------------------
"
echo
