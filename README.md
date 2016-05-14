# bash-utils
This project include some useful utils for bash script development.e.g. color, debug, progress bar...

## Install 安装

You can use bash script in this project with way below:
* copy code segment below to the top of your script
* replace the url address to the real address.

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
or write in exactly one line.
```
import () { url="$1"; file=".bash_debug.sh"; if [[ -e "$HOME/$file" ]]; then . "$HOME/$file"; else printf "downloading ..."; curl -o "$file" "$url" 2> /dev/null && mv "$file" "$HOME/$file" && . "$HOME/$file"; printf "\r"; fi; return 0; }; import "https://raw.githubusercontent.com/whinc/bash-utils/master/bash_debug/bash_debug.sh"
```

## assert 断言

Usage: `assert condition`

Description: assert the condition is true. script will continue to execute if codition is true, otherwise exit script with code 1 and print line number, function name and script name. condition is a expression in [[...]], so you can use any expression used in [[...]], e.g. `"str1 == str2", "1 -eq 1", "-e file"`.

Examples:
```
# test_bash_debug.sh
...
assert "0 -eq 1"
...

# output
Assert failed:"0 -eq 1". Location: 9 test_assert ./test_bash_debug.sh
```
Address:`https://raw.githubusercontent.com/whinc/bash-utils/master/bash_debug/bash_debug.sh`
