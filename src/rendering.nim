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

# const SpriteData*: array[0..6, cstring] = [EchoTiles,
#                                            BotTiles,
#                                            EnemyChronchaTiles,
#                                            EnemyNaniteWaveTiles,
#                                            EnemySentryTiles,
#                                            EnemySlimeTiles,
#                                            EnemyTrentTiles]

# const SpritePals*: array[0..6, cstring] = [EchoPalette,
#                                            BotPalette,
#                                            EnemyChronchaPalette,
#                                            EnemyNaniteWavePalette,
#                                            EnemySentryPalette,
#                                            EnemySlimePalette,
#                                            EnemyTrentPalette]

# const BgData*: array[0..4, cstring] = [Room1Tiles,
#                                        Room2Tiles,
#                                        Room3Tiles,
#                                        Room4Tiles,
#                                        KakarikoTiles]

# const BgPals*: array[0..4, cstring] = [Room1Palette,
#                                        Room2Palette,
#                                        Room3Palette,
#                                        Room4Palette,
#                                        KakarikoPalette]

# proc loadSprites*(data: openarray[cstring]) =
#   var 
#     layer: uint = 0
#     index: uint = 0

#   for sprite in data:
#     memcpy32(addr tileMemObj[layer][index], sprite, sprite.len div 4)
#     index += cast[uint](sprite.len div 4) + 1
#     if index > 2047'u:
#       index  = 0
#       layer += 1

# proc loadObjPalettes*(data: openarray[cstring]) =
#   var
#     layer: uint = 0
#     # index: uint = 0

#   for palette in data:
#     memcpy16(addr palObjBank[layer], palette, palette.len div 2)
#     if layer < 16'u:
#       inc(layer)

proc loadObjSprites*() =
  memcpy32(addr tileMemObj[0][0], BotTiles, BotTiles.len div 4)
  memcpy32(addr tileMemObj[0][5], EchoTiles, EchoTiles.len div 4)
  memcpy32(addr tileMemObj[0][14], EnemyChronchaTiles, EnemyChronchaTiles.len div 4)
  # memcpy32(addr tileMemObj[0][31], EnemyNaniteWaveTiles, EnemyNaniteWaveTiles.len div 4)
  memcpy32(addr tileMemObj[0][31], EnemySentryTiles, EnemySentryTiles.len div 4)
  memcpy32(addr tileMemObj[0][36], EnemySlimeTiles, EnemySlimeTiles.len div 4)
  memcpy32(addr tileMemObj[0][77], EnemyTrentTiles, EnemyTrentTiles.len div 4)

proc loadObjPalettes*() =
  memcpy16(addr palObjBank[0], BotPalette, BotPalette.len div 2)
  memcpy16(addr palObjBank[1], EchoPalette, EchoPalette.len div 2)
  memcpy16(addr palObjBank[2], EnemyChronchaPalette, EnemyChronchaPalette.len div 2)
  memcpy16(addr palObjBank[3], EnemySentryPalette, EnemySentryPalette.len div 2)
  memcpy16(addr palObjBank[4], EnemySlimePalette, EnemySlimePalette.len div 2)
  memcpy16(addr palObjBank[5], EnemyTrentPalette, EnemyTrentPalette.len div 2)