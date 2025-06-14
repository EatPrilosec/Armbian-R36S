#!/bin/bash

prep() {
    export LatestArmbianVer=$(gh release list -R armbian/build |grep -v trunk | head -n1 |cut -f1)
    export LatestArmbianURL=https://github.com/armbian/build/archive/refs/tags/${LatestArmbianVer}.tar.gz
    echo LatestArmbianURL=$LatestArmbianURL
    wget -q -nv "$LatestArmbianURL" -O${LatestArmbianVer}.tar.gz
    tar --strip-components=1 --exclude=.gitignore --exclude=.git --exclude=README.md -xf ${LatestArmbianVer}.tar.gz
    rm -f ${LatestArmbianVer}.tar.gz
    #mkdir release
    [[ "$1" == "prep" ]] && exit 
}

[[ "$1" == "prep" ]] && prep 

[[ ! -f "compile.sh" ]] && prep

./compile.sh r36s-bookworm-xfce