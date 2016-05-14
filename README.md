# bash-utils
This project include some useful utils for bash script development.e.g. color, debug, progress bar...

## 安装

可通过下面方式之一使用该项目中 bash 脚本：

* 复制 bash 脚本片段到你的脚本中
* 下载 bash 脚本文件，然后导入到你的脚本中。
* 直接导入网络脚本，将下面代码段复制到你的脚本中，修改其中的 url 地址为要导入的网络脚本地址。
```
import ()
{
    url="$1"
    file=".bash_debug.sh"
    if [[ -e "$HOME/$file" ]]; then
        . "$HOME/$file"
    else
        printf "downloading ..."
        curl -o "$file" "$url" 2> /dev/null && mv "$file" "$HOME/$file" && . "$HOME/$file"
        printf "\r"
    fi
    return 0
}
import "https://raw.githubusercontent.com/whinc/bash-utils/master/bash_debug/bash_debug.sh"
```
或者写在一行中：
```
import () { url="$1"; file=".bash_debug.sh"; if [[ -e "$HOME/$file" ]]; then . "$HOME/$file"; else printf "downloading ..."; curl -o "$file" "$url" 2> /dev/null && mv "$file" "$HOME/$file" && . "$HOME/$file"; printf "\r"; fi; return 0; }; import "https://raw.githubusercontent.com/whinc/bash-utils/master/bash_debug/bash_debug.sh"
```

## assert 断言

用法：`assert condition`

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
脚本地址：`https://raw.githubusercontent.com/whinc/bash-utils/master/bash_debug/bash_debug.sh`
