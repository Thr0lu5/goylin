#!/bin/bash

pkgname="goylin-config"

#tar -czvf ${pkgname}.tar.gz ${pkgname}
makepkg -sf
#rm ${pkgname}.tar.gz