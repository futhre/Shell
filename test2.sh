#!/bin/bash
if [ $# -eq 0 ];then
   echo "您需要制定一个软件包名称作为脚本参数"
   echo "用法:$0 软件包名称..."
fi

for Package in "$@";do
 if rpm  -q  ${Package} &> /dev/null;then
         
    echo  -e  "${Package}\033[32m 已安装\033[0m"
else
  
    echo  -e  "${Package}\033[34;1m 未安装\033[0m"
 fi
done
