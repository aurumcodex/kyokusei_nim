##[
  極性 -Kyokusei- (Nim)
  =====================
  Date Modified: 2019-11-19

  ## [Main File]
  The main file for executing the commands/functions/calls/etc.
  for the GBA project.

  ## [License]
  MIT Licensed. View LICENSE file for details.
]##

#[System Imports]#
# import random

#[Nimble Imports]#
import tonc
import tonc/maxmod

#[Local Imports]#
import actors
import collision
import ffi_c          # will probably be removed
import geometry
import input
import panicoverride
import rendering      # also imports the sprites, since that's chained in.
import text
import utility

import logic/rngs

#[Inline Assembly]#
# Some inline assembly, mainly for emulators or flashcarts, since those search
# through the ROM data for a "magic string" that determines what save type it uses.
asm """
.balign 4
.string \"SRAM_Vnnn\"
"""

#[Variables]#
var roomID = riOne
var bg1Vec = Offsets(xOffset: 0, yOffset: 0)
var room = Room(roomID: riOne, submap: sectionOne)

var delay: uint = 0   ## used for key input delay.

var posVec = vec2i(0, 152)
  
# importSoundbank()
var soundbankBin* {.importc:"soundbank_bin", header:"soundbank_bin.h".}: pointer
var modSpacecat* {.importc:"MOD_SPACECAT", header:"soundbank.h".}: uint
var modFlatOutLies* {.importc:"MOD_FLAT_OUT_LIES", header:"soundbank.h".}: uint
var sfxShoot* {.importc:"SFX_SHOOT", header:"soundbank.h".}: uint

var slime = Enemy(
  objID: 3,
  spriteIndex: 549'u16,
  animState: asIdle,
  HP: 10,
  damage: 2,
  pos: vec2i(50, 12),
  height: 16,
  width: 16,
  scoreValue: 10,
  aiType: EnemyAI.Slime
)

# This is *not* an import; it just includes all of the data from a file and places it here.
include logic/player_data

var health = Item(
  actorType: ActorType.Item,
  objID: 4,
  spriteIndex: 640'u16,
  pos: posVec,
  height: 8,
  width: 8,
  visible: true,
  isEcho: false,
  isBullet: false
)

var gameInfo = Game(
  frameCount: 0,
  player: player,
  bgOffsets: bg1Vec,
  state: gsTitle,
  hiScore: 100,
  score: 0
)

var rngState: XorWowState

proc initialize*() =
  ## Helper function to lessen some of the boilerplate that would otherwise appear in main().
  REG_WAITCNT = WS_STANDARD   # Set wait-state of the GBA CPU.

  # Set BG 0 to use the data at charblock 4 and screenblock 10, at a 4 bit depth
  REG_BG0CNT = BG_CBB(4) or BG_SBB(10) or BG_4BPP
  # Set BG 1 to use the data at charblock 14 and screenblock 20, at a 4 bit depth with the map set to a 64x64 tile map.
  REG_BG1CNT = BG_CBB(14) or BG_SBB(20) or BG_4BPP or BG_REG_64x64
  # Set BG 2 to use the data at charblock x and screenblock y, at a 4 bit depth (used for the title screen)
  # REG_BG2CNT = BG_CBB() or BG_SBB() or BG_4BPP   # to be added
  # Set up the Display Controller with all the needed values so that everything can be rendered, and used.
  REG_DISPCNT = DCNT_MODE0 or DCNT_BG0 or DCNT_BG1 or DCNT_OBJ or DCNT_OBJ_1D

  # Set the background offsets for background 1
  REG_BG1VOFS = cast[uint16](bg1Vec.yOffset)
  REG_BG1HOFS = cast[uint16](bg1Vec.xOffset)

  # Check if a save exists, or if it's somehow corrupted, and creates a new save, otherwise
  # loads the available saved data.
  if not validateSave(): 
    initializeSave(player)
  else:
    loadSave(player)

  # Initialize the interupts with vsync capabilities, and adds the maxmod worker to it.
  irqInit()
  irqEnable(II_VBLANK)
  discard irqAdd(II_VBLANK, maxmod.vblank)

  # Initialize OAM (onject attribute memory)
  oamInit(addr oamMem[0], OAM_SIZE div sizeof_ObjAttr)

  # Load Object Sprite tiles and palettes
  loadObjSprites()
  loadObjPalettes()

  # Load Background Tiles, Palettes, and Map data
  loadBGTiles(roomID)
  loadBGPalettes(roomID)
  loadBGMap(roomID)

  # Initialize the Tonc Text Engine (Nim wrapped)
  tteInitCon()
  tteInitChr4c(0, BG_CBB(4) or BG_SBB(10), 0xF000, 0x0201,
               CLR_PURPLE shl 16 or CLR_CYAN, addr(verdana9Font), nil)
  tteSetMargins(0, 0, 240, 100)


#[Main Game Loop]#
proc main() =
  ## Main game logic; a sort of "glue" that binds all of the features together.

  initialize()    # Initialize all data points.
  # initializeOAM() # Initialize OAM data.

  

  # oamMem[1].setAttr(
  #   ATTR0_Y(120) or ATTR0_4BPP or ATTR0_TALL,
  #   ATTR1_X(140) or ATTR1_SIZE_16x32,
  #   ATTR2_ID(518) or ATTR2_PALBANK(1)
  # )

  oamMem[32].setAttr(
    ATTR0_Y(posVec.y.uint16) or ATTR0_4BPP or ATTR0_SQUARE,
    ATTR1_X(posVec.x.uint16) or ATTR1_SIZE_8x8,
    ATTR2_ID(255) or ATTR2_PALBANK(12)
  )

  # Initialize the MaxMod playback with default settings and with the soundbank files,
  # then starts playing the .mod file called "spacecat."
  maxmod.init(soundbankBin, 8)
  maxmod.start(modSpacecat, MM_PLAY_LOOP)

  while true:

    player.ammoList[1].pos = vec2i(player.pos.x+(player.width div 2), player.pos.y+(player.height div 2))

    player.ammoList[1].renderProjectile
    player.renderPlayer
    health.renderItem
    # loadBGMap(riOne)
    rngState = XorWowState(
      a: gameInfo.frameCount,
      b: gameInfo.frameCount mod 42,
      c: gameInfo.frameCount shr 3,
      d: gameInfo.frameCount - 3000,
      counter: 0
    )

    if gameInfo.frameCount mod 10 == 0:
      # printScore(gameInfo.frameCount)
      # printScore(delay)
      # printScore(player)
      # printScore(xorShiftRNG(gameInfo.frameCount))
      # printScore(xorwowRNG(rngState))
      printPlayerPos(player.pos.x, player.pos.y)

    keyPoll()

    # rand(frameCount)
    # randomize(gameInfo.frameCount.int64)
    
    keyRepeatLimits(0, 0)
    player.getInput(room, delay)

    # if keyIsDown(KEY_ANY):
    #   if gameInfo.frameCount mod 10 == 0:
    #     slime.animState = asMove
    #     slime.spriteIndex += 4
    #     oamMem[3].setAttr(
    #       ATTR0_Y(slime.pos.y.uint16) or ATTR0_4BPP or ATTR0_SQUARE,
    #       ATTR1_X(slime.pos.x.uint16) or ATTR1_SIZE_16x16,
    #       ATTR2_ID(slime.spriteIndex) or ATTR2_PALBANK(4)
    #     )
    #     if slime.spriteIndex == 561:
    #       slime.spriteIndex = 549

    # if keyIsDown(KEY_SELECT) and keyIsDown(KEY_L) and keyIsDown(KEY_R):
    #   maxmod.stop()
    #   maxmod.start(modFlatOutLies, MM_PLAY_LOOP)

    if player.backgroundCollision(room) == false:
      player.autoMove(room)
      player.verticalMove = true
    if player.backgroundCollision(room) == true:
      player.verticalMove = false

    if keyIsUp(KEY_SELECT) and not keyIsUp(KEY_R) and gameInfo.frameCount > 300'u:
      tteEraseScreen()

    if keyIsDown(KEY_START) and (keyIsDown(KEY_L) or keyIsDown(KEY_R)):
      writeSave(player)

    oamMem[player.objID].setPos(player.pos)
    # oamMem[slime.objID].setPos(slime.pos)
    oamMem[32].setPos(posVec)  # debug sprite

    maxmod.frame()  # Increment frame for MaxMod playback to work properly.

    moveScreen(player, bg1Vec, room)

    inc(gameInfo.frameCount) # increment frame count
    inc(delay)

    if delay == 20:  # if delay hits 5 seconds
      delay = 0

    VBlankIntrWait()

main()