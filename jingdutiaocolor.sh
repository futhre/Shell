#!/bin/bash
#Author:木+辛
#mail:(3341351937@qq.com)
#Description:Progress Bar

i=0
str=""
arr=("|" "/" "_" "\\")
#########################################
while  [  "$i"  -le  100 ]
do
     let  index=i%4
     let  indexcolor=i%8
     let  color=30+indexcolor
     printf  "\e[0;$color;1m[%-100s][%d%%]%c\r" "$str" "$i" "${arr[$index]}"
     sleep  0.1
     let  i++
     str+='='
done
printf  "\n"
