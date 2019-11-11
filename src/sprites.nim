##[
  極性 -Kyokusei- (Nim)
  =====================
  Date Modified: 2019-10-23

  ## [Sprites File]
  A file used for keeping the sprite data and palette data
  together and declaring constants that hold the generated
  data from the `grit` utility. These files are converted and
  stored in the `gfx` folder.

  ## [License]
  MIT Licensed. View LICENSE file for details.
]##

const
  Room1Tiles*: cstring = staticRead("gfx/bg_room1.img.bin")
  Room2Tiles*: cstring = staticRead("gfx/bg_room2.img.bin")
  Room3Tiles*: cstring = staticRead("gfx/bg_room3.img.bin")
  Room4Tiles*: cstring = staticRead("gfx/bg_room4.img.bin")
  
const
  Room1Palette*: cstring = staticRead("gfx/bg_room1.pal.bin")
  Room2Palette*: cstring = staticRead("gfx/bg_room2.pal.bin")
  Room3Palette*: cstring = staticRead("gfx/bg_room3.pal.bin")
  Room4Palette*: cstring = staticRead("gfx/bg_room4.pal.bin")
  
const
  Room1Map*: cstring = staticRead("gfx/bg_room1.map.bin")
  Room2Map*: cstring = staticRead("gfx/bg_room2.map.bin")
  Room3Map*: cstring = staticRead("gfx/bg_room3.map.bin")
  Room4Map*: cstring = staticRead("gfx/bg_room4.map.bin")
  
const
  BotTiles*: cstring = staticRead("gfx/bot.img.bin")
  EchoTiles*: cstring = staticRead("gfx/echo.img.bin")
  PumpkinTiles*: cstring = staticRead("gfx/pumpkin.img.bin")
  EnemyChronchaTiles*: cstring = staticRead("gfx/emy_chroncha.img.bin")
  EnemyNaniteWaveTiles*: cstring = staticRead("gfx/emy_nanite_wave.img.bin")
  EnemySentryTiles*: cstring = staticRead("gfx/emy_sentry.img.bin")
  EnemySlimeTiles*: cstring = staticRead("gfx/emy_slime.img.bin")
  EnemyTrentTiles*: cstring = staticRead("gfx/emy_trent.img.bin")

const
  BotPalette*: cstring = staticRead("gfx/bot.pal.bin")
  EchoPalette*: cstring = staticRead("gfx/echo.pal.bin")
  PumpkinPallete*: cstring = staticRead("gfx/pumpkin.pal.bin")
  EnemyChronchaPalette*: cstring = staticRead("gfx/emy_chroncha.pal.bin")
  EnemyNaniteWavePalette*: cstring = staticRead("gfx/emy_nanite_wave.pal.bin")
  EnemySentryPalette*: cstring = staticRead("gfx/emy_sentry.pal.bin")
  EnemySlimePalette*: cstring = staticRead("gfx/emy_slime.pal.bin")
  EnemyTrentPalette*: cstring = staticRead("gfx/emy_trent.pal.bin")

# place these back in rendering.nim later
#memcpy32(addr tileMemObj[0][31], EnemySentryTiles, EnemySentryTiles.len div 4)
#memcpy16(addr palObjBank[3], EnemySentryPalette, EnemySentryPalette.len div 2)