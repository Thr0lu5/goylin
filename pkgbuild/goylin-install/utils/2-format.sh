#!/bin/bash

echo ">: Formating ${device}..."; echo

mkfs.fat -F32 ${boot}
mkswap ${swap}
yes | mkfs.ext4 ${root}
yes | mkfs.ext4 ${home}

echo ":: Done!"; echo