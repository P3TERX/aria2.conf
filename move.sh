#!/usr/bin/env bash
#
# Copyright (c) 2018-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/aria2.conf
# File name：move.sh
# Description: Move files after Aria2 download is complete
# Version: 2.0
#

# Aria2下载目录
DOWNLOAD_PATH='/root/Download'

# 目标目录
TARGET_DIR='/root/Download/completed'

# 日志保存路径。注释或留空为不保存。
#LOG_PATH='/root/.aria2/move.log'

#============================================================

FILE_PATH=$3                                   # Aria2传递给脚本的文件路径。BT下载有多个文件时该值为文件夹内第一个文件，如/root/Download/a/b/1.mp4
RELATIVE_PATH=${FILE_PATH#${DOWNLOAD_PATH}/}   # 路径转换，去掉开头的下载路径。
TOP_PATH=${DOWNLOAD_PATH}/${RELATIVE_PATH%%/*} # 路径转换，BT下载文件夹时为顶层文件夹路径，普通单文件下载时与文件路径相同。
RED_FONT_PREFIX="\033[31m"
LIGHT_GREEN_FONT_PREFIX="\033[1;32m"
YELLOW_FONT_PREFIX="\033[1;33m"
LIGHT_PURPLE_FONT_PREFIX="\033[1;35m"
FONT_COLOR_SUFFIX="\033[0m"
INFO="[${LIGHT_GREEN_FONT_PREFIX}INFO${FONT_COLOR_SUFFIX}]"
ERROR="[${RED_FONT_PREFIX}ERROR${FONT_COLOR_SUFFIX}]"
WARRING="[${YELLOW_FONT_PREFIX}WARRING${FONT_COLOR_SUFFIX}]"

TASK_INFO() {
    echo -e "
-------------------------- [${YELLOW_FONT_PREFIX}TASK INFO${FONT_COLOR_SUFFIX}] --------------------------
${LIGHT_PURPLE_FONT_PREFIX}Download path:${FONT_COLOR_SUFFIX} ${DOWNLOAD_PATH}
${LIGHT_PURPLE_FONT_PREFIX}File path:${FONT_COLOR_SUFFIX} ${FILE_PATH}
${LIGHT_PURPLE_FONT_PREFIX}Source path:${FONT_COLOR_SUFFIX} ${SOURCE_PATH}
${LIGHT_PURPLE_FONT_PREFIX}Target path:${FONT_COLOR_SUFFIX} ${TARGET_PATH}
-------------------------- [${YELLOW_FONT_PREFIX}TASK INFO${FONT_COLOR_SUFFIX}] --------------------------
"
}

MOVE_FILE() {
    echo -e "$(date +"%m/%d %H:%M:%S") ${INFO} Start move files ..."
    TASK_INFO
    mkdir -p "${TARGET_PATH}"
    mv -f "${SOURCE_PATH}" "${TARGET_PATH}"
    MOVE_EXIT_CODE=$?
    if [ ${MOVE_EXIT_CODE} -eq 0 ]; then
        echo -e "$(date +"%m/%d %H:%M:%S") ${INFO} Move done: ${SOURCE_PATH} -> ${TARGET_PATH}"
        [ $LOG_PATH ] && echo -e "$(date +"%m/%d %H:%M:%S") [INFO] Move done: ${SOURCE_PATH} -> ${TARGET_PATH}" >>${LOG_PATH}
    else
        echo -e "$(date +"%m/%d %H:%M:%S") ${ERROR} Move failed: ${SOURCE_PATH}"
        [ $LOG_PATH ] && echo -e "$(date +"%m/%d %H:%M:%S") [ERROR] Move failed: ${SOURCE_PATH}" >>${LOG_PATH}
    fi
    echo -e "$(date +"%m/%d %H:%M:%S") ${INFO} Clean up extra files ..."
    [ -e "${DOT_ARIA2_FILE}" ] && rm -vf "${DOT_ARIA2_FILE}"
    find "${DOWNLOAD_PATH}" ! -path "${DOWNLOAD_PATH}" -depth -type d -empty -exec rm -vrf {} \;
}

if [ -z $2 ]; then
    echo && echo -e "${ERROR} This script can only be used by passing parameters through Aria2."
    echo && echo -e "${WARRING} 直接运行此脚本可能导致无法开机！"
    exit 1
elif [ $2 -eq 0 ]; then
    exit 0
fi

if [ -e "${FILE_PATH}.aria2" ]; then
    DOT_ARIA2_FILE="${FILE_PATH}.aria2"
elif [ -e "${TOP_PATH}.aria2" ]; then
    DOT_ARIA2_FILE="${TOP_PATH}.aria2"
fi

if [ "${TOP_PATH}" = "${FILE_PATH}" ] && [ $2 -eq 1 ]; then # 普通单文件下载，移动文件到设定的文件夹。
    SOURCE_PATH="${FILE_PATH}"
    TARGET_PATH="${TARGET_DIR}"
    MOVE_FILE
    exit 0
elif [ "${TOP_PATH}" != "${FILE_PATH}" ] && [ $2 -gt 1 ]; then # BT下载（文件夹内文件数大于1），移动整个文件夹到设定的文件夹。
    SOURCE_PATH="${TOP_PATH}"
    TARGET_PATH="${TARGET_DIR}"
    MOVE_FILE
    exit 0
elif [ "${TOP_PATH}" != "${FILE_PATH}" ] && [ $2 -eq 1 ]; then # 第三方度盘工具下载（子文件夹或多级目录等情况下的单文件下载）、BT下载（文件夹内文件数等于1），移动文件到设定的文件夹下的相同路径文件夹。
    SOURCE_PATH="${FILE_PATH}"
    TARGET_PATH="${TARGET_DIR}/${RELATIVE_PATH%/*}"
    MOVE_FILE
    exit 0
fi

echo -e "${ERROR} Unknown error."
TASK_INFO
exit 1
