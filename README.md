# bash-utils
This project include some useful utils for bash script development.e.g. color, debug, progress bar...

## Install 安装

You can use bash script in this project with way below:
* copy code segment below to the top of your script
* replace the "ADDRESS" to the real url address.

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
import "ADDRESS"
```
or write in exactly one line.
```
import () { url="$1"; file=".bash_debug.sh"; if [[ -e "$HOME/$file" ]]; then . "$HOME/$file"; else printf "downloading ..."; curl -o "$file" "$url" 2> /dev/null && mv "$file" "$HOME/$file" && . "$HOME/$file"; printf "\r"; fi; return 0; }; import "ADDRESS"
```

## assert 断言

**Usage**: `assert condition`

**Description**: assert the condition is true. script will continue to execute if codition is true, otherwise exit script with code 1 and print line number, function name and script name. condition is a expression in [[...]], so you can use any expression used in [[...]], e.g. `"str1 == str2", "1 -eq 1", "-e file"`.

**Examples**:
```
#! /usr/bin/sh
# test_bash_debug.sh

...

test_assert ()
{
    assert "0 -eq 1"
}

# output
Assert failed:"0 -eq 1". Location: 9 test_assert ./test_bash_debug.sh
```

**Address**:`https://raw.githubusercontent.com/whinc/bash-utils/master/bash_debug/bash_debug.sh`


## color 颜色

**Usage**: `color STYLE FG BG`

**Description**:Print color value specified by STYLE, FG and BG to stdout, e.g. `'\e[00;31;47m'`.Your can use this color value to control bash console color.STYLE, FG and BG can reference to table below:

|STYLE|说明|
|---|----|
|`00`|无样式 none|
|`01`|粗体 bold|
|`04`|下划线 underscore|
|`05`|高亮 blink|
|`07`|前景背景互换 reverse|
|`08`|隐藏 concealed |

|Color|FG|BG|说明|
|----|--|--|----|
|<font color="black">■</font>|`30`|`40`|黑色 black |
|<font color="red"  >■</font>|`31`|`41`|红色 red|
|<font color="green">■</font>|`32`|`42`|绿色 green |
|<font color="yellow">■</font>|`33`|`43`|黄色 yellow |
|<font color="blue">■</font> |`34`|`44`|蓝色 blue |
|<font color="magenta">■</font>|`35`|`45`|品红 magenta |
|<font color="cyan">■</font> |`36`|`46`|青色 cyan |
|<font color="white">■</font>|`37`|`47`|白色 white |

**Examples**:
```
$ echo -e "$(color blink red green)hello$(color) world"
```

**Address**:
