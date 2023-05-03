#!/bin/bash

echo ">: Partitioning ${device}..."; echo

(
    echo
    echo "o"; echo "Y"
    echo "n"; echo; echo; echo "+512M"; echo "ef00"; echo "c"; echo "BOOT"
    echo "n"; echo; echo; echo "+8G"; echo "8200"; echo "c"; echo "2"; echo "SWAP"
    echo "n"; echo; echo; echo "+100G"; echo; echo "c"; echo "3"; echo "ROOT"
    echo "n"; echo; echo; echo; echo; echo "c"; echo "4"; echo "HOME"
    echo "w"; echo "Y"
) | gdisk ${device}

echo; lsblk | grep ${deviceName}; echo

echo ":: Done!"; echo