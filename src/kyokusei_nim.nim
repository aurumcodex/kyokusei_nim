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

import tonc
import tonc/maxmod

import actors
import geometry
import panicoverride
import rendering      # also imports the sprites, since that's chained in.
import text
import utility

var
  posVec = vec2i(82, 78)
  slimePos = vec2i(120, 80)
  frameCount: uint = 0
  slimeIndex = 37

var
  rID = riOne

# importSoundbank()
var soundbankBin* {.importc:"soundbank_bin", header:"soundbank_bin.h".}: pointer
var modSpacecat* {.importc:"MOD_SPACECAT", header:"soundbank.h".}: uint
var modFlatOutLies* {.importc:"MOD_FLAT_OUT_LIES", header:"soundbank.h".}: uint

var player = (objID: 0,
              spriteIndex: 0,
              HP: 10, 
              AP: 10, 
              pos: vec2i(10, 10), 
              height: 32, 
              width: 16)

# var slime = (objID)

proc main() =
  irqInit()
  irqEnable(II_VBLANK)

  discard irqAdd(II_VBLANK, maxmod.vblank)

  tteInitCon()

  loadObjSprites()
  loadObjPalettes()

  oamMem[0].setAttr(
    ATTR0_Y(player.pos.y.uint16) or ATTR0_4BPP or ATTR0_SQUARE,
    ATTR1_X(player.pos.x.uint16) or ATTR1_SIZE_16,
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

  oamMem[4].setAttr(
    ATTR0_Y(slimePos.y.uint16 + 30) or ATTR0_4BPP or ATTR0_SQUARE,
    ATTR1_X(slimePos.x.uint16 - 20) or ATTR1_SIZE_32x32,
    ATTR2_ID(513) or ATTR2_PALBANK(3)
  )

  tteInitCon()
  tteInitChr4cDefault(0, BG_CBB(4) or BG_SBB(10))
  tteSetMargins(16, 60, 224, 160)
  tteWrite("#{P:92,68}")
  tteWrite("I'M ON A SCREEEEEEEEEEN")
  tteWrite("#{P:92,100}")
  tteWrite("WEeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
  tteWrite("#{P:10,100}test printing mapping thing")

  loadBGTiles(rID)
  loadBGPalettes(rID)
  loadBGMap(rID)

  REG_BG0CNT = BG_CBB(0) or BG_SBB(20) or BG_4BPP or BG_REG_64x32
  REG_BG1CNT = BG_CBB(4) or BG_SBB(10) or BG_4BPP
  REG_DISPCNT = DCNT_MODE0 or DCNT_BG0 or DCNT_BG1 or DCNT_OBJ or DCNT_OBJ_1D
  REG_BG0VOFS = 96

  # initialize the MaxMod playback with default settings and with the soundbank files,
  # then starts playing the .mod file called "spacecat."
  maxmod.init(soundbankBin, 8)
  maxmod.start(modSpacecat, MM_PLAY_LOOP)

  while true:
    # loadBGMap(riOne)
    keyPoll()

    if keyIsDown(KEY_LEFT): player.pos.x -= 1
    if keyIsDown(KEY_RIGHT): player.pos.x += 1
    if keyIsDown(KEY_UP): player.pos.y -= 1
    if keyIsDown(KEY_DOWN): player.pos.y += 1

    if keyIsDown(KEY_A): slimePos.y -= 1
    if keyIsDown(KEY_B): slimePos.y += 1
    if keyIsDown(KEY_L): slimePos.x -= 1
    if keyIsDown(KEY_R): slimePos.x += 1
    if keyIsDown(KEY_ANY): slimeIndex += 4

    if keyIsDown(KEY_SELECT):
      displayText(1)
      # tteEraseScreen()

    if keyIsDown(KEY_SELECT) and keyIsDown(KEY_L) and keyIsDown(KEY_R):
      maxmod.stop()
      maxmod.start(modFlatOutLies, MM_PLAY_LOOP)

    if keyIsUp(KEY_SELECT) and frameCount > 300'u:
      tteEraseScreen()

    oamMem[0].setPos(player.pos)
    oamMem[3].setPos(slimePos)

    maxmod.frame()

    inc(frameCount) # increment frame count

    VBlankIntrWait()

main()