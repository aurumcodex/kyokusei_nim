##[
  極性 -Kyokusei- (Nim)
  =====================
  Date Modified: 2019-10-23

  ## [Main File]
  The main file for executing the commands/functions/calls/etc.
  for the GBA project.

  ## [License]
  MIT Licensed. View LICENSE file for details.
]##

import tonc

import actors
import rendering
import panicoverride

var
  posVec = vec2i(82, 78)
  slimePos = vec2i(120, 80)
  frameCount = 0
  slimeIndex = 37

proc main() =
  irqInit()
  irqEnable(II_VBLANK)

  REG_DISPCNT = DCNT_BG0 or DCNT_OBJ or DCNT_OBJ_1D

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
    ATTR2_ID(6) or ATTR2_PALBANK(3)
  )

  oamMem[2].setAttr(
    ATTR0_Y(posVec.y.uint16 + 10) or ATTR0_4BPP or ATTR0_TALL,
    ATTR1_X(posVec.x.uint16 + 50) or ATTR1_SIZE_16x32,
    ATTR2_ID(76) or ATTR2_PALBANK(1)
  )

  oamMem[3].setAttr(
    ATTR0_Y(slimePos.y.uint16) or ATTR0_4BPP or ATTR0_SQUARE,
    ATTR1_X(slimePos.x.uint16) or ATTR1_SIZE_16x16,
    ATTR2_ID(37) or ATTR2_PALBANK(4)
  )

  tteInitChr4cDefault(0, BG_CBB(0) or BG_SBB(31))
  tteWrite("#{P:92,68}")
  tteWrite("I'M ON A SCREEEEEEEEEEN")
  tteWrite("#{P:92,100}")
  tteWrite("WEeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");

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

    tteWrite("#{P:10,10")
    # tte
    # tteWrite("x =")

    oamMem[0].setPos(posVec)
    # oamMem[3].setAttr(
    #   ATTR0_Y(slimePos.y.uint16) or ATTR0_4BPP or ATTR0_SQUARE,
    #   ATTR1_X(slimePos.x.uint16) or ATTR1_SIZE_16x16,
    #   ATTR2_ID(slimeIndex) or ATTR2_PALBANK(4)
    # )
    # oamMem[3].attr2 = 

    inc(frameCount) # increment frame count

    VBlankIntrWait()

main()