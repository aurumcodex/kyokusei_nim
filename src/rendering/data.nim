##[
  極性 -Kyokusei- (Nim)
  =====================
  Date Modified: 2019-11-25

  ## [Data File]
  A file used for the functions that load in the data required for the sprites and
  backgrounds, as well as background map data.

  ## [License]
  MIT Licensed. View LICENSE file for details.
]##

import ../sprites

proc loadObjSprites*() =
  ## Function to load sprite data into respective sprite location banks.
  memcpy32(addr tileMemObj[1][0], BotTiles, BotTiles.len)
  memcpy32(addr tileMemObj[1][5], EchoTiles, EchoTiles.len div 4)
  memcpy32(addr tileMemObj[1][14], EnemyChronchaTiles, EnemyChronchaTiles.len div 4)
  memcpy32(addr tileMemObj[1][26], EnemySentryTiles, EnemySentryTiles.len div 4)
  memcpy32(addr tileMemObj[1][36], EnemySlimeTiles, EnemySlimeTiles.len div 4)
  memcpy32(addr tileMemObj[1][77], EnemyTrentTiles, EnemyTrentTiles.len div 4)
  memcpy32(addr tileMemObj[1][99], PumpkinTiles, PumpkinTiles.len div 4)
  memcpy32(addr tileMemObj[1][200], UIHeartTiles, UIHeartTiles.len div 4)
  memcpy32(addr tileMemObj[1][118], ObjBladeSlashTiles, ObjBladeSlashTiles.len div 4)
  memcpy32(addr tileMemObj[1][125], ObjBulletTiles, ObjBulletTiles.len div 4)
  memcpy32(addr tileMemObj[1][127], ObjHealthTiles, ObjHealthTiles.len div 4)
  memcpy32(addr tileMemObj[1][129], EnemyNaniteWaveTiles, EnemyNaniteWaveTiles.len div 4)

proc loadObjPalettes*() =
  ## Function to load palette data into respective palette banks.
  memcpy16(addr palObjBank[0], BotPalette, BotPalette.len div 2)
  memcpy16(addr palObjBank[1], EchoPalette, EchoPalette.len div 2)
  memcpy16(addr palObjBank[2], InvertEchoPalette, InvertEchoPalette.len div 2)
  memcpy16(addr palObjBank[3], EnemyChronchaPalette, EnemyChronchaPalette.len div 2)
  memcpy16(addr palObjBank[4], PumpkinPalette, PumpkinPalette.len div 2)
  memcpy16(addr palObjBank[6], EnemySlimePalette, EnemySlimePalette.len div 2)
  memcpy16(addr palObjBank[8], EnemyTrentPalette, EnemyTrentPalette.len div 2)
  memcpy16(addr palObjBank[9], UIHeartPalette, UIHeartPalette.len div 2)
  memcpy16(addr palObjBank[10], ObjBladeSlashPalette, ObjBladeSlashPalette.len div 2)
  memcpy16(addr palObjBank[11], ObjBulletPalette, ObjBulletPalette.len div 2)
  memcpy16(addr palObjBank[12], ObjHealthPalette, ObjHealthPalette.len div 2)
  memcpy16(addr palObjBank[13], EnemyNaniteWavePalette, EnemyNaniteWavePalette.len div 2)
  memcpy16(addr palObjBank[15], EnemySentryTiles, EnemySentryPalette.len div 2)

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