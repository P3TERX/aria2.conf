# aria2 完美配置
`aria2.conf` 配置文件本体

调用的脚本：

`autoupload.sh` 下载完成后自动调用 rclone 上传( move )到网盘，删除 `.aria2` 文件，过滤无用文件等。

`delete.aria2.sh` 下载完成后删除.aria2文件，如果不需要上传用这个。

`delete.sh` 下载错误和停止后删除文件，避免占用空间。

`test.sh` 测试脚本，测试脚本中变量是否正确。在开始和暂停时运行。
