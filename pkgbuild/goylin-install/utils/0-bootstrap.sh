#!/bin/bash

echo ">: Bootstraping..."; echo

#loadkeys br-abnt2
#timedatectl set-ntp true
#timedatectl status; echo

#pacman -Syy
pacman -S --noconfirm --needed - < pkgList/dep
#reflector --latest 10 --sort rate --save /etc/pacman.d/mirrorlist
#umount -R /mnt

echo ":: Done!"; echo