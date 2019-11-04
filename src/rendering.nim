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
