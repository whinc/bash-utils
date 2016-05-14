#! /usr/bin/sh 

import () { url="$1"; file=".bash_color.sh"; if [[ -e "$HOME/$file" ]]; then . "$HOME/$file"; else printf "downloading ..."; curl -o "$file" "$url" 2> /dev/null && mv "$file" "$HOME/$file" && . "$HOME/$file"; printf "\r"; fi; return 0; }; import "https://raw.githubusercontent.com/whinc/bash-utils/master/bash_color/bash_color.sh"

test_get_style() 
{
    get_style
    assert "! $? -eq 0"

    get_style 1 2
    assert "! $? -eq 0"

    style=$(get_style 'none')
    assert "$? -eq 0"
    assert "$style == 00"

    get_style 'abc'
    assert "! $? -eq 0"
}


test_get_color()
{
    get_color
    assert "! $? -eq 0"

    get_color 1 2
    assert "! $? -eq 0"

    color=$(get_color -f "red")
    assert "$? -eq 0"
    assert "$color == 31"

    color=$(get_color -b "red")
    assert "$? -eq 0"
    assert "$color == 41"

    get_color "xxx"
    assert "! $? -eq 0"
}


test_color()
{
    echo "color"
    color
    echo -e "\ncolor none red green"
    color none red green
    echo -e "\ncolor - - -"
    color - - -
    echo -e "\ncolor blink - cyan"
    color blink - cyan
    echo -e "\ncolor bold red abc"
    color bold red abc
    echo -e "\ncolor a b c"
    color a b c
}

test_color
