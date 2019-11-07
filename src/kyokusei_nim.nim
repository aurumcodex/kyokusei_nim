##[
  極性 -Kyokusei- (Nim)
  =====================
  Date Modified: 2019-11-5

  ## [Main File]
  The main file for executing the commands/functions/calls/etc.
  for the GBA project.

  ## [License]
  MIT Licensed. View LICENSE file for details.
]##

import system
import strutils

import tonc
import tonc/maxmod

import actors
import rendering      # also imports the sprites, since that's chained in.
import panicoverride
import text
import utility

var
  posVec = vec2i(82, 78)
  slimePos = vec2i(120, 80)
  frameCount: uint = 0
  slimeIndex = 37

var
  rID = riOne

# var
  # positionXInfo = "X = "
  # positionYInof = "Y = "
  # xInfo = $posVec.x
  # yInfo = $posVec.y

# proc copyString() =
#   discard

# importSoundbank()
var soundbankBin* {.importc:"soundbank_bin", header:"soundbank_bin.h".}: pointer
var modSpacecat* {.importc:"MOD_SPACECAT", header:"soundbank.h".}: uint

proc main() =
  irqInit()
  irqEnable(II_VBLANK)

  discard irqAdd(II_VBLANK, maxmod.vblank)

  REG_BG0CNT = BG_CBB(0) or BG_SBB(0) or BG_4BPP or BG_REG_64x32
  REG_DISPCNT = DCNT_BG0 or DCNT_OBJ or DCNT_OBJ_1D

  tteInitCon()

  loadObjSprites()
  loadObjPalettes()

  oamMem[0].setAttr(
    ATTR0_Y(posVec.y.uint16) or ATTR0_4BPP or ATTR0_SQUARE,
    ATTR1_X(posVec.x.uint16) or ATTR1_SIZE_16,
    ATTR2_ID(1) or ATTR2_PALBANK(0)
  )

  oamMem[1].setAttr(
    ATTR0_Y(posVec.y.uint16 - 20) or ATTR0_4BPP or ATTR0_TALL,
    ATTR1_X(posVec.x.uint16 - 40) or ATTR1_SIZE_16x32,
    ATTR2_ID(6) or ATTR2_PALBANK(1)
  )

  oamMem[2].setAttr(
    ATTR0_Y(posVec.y.uint16 + 10) or ATTR0_4BPP or ATTR0_TALL,
    ATTR1_X(posVec.x.uint16 + 50) or ATTR1_SIZE_16x32,
    ATTR2_ID(76) or ATTR2_PALBANK(6)
  )

  oamMem[3].setAttr(
    ATTR0_Y(slimePos.y.uint16) or ATTR0_4BPP or ATTR0_SQUARE,
    ATTR1_X(slimePos.x.uint16) or ATTR1_SIZE_16x16,
    ATTR2_ID(37) or ATTR2_PALBANK(4)
  )

  tteInitChr4cDefault(0, BG_CBB(9) or BG_SBB(28))
  tteWrite("#{P:92,68}")
  tteWrite("I'M ON A SCREEEEEEEEEEN")
  tteWrite("#{P:92,100}")
  tteWrite("WEeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");

  loadBGTiles(rID)
  loadBGPalettes(rID)
  loadBGMap(rID)

  maxmod.init(soundbankBin, 8)
  maxmod.start(modSpacecat, MM_PLAY_LOOP)

  while true:
    keyPoll()

    if keyIsDown(KEY_LEFT): posVec.x -= 1
    if keyIsDown(KEY_RIGHT): posVec.x += 1
    if keyIsDown(KEY_UP): posVec.y -= 1
    if keyIsDown(KEY_DOWN): posVec.y += 1

    if keyIsDown(KEY_A): slimePos.y -= 1
    if keyIsDown(KEY_B): slimePos.y += 1
    if keyIsDown(KEY_L): slimePos.x -= 1
    if keyIsDown(KEY_R): slimePos.x += 1
    if keyIsDown(KEY_ANY): slimeIndex += 4

    if keyIsDown(KEY_SELECT):
      displayText(1)
      # tteEraseScreen()

    if keyIsUp(KEY_SELECT) and frameCount > 600'u:
      # displayText(0)
      tteEraseScreen()

    if frameCount mod 20 == 10:
      case rID:
        of riOne: rID = riTwo
        of riTwo: rID = riThree
        of riThree: rID = riFour
        of riFour: rID = riOne

    # loadBGTiles(rID)
    # loadBGPalettes(riOne)
    # loadGBMap(riOne)

    # tteWrite("#{P:10,10}")
    # tte
    # tteWrite("x =")
    # printf("#{P:90,90}")

    # tteWrite(cstringArrayToSeq(positionXInfo.items))

    # tteWriteEx(90, 90, "X = {posVec.x}, Y = {posVec.y}", CLR_CYAN)

    # displayText(frameCount)

    oamMem[0].setPos(posVec)
    oamMem[3].setPos(slimePos)
    # oamMem[3].setAttr(
    #   ATTR0_Y(slimePos.y.uint16) or ATTR0_4BPP or ATTR0_SQUARE,
    #   ATTR1_X(slimePos.x.uint16) or ATTR1_SIZE_16x16,
    #   ATTR2_ID(slimeIndex) or ATTR2_PALBANK(4)
    # )
    # oamMem[3].attr2 = 

    # if frameCount mod 10 == 0:
    #   tteEraseScreen()

    maxmod.frame()

    inc(frameCount) # increment frame count

    VBlankIntrWait()

main()