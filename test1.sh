#!/bin/bash

rm   -rf    ~/.ssh/{known_hosts,id_rsa*}

ssh-keygen  -t  RSA  -N  ""   -f   ~/.ssh/id_rsa    &>   /dev/null
if  [  $?  -eq   0  ];then
    ls -l    ~/.ssh/*
else
    echo    "Error"
fi
