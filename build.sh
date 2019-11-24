#!/usr/bin/env bash

# this file doesn't particularly need to exist, but, it's still good to have
# and to keep compilation "simplfied" as much as I can make it.

readonly RESET="\033[0m"
readonly BLD_ULINE="\033[1;4m"
readonly BOLD="\033[1m"
readonly BLD_YLW="\033[1;33m"
readonly BLD_BLUE="\033[1;34m"
readonly BLD_PURP="\033[1;35m"
readonly CLR_RED="\033[31m"
readonly CLR_B_RED="\033[1;31m"
readonly CLR_YLW="\033[33m"
readonly CLR_CYAN="\033[36m"

readonly SRC_DIR=src
readonly GFX_DIR=src/gfx

readonly GRIT_OPT=options.grit
readonly GRIT_BG_OPT=backgrounds.grit

readonly BG_PTTR="^bg_"
readonly OBJ_MAP_PTTR=".map.bin$"

# clean build setting first for a fresh clean slate
make clean

# Generate random seeds for use in ROM.
printf "\n${BLD_YLW}::${RESET} ${BOLD}Creating RNG Seed file...${RESET}\n"
xxd -c8 -l4 -i /dev/urandom > src/rng_seeds.c
c2nim src/rng_seeds.c
# readonly HEXDUMP=$(xxd -c8 -n16 -i /dev/urandom)


printf "\n${BLD_BLUE}::${RESET} "
printf "${BOLD}Making GBA ROM...${RESET}\n\n"

# image creation build sequence
printf "${BLD_YLW}::${RESET} "
printf "${BLD_ULINE}Compiling Sprite Data...${RESET}\n"
cd ${GFX_DIR}
for image in png/*; do
    if [[ ! $(basename ${image}) =~ ${BG_PTTR} ]]; then
        printf "${CLR_YLW}compiling sprite${RESET}: ${image}\n"
        grit ${image} -ff ${GRIT_OPT}
    else
        printf "${CLR_YLW}compiling background${RESET}: ${image}\n"
        grit ${image} -ff ${GRIT_BG_OPT}
    fi
done

for image in ./*; do
    if [[ $(basename ${image}) =~ ${OBJ_MAP_PTTR} && \
    ! $(basename ${image}) =~ ${BG_PTTR} ]]; then
        printf "${CLR_YLW}Removing unnecessary map${RESET}: $(basename ${image})\n"
        rm ${image}
    fi
done
cd ../..

# main build sequence
printf "\n${BLD_PURP}::${RESET} "
printf "${BLD_ULINE}Compiling Nim source...${RESET}\n"
nim c src/kyokusei_nim.nim
if [[ $? > 0 ]]; then
    printf "${CLR_B_RED}::${RESET} ${CLR_RED}Nim compilation failed.${RESET} Aborting.\n"
    exit 1
fi

make
if [[ $? > 0 ]]; then
    printf "${CLR_B_RED}::${RESET} ${CLR_RED}GBA compilation failed.${RESET} Aborting.\n"
    exit 1
fi

# result printing
printf "${CLR_CYAN}>>${RESET} ${BOLD}build script compilation done.${RESET}\n"
printf "${CLR_CYAN}>>${RESET} ${BOLD}time taken${RESET}: ${SECONDS} second(s).\n"