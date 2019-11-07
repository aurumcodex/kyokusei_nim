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

import sprites

type
  RoomId* = enum
    riOne
    riTwo
    riThree
    riFour

proc loadObjSprites*() =
  ## Function to load sprite data into respective sprite location banks.
  memcpy32(addr tileMemObj[0][0], BotTiles, BotTiles.len div 4)
  memcpy32(addr tileMemObj[0][5], EchoTiles, EchoTiles.len div 4)
  memcpy32(addr tileMemObj[0][14], EnemyChronchaTiles, EnemyChronchaTiles.len div 4)
  memcpy32(addr tileMemObj[0][36], EnemySlimeTiles, EnemySlimeTiles.len div 4)
  memcpy32(addr tileMemObj[0][77], EnemyTrentTiles, EnemyTrentTiles.len div 4)

proc loadObjPalettes*() =
  ## Function to load palette data into respective palette banks.
  memcpy16(addr palObjBank[0], BotPalette, BotPalette.len div 2)
  memcpy16(addr palObjBank[1], EchoPalette, EchoPalette.len div 2)
  memcpy16(addr palObjBank[2], EnemyChronchaPalette, EnemyChronchaPalette.len div 2)
  memcpy16(addr palObjBank[4], EnemySlimePalette, EnemySlimePalette.len div 2)
  memcpy16(addr palObjBank[6], EnemyTrentPalette, EnemyTrentPalette.len div 2)

proc loadBGTiles*(rid: RoomId) =
  ## Function to load tile data for the backgrounds depending on the room ID passed to it.
  case rid:
    of riOne:
      memcpy32(addr tileMem[0][0], Room1Tiles, Room1Tiles.len div 4)
    of riTwo:
      memcpy32(addr tileMem[0][0], Room2Tiles, Room2Tiles.len div 4)
    of riThree:
      memcpy32(addr tileMem[0][0], Room3Tiles, Room3Tiles.len div 4)
    of riFour:
      memcpy32(addr tileMem[0][0], Room4Tiles, Room4Tiles.len div 4)

proc loadBGPalettes*(rid: RoomId) =
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
  case rid:
    of riOne:
      # BG_BUILD
      memcpy32(addr seMem[0][0], Room1Map, Room1Map.len)
    of riTwo:
      memcpy32(addr seMem[0][0], Room2Map, Room2Map.len)
    of riThree:
      memcpy32(addr seMem[0][0], Room3Map, Room3Map.len)
    of riFour:
      memcpy32(addr seMem[0][0], Room4Map, Room4Map.len)

# proc loadGBMap*() =
#   memcpy32(addr )