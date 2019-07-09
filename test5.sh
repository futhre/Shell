#!/bin/bash
function A {
#DISK INFORMATION          要求用户只能选择一个空硬盘进行操作
  D=`fdisk -l | grep -v Extended | grep Di | awk '{print $2}' | cut -d: -f1`                #截取出所有的DISK名字
for I in $D;do                                                                              #用for循环打印出每一个DISK的柱面信息
  C=`fdisk -l $I | grep -v Extended |  head -3 | tail -1 | awk '{print $5}'`                #截取出总柱面信息 
  CN=`fdisk -l $I | grep -v Extended | tail -1 | awk '{print $3}' `                         #截取出最后柱面，并排除extend分区
    if [ $CN == 'Start' ];then                                                              #排除新硬盘没有分区的情况
       let CN=0
       echo "DISK:$I Total:$C Free:$[$C-$CN]"
    else
       echo "DISK:$I Total:$C Free:$[$C-$CN]"
    fi
done
 
 
#USER INPUT      
  read -p "Please chose a free disk for creating LV:" DISK
  fdisk -l $DISK
  read -p "Input the VG's name;" VG
  read -p "The number of PV;" NPV
 
 
#FDISK PV  用for循环实现创建用户所要求的PV，精确到每一个
for (( i=1;i<=$NPV;i++ ));do
  read -p "The size of $i PV:" SPV
fdisk /dev/vdb << End
n
p
 
 
+$SPV                      
t
$i
8e
w 
End
done
 
 
  partprobe $DISK
#PV $ VG CREATE                 在刚创建的PV基础上创建VG
  DPV=`fdisk -l /dev/vdb | tail -$NPV | awk '{print $1}'`
for I in $DPV ;do
  pvcreate $I
done
  DPV=`echo $DPV`
  vgcreate $VG $DPV
 
 
#LV CREATE                      询问用户创建的LV的名字，和vg，创建出LV
  read -p "Input the name of LV:" LV
  read -p "Input the size of LV;" SLV
  lvcreate -L $SLV -n $LV $VG
  mke2fs -r /dev/$LV
 
 
#MOUNT              询问用户挂载点，并且直到这个挂载点没有被占用，才挂载上LV
  read -p "Input the mount dir:" DIR
  mount | grep "DIR"
  TEST=$?
until [ $TEST -eq 0 ] ;do
    echo "The dir is exist,try another!"
    read -p "Input the mount dir:" DIR
    mount | grep "DIR"
    TEST=$?
done
  mount /dev/$VG/$LV
 
 
}
 
 
function B {
 
######################创建LV
until [ $TEST -eq 0 ];do
  read -p "Input the the name of LV:" LV
  read -p "Input the size of LV:" SLV
  vgdisplay
  read -p "Input the VG's name:" VG
  lvcreate /dev/$VG/$LV
  TEST=$?
done
}
 
#####################扩展LV，如果容量不够扩展，重新选择大小进行扩展，直到可以扩展
function C {
until [ $TEST -eq 0 ];do                                       
  read -p "Which LV you want extend:" LV          
  lvdisplay $LV
  read -p "Input the VG;s name:" VG
  read -p "The size of extend:" SEN
  lvextend -L $SEN /dev/$VG/$LV
  TEST=$?
  resize -p /dev/$VG/$LV
done
}
 
#######################缩小LV，如果容量限制不能缩小，重新选择大小，直到可以缩小，并且缩小前自检
function D {
until [ $TEST -eq 0 ];do
  read -p "Which LV you want reduce:" LV
  lvdisplay $LV
  read -p "Input the VG's name:" VG
  read -p "The size of reduce to:" SRE
  umount /dev/$VG/$LV
  e2fsck -f /dev/$VG/$LV
  resize2fs /dev/$VG/$LV $SRE
  TEST=$?
  lvreduce -L $SRE /dev/$VG/$LV
done
}
 
### 程序选择界面
echo "------------------------------------------"
echo '-----------Program for LVM----------------'
echo "A Create an LV.
B Create an LV in an existing VG.
C Extend an LV.
D Reduce an LV."
read -p "Your choise,others for quite:" CH
case $CH in
'A')
     A
    ;;
'B')
     B
    ;;
'C')
     C
    ;;
'D')
     D
    ;;
  *)
    exit
    ;;
esac
