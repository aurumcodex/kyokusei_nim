##[
  極性 -Kyokusei- (Nim)
  =====================
  Date Modified: 2019-11-18

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
  UIHeartTiles*: cstring = staticRead("gfx/ui_heart.img.bin")
  ObjBladeSlashTiles*: cstring = staticRead("gfx/obj_bladeslash.img.bin")
  ObjBulletTiles*: cstring = staticRead("gfx/obj_bullet.img.bin")
  ObjHealthTiles*: cstring = staticRead("gfx/obj_health.img.bin")
  EnemyChronchaTiles*: cstring = staticRead("gfx/emy_chroncha.img.bin")
  EnemyNaniteWaveTiles*: cstring = staticRead("gfx/emy_nanite_wave.img.bin")
  EnemySentryTiles*: cstring = staticRead("gfx/emy_sentry.img.bin")
  EnemySlimeTiles*: cstring = staticRead("gfx/emy_slime.img.bin")
  EnemyTrentTiles*: cstring = staticRead("gfx/emy_trent.img.bin")

const
  BotPalette*: cstring = staticRead("gfx/bot.pal.bin")
  EchoPalette*: cstring = staticRead("gfx/echo.pal.bin")
  PumpkinPalette*: cstring = staticRead("gfx/pumpkin.pal.bin")
  UIHeartPalette*: cstring = staticRead("gfx/ui_heart.pal.bin")
  ObjBladeSlashPalette*: cstring = staticRead("gfx/obj_bladeslash.pal.bin")
  ObjBulletPalette*: cstring = staticRead("gfx/obj_bullet.pal.bin")
  ObjHealthPalette*: cstring = staticRead("gfx/obj_health.pal.bin")
  EnemyChronchaPalette*: cstring = staticRead("gfx/emy_chroncha.pal.bin")
  EnemyNaniteWavePalette*: cstring = staticRead("gfx/emy_nanite_wave.pal.bin")
  EnemySentryPalette*: cstring = staticRead("gfx/emy_sentry.pal.bin")
  EnemySlimePalette*: cstring = staticRead("gfx/emy_slime.pal.bin")
  EnemyTrentPalette*: cstring = staticRead("gfx/emy_trent.pal.bin")