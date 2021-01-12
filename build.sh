#!/bin/bash

set -e

source ./build-order.source.sh

for b in "${BUILD_ORDER[@]}"; do
    cd "./$b"
    # rm ./*.tar.zst
    makepkg -fsc
    sudo pacman --noconfirm -U "$b"*.pkg.tar.zst
    cd ".."
done