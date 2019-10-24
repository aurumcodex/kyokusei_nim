##[
  極性 -Kyokusei- (Nim)
  =====================
  Date Modified: 2019-10-23

  ## [Sprites File]
  A file used for keeping the sprite data and palette data
  together and declaring constants that hold the generated
  data from the `grit` utility.

  ## [License]
  MIT Licensed. View LICENSE file for details.
]##

const
  Room1Tiles*: cstring = staticRead("gfx/bg_room1.img.bin")
  Room2Tiles*: cstring = staticRead("gfx/bg_room2.img.bin")
  Room3Tiles*: cstring = staticRead("gfx/bg_room3.img.bin")
  Room4Tiles*: cstring = staticRead("gfx/bg_room4.img.bin")
  KakarikoTiles*: cstring = staticRead("gfx/kakariko.img.bin")

const
  EchoTiles*: cstring = staticRead("gfx/echo.img.bin")
  BotTiles*: cstring = staticRead("gfx/bot.img.bin")
  GimpBotTiles*: cstring = staticRead("gfx/bot_gimp.img.bin")
  EnemyChronchaTiles*: cstring = staticRead("gfx/emy_chroncha.img.bin")
  EnemyNaniteWaveTiles*: cstring = staticRead("gfx/emy_nanite_wave.img.bin")
  EnemySentryTiles*: cstring = staticRead("gfx/emy_sentry.img.bin")
  EnemySlimeTiles*: cstring = staticRead("gfx/emy_slime.img.bin")
  EnemyTrentTiles*: cstring = staticRead("gfx/emy_trent.img.bin")

const
  Room1Palette*: cstring = staticRead("gfx/bg_room1.pal.bin")
  Room2Palette*: cstring = staticRead("gfx/bg_room2.pal.bin")
  Room3Palette*: cstring = staticRead("gfx/bg_room3.pal.bin")
  Room4Palette*: cstring = staticRead("gfx/bg_room4.pal.bin")
  KakarikoPalette*: cstring = staticRead("gfx/kakariko.pal.bin")

const
  EchoPalette*: cstring = staticRead("gfx/echo.pal.bin")
  BotPalette*: cstring = staticRead("gfx/bot.pal.bin")
  GimpBotPalette*: cstring = staticRead("gfx/bot_gimp.pal.bin")
  EnemyChronchaPalette*: cstring = staticRead("gfx/emy_chroncha.pal.bin")
  EnemyNaniteWavePalette*: cstring = staticRead("gfx/emy_nanite_wave.pal.bin")
  EnemySentryPalette*: cstring = staticRead("gfx/emy_sentry.pal.bin")
  EnemySlimePalette*: cstring = staticRead("gfx/emy_slime.pal.bin")
  EnemyTrentPalette*: cstring = staticRead("gfx/emy_trent.pal.bin")