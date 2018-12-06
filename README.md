# aria2 完美配置
`aria2.conf` 配置文件本体

**调用的脚本：**

`autoupload.sh` 下载完成后自动调用 rclone 上传(move)到网盘，删除 `.aria2` 文件，过滤无用文件等。（可选）

`delete.aria2.sh` 下载完成后删除 `.aria2` 文件。

`delete.sh` 下载错误和停止后删除文件（包括 `.aria2` 文件），避免占用空间。

**其他文件：**

`dht.dat` DHT（IPv4）文件

`dht6.dat` DHT（IPv6）文件

`test.sh` 测试脚本时 debug 用的，可能永远用不到了。