#!/bin/bash
#Author:木+辛
#mail:(3341351937@qq.com)
#Description:Color

ProcessBar()
{
    Now=$1
    All=$2
    percent=$(awk  BEGIN'{printf  "%f",('$Now'/'$All')}')
    len=`awk  BEGIN'{printf  "%d",(100*'$percent')}'`
    bar='>'
#1
for ((i=0;i<len-1;i++))
do
     bar="="$bar
done
     printf   "[%-100s][%03d/%03d]\r"  $bar  $len  100
}
whole=100
process=0
while  [ "$process"   -lt  "$whole"  ]
do 
     let   process++
     ProcessBar  $process   $whole
     sleep  0.1
done
printf  "\n"      

