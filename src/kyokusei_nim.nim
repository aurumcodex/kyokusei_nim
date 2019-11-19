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

#[Nimble Imports]#
import tonc
import tonc/maxmod

#[Local Imports]#
import actors
import ffi_c
import geometry
import panicoverride
import rendering      # also imports the sprites, since that's chained in.
import text
import utility

#[Inline Assembly]#
# Some inline assembly, mainly for emulators or flashcarts, since those search
# through the ROM data for a "magic string" that determines what save type it uses.
asm """
.balign 4
.string \"SRAM_Vnnn\"
"""

#[Variables]#

# var frameCount: uint = 0
# var obj_buffer*: ObjAttrPtr = array[128, ObjAttr]
var rID = riOne
# var bg0Vec = Offsets(xOffset: 180, yOffset: 0)
var bg1Vec = Offsets(xOffset: 0, yOffset: 0)

var room = Room(roomID: riOne, submap: sectionOne)

var
  posVec = vec2i(82, 78)
  slimePos = vec2i(120, 80)
  slimeIndex = 37
  
# importSoundbank()
var soundbankBin* {.importc:"soundbank_bin", header:"soundbank_bin.h".}: pointer
var modSpacecat* {.importc:"MOD_SPACECAT", header:"soundbank.h".}: uint
var modFlatOutLies* {.importc:"MOD_FLAT_OUT_LIES", header:"soundbank.h".}: uint
  
var player = Player(objID: 0,
                    spriteIndex: 513'u16,
                    HP: 10, 
                    AP: 10, 
                    pos: vec2i(15, 128), 
                    height: 16, # 32 when playing as Echo, 16 as Era 
                    width: 16)
  
var slime = Enemy(objID: 3,
                  spriteIndex: 549'u16,
                  animState: asIdle,
                  HP: 10, 
                  AP: 10, 
                  pos: vec2i(50, 50), 
                  height: 16, 
                  width: 16)
  
var gameInfo = Game(frameCount: 0,
                    player: player,
                    bgOffsets: bg1Vec,
                    state: gsTitle)

# var slime = (objID)

#[Main Game Loop]#
proc main() =
  ## Main game logic; a sort of "glue" that binds all of the features together.

  # Setting of the wait-states of the GBA's cpu
  REG_WAITCNT = WS_STANDARD

  if not validateSave():
    # tteInitChr4cDefault(0, BG_CBB(4) or BG_SBB(10))
    # tteSetMargins(16, 60, 224, 160)
    # tteWrite("{P:120,0}save not found.")
    initializeSave(player)
  else:
    loadSave(player)

  irqInit()
  irqEnable(II_VBLANK)

  discard irqAdd(II_VBLANK, maxmod.vblank)

  oamInit(addr oamMem[0], OAM_SIZE div sizeof_ObjAttr)

  loadObjSprites()
  loadObjPalettes()

  oamMem[0].setAttr(
    ATTR0_Y(player.pos.y.uint16) or ATTR0_4BPP or ATTR0_SQUARE,
    ATTR1_X(player.pos.x.uint16) or ATTR1_SIZE_16,
    ATTR2_ID(player.spriteIndex) or ATTR2_PALBANK(0)
  )

  oamMem[1].setAttr(
    ATTR0_Y(posVec.y.uint16 - 20) or ATTR0_4BPP or ATTR0_TALL,
    ATTR1_X(posVec.x.uint16 - 40) or ATTR1_SIZE_16x32,
    ATTR2_ID(518) or ATTR2_PALBANK(1)
  )

  oamMem[2].setAttr(
    ATTR0_Y(posVec.y.uint16 + 10) or ATTR0_4BPP or ATTR0_TALL,
    ATTR1_X(posVec.x.uint16 + 50) or ATTR1_SIZE_16x32,
    ATTR2_ID(76) or ATTR2_PALBANK(6)
  )

  #[slime stuff]#
  oamMem[3].setAttr(
    ATTR0_Y(slime.pos.y.uint16) or ATTR0_4BPP or ATTR0_SQUARE,
    ATTR1_X(slime.pos.x.uint16) or ATTR1_SIZE_16x16,
    ATTR2_ID(slime.spriteIndex) or ATTR2_PALBANK(4)
  )

  oamMem[4].setAttr(
    ATTR0_Y(slimePos.y.uint16 + 30) or ATTR0_4BPP or ATTR0_SQUARE,
    ATTR1_X(slimePos.x.uint16 - 20) or ATTR1_SIZE_32x32,
    ATTR2_ID(613) or ATTR2_PALBANK(3)
  )

  tteInitCon()
  tteInitChr4cDefault(0, BG_CBB(4) or BG_SBB(10))
  # tteSetDrawg(chr4cDrawgB4CTS)
  tteSetMargins(8, 0, 224, 160)
  tteWrite("#{P:92,68}")
  tteWrite("I'M ON A SCREEEEEEEEEEN")
  tteWrite("#{P:92,100}")
  tteWrite("WEeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
  tteWrite("#{P:10,100}test printing mapping thing")

  loadBGTiles(rID)
  loadBGPalettes(rID)
  loadBGMap(rID)

  REG_BG0CNT = BG_CBB(4) or BG_SBB(10) or BG_4BPP
  REG_BG1CNT = BG_CBB(14) or BG_SBB(20) or BG_4BPP or BG_REG_64x64
  REG_DISPCNT = DCNT_MODE0 or DCNT_BG0 or DCNT_BG1 or DCNT_OBJ or DCNT_OBJ_1D

  # REG_BG0VOFS = cast[uint16](bg0Vec.yOffset)
  # REG_BG0HOFS = cast[uint16](bg0Vec.xOffset)
  REG_BG1VOFS = cast[uint16](bg1Vec.yOffset)
  REG_BG1HOFS = cast[uint16](bg1Vec.xOffset)

  # initialize the MaxMod playback with default settings and with the soundbank files,
  # then starts playing the .mod file called "spacecat."
  maxmod.init(soundbankBin, 8)
  maxmod.start(modSpacecat, MM_PLAY_LOOP)

  while true:
    # loadBGMap(riOne)
    if gameInfo.frameCount mod 30 == 0:
      printScore(gameInfo.frameCount)

    keyPoll()

    if keyIsDown(KEY_LEFT): player.pos.x -= 1
      # if player.pos.x != 0:
      #   player.pos.x -= 1
      # else:
      #   player.pos.x -= 0

    if keyIsDown(KEY_RIGHT): player.pos.x += 1

    if keyIsDown(KEY_UP): player.pos.y -= 1
      # if player.pos.y != 0:
      #   player.pos.y -= 1
      # else:
      #   player.pos.y -= 0

    if keyIsDown(KEY_DOWN): player.pos.y += 1
      # if player.pos.y != 144:
      #   player.pos.y += 1
      # else:
      #   player.pos.y += 0

    if keyIsDown(KEY_A): slime.pos.y -= 1
    if keyIsDown(KEY_B): slime.pos.y += 1
    if keyIsDown(KEY_L): slime.pos.x -= 1
    if keyIsDown(KEY_R): slime.pos.x += 1
    if keyIsDown(KEY_ANY):
      if gameInfo.frameCount mod 10 == 0:
        slime.animState = asMove
        slime.spriteIndex += 4
        # animateSlime(slime)
        # inc(slime.spriteIndex)
        oamMem[3].setAttr(
          ATTR0_Y(slime.pos.y.uint16) or ATTR0_4BPP or ATTR0_SQUARE,
          ATTR1_X(slime.pos.x.uint16) or ATTR1_SIZE_16x16,
          ATTR2_ID(slime.spriteIndex) or ATTR2_PALBANK(4)
        )
        if slime.spriteIndex == 561:
          slime.spriteIndex = 549

    if keyIsDown(KEY_SELECT):
      displayText(1)
      # tteEraseScreen()

    if keyIsDown(KEY_SELECT) and keyIsDown(KEY_L) and keyIsDown(KEY_R):
      maxmod.stop()
      maxmod.start(modFlatOutLies, MM_PLAY_LOOP)

    if keyIsUp(KEY_SELECT) and not keyIsUp(KEY_R) and gameInfo.frameCount > 300'u:
      tteEraseScreen()

    if keyIsDown(KEY_START) and (keyIsDown(KEY_L) or keyIsDown(KEY_R)):
      writeSave(player)

    oamMem[player.objID].setPos(player.pos)
    oamMem[slime.objID].setPos(slime.pos)

    maxmod.frame()

    if player.hasCollided(slime, gameInfo.frameCount):
      displayText(42)

    # backgroundCollision(player, gameInfo.frameCount)

    moveScreen(player, bg1Vec, room)

    inc(gameInfo.frameCount) # increment frame count

    VBlankIntrWait()

main()