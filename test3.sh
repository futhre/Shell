#!/bin/bash
Url=http://201.1.1.5/index.html

Check_http () {
Status_code=$(curl -m 5 -s -o /dev/null -w %{http_code} $Url)
}

while true;do
   Check_http
   Date=$(date +%Y%m%d-%H:%M:%S)
   echo  "当前时间为:"$Date" "$Url"服务器异常,状态码为${Status_code}.请进快排查."  >   /tmp/http$$.pid
if [ "$Status_code"  -ne  200 ];then
    mail  -s  "Warning"   root  <  /tmp/http$$.pid

else
    echo  "$Url连接正常"   >>  /var/log/http.log
fi
    sleep  5s
done
                         
