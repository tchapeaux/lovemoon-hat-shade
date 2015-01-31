#!/bin/bash

NAME=HatShade
AUTHOR=BAF_Game
LOVE_VERSION=0.9.1

mkdir -p gen_love

if [ -d "src/lib" ] || [ -d "thirdparty/lib" ]; then
    mkdir -p gen_love/lib
    if [ -d "src/lib" ]; then
        rsync -ru ./src/lib ./gen_love
    fi

    if [ -d "thirdparty/lib" ]; then
        rsync -ru thirdparty/lib ./gen_love
    fi
fi

if [ -d "res" ]; then
    mkdir -p gen_love/res
    rsync -ru ./res ./gen_love
fi

if [ -d "data" ]; then
    mkdir -p gen_love/data
    rsync -ru ./data ./gen_love
fi

cd ./src
moonc -t ../gen_love .

cd ../gen_love
../thirdparty/love-release.sh -l -r build -n $NAME -u $AUTHOR -v0.9.1

love build/$LOVE_VERSION/$NAME.love
