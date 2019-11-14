##[
  極性 -Kyokusei- (Nim)
  =====================
  Date Modified: 2019-11-14

  ## [Utility File]
  A file used for various utility functions (i.e. Saving to SRAM).

  ## [License]
  MIT Licensed. View LICENSE file for details.
]##

import tonc

import actors
import geometry

proc tteInitCon*() {.importc: "tte_init_con", header: "tonc.h".}

type
  Game = object
    frameCount: uint
    player: Player
    bgOffsets: Offsets

# If this isn't "found," then eihter it's a new game, or the save is corrupted.
const sramHeader: cstring = "kyokusei_nim" ## Validation: header string for confirming data in SRAM.

proc validateSave*(): bool {.codegenDecl:EWRAM_CODE.} =
  ## Cycle through the header and the SRAM memory to make sure it is a valid save.
  for index, ch in sramHeader:
    if sramMem[index].char != ch:
      return false
  return true # return true if nothing erroneous comes up.

proc initializeSave*(p: var Player)=
  ## Function to initialize the save file(s) for saving purposes.
  for index, ch in sramHeader:
    sramMem[index] = ch.uint8

  # SRAM memory location at hex location 0x10 (16) {used for player X position}.
  sramMem[0x10] = 15
  # SRAM memory location at hex location 0x11 (17) {used for player Y position}.
  sramMem[0x11] = 128

proc loadSave*(p: var Player) {.codegenDecl:EWRAM_CODE.} =
  ## Function to load in the data from a save file.
  p.pos.x = sramMem[0x10].int
  p.pos.y = sramMem[0x11].int

proc writeSave*(p: var PLayer) =
  ## Function to write game data into SRAM.
  sramMem[0x10] = p.pos.x.uint8
  sramMem[0x11] = p.pos.y.uint8