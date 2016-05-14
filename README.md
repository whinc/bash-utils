# bash-utils
This project include some useful utils for bash script development.e.g. color, debug, progress bar...

## 安装

可通过下面方式之一使用该项目中 bash 脚本：

* 复制 bash 脚本片段到你的脚本中
* 下载 bash 脚本文件，然后导入到你的脚本中。
* 在你的脚本使用前导入 bash 脚本，通过下面代码：
```
[[ -e ~/.file.sh ]] && . ~/.file.sh || curl -o ~/.file.sh"$url_to_script" && . ~/.file.sh
```

## assert 断言

使用：`assert condition`
说明：断言函数，如果条件成立则脚本继续执行，否则输出断言的行号、所在函数名和脚本名。condition 是一个"[[..]]"内部表达式，因此你可以使用"[[..]]"中所有的条件判断，如"str1 == str2", "1 -eq 1", "-e file"等。
示例：
```
# test_bash_debug.sh
...
assert "0 -eq 1"
...

# output
Assert failed:"0 -eq 1". Location: 9 test_assert ./test_bash_debug.sh
```
