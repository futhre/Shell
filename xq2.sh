#!/bin/bash

#=======================================================================
#Copyright(C)2018Westos All rights reserved.
#
#  
#  Author:木+辛
#  Mail: 3341351937@qq.com
#  Date:2018-12-28
#  Description:Chess
#  Blog: http://blog.51.cto.com/4081735
#  Lisense: GPL
#
#=======================================================================
read  -p  "Please input cell's height:"   HI
echo ""
read  -p  "Please  input cell's width:"   WI
[[ "$HI"  =~ ^[0-9] +$  ]]  &&  [[ "$WI" =~ ^[0-9] +$  ]] || {echo  "Invalid argu,Please input Numeric"; exit; }

 echo  "==================================="
PS3="Please choose the Player1's Board Color(1-7):"
select COL1 in red green yellow blue purple skyblue white;do

case $COL1 in 
red)
      echo    Player\'s color is $COL1
              let  COL1=1
              break
              ;;

green)


      echo   Player\'s color is $COL1
             let  COL1=2
             break
             ;;

yellow)
      echo   Player\'s color is $COL1
             let  COL1=3
             break 
             ;;

blue)
      echo   Player\'s color is $COL1
             let  COL1=4
             break
             ;;

purple)
      echo    Player\'s color is $COL1
              let  COL1=5
              break
              ;;
skyblue)
      echo   Player\'s color is $COL1
             let  COL1=6
             break
             ;;

white)
     echo    Player\'s color is $COL1
             let  COL1=7 
             break
             ;;
esac
done
echo  ""
echo    "==============================================================="
echo  ""


PS3="Please choose the Player2's Borad Color(1-7):"
select COL2 in red green yellow blue purple skyblue white;do       
case $COL2 in
red)
    echo    Player\'s color is $COL2
            let  COL2=1
            break
            ;;

green)
     echo   Player\'S color is $COL2
            let  COL2=2
            break
            ;;

yellow)
      echo   Player\'s color is $COL2
             let  COL2=3
             break
             ;;

blue)
     echo    Player\'s color is $COL2
             let  COL2=4
             break
             ;;

purple)
      echo   Player\'s color is $COL2
             let  COL2=5
             break
             ;;

skyblue)
      echo   Player\'s  color is $COL2
             let  COL2=6
             break 
    	     ;;
white)
      echo   Playre\'s   color is $COL2
             let  COL2=7
             break
             ;;
esac
done

echo  ""
echo   "============================================================="
echo  ""

for I in {1..8};do
if [ $[I%2] -eq 1 ];then
   for J in `seq $HI`;do
      for  K in {1..8};do
          if [ $[K%2] -eq 1 ];then
               echo   -e  "\033[1;4$[$COL1]m'printf  "%$[$WI]s"'\033[0m\c"
      else    
              echo    -e  "\033[1;4$[$COL2]m'printf  "%$[$WI]s"'\033[0m\c"

fi
   
      let K++
done
echo ""
      let J++
done

      else
        for J in `seq $HI`;do
           for K in {1..8};do
               if [ $[K%2] -eq 1 ];then
              echo   -e  "\033[1;4$[$COL2]m'printf "%$[$WI]s"'\033[0m\c"
      else
              echo   -e  "\033[1;4$[$COL1]m'printf "%$[$WI]s"'\033[0m\c"
fi

      let K++
done
echo  ""
      let J++
done
fi
      let I++
done
