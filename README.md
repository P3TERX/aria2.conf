# Aria2 完美配置

[![LICENSE](https://img.shields.io/github/license/mashape/apistatus.svg?style=flat-square&label=LICENSE)](https://github.com/P3TERX/aria2_perfect_config/blob/master/LICENSE)
[![GitHub Stars](https://img.shields.io/github/stars/P3TERX/aria2_perfect_config.svg?style=flat-square&label=Stars&logo=github)](https://github.com/P3TERX/aria2_perfect_config/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/P3TERX/aria2_perfect_config.svg?style=flat-square&label=Forks&logo=github)](https://github.com/P3TERX/aria2_perfect_config/fork)

本项目是一套 Aria2 配置方案，包含了配置文件、附加功能脚本等文件，用于实现 Aria2 功能的增强和扩展，提升 Aria2 的下载速度与使用体验，解决 Aria2 在使用中遇到的 BT 下载无速度、文件残留占用磁盘空间、任务丢失、重复下载等问题。

## 功能特性

* BT 下载率高、速度快
* 重启后不丢失任务进度、不重复下载
* 下载错误或取消下载自动删除未完成的文件防止磁盘空间占用
* 下载完成自动清除`.aria2`后缀名文件
* 一键获取 BT tracker，进一步提升 BT 下载速度
* 更好的 PT 下载支持
* 有一定的防版权投诉、防迅雷吸血效果
* 联动 RCLONE 自动上传到 Google Drive 和 OneDrive 等网盘

## 部署方案

**推荐使用以下项目部署以获得最佳使用体验**

- [Aria2 Pro](https://github.com/P3TERX/docker-aria2-pro) (Docker)

- [Aria2 一键安装管理脚本 增强版](https://github.com/P3TERX/aria2.sh) (GNU/Linux)

## 进阶玩法

* [OneDrive、Google Drive 等网盘离线下载](https://p3terx.com/archives/offline-download-of-onedrive-gdrive.html)
* [百度网盘转存到 OneDrive 、Google Drive 等其他网盘](https://p3terx.com/archives/baidunetdisk-transfer-to-onedrive-and-google-drive.html)

## 文件说明

> **TIPS:** 脚本需配合配置文件使用，仅适用于 GNU/Linux

| 文件                    | 说明                                                                                                                                                                                                                                                                 |
| ----------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `aria2.conf`            | Aria2 配置文件。建议使用 1.35.0 及以上版本，在不了解的情况下修改可能导致本方案的特性失效。                                                                                                                                                                           |
| `delete.sh`             | 文件删除脚本。在下载停止后执行([on-download-stop](https://aria2.github.io/manual/en/html/aria2c.html#cmdoption-on-download-stop))，自动删除文件及 `.aria2` 后缀名文件，防止不必要的磁盘空间占用。（默认启用）                                                        |
| `clean.sh`              | 清理脚本。在下载完成后执行([on-download-complete](https://aria2.github.io/manual/en/html/aria2c.html#cmdoption-on-download-complete))，自动清除 `.aria2` 后缀名文件。（默认启用）                                                                                    |
| `upload.sh`             | 上传脚本。在下载完成后执行([on-download-complete](https://aria2.github.io/manual/en/html/aria2c.html#cmdoption-on-download-complete))，自动调用 RCLONE 上传(move)下载的文件到网盘，并自动清除 `.aria2` 后缀名文件与空目录。（默认不启用）                            |
| `move.sh`               | 文件移动脚本。在下载完成后执行([on-download-complete](https://aria2.github.io/manual/en/html/aria2c.html#cmdoption-on-download-complete))，自动将下载完成的文件移动到指定目录，并自动清除 `.aria2` 后缀名文件与空目录。（默认不启用）                                |
| `tracker.sh`            | BT tracker 列表更新脚本。在 Aria2 配置文件(`aria2.conf`)所在目录执行即可获取[最新 tracker 列表](https://raw.githubusercontent.com/XIU2/TrackersListCollection/master/all.txt)并添加到配置文件中。此脚本还有更强大的功能，具体使用方法详见 [tracker.md](./tracker.md) |
| `dht.dat`<br>`dht6.dat` | DHT 文件。提升 BT 下载率和下载速度的关键之一。相关科普：《[解决 Aria2 无法下载磁力链接、BT种子和速度慢的问题](https://p3terx.com/archives/solved-aria2-cant-download-magnetic-link-bt-seed-and-slow-speed.html)》                                                    |

## 遇到问题如何处理

遇到问题先看 [FAQ](https://p3terx.com/archives/aria2_perfect_config-faq.html) 再提问，你还可以加入 [Aria2 TG 群](https://t.me/Aria2c)和小伙伴们一起讨论。要注意提问的方式和提供有用的信息，提问前建议去学习《[提问的智慧](https://github.com/ryanhanwu/How-To-Ask-Questions-The-Smart-Way/blob/master/README-zh_CN.md)》，这能更好的帮助你去解决问题和节约时间。诸如 “为什么不能使用？”、“那你能帮帮我吗？” 之类的问题应该没有人会知道。

## 更新日志

**全新版本即将来袭，敬请期待...**

更新推送：[Aria2 Channel](https://t.me/Aria2_Channel)

### 2020-06-27 | V2 终极版

配置文件(`aria2.conf`)：
- 优化选项参数，提升下载速度与使用体验
- 优化排版格式及注释说明，提升阅读体验

附加功能脚本：
- `delete.aria2.sh`更名为`clean.sh`
- `autoupload.sh`更名为`upload.sh`
- 细节改进，提升使用体验

<details>
<summary>历史记录</summary>

### 2020-06-08

配置文件(`aria2.conf`)：
- 默认关闭文件预分配(`file-allocation=none`)，最大化文件系统兼容性。
- 其它细节改进

其它：
- 更新 DHT 文件

### 2020-05-03

配置文件(`aria2.conf`)：
- 优化 部分设置选项与注释说明。
- 增加 非官方增强选项。仅适用于 [myfreeer/aria2-build-msys2](https://github.com/myfreeer/aria2-build-msys2) 和 [P3TERX/aria2-builder](https://github.com/P3TERX/aria2-builder) 项目所构建的版本。

### 2020-04-16

- 新增 文件移动脚本(`move.sh`)，将下载完成的文件移动到指定目录。与自动上传脚本类似，对于 BT 多文件可完整保留目录结构。

### 2020-04-12

- 重构 BT tracker 列表更新脚本(`tracker.sh`) ，增加通过 RPC 方式更新 BT tracker 的功能，无需重启 Aria2 即可生效。

### 2020-03-11

配置文件(`aria2.conf`)：
- 新增 日志设置。默认设置日志级别为`warn`，仅输出警告和错误，可大幅减少日志产生并有利于排错。

### 2020-02-18

> **TIPS:** 本次更新重构了所有附加功能脚本。使用 [Aria2 一键安装管理脚本](https://github.com/P3TERX/aria2.sh) 的小伙伴请卸载后升级到最新脚本部署。使用 [Aria2 Pro](https://github.com/P3TERX/docker-aria2-pro)  Docker 镜像的小伙伴请删除配置文件目录后拉取最新镜像进行部署。

RCLONE 自动上传脚本（`autoupload.sh`） ：
- 文件过滤功能强势回归，文件大小过滤、文件类型过滤，功能更强大。
- 新增 RCLONE 高级设置：自定义配置文件路径、配置文件解密、并行上传数等功能。
- 增强上传失败重试机制。

其它：
- 优化自动删除脚本（`delete.sh`、`delete.aria2.sh`）判断逻辑。
- 移除配置文件(`aria2.conf`)过时配置项
- 更新 DHT 文件

### 2020-02-05

配置文件(`aria2.conf`)：
- 更新客户端伪装设置
- 默认开启强制加密（防版权投诉、迅雷吸血）

### 2020-01-22

配置文件(`aria2.conf`)：
- 默认关闭 IPv6 相关功能，防止不支持 IPv6 的情况下导致的 DHT 功能异常。
- 更新客户端伪装设置，理论上可更好的支持 PT 下载。
- 新增 BT 加密设置，理论上可防版权投诉、迅雷吸血。

### 2020-01-15

- 调整脚本注释与格式。
- 优化`delete.sh`判断逻辑，防止不正确的使用方式（路径不一致）导致的文件被删除。

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

## 声明

本项目使用 [MIT](https://github.com/P3TERX/aria2.conf/blob/master/LICENSE) 开源协议，对于本项复制、修改、发布等行为请遵守相关协议保留所有文件中的版权信息，谢谢合作！
