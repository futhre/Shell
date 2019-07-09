#!/bin/bash
#Author:木+辛
clear
echo   -e  "\033[32m  !!!!!警告(Warning)!!!!!\033[0m"
echo 
echo   "+++++++++++++++++++++++++++++++++++++++++++++"
echo   "脚本会将整个整磁盘转换为PV,并删除磁盘上所有数据..."
echo   "This Script Will Destroy All Data On The Disk..."
echo   "+++++++++++++++++++++++++++++++++++++++++++++++++"
echo 

read   -p   "请问是否继续Y/N?:"  Sure
[ $Sure != Y  ]  &&   exit

read   -p   "请输入磁盘名称,如/dev/vdb:" Disk
[ -z  $Disk   ]  &&   echo  "没有输入磁盘名称"   &&  exit

read   -p   "请输入卷组名称:"  Vg_Name
[ -z $Vg_Name ]  &&   echo  "没有输入卷组名称"   &&   exit

read   -p   "请输入逻辑卷名称:"  Lv_Name 
[ -z $Lv_Name ]  &&   echo  "没有输入逻辑名称"   &&   exit

read   -p  "请输入逻辑卷大小:"  Lv_Size 
[ -z $Lv_Size ]  &&   echo  "没有输入逻辑卷大小"  &&   exit

pvcreate  $Disk

if  [  $?  -eq  0  ];then
vgcreate $Vg_Name  $Disk

  if  [ $?  -eq   0  ];then
          lvcreate  -n ${Lv_Name}   -L  ${Lv_Size}   ${Vg_Name}

  fi

fi

