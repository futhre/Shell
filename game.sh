#!/bin/bash
#Author:木+辛
#mail:(3341351937@qq.com)
#Description:Rock-Paper-Scissors

Game=(石头 剪刀 布)
Num=$[RANDOM%3]
Computer=${Game[$Num]}
#1
echo  "请根据下列提示选择你出拳的手势"
    echo  "1.石头"
    echo  "2.剪刀"
    echo  "3.布"

#2
read   -p   "请选择1-3:"  Person
case  $Person  in
1)
if   [ "$Num"   -eq   0  ];then
    echo   "平局"
elif [ "$Num"   -eq   1  ];then
    echo   "您赢"
else 
    echo   "计算机赢"
fi;;

#3
2)
if   [ "$Num"   -eq   0 ];then
    echo   "计算机赢"
elif [ "$Num"   -eq  1  ];then
    echo   "平局"
else
    echo   "您赢"
fi;;

#4
3)
if   [ "$Num"   -eq  0  ];then
    echo   "您赢"
elif [ "$Num"   -eq   1 ];then
    echo    "计算机赢"
else
    echo    "平局"
fi;;
*)
echo   "必须输入1-3的数字"
esac
