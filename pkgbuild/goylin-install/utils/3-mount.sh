#!/bin/bash

echo ">: Mounting ${device} partitions..."; echo

#swapon ${swap}
mount ${root} /mnt
mkdir -pv /mnt/{boot,home}
mount ${boot} /mnt/boot
mount ${home} /mnt/home

echo; lsblk | grep ${deviceName}; echo

echo ":: Done!"; echo