#!/bin/bash

echo ">: Configuring..."; echo

(
echo pacman-key --init
echo pacman-key --populate archlinux
echo pacman -Syy
echo reflector --sort rate --latest 5 --save /etc/pacman.d/mirrorlist
echo locale-gen
echo ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
echo hwclock --systhoc --utc
echo ${hostName} > /etc/hostname
) | arch-chroot /mnt

echo ":: Done!"; echo