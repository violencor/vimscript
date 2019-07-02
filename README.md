```
open vim, do ":PluginInstall"

## command
| 操作    | 功能                                                                                       |
|---------|--------------------------------------------------------------------------------------------|
| C-c     | 复制光标所在的整个单词                                                                     |
| Space-f | 跳转光标所在变量/函数的声明/定义(优先跳转到定义), 这里的跳转使用的是ycmd                   |
| Space-d | 跳转光标所在变量/函数的定义(在定义上使用该命令会跳转到声明), 依赖rtags建立的索引           |
| Space-r | 跳转光标所在变量/函数的引用(如果是多个引用, 会以quick-list的形式展示), 依赖rtags建立的索引 |
| Space-c | 清除行尾空格                                                                               |
| Space-v | 清除行尾tab                                                                                |
| Space-w | 在当前目录下用grep全局查找光标所在的单词, 一般是在Space-r使用无效的时候使用, 应急          |
| F2      | 显示80列的警戒线(再敲一次F2取消)                                                           |
