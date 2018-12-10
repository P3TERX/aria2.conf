#!/bin/bash
downloadpath='/root/Download' #Aria2下载目录
filepath=$3
rdp=${filepath#${downloadpath}/}
path=${downloadpath}/${rdp%%/*}

echo "Aria2 变量显示测试: [$1] [$2] [$3]"
echo -------------------------- 测试 --------------------------
echo 下载路径：${downloadpath}
echo 文件路径：${filepath}
echo 文件或文件夹路径：${path}
echo 文件或文件夹名称：${rdp%%/*}
echo .aria2 文件：${rdp%%/*}.aria2
echo -------------------------- 测试 --------------------------

echo "Aria2 variable display test: [$1] [$2] [$3]"
echo -------------------------- TEST --------------------------
echo Download path：${downloadpath}
echo File path: ${filepath}
echo File or folder path: ${path}
echo File or folder name: ${rdp%%/*}
echo .aria2 file: ${rdp%%/*}.aria2
echo -------------------------- TEST --------------------------