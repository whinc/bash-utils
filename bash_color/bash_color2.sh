#! /usr/bin/sh

# font style
SNONE=00
SBOLD=01
SUNDERSCORE=04
SBLINK=05
SREVERSE=07
SCONCEALED=08

# font foreground color
FBLACK=30
FRED=31
FGREEN=32
FYELLOW=33
FBLUE=34
FMAGENTA=35
FCYAN=36
FWHITE=37

# font background color
BBLACK=40
BRED=41
BGREEN=42
BYELLOW=43
BBLUE=44
BMAGENTA=45
BCYAN=46
BWHITE=47

PRE_STYLE="none"
PRE_FG="white"
PRE_BG="black"

# color sytle fg bg
color ()
{
    # clear font style and color if no input arguments
    if [[ $# -eq 0 ]]; then 
        PRE_STYLE="none"
        PRE_FG="white"
        PRE_BG="black"
        echo -n "\e[m"
        return 0
    elif [[ ! $# -eq 3 ]];then
        return 1
    fi

    local style_name
    local fg_name
    local bg_name
    if [[ "$1" == "-" ]]; then
        style_name="$PRE_STYLE"
    else
        style_name="$1"
        PRE_STYLE="$style_name"
    fi

    if [[ "$2" == "-" ]]; then
        fg_name="$PRE_FG"
    else
        fg_name="$2"
        PRE_FG="$fg_name"
    fi

    if [[ "$3" == "-" ]]; then
        bg_name="$PRE_BG"
    else
        bg_name="$3"
        PRE_BG="$bg_name"
    fi

    local style=S$(tr "[:lower:]" "[:upper:]" <<< "${style_name}")
    local fg=F$(tr "[:lower:]" "[:upper:]" <<< "${fg_name}")
    local bg=B$(tr "[:lower:]" "[:upper:]" <<< "${bg_name}")

    local color="\e["
    [[ -n "${!style}" ]] && color="${color}${!style}"
    if [[ -n "${!fg}" ]]; then
        [[ -n "${!style}" ]] && color="${color};"
        color="${color}${!fg}"
    fi
    if [[ -n "${!bg}" ]]; then
        [[ -n "${!fg}" ]] && color="${color};"
        color="${color}${!bg}"
    fi
    color="${color}m"
    echo -n "$color"
    return 0
}
