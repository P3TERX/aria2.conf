#!/usr/bin/env bash
#
# Copyright (c) 2018-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/aria2.conf
# File name：tracker.sh
# Description: Get BT trackers and add to Aria2
# Version: 2.3
#

RED_FONT_PREFIX="\033[31m"
GREEN_FONT_PREFIX="\033[32m"
YELLOW_FONT_PREFIX="\033[1;33m"
LIGHT_PURPLE_FONT_PREFIX="\033[1;35m"
FONT_COLOR_SUFFIX="\033[0m"
INFO="[${GREEN_FONT_PREFIX}INFO${FONT_COLOR_SUFFIX}]"
ERROR="[${RED_FONT_PREFIX}ERROR${FONT_COLOR_SUFFIX}]"
ARIA2_CONF=${1:-aria2.conf}
DOWNLOADER="curl -fsSL --connect-timeout 3 --max-time 3 --retry 1"

# BT tracker is provided by the following project.
# https://github.com/XIU2/TrackersListCollection
# https://github.com/ngosang/trackerslist
# Fallback URLs provided by jsDelivr and Cloudflare Workers
# https://www.jsdelivr.com
# https://workers.cloudflare.com/
GET_TRACKERS() {
    echo && echo -e "$(date +"%m/%d %H:%M:%S") ${INFO} Get BT trackers ..."
    TRACKER=$(
        ${DOWNLOADER} https://trackerslist.com/all_aria2.txt ||
            ${DOWNLOADER} https://cdn.jsdelivr.net/gh/XIU2/TrackersListCollection/all_aria2.txt ||
            ${DOWNLOADER} https://trackerslist.p3terx.workers.dev/all_aria2.txt
    )
    [ -z ${TRACKER} ] && {
        TRACKER2=$(
            {
                ${DOWNLOADER} https://ngosang.github.io/trackerslist/trackers_all.txt ||
                    ${DOWNLOADER} https://cdn.jsdelivr.net/gh/ngosang/trackerslist/trackers_all.txt
            } | awk NF | sed ":a;N;s/\n/,/g;ta"
        )
        [ -z ${TRACKER2} ] && {
            echo
            echo -e "$(date +"%m/%d %H:%M:%S") ${ERROR} Unable to get trackers, network failure or invalid links." && exit 1
        } || {
            TRACKER="$TRACKER2"
        }
    }
}

ECHO_TRACKERS() {
    echo -e "
--------------------[TRACKERS]--------------------
${TRACKER}
--------------------[TRACKERS]--------------------
"
}

ADD_TRACKERS() {
    echo -e "$(date +"%m/%d %H:%M:%S") ${INFO} Adding BT trackers to Aria2 configuration file ${LIGHT_PURPLE_FONT_PREFIX}${ARIA2_CONF}${FONT_COLOR_SUFFIX} ..." && echo
    if [ ! -f ${ARIA2_CONF} ]; then
        echo -e "$(date +"%m/%d %H:%M:%S") ${ERROR} '${ARIA2_CONF}' does not exist."
        exit 1
    else
        [ -z $(grep "bt-tracker=" ${ARIA2_CONF}) ] && echo "bt-tracker=" >>${ARIA2_CONF}
        sed -i "s@^\(bt-tracker=\).*@\1${TRACKER}@" ${ARIA2_CONF} && echo -e "$(date +"%m/%d %H:%M:%S") ${INFO} BT trackers successfully added to Aria2 configuration file !"
    fi
}

ADD_TRACKERS_REMOTE_RPC() {
    echo -e "$(date +"%m/%d %H:%M:%S") ${INFO} Adding BT trackers to remote Aria2: ${LIGHT_PURPLE_FONT_PREFIX}${RPC_ADDRESS}${FONT_COLOR_SUFFIX} ..." && echo
    RPC_RESULT=$(curl "${RPC_ADDRESS}/jsonrpc" -kfsSd '{"jsonrpc":"2.0","method":"aria2.changeGlobalOption","id":"trackers","params":["token:'${RPC_SECRET}'",{"bt-tracker":"'${TRACKER}'"}]}')
    [ $(echo ${RPC_RESULT} | grep OK) ] &&
        echo -e "$(date +"%m/%d %H:%M:%S") ${INFO} BT trackers successfully added to remote Aria2 !" ||
        echo -e "$(date +"%m/%d %H:%M:%S") ${ERROR} Network failure or Aria2 RPC address is incorrect."
}

ADD_TRACKERS_LOCAL_RPC() {
    if [ ! -f ${ARIA2_CONF} ]; then
        echo -e "$(date +"%m/%d %H:%M:%S") ${ERROR} '${ARIA2_CONF}' does not exist."
        exit 1
    else
        RPC_PORT=$(grep rpc-listen-port ${ARIA2_CONF} | cut -d= -f2)
        RPC_SECRET=$(grep rpc-secret ${ARIA2_CONF} | cut -d= -f2)
        [[ ${RPC_PORT} && ${RPC_SECRET} ]] || {
            echo -e "$(date +"%m/%d %H:%M:%S") ${ERROR} Aria2 configuration file incomplete."
            exit 1
        }
        RPC_ADDRESS="localhost:${RPC_PORT}"
        echo -e "$(date +"%m/%d %H:%M:%S") ${INFO} Adding BT trackers to Aria2 ..." && echo
        RPC_RESULT=$(curl "${RPC_ADDRESS}/jsonrpc" -kfsSd '{"jsonrpc":"2.0","method":"aria2.changeGlobalOption","id":"trackers","params":["token:'${RPC_SECRET}'",{"bt-tracker":"'${TRACKER}'"}]}')
        [ $(echo ${RPC_RESULT} | grep OK) ] &&
            echo -e "$(date +"%m/%d %H:%M:%S") ${INFO} BT trackers successfully added to Aria2 !" ||
            echo -e "$(date +"%m/%d %H:%M:%S") ${ERROR} Network failure or Aria2 RPC address is incorrect."
    fi
}

[ $(command -v curl) ] || {
    echo -e "$(date +"%m/%d %H:%M:%S") ${ERROR} curl is not installed."
    exit 1
}

if [ "$1" = "cat" ]; then
    GET_TRACKERS
    ECHO_TRACKERS
    exit 0
elif [ "$1" = "RPC" ]; then
    RPC_ADDRESS=$2
    RPC_SECRET=$3
    GET_TRACKERS
    ECHO_TRACKERS
    ADD_TRACKERS_REMOTE_RPC
    exit 0
elif [ "$2" = "RPC" ]; then
    GET_TRACKERS
    ECHO_TRACKERS
    ADD_TRACKERS
    echo
    ADD_TRACKERS_LOCAL_RPC
    exit 0
else
    GET_TRACKERS
    ECHO_TRACKERS
    ADD_TRACKERS
    exit 0
fi
