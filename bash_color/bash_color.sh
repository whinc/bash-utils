#!/usr/bin/sh 

# import debug tools
# . ./debug.sh

EXIT_OK=0
EXIT_FAILED=1

# Usage: get_style style_name
# Description: Get style code by style name.
# Argument style_name: one of "none" "bold" "underscore" "blink" "reverse" "concealed"
# Return: return 0 if success, otherwise reutrn 1.
# Output: print style code if success.
get_style() 
{
    # check argc
    [[ ! $# -eq 1 ]] && return $EXIT_FAILED

    # style name
    local name="$1"

    # style code
    local none="00"
    local bold="01"
    local underscore="04"
    local blink="05"
    local reverse="07"
    local concealed="08"

    # style name array
    local styles=("none" "bold" "underscore" "blink" "reverse" "concealed")

    # query style code
    local code
    for ((i = 0; i < ${#styles[*]}; ++i));do
        if [[ "${styles[i]}" == "${name}" ]];then
            code="${!name}"
            break
        fi
    done

    # print code if it is found in defined style 
    if [[ -n "$code" ]];then
        echo -n "$code"
    else
        return $EXIT_FAILED
    fi
    return $EXIT_OK
}

# Usage: get_color (-f|-b) name
# -f: foreground color
# -b: background color
# name: one of "black" "red" "green" "yellow" "blue" "magenta" "cyan"
get_color()
{
    # check argc
#    [[ ! $# -eq 1 ]] && return $EXIT_FAILED

    local option    # option -f or -b
    local name      # color name

    while getopts "f:b:" opt; do
        case $opt in
            "f" | "b")
                option=$opt
                name=$OPTARG
            ;;
        esac
    done

    local black="30"
    local red="31"
    local green="32"
    local yellow="33"
    local blue="34"
    local magenta="35"
    local cyan="36"
    local white="37"
    local colors=("black" "red" "green" "yellow" "blue" "magenta"  "cyan" "white")
    local code

    # query color code 
    for ((i = 0; i < ${#colors[*]}; ++i));do
        if [[ "${colors[i]}" == "$name" ]]; then
            code=${!name}
            break
        fi
    done

    # print code if it is found in defined colors 
    if [[ -z "$code" ]]; then
        return $EXIT_FAILED
    else
        # if it is background color, code plus 10
        [[ "$option" == "b" ]] &&  let "code += 10"
        echo -n "$code"
    fi

    return 0
}

pre_style=""
pre_fg=""
pre_bg=""

show_usage()
{
    TAB="    "
    echo "Usage:"
    echo "${TAB}$(basename ${BASH_SOURCE[0]}) STYLE FG BG"
    echo "Description:"
    echo "${TAB}STYLE is the style of char, it is one of 'none' 'bold' 'underscore' 'blink' 'reverse' 'concealed'"
    echo "${TAB}FG is the foreground color of char. BG is the background color of char. FG and BG is one of 'black' 'red' 'green' 'yellow' 'blue' 'magenta' 'cyan'"
    echo "${TAB}If STYLE, FG or BG is '-' the previous value is used."
    echo "${TAB}Clear char style and color if there is no any argument. Equal to execute 'color none white black'"
    echo 
    echo "Examples:"
    echo "    echo \"\$(color blink red green)hello\$(color)"
    echo -e "    $(color blink red green)hello$(color)"
    return 0
}

show_version()
{
    echo "color version 0.1"
    return 0
}

color()
{
    # clear char style and color if there are no argv
    [[ $# -eq 0 ]] && echo -n "\e[m" && return 0
    [[ "$1" == "-h" || "$1" == "--help" ]] && show_usage && return 0
    [[ "$1" == "-v" || "$1" == "--version" ]] && show_version && return 0

    local style     # style code
    local fg        # foreground color code
    local bg        # background color code

    # get style and color with their name
    # if style or color is '-' it's previous value is used.
    [[ "$1" == "-" ]] && style="$pre_style" || style="$(get_style $1)"
    [[ "${2:--}" == "-" ]] && fg="$pre_fg" || fg="$(get_color -f ${2:--})"
    [[ "${3:--}" == "-" ]] && bg="$pre_bg" || bg="$(get_color -b ${3:--})"

    # store style and color 
    pre_style="$style"
    pre_fg="$fg"
    pre_bg="$bg"

    # construct color value
    local color="\e["
    if [[ -n "${style}" ]]; then
        color="${color}${style}"
    fi
    if [[ -n "${fg}" ]]; then
        if [[ -n "${style}" ]]; then
            color="${color};"
        fi
        color="${color}${fg}"
    fi
    if [[ -n "${bg}" ]]; then
        if [[ -n "${style}"  || -n "${fg}" ]] ;then
            color="${color};"
        fi
        color="${color}${bg}"
    fi
    color="${color}m"
    echo -n "$color"
}

