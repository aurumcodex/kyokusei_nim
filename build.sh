#!/usr/bin/env bash

# this file doesn't particularly need to exist, but, it's still good to have
# and to keep compilation "simplfied" as much as I can make it.

readonly SRC_DIR=src
readonly GFX_DIR=src/gfx

readonly GRIT_OPT=options.grit

# image creation build sequence
cd ${GFX_DIR}
for image in png/*; do
    printf "${image}\n"
    grit ${image} -ff ${GRIT_OPT}
done
cd ../..

# main build sequence
make clean

nim c src/kyokusei_nim.nim
if [[ $? > 0 ]]; then
    printf "Nim compilation did not succeed. Exitng with code: $?\n"
    exit $?
fi

make

printf "build script complete done.\n"
printf "time taken: ${SECONDS} seconds.\n"