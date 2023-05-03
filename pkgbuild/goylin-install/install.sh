#!/bin/bash

echo
echo "# Goylin Install #"
echo

read -p "?: Hostname: " hostName; echo

echo ">: Device List:"; echo
lsblk; echo
read -p "?: Target device: " deviceName; echo
device="/dev/${deviceName}"
boot="${device}1"
swap="${device}2"
root="${device}3"
home="${device}4"

. utils/0-bootstrap.sh
. utils/1-partition.sh
. utils/2-format.sh
. utils/3-mount.sh
. utils/4-pacstrap.sh
. utils/5-grub.sh
. utils/6-config.sh
