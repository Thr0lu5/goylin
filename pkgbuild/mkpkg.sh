#!/bin/bash

if ! pacman -Q devtools 1> /dev/null; then
    pacman --noconfirm -S devtools
fi

CHROOT=$HOME/.chroot

if [ ! -d ~/.chroot ]; then
    mkdir -pv ~/.chroot
    mkarchroot $CHROOT/root base-devel
fi

cd $1

if [ -f build.sh ]; then
    . build.sh
fi

arch-nspawn $CHROOT/root pacman -Syu

makechrootpkg -c -r $CHROOT

repo-add ../../repo/goylin-repo.db.tar.gz *.pkg.*
rm -rf $1*

