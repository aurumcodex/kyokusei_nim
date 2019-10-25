##[
  極性 -Kyokusei- (Nim)
  =====================
  Date Modified: 2019-10-23

  ## [Main File]
  The main file for executing the commands/functions/calls/etc.
  for the GBA project.

  ## [License]
  MIT Licensed. View LICENSE file for details.
]##

import tonc

# import sprites
import actors
# import mechanics
import rendering
import panicoverride

var
  posVec = vec2i(82, 78)
  frameCount = 0

proc main() =
  irqInit()
  irqEnable(II_VBLANK)

  REG_DISPCNT = DCNT_BG0 or DCNT_OBJ or DCNT_OBJ_1D

  # memcpy16(addr palObjBank[0], BotPalette, BotPalette.len div 2)
  # memcpy32(addr tileMemObj[0], BotTiles, BotTiles.len div 4)

  # memcpy16(addr palObjBank[1], EnemySlimePalette, EnemySlimePalette.len div 8)
  # memcpy32(addr tileMemObj[1], EnemySlimeTiles, EnemySlimeTiles.len div 4)

  # memcpy16(addr palObjBank[3], EchoPalette, EchoPalette.len div 2)
  # memcpy32(addr tileMemObj[0][5], EchoTIles, EchoTiles.len div 4)

  # # memcpy16(addr palBgBank[0], KakarikoPalette, KakarikoPalette.len div 2)
  # # memcpy32(addr seMem[0], KakarikoTiles, KakarikoTiles.len div 4)

  # memcpy16(addr palBgBank[0], Room1Palette, Room1Palette.len div 2)
  # memcpy32(addr tileMem[0], Room1Tiles, Room1Tiles.len div 4)

  # loadSprites(SpriteData)
  # loadObjPalettes(SpritePals)

  loadObjSprites()
  loadObjPalettes()

  oamMem[0].setAttr(
    ATTR0_Y(posVec.y.uint16) or ATTR0_4BPP or ATTR0_SQUARE,
    ATTR1_X(posVec.x.uint16) or ATTR1_SIZE_16,
    ATTR2_ID(1) or ATTR2_PALBANK(0)
  )

  oamMem[1].setAttr(
    ATTR0_Y(posVec.y.uint16 - 20) or ATTR0_4BPP or ATTR0_TALL,
    ATTR1_X(posVec.x.uint16 - 40) or ATTR1_SIZE_16x32,
    ATTR2_ID(6) or ATTR2_PALBANK(3)
  )

  oamMem[2].setAttr(
    ATTR0_Y(posVec.y.uint16 + 10) or ATTR0_4BPP or ATTR0_TALL,
    ATTR1_X(posVec.x.uint16 + 50) or ATTR1_SIZE_16x32,
    ATTR2_ID(76) or ATTR2_PALBANK(1)
  )

  tteInitChr4cDefault(0, BG_CBB(0) or BG_SBB(31))
  tteWrite("#{P:92,68}")
  tteWrite("I'M ON A SCREEEEEEEEEEN")
  tteWrite("#{P:92,100}")
  tteWrite("WEeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");

  while true:
    keyPoll()

    if keyIsDown(KEY_LEFT): posVec.x -= 1
    if keyIsDown(KEY_RIGHT): posVec.x += 1
    if keyIsDown(KEY_UP): posVec.y -= 1
    if keyIsDown(KEY_DOWN): posVec.y += 1

    oamMem[0].setPos(posVec)

    inc(frameCount) # increment frame count

    VBlankIntrWait()

main()