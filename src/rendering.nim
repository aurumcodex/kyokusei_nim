##[
  極性 -Kyokusei- (Nim)
  =====================
  Date Modified: 2019-11-22

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
# Check out the Nim file in `rendering/screens.nim` for the functions listed there.
include rendering/screens

# proc animateSlime*(slime: Enemy, frame: uint16) =
#   discard

# # This `include` is at the bottom, due to the way Nim handles declarations.
# include rendering/collision