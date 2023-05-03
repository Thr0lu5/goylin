#!/bin/bash

echo ">: Installing GRUB..."; echo

(
grub-install --target-efi-x86-efi
) | arch-chroot /mnt

echo ":: Done!"; echo