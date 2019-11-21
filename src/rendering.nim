##[
  極性 -Kyokusei- (Nim)
  =====================
  Date Modified: 2019-10-24

  ## [Rendering File]
  A file used for incorporating the sprite data and background data
  into user-made memory loading functions

  ## [License]
  MIT Licensed. View LICENSE file for details.
]##

import tonc

import actors
import geometry
import sprites
import ffi_c

# include rendering/collision

# type
#   Viewport* {.bycopy.} = object
#     x*: cint
#     xMin*: cint
#     xMax*: cint
#     xPage*: cint
#     y*: cint
#     yMin*: cint
#     yMax*: cint
#     yPage*: cint

# var obj_buffer*: ptr ObjAttr = array[128, ObjAttr]
var obj_buffer*: ptr ObjAttr

type
  RoomId* = enum
    ## An enum type for determing which backgrounds to load in the dedicated
    ## rendering functions for the backgrounds.
    riOne
    riTwo
    riThree
    riFour

type
  Room* = object
    roomID*: RoomID
    submap*: Submap

# proc setViewportPos(vp: var Viewport, x, y: int) =
#   ## Procedure to set the viewport's location.
#   vp.x = clamp(x, vp.xMin, vp.xMax - vp.xPage)
#   vp.y = clamp(y, vp.yMin, vp.yMax - vp.yPage)

# proc centerViewport(vp: var Viewport, x, y: int) =
#   ## Procedure to center the viewport.
#   vp.setViewportPos(x - vp.xPage div 2, y - vp.yPage div 2)

#[Sprite, Palette, and Map Data Loading]#

proc loadObjSprites*() =
  ## Function to load sprite data into respective sprite location banks.
  memcpy32(addr tileMemObj[1][0], BotTiles, BotTiles.len)
  memcpy32(addr tileMemObj[1][5], EchoTiles, EchoTiles.len div 4)
  memcpy32(addr tileMemObj[1][14], EnemyChronchaTiles, EnemyChronchaTiles.len div 4)
  memcpy32(addr tileMemObj[1][36], EnemySlimeTiles, EnemySlimeTiles.len div 4)
  memcpy32(addr tileMemObj[1][77], EnemyTrentTiles, EnemyTrentTiles.len div 4)
  memcpy32(addr tileMemObj[1][100], PumpkinTiles, PumpkinTiles.len div 4)
  memcpy32(addr tileMemObj[1][117], UIHeartTiles, UIHeartTiles.len div 4)
  memcpy32(addr tileMemObj[1][118], ObjBladeSlashTiles, ObjBladeSlashTiles.len div 4)
  memcpy32(addr tileMemObj[1][125], ObjBulletTiles, ObjBulletTiles.len div 4)
  memcpy32(addr tileMemObj[1][127], ObjHealthTiles, ObjHealthTiles.len div 4)


proc loadObjPalettes*() =
  ## Function to load palette data into respective palette banks.
  memcpy16(addr palObjBank[0], BotPalette, BotPalette.len div 2)
  memcpy16(addr palObjBank[1], EchoPalette, EchoPalette.len div 2)
  memcpy16(addr palObjBank[2], EnemyChronchaPalette, EnemyChronchaPalette.len div 2)
  memcpy16(addr palObjBank[3], PumpkinPalette, PumpkinPalette.len div 2)
  memcpy16(addr palObjBank[4], EnemySlimePalette, EnemySlimePalette.len div 2)
  memcpy16(addr palObjBank[6], EnemyTrentPalette, EnemyTrentPalette.len div 2)
  memcpy16(addr palObjBank[7], UIHeartPalette, UIHeartPalette.len div 2)
  memcpy16(addr palObjBank[8], ObjBladeSlashPalette, ObjBladeSlashPalette.len div 2)
  memcpy16(addr palObjBank[9], ObjBulletPalette, ObjBulletPalette.len div 2)
  memcpy16(addr palObjBank[10], ObjHealthPalette, ObjHealthPalette.len div 2)

proc loadBGTiles*(rid: RoomId) =
  ## Function to load tile data for the backgrounds depending on the room ID passed to it.
  case rid:
    of riOne:
      memcpy32(addr tileMem[2][0], Room1Tiles, Room1Tiles.len div 4)
    of riTwo:
      memcpy32(addr tileMem[2][0], Room2Tiles, Room2Tiles.len div 4)
    of riThree:
      memcpy32(addr tileMem[2][0], Room3Tiles, Room3Tiles.len div 4)
    of riFour:
      memcpy32(addr tileMem[2][0], Room4Tiles, Room4Tiles.len div 4)

proc loadBGPalettes*(rid: RoomId) =
  ## Function to load in the palettes for the backgrounds conditionally, based on .
  case rid:
    of riOne:
      memcpy16(addr palBgBank[0][0], Room1Palette, Room1Palette.len div 12)
    of riTwo:
      memcpy16(addr palBgBank[0][0], Room2Palette, Room2Palette.len div 12)
    of riThree:
      memcpy16(addr palBgBank[0][0], Room3Palette, Room3Palette.len div 12)
    of riFour:
      memcpy16(addr palBgBank[0][0], Room4Palette, Room4Palette.len div 12)

proc loadBGMap*(rid: RoomID) =
  ## Function to load in the mapping data for the backgrounds.
  ## NOTE: There's a significantly better and more efficient way of doing this,
  ## but I couldn't get it to work withou ruining the text.
  case rid:
    of riOne:
      memcpy32(addr seMem[20][0], Room1Map, Room1Map.len)
    of riTwo:
      memcpy32(addr seMem[20][0], Room2Map, Room2Map.len)
    of riThree:
      memcpy32(addr seMem[20][0], Room3Map, Room3Map.len)
    of riFour:
      memcpy32(addr seMem[20][0], Room4Map, Room4Map.len)

#[Screen Movement]#

proc shiftScreenUp*(player: var Player, bgVec: var Offsets, room: var Room) =
  ## Helper function to shift the screen upwards.
  var section: uint = 0
  case room.submap:
  of sectionOne:
    bgVec.yOffset -= SCREEN_HEIGHT + 32      # plus 32 due to wrap around, and how the screens move.
    REG_BG1VOFS = cast[uint16](bgVec.yOffset)
    player.pos.y = SCREEN_HEIGHT - player.height
    room.submap = sectionFive
    # section = 1
    # printSection(section)
    # discard
  of sectionTwo:
    bgVec.yOffset -= SCREEN_HEIGHT + 32      # plus 32 due to wrap around, and how the screens move.
    REG_BG1VOFS = cast[uint16](bgVec.yOffset)
    player.pos.y = SCREEN_HEIGHT - player.height
    room.submap = sectionSix
    # section = 2
    # printSection(section)
  of sectionThree:
    bgVec.yOffset -= SCREEN_HEIGHT
    REG_BG1VOFS = cast[uint16](bgVec.yOffset)
    player.pos.y = SCREEN_HEIGHT - player.height
    room.submap = sectionOne
    # section = 3
    # printSection(section)
  of sectionFour:
    bgVec.yOffset -= SCREEN_HEIGHT
    REG_BG1VOFS = cast[uint16](bgVec.yOffset)
    player.pos.y = SCREEN_HEIGHT - player.height
    room.submap = sectionTwo
    # section = 4
    # printSection(section)
  of sectionFive:
    bgVec.yOffset -= SCREEN_HEIGHT
    REG_BG1VOFS = cast[uint16](bgVec.yOffset)
    player.pos.y = SCREEN_HEIGHT - player.height
    room.submap = sectionThree
    # section = 5
    # printSection(section)
  of sectionSix:
    bgVec.yOffset -= SCREEN_HEIGHT
    REG_BG1VOFS = cast[uint16](bgVec.yOffset)
    player.pos.y = SCREEN_HEIGHT - player.height
    room.submap = sectionFour
    # section = 6
    # printSection(section)

proc shiftScreenRight*(player: var Player, bgVec: var Offsets, room: var Room) =
  ## Helper function to shift the screen rightwards.
  bgVec.xOffset += SCREEN_WIDTH
  REG_BG1HOFS = cast[uint16](bgVec.xOffset)
  player.pos.x = 0
  case room.submap:
  of sectionOne:
    room.submap = sectionTwo
  of sectionThree:
    room.submap = sectionFour
  of sectionFive:
    room.submap = sectionSix
  else:
    discard

proc shiftScreenLeft*(player: var Player, bgVec: var Offsets, room: var Room) =
  ## Helper function to shift the screen leftwards.
  bgVec.xOffset -= SCREEN_WIDTH
  REG_BG1HOFS = cast[uint16](bgVec.xOffset)
  player.pos.x = (SCREEN_WIDTH - player.width) - 1
  case room.submap:
  of sectionTwo:
    room.submap = sectionOne
  of sectionFour:
    room.submap = sectionThree
  of sectionSix:
    room.submap = sectionFive
  else:
    discard

proc shiftScreenDown*(player: var Player, bgVec: var Offsets, room: var Room) =
  ## Helper function to shift the screen downwards.
  case room.submap:
  of sectionOne:
    bgVec.yOffset += SCREEN_HEIGHT
    REG_BG1VOFS = cast[uint16](bgVec.yOffset)
    # player.pos.y = (SCREEN_HEIGHT - player.height) - 1
    player.pos.y = 1
    room.submap = sectionThree
  of sectionTwo:
    bgVec.yOffset += SCREEN_HEIGHT
    REG_BG1VOFS = cast[uint16](bgVec.yOffset)
    # player.pos.y = (SCREEN_HEIGHT - player.height) - 1
    player.pos.y = 1
    room.submap = sectionFour
  of sectionThree:
    bgVec.yOffset += SCREEN_HEIGHT
    REG_BG1VOFS = cast[uint16](bgVec.yOffset)
    # player.pos.y = (SCREEN_HEIGHT - player.height) - 1
    player.pos.y = 1
    room.submap = sectionFive
  of sectionFour:
    bgVec.yOffset += SCREEN_HEIGHT
    REG_BG1VOFS = cast[uint16](bgVec.yOffset)
    # player.pos.y = (SCREEN_HEIGHT - player.height) - 1
    player.pos.y = 1
    room.submap = sectionSix
  of sectionFive:
    # bgVec.yOffset += SCREEN_HEIGHT
    bgVec.yOffset += SCREEN_HEIGHT + 32      # plus 32 due to wrap around, and how the screens move.
    REG_BG1VOFS = cast[uint16](bgVec.yOffset)
    # player.pos.y = (SCREEN_HEIGHT - player.height) - 1
    player.pos.y = 1
    room.submap = sectionOne
  of sectionSix:
    # bgVec.yOffset += SCREEN_HEIGHT
    bgVec.yOffset += SCREEN_HEIGHT + 32      # plus 32 due to wrap around, and how the screens move.
    REG_BG1VOFS = cast[uint16](bgVec.yOffset)
    # player.pos.y = (SCREEN_HEIGHT - player.height) - 1
    player.pos.y = 1
    room.submap = sectionTwo

proc moveScreen*(player: var Player, bgVec: var Offsets, room: var Room) =
  ## Function to move the displayed section(s) of the mapping data of the backgrounds
  case room.submap:
  of sectionOne:
    if player.pos.x+player.width == SCREEN_WIDTH:
      shiftScreenRight(player, bgVec, room)
    if player.pos.y == 0:
      shiftScreenUp(player, bgVec, room)
    elif player.pos.y + player.height == SCREEN_HEIGHT:
      shiftScreenDown(player, bgVec, room)

  of sectionTwo:
    if player.pos.x == 0:
      shiftScreenLeft(player, bgVec, room)
    if player.pos.y == 0:
      shiftScreenUp(player, bgVec, room)
    elif player.pos.y + player.height == SCREEN_HEIGHT:
      shiftScreenDown(player, bgVec, room)

  of sectionThree:
    if player.pos.x + player.width == SCREEN_WIDTH:
      shiftScreenRight(player, bgVec, room)
    if player.pos.y == 0:
      shiftScreenUp(player, bgVec, room)
    elif player.pos.y + player.height == SCREEN_HEIGHT:
      shiftScreenDown(player, bgVec, room)

  of sectionFour:
    if player.pos.x == 0:
      shiftScreenLeft(player, bgVec, room)
    if player.pos.y == 0:
      shiftScreenUp(player, bgVec, room)
    elif player.pos.y + player.height == SCREEN_HEIGHT:
      shiftScreenDown(player, bgVec, room)

  of sectionFive:
    if player.pos.x+player.width == SCREEN_WIDTH:
      shiftScreenRight(player, bgVec, room)
    if player.pos.y == 0:
      shiftScreenUp(player, bgVec, room)
    elif player.pos.y + player.height == SCREEN_HEIGHT:
      shiftScreenDown(player, bgVec, room)

  of sectionSix:
    if player.pos.x == 0:
      shiftScreenLeft(player, bgVec, room)
    if player.pos.y == 0:
      shiftScreenUp(player, bgVec, room)
    elif player.pos.y + player.height == SCREEN_HEIGHT:
      shiftScreenDown(player, bgVec, room)


# proc animateSlime*(slime: Enemy, frame: uint16) =
#   discard