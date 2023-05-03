#!/bin/bash

echo ">: Installing base..."; echo

pacstrap -K /mnt - < pkgList/pacstrap
genfstab -U /mnt >> /mnt/etc/fstab

install -Dmv 665 dot/pacman.conf /mnt/etc/pacman.conf
install -Dmv 665 dot/vconsole.conf /mnt/etc/vconsole.conf
install -Dmv 665 dot/locale.gen /mnt/etc/locale.gen
install -Dmv 665 dot/locale.conf /mnt/etc/locale.conf
install -Dmv 665 dot/hosts /mnt/etc/hosts
install -Dmv 665 skel /mnt

echo ":: Done!"; echo