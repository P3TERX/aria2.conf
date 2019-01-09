# Aria2 完美配置

[![GitHub](https://img.shields.io/github/license/mashape/apistatus.svg?style=flat-square)](https://github.com/P3TERX/aria2_perfect_config/blob/master/LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/P3TERX/aria2_perfect_config.svg?style=flat-square&label=Stars)](https://github.com/P3TERX/aria2_perfect_config/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/P3TERX/aria2_perfect_config.svg?style=flat-square&label=Fork)](https://github.com/P3TERX/aria2_perfect_config/fork)

**本项目配合 [Aria2 一键安装管理脚本](https://p3terx.com/archives/aria2-oneclick-installation-management-script.html)食用效果更佳**

`aria2.conf` 配置文件本体

### 附加功能脚本

`autoupload.sh` 下载完成后自动调用 rclone 上传(move)到网盘，删除 `.aria2` 文件，过滤无用文件（默认不启用，[使用教程](https://p3terx.com/archives/offline-download-of-onedrive-gdrive.html)）

`delete.aria2.sh` 下载完成后删除 `.aria2` 文件（默认启用）

`delete.sh` 下载错误和停止后删除文件（包括 `.aria2` 文件），避免占用空间（默认启用）

`info.sh` 下载暂停时输出下载任务信息到日志中（默认不启用）

### 其他文件

`dht.dat` DHT（IPv4）文件

`dht6.dat` DHT（IPv6）文件，待添加

### [相关教程](https://p3terx.com/tag/aria2/)

## 更新日志
### 2019-1-9
附加功能脚本：
* 修复 `autoupload.sh` 在某些情况下文件上传位置不正确的 bug
* 修复 `delete.sh` 在某些情况下不删除文件的 bug
* 其他优化调整

### 2018-12-25
配置文件：
* 调整 下载暂停时运行`info.sh`，默认不启用

附加功能脚本：
* 优化 `autoupload.sh` 自动上传脚本使用体验，脚本触发时会在日志中输出高能提醒，防止萌新一脸懵逼
* 增加 `info.sh` 下载任务信息显示脚本
* 移除 `test.sh` 测试脚本

### 2018-12-22
配置文件：
* 调整 期望下载速度参数

附加功能脚本：
* 修复 下载文件夹时复杂情况出现的 bug
* 优化 下载文件夹时的判断条件

### 2018-12-11
附加功能脚本：
* 修复 BT下载多级目录时上传不完整的 bug
* 修复 BT下载多级目录时导致的其它 bug

### 2018-12-07
* 添加 DHT（IPv4）文件
* 调整配置文件
* 整合到 [Aria2 一键安装管理脚本](https://github.com/P3TERX/aria2.sh)

### 2018-11-10
* 首次提交