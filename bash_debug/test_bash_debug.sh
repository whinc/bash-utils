#! /usr/bin/sh

# 导入断言函数
. "$PWD/bash_debug.sh"

test_assert()
{
    assert "0 -eq 0"
    assert "0 -eq 1" 
}

test_assert
