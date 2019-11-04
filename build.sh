#!/usr/bin/env bash

# this file doesn't particularly need to exist, but, it's still good to have
# and to keep compilation "simplfied" as much as I can make it.

readonly SRC_DIR=src
readonly GFX_DIR=src/gfx

readonly GRIT_OPT=options.grit
readonly GRIT_BG_OPT=backgrounds.grit

readonly BG_PTTR="^bg_"

# image creation build sequence
cd ${GFX_DIR}
for image in png/*; do
    if [[ ! $(basename ${image}) =~ ${BG_PTTR} ]]; then
        printf "compiling sprite: ${image}\n"
        grit ${image} -ff ${GRIT_OPT}
    else
        printf "compiling background: ${image}\n"
        grit ${image} -ff ${GRIT_BG_OPT}
    fi
done
cd ../..

# main build sequence
make clean

nim c src/kyokusei_nim.nim
if [[ $? > 0 ]]; then
    printf "Nim compilation did not succeed. Aborting.\n"
    exit 1
fi

make

# result printing
printf "build script compilation done.\n"
printf "time taken: ${SECONDS} seconds.\n"