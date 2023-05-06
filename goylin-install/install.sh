#!/bin/bash

echo
echo "# Goylin Install #"
echo

function _menu(){
    read -p "?: Hostname: " hostName; echo
    read -p "?: Password: " passWd; echo
    lsblk; echo
    read -p "?: Target device: " deviceName
    device="/dev/${deviceName}"
    boot="${device}1"
    swap="${device}2"
    root="${device}3"
    home="${device}4"
}

function _bootstrap(){
    #timedatectl set-ntp true
    #pacman -Syy
    #pacman -S --noconfirm --needed - < pkgList/dep
    #reflector --latest 10 --sort rate --save /etc/pacman.d/mirrorlist

    sudo umount -R /mnt
    sudo umount -l ${root}
}

function _partition(){
    (
        echo
        echo "o"; echo "Y"
        echo "n"; echo; echo; echo "+512M"; echo "ef00"; echo "c"; echo "BOOT"
        echo "n"; echo; echo; echo "+8G"; echo "8200"; echo "c"; echo "2"; echo "SWAP"
        echo "n"; echo; echo; echo "+100G"; echo; echo "c"; echo "3"; echo "ROOT"
        echo "n"; echo; echo; echo; echo; echo "c"; echo "4"; echo "HOME"
        echo "w"; echo "Y"
        
    ) | gdisk ${device}
}

function _format(){
    yes | mkfs.fat -F32 ${boot}
    mkswap ${swap}
    yes | mkfs.ext4 ${root}
    yes | mkfs.ext4 ${home}
}

function _mount(){
    #swapon ${swap}
    mount ${root} /mnt
    mkdir -pv /mnt/{boot,home}
    mount ${boot} /mnt/boot
    mount ${home} /mnt/home
}

function _install(){
    
    pacstrap -K /mnt - < pkgList/pacstrap
    genfstab -U /mnt >> /mnt/etc/fstab
    
    install -vDm 644 etc/pacman.conf /mnt/etc
    install -vDm 644 etc/locale.gen /mnt/etc
    install -vDm 644 etc/locale.conf /mnt/etc
    install -vDm 644 etc/vconsole.conf /mnt/etc
    install -vDm 644 etc/hosts /mnt/etc/hosts
    install -vDm 644 etc/default/grub /mnt/etc/default
    install -vDm 440 etc/sudoers /mnt/etc
}

function _chroot(){
    (
        echo reflector --sort rate --latest 10 --save /etc/pacman.d/mirrorlist
        echo pacman-key --init
        echo pacman-key --populate archlinux
        echo pacman -Syy
        
        echo locale-gen
        echo ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
        echo hwclock --systohc --utc
        
        echo ${hostName} > /etc/hostname
        echo sed -i "s/hostName/${hostName}/g" /etc/hosts

        echo passwd; echo ${passWd}; echo ${passWd}
        echo useradd -m -g users -G wheel,storage,power,audio admin
        echo passwd admin; echo ${passWd}; echo ${passWd}

        echo grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=Goylin
        echo grub-mkconfig -o /boot/grub/grub.cfg

        echo systemctl enable fstrim.timer

        echo mkinitcpio -P

    ) | arch-chroot /mnt
}

_menu
_bootstrap
_partition
_format
_mount
_install
_chroot
