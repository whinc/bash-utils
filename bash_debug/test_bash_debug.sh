#! /usr/bin/sh 

# 导入断言函数
#. "$PWD/bash_debug.sh"

#import ()
#{
#    url="$1"
#    file=".bash_debug.sh"
#    if [[ -e "$HOME/$file" ]]; then
#        . "$HOME/$file"
#    else
#        printf "downloading ..."
#        curl -o "$file" "$url" 2> /dev/null && mv "$file" "$HOME/$file" && . "$HOME/$file"
#        printf "\r"
#    fi
#    return 0
#}
#import "https://raw.githubusercontent.com/whinc/bash-utils/master/bash_debug/bash_debug.sh"

import () { url="$1"; file=".bash_debug.sh"; if [[ -e "$HOME/$file" ]]; then . "$HOME/$file"; else printf "downloading ..."; curl -o "$file" "$url" 2> /dev/null && mv "$file" "$HOME/$file" && . "$HOME/$file"; printf "\r"; fi; return 0; }; import "https://raw.githubusercontent.com/whinc/bash-utils/master/bash_debug/bash_debug.sh"

test_assert()
{
    assert "0 -eq 0"
    assert "0 -eq 1" 
}

test_assert
