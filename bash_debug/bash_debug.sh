#! /usr/bin/sh 

# Usage: assert condition [err_msg]
# Description: if condition is true script continue to execute, otherwise exit script. If "err_msg" is present it will be print as well. condition reference to "[[ condition ]]"
assert()
{
    [[ $# -eq 0 ]] && return 0
    local condition="$1"
    local message="$2"
    eval "[[ $condition ]]" 
    if [[ ! $? -eq 0 ]]; then
        printf "Assert failed:\"%s\". Location: " "$condition"
        caller 0
        exit 1
    fi
}

