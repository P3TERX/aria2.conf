#!/bin/bash
#=================================================
# https://github.com/P3TERX/aria2.conf
# File name：tracker.sh
# Description: Get trackers and add to aria2.conf
# Lisence: MIT
# Version: 1.3
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================

INFO="[\033[32mINFO\033[0m]"
ERROR="[\033[31mERROR\033[0m]"
ARIA2_CONF=${1:-aria2.conf}

echo && echo -e "$INFO Check downloader ..."
if [ `command -v curl` ]; then
    DOWNLOADER='curl -fsSL'
elif [ `command -v wget` ]; then
    DOWNLOADER='wget -qO-'
else
    echo -e "$ERROR curl or wget is not installed."
fi

# BT tracker is provided by the following project.
# https://github.com/ngosang/trackerslist
# https://github.com/XIU2/TrackersListCollection
# Alternative link provided by jsDelivr.
# https://www.jsdelivr.com
echo && echo -e "$INFO Get trackers ..."
TRACKER=$(
    ${DOWNLOADER} https://raw.githubusercontent.com/XIU2/TrackersListCollection/master/all_aria2.txt || \
    ${DOWNLOADER} https://cdn.jsdelivr.net/gh/XIU2/TrackersListCollection/all_aria2.txt || \
    {
        ${DOWNLOADER} https://raw.githubusercontent.com/ngosang/trackerslist/master/trackers_all.txt  || \
        ${DOWNLOADER} https://cdn.jsdelivr.net/gh/ngosang/trackerslist/trackers_all.txt
    } \
    | awk NF | sed ":a;N;s/\n/,/g;ta"
)

[ -z $TRACKER ] && echo -e "
$ERROR Unable to get trackers, network failure or invalid links." && exit 1
echo -e "
--------------------[TRACKERS]--------------------
${TRACKER}
--------------------[TRACKERS]--------------------
"
[ ${ARIA2_CONF} == "cat" ] && exit 0

echo -e "$INFO Adding trackers to '${ARIA2_CONF}' ..." && echo
if [ ! -f ${ARIA2_CONF} ]; then
    echo -e "$ERROR '${ARIA2_CONF}' does not exist."
    exit 1
else
    [ -z $(grep "bt-tracker=" ${ARIA2_CONF}) ] && echo "bt-tracker=" >>${ARIA2_CONF}
    sed -i "s@^\(bt-tracker=\).*@\1${TRACKER}@" ${ARIA2_CONF} && echo -e "$INFO Trackers added successfully!"
fi
