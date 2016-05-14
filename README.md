# bash-utils
This project include some useful utils for bash script development.e.g. color, debug, progress bar...

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

**Install:** Copy code below to the top of your script.
```
import () { url="$1"; file=".bash_debug.sh"; if [[ -e "$HOME/$file" ]]; then . "$HOME/$file"; else printf "downloading ..."; curl -o "$file" "$url" 2> /dev/null && mv "$file" "$HOME/$file" && . "$HOME/$file"; printf "\r"; fi; return 0; }; import "https://raw.githubusercontent.com/whinc/bash-utils/master/bash_debug/bash_debug.sh"
```


## color 颜色

**Usage**: `color STYLE FG BG`

**Description**:Print color value specified by STYLE, FG and BG to stdout, e.g. `'\e[00;31;47m'`.Your can use this color value to control bash console color.STYLE, FG and BG can reference to table below:

|STYLE|说明|
|-----|----|
|none|无样式 |
|bold|粗体 |
|underscore|下划线 |
|blink|高亮 |
|reverse|前景背景互换 |
|concealed|隐藏 |

|FG or BG|说明|
|----|-----------|
|black|黑色|
|red|红色 |
|green|绿色|
|yellow|黄色 |
|blue|蓝色|
|magenta |品红 |
|cyan |青色 |
|white|白色 |

**Examples**:
```
$ echo -e "$(color blink red green)hello$(color) world"
```

![screenshot](https://raw.githubusercontent.com/whinc/bash-utils/master/bash_color/screenshot.png)

**Install:** Copy code below to the top of your script.
```
import () { url="$1"; file=".bash_color.sh"; if [[ -e "$HOME/$file" ]]; then . "$HOME/$file"; else printf "downloading ..."; curl -o "$file" "$url" 2> /dev/null && mv "$file" "$HOME/$file" && . "$HOME/$file"; printf "\r"; fi; return 0; }; import "https://raw.githubusercontent.com/whinc/bash-utils/master/bash_color/bash_color.sh"
```
