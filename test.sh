#!/bin/sh
filepath=$3
path=${3%/*}
downloadpath='/root/Download'	#Aria2下载目录

echo "Aria2 变量显示测试: [$1] [$2] [$3]"
echo -------------------------- 测试 --------------------------
echo 下载路径：${downloadpath}
echo 文件路径：${filepath}
echo 文件根路径：${path}
echo 最终路径："${path##*/}"
echo -------------------------- 测试 --------------------------

echo "Aria2 variable display test: [$1] [$2] [$3]"
echo -------------------------- TEST --------------------------
echo Download path：${downloadpath}
echo File path: ${filepath}
echo Path: ${path}
echo Final path: "${path##*/}"
echo -------------------------- TEST --------------------------