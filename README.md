# Aria2 完美配置

[![LICENSE](https://img.shields.io/github/license/mashape/apistatus.svg?style=flat-square&label=LICENSE)](https://github.com/P3TERX/aria2_perfect_config/blob/master/LICENSE)
[![GitHub Stars](https://img.shields.io/github/stars/P3TERX/aria2_perfect_config.svg?style=flat-square&label=Stars)](https://github.com/P3TERX/aria2_perfect_config/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/P3TERX/aria2_perfect_config.svg?style=flat-square&label=Forks)](https://github.com/P3TERX/aria2_perfect_config/fork)

本项目是一套 Aria2 配置方案，包含了配置文件、附加功能脚本等文件，用于实现 Aria2 功能的增强和扩展。

[Aria2 一键安装管理脚本](https://github.com/P3TERX/aria2.sh)使用本项目作为配置方案，推荐使用。

## 功能说明

增强功能：

* 提升BT下载率和下载速度
* 下载完成删除残留的`.aria2`后缀名文件
* 下载错误或取消下载删除未完成的文件
* 一键获取 BT tracker

扩展功能：

* [OneDrive、Google Drive 等网盘离线下载](https://p3terx.com/archives/offline-download-of-onedrive-gdrive.html)
* [百度网盘转存到 OneDrive 、Google Drive 等其他网盘](https://p3terx.com/archives/baidunetdisk-transfer-to-onedrive-and-google-drive.html)

> **TIPS：** 如果遇到问题先看 [FAQ](https://p3terx.com/archives/aria2_perfect_config-faq.html) 再提问，这会为大家都省下很多宝贵的时间。你还可以加入[TG群](https://t.me/Aria2c)和小伙伴们一起讨论。提问前建议去学习《[提问的智慧](https://github.com/ryanhanwu/How-To-Ask-Questions-The-Smart-Way/blob/master/README-zh_CN.md)》，这能更好的帮助你去解决问题和节约时间。

## 文件说明

`aria2.conf` - Aria2 配置文件。除非你对这些参数非常了解，否则不建议进行任何修改。

### 附加功能脚本

`autoupload.sh` - 自动上传脚本：在下载完成后执行([on-download-complete](https://aria2.github.io/manual/en/html/aria2c.html#cmdoption-on-download-complete))，调用 Rclone 上传(move)下载的文件到网盘，并删除 `.aria2` 后缀名文件。（默认不启用）

`delete.aria2.sh` - `*.aria2`文件删除脚本：在下载完成后执行([on-download-complete](https://aria2.github.io/manual/en/html/aria2c.html#cmdoption-on-download-complete))，删除 `.aria2` 后缀名文件。（默认启用）

`delete.sh` - 删除脚本：在下载停止后执行([on-download-stop](https://aria2.github.io/manual/en/html/aria2c.html#cmdoption-on-download-stop))，删除文件及 `.aria2` 后缀名文件。（默认启用）

`info.sh` - 任务信息显示脚本：在下载暂停后执行([on-download-pause](https://aria2.github.io/manual/en/html/aria2c.html#cmdoption-on-download-pause))，输出下载任务信息到日志中。（debug 专用）

`tracker.sh` - BT tracker 获取脚本：在 Aria2 配置文件(`aria2.conf`)所在目录执行即可获取[最新 tracker 列表](https://raw.githubusercontent.com/XIU2/TrackersListCollection/master/all.txt)并添加到配置文件中。由于脚本具有时效性，建议执行`bash <(wget -qO- git.io/tracker.sh)`命令获取最新脚本并直接运行。其它使用方法详见[这里](https://p3terx.com/archives/solved-aria2-cant-download-magnetic-link-bt-seed-and-slow-speed.html)。

### DHT 文件

提升 BT 下载率和下载速度的关键之一。相关科普：《[解决 Aria2 无法下载磁力链接、BT种子和速度慢的问题](https://p3terx.com/archives/solved-aria2-cant-download-magnetic-link-bt-seed-and-slow-speed.html)》

`dht.dat` - DHT（IPv4）文件

`dht6.dat` - DHT（IPv6）文件

## 更新日志

### 2020-1-15

- 调整脚本注释与格式。
- 优化`delete.sh`判断逻辑，防止不正确的使用方式（路径不一致）导致的文件被删除。

<details>
<summary>历史记录</summary>

### 2019-11-28

配置文件(`aria2.conf`)：

- 优化配置参数

其它文件：

- 更新 DHT 文件

### 2019-11-25

附加功能脚本：

- 修改 Trackers 来源([XIU2/TrackersListCollection](https://github.com/XIU2/TrackersListCollection))

### 2019-10-23

附加功能脚本：

- 新增 BT tracker 获取脚本

### 2019-10-21

配置文件(`aria2.conf`)：

- 优化配置参数
- 解决已完成的任务在重启后重复下载的 bug
- ~~新增 重启后已完成的任务消失的 bug（雾~~

附加功能脚本：

- 修复 `autoupload.sh` 因 Rlone 上传后剩余空目录导致**上传失败重试功能**误判的 bug
- 改善 `delete.sh`、`delete.aria2.sh` 路径判断逻辑，增加删除空目录功能。

### 2019-10-10

附加功能脚本（`autoupload.sh`）：

- 增加 上传失败重试功能

### 2019-06-08

附加功能脚本（`autoupload.sh`）：

* 优化 路径判断逻辑
* 修复 BT下载文件夹下所有文件时路径无法判断的 bug

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

</details>
