# Aria2 完美配置

[![GitHub](https://img.shields.io/github/license/mashape/apistatus.svg?style=flat-square)](https://github.com/P3TERX/aria2_perfect_config/blob/master/LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/P3TERX/aria2_perfect_config.svg?style=flat-square&label=Stars)](https://github.com/P3TERX/aria2_perfect_config/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/P3TERX/aria2_perfect_config.svg?style=flat-square&label=Fork)](https://github.com/P3TERX/aria2_perfect_config/fork)

本项目是一套 Aria2 配置方案，包含了配置文件、附加功能脚本等文件，用于实现 Aria2 功能的增强和扩展。

增强功能：
* 提升BT下载率和下载速度
* 下载完成删除残留的`.aria2`后缀名文件
* 下载错误或取消下载删除未完成的文件

扩展功能：
* [OneDrive、Google Drive 等网盘离线下载](https://p3terx.com/archives/offline-download-of-onedrive-gdrive.html)
* [百度网盘转存到 OneDrive 、Google Drive 等其他网盘](https://p3terx.com/archives/baidunetdisk-transfer-to-onedrive-and-google-drive.html)

> **[Aria2 一键安装管理脚本](https://p3terx.com/archives/aria2-oneclick-installation-management-script.html)使用本项目作为配置方案，推荐使用。**

## 文件说明
`aria2.conf` 配置文件

### 附加功能脚本
`autoupload.sh` 自动上传脚本：在下载完成后执行（[on-download-complete](https://aria2.github.io/manual/en/html/aria2c.html#cmdoption-on-download-complete)），调用 Rclone 上传(move)下载的文件到网盘，并删除 `.aria2` 后缀名文件，过滤无用文件（默认不启用）

`delete.aria2.sh` .aria2后缀文件删除脚本：在下载完成后执行（[on-download-complete](https://aria2.github.io/manual/en/html/aria2c.html#cmdoption-on-download-complete)），删除 `.aria2` 后缀名文件（默认启用）

`delete.sh` 删除脚本：在下载停止后执行（[on-download-stop](https://aria2.github.io/manual/en/html/aria2c.html#cmdoption-on-download-stop)），删除文件及 `.aria2` 后缀名文件。（默认启用）

`info.sh` 任务信息显示脚本：在下载暂停后执行（[on-download-pause](https://aria2.github.io/manual/en/html/aria2c.html#cmdoption-on-download-pause)），输出下载任务信息到日志中（默认不启用）

### 其他文件
`dht.dat` DHT（IPv4）文件

~~`dht6.dat` DHT（IPv6）文件~~

## 更新日志
### 2019-05-23
附加功能脚本（`autoupload.sh`）：
* 移除上传大小限制
* 优化路径判断逻辑
* 调整脚本触发日志

### 2019-02-13
配置文件：
* 优化 配置参数

### 2019-01-31
配置文件：
* 调整 注释说明

其他文件：
* 更新 DHT（IPv4）文件

### 2019-01-14
附加功能脚本：
* 修复 `autoupload.sh` 在某些情况下上传整个 `root` 目录的 bug
* 优化 `autoupload.sh` 在日志中输出上传文件路径

### 2019-01-09
附加功能脚本：
* 修复 `autoupload.sh` 在某些情况下文件上传位置不正确的 bug
* 修复 `delete.sh` 在某些情况下不删除文件的 bug
* 其他优化调整
* ~~增加  `autoupload.sh` 在某些情况下上传整个 `root` 目录的 bug~~

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
* 修复 BT下载多级目录时上传不完整和其它 bug

### 2018-12-07
* 添加 DHT（IPv4）文件
* 调整配置文件
* 整合到 [Aria2 一键安装管理脚本](https://github.com/P3TERX/aria2.sh)

### 2018-11-10
* 首次提交