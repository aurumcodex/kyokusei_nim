##[
  極性 -Kyokusei- (Nim)
  =====================
  Date Modified: 2019-11-25

  ## [Rendering File]
  A file used for incorporating the sprite data and background data
  into user-made memory loading functions.

  ## [License]
  MIT Licensed. View LICENSE file for details.
]##

import tonc

import actors
import geometry

#[Sprite, Palette, and Map Data Loading]#
# Check out the Nim file in `rendering/data.nim` for the functions listed there.
include rendering/data

#[Screen Movement]#
# Check out the Nim file in `rendering/screens.nim` for the functions listed there.
include rendering/screens

const baseSlimeSprite: uint16 = 549'u16

#[Rendering Functions]#
proc renderPlayer*(sprite: var Player) =
  ## Rendering function to automatically render the OAM attributes of the player sprite(s).
  if sprite.visible:
    if not sprite.isEcho:
      if sprite.gravity == Gravity.Invert:
        if sprite.lookDir == LookDir.Left:
          oamMem[sprite.objID].setAttr(
            ATTR0_Y(sprite.pos.y.uint16) or ATTR0_4BPP or ATTR0_SQUARE,
            ATTR1_X(sprite.pos.x.uint16) or ATTR1_SIZE_16x16 or ATTR1_VFLIP,
            ATTR2_ID(sprite.spriteIndex) or ATTR2_PALBANK(0)
          )
        else:
          oamMem[sprite.objID].setAttr(
            ATTR0_Y(sprite.pos.y.uint16) or ATTR0_4BPP or ATTR0_SQUARE,
            ATTR1_X(sprite.pos.x.uint16) or ATTR1_SIZE_16x16 or ATTR1_HFLIP or ATTR1_VFLIP,
            ATTR2_ID(sprite.spriteIndex) or ATTR2_PALBANK(0)
          )
      elif sprite.gravity == Gravity.Normal:
        if sprite.lookDir == LookDir.Left:
          oamMem[sprite.objID].setAttr(
            ATTR0_Y(sprite.pos.y.uint16) or ATTR0_4BPP or ATTR0_SQUARE,
            ATTR1_X(sprite.pos.x.uint16) or ATTR1_SIZE_16x16,
            ATTR2_ID(sprite.spriteIndex) or ATTR2_PALBANK(0)
          )
        else:
          oamMem[sprite.objID].setAttr(
            ATTR0_Y(sprite.pos.y.uint16) or ATTR0_4BPP or ATTR0_SQUARE,
            ATTR1_X(sprite.pos.x.uint16) or ATTR1_SIZE_16x16 or ATTR1_HFLIP,
            ATTR2_ID(sprite.spriteIndex) or ATTR2_PALBANK(0)
          )
    else:
      if sprite.gravity == Gravity.Invert:
        if sprite.polarity == Polarity.Impulse:
          if sprite.lookDir == LookDir.Left:
            oamMem[sprite.objID].setAttr(
              ATTR0_Y(sprite.pos.y.uint16) or ATTR0_4BPP or ATTR0_TALL,
              ATTR1_X(sprite.pos.x.uint16) or ATTR1_SIZE_16x32 or ATTR1_VFLIP,
              ATTR2_ID(sprite.spriteIndex) or ATTR2_PALBANK(1)
            )
          else:
            oamMem[sprite.objID].setAttr(
              ATTR0_Y(sprite.pos.y.uint16) or ATTR0_4BPP or ATTR0_TALL,
              ATTR1_X(sprite.pos.x.uint16) or ATTR1_SIZE_16x32 or ATTR1_HFLIP or ATTR1_VFLIP,
              ATTR2_ID(sprite.spriteIndex) or ATTR2_PALBANK(1)
            )
        elif sprite.polarity == Polarity.Keen:
          if sprite.lookDir == LookDir.Left:
            oamMem[sprite.objID].setAttr(
              ATTR0_Y(sprite.pos.y.uint16) or ATTR0_4BPP or ATTR0_TALL,
              ATTR1_X(sprite.pos.x.uint16) or ATTR1_SIZE_16x32 or ATTR1_VFLIP,
              ATTR2_ID(sprite.spriteIndex) or ATTR2_PALBANK(2)
            )
          else:
            oamMem[sprite.objID].setAttr(
              ATTR0_Y(sprite.pos.y.uint16) or ATTR0_4BPP or ATTR0_TALL,
              ATTR1_X(sprite.pos.x.uint16) or ATTR1_SIZE_16x32 or ATTR1_HFLIP or ATTR1_VFLIP,
              ATTR2_ID(sprite.spriteIndex) or ATTR2_PALBANK(2)
            )
      if sprite.gravity == Gravity.Normal:
        if sprite.polarity == Polarity.Impulse:
          if sprite.lookDir == LookDir.Left:
            oamMem[sprite.objID].setAttr(
              ATTR0_Y(sprite.pos.y.uint16) or ATTR0_4BPP or ATTR0_TALL,
              ATTR1_X(sprite.pos.x.uint16) or ATTR1_SIZE_16x32,
              ATTR2_ID(sprite.spriteIndex) or ATTR2_PALBANK(1)
            )
          else:
            oamMem[sprite.objID].setAttr(
              ATTR0_Y(sprite.pos.y.uint16) or ATTR0_4BPP or ATTR0_TALL,
              ATTR1_X(sprite.pos.x.uint16) or ATTR1_SIZE_16x32 or ATTR1_HFLIP,
              ATTR2_ID(sprite.spriteIndex) or ATTR2_PALBANK(1)
            )
        elif sprite.polarity == Polarity.Keen:
          if sprite.lookDir == LookDir.Left:
            oamMem[sprite.objID].setAttr(
              ATTR0_Y(sprite.pos.y.uint16) or ATTR0_4BPP or ATTR0_TALL,
              ATTR1_X(sprite.pos.x.uint16) or ATTR1_SIZE_16x32,
              ATTR2_ID(sprite.spriteIndex) or ATTR2_PALBANK(2)
            )
          else:
            oamMem[sprite.objID].setAttr(
              ATTR0_Y(sprite.pos.y.uint16) or ATTR0_4BPP or ATTR0_TALL,
              ATTR1_X(sprite.pos.x.uint16) or ATTR1_SIZE_16x32 or ATTR1_HFLIP,
              ATTR2_ID(sprite.spriteIndex) or ATTR2_PALBANK(2)
            )
  elif not sprite.visible:
    oamMem[sprite.objID].hide

proc renderProjectile*(sprite: var Projectile) =
  ## Renders the projectile being used.
  if sprite.isBullet:
    if sprite.lookDir == LookDir.Left:
      oamMem[sprite.objID].setAttr(
        ATTR0_Y(sprite.pos.y.uint16) or ATTR0_4BPP or ATTR0_SQUARE,
        ATTR1_X(sprite.pos.x.uint16) or ATTR1_SIZE_8x8,
        ATTR2_ID(sprite.spriteIndex) or ATTR2_PALBANK(11'u16)
      )
    else:
      oamMem[sprite.objID].setAttr(
        ATTR0_Y(sprite.pos.y.uint16) or ATTR0_4BPP or ATTR0_SQUARE,
        ATTR1_X(sprite.pos.x.uint16) or ATTR1_SIZE_8x8 or ATTR1_HFLIP,
        ATTR2_ID(sprite.spriteIndex) or ATTR2_PALBANK(11)
      )
  else:
    if sprite.lookDir == LookDir.Left:
      oamMem[sprite.objID].setAttr(
        ATTR0_Y(sprite.pos.y.uint16) or ATTR0_4BPP or ATTR0_SQUARE,
        ATTR1_X(sprite.pos.x.uint16) or ATTR1_SIZE_16x16,
        ATTR2_ID(sprite.spriteIndex) or ATTR2_PALBANK(10)
      )
    else:
      oamMem[sprite.objID].setAttr(
        ATTR0_Y(sprite.pos.y.uint16) or ATTR0_4BPP or ATTR0_SQUARE,
        ATTR1_X(sprite.pos.x.uint16) or ATTR1_SIZE_16x16 or ATTR1_HFLIP,
        ATTR2_ID(sprite.spriteIndex) or ATTR2_PALBANK(10)
      )
  if not sprite.visible:
    oamMem[sprite.objID].hide

proc renderItem*(sprite: var Item) =
  ## Renders the specified item.
  oamMem[sprite.objID].setAttr(
    ATTR0_Y(sprite.pos.y.uint16) or ATTR0_4BPP or ATTR0_SQUARE,
    ATTR1_X(sprite.pos.x.uint16) or ATTR1_SIZE_8x8,
    ATTR2_ID(sprite.spriteIndex) or ATTR2_PALBANK(12)
  )

proc renderHeart(sprite: UserInterface) =
  ## Individual function to render the heart sprites for the user interface;
  ## namely the health meter.
  oamMem[sprite.objID].setAttr(
    ATTR0_Y(sprite.pos.y.uint16) or ATTR0_4BPP or ATTR0_SQUARE,
    ATTR1_X(sprite.pos.x.uint16) or ATTR1_SIZE_8x8,
    ATTR2_ID(sprite.spriteIndex) or ATTR2_PALBANK(9)
  )

proc renderUI*(sprites: array[0..4, UserInterface]) =
  ## Function to render the user interface.
  sprites[0].renderHeart
  sprites[1].renderHeart
  sprites[2].renderHeart
  sprites[3].renderHeart
  sprites[4].renderHeart

proc renderSlime(sprite: var Enemy, frames: var uint) =
  if sprite.animState == asMove:
    if sprite.lookDir == LookDir.Left:
      if frames mod 10 == 0:
        # sprite.animState = asMove
        oamMem[sprite.objID].setAttr(
          ATTR0_Y(sprite.pos.y.uint16) or ATTR0_4BPP or ATTR0_SQUARE,
          ATTR1_X(sprite.pos.x.uint16) or ATTR1_SIZE_16x16,
          ATTR2_ID(sprite.spriteIndex) or ATTR2_PALBANK(4)
        )
        sprite.spriteIndex += 4
        if sprite.spriteIndex == 561:
          sprite.spriteIndex = baseSlimeSprite
    if sprite.lookDir == LookDir.Right:
      if frames mod 10 == 0:
        # sprite.animState = asMove
        oamMem[sprite.objID].setAttr(
          ATTR0_Y(sprite.pos.y.uint16) or ATTR0_4BPP or ATTR0_SQUARE,
          ATTR1_X(sprite.pos.x.uint16) or ATTR1_SIZE_16x16 or ATTR1_HFLIP,
          ATTR2_ID(sprite.spriteIndex) or ATTR2_PALBANK(4)
        )
        sprite.spriteIndex += 4
        if sprite.spriteIndex == 561:
          sprite.spriteIndex = baseSlimeSprite
  if sprite.animState == asIdle:
    sprite.spriteIndex = baseSlimeSprite
    if sprite.lookDir == LookDir.Left:
      oamMem[sprite.objID].setAttr(
        ATTR0_Y(sprite.pos.y.uint16) or ATTR0_4BPP or ATTR0_SQUARE,
        ATTR1_X(sprite.pos.x.uint16) or ATTR1_SIZE_16x16,
        ATTR2_ID(sprite.spriteIndex) or ATTR2_PALBANK(4)
      )
    if sprite.lookDir == LookDir.Left:
      oamMem[sprite.objID].setAttr(
        ATTR0_Y(sprite.pos.y.uint16) or ATTR0_4BPP or ATTR0_SQUARE,
        ATTR1_X(sprite.pos.x.uint16) or ATTR1_SIZE_16x16 or ATTR1_HFLIP,
        ATTR2_ID(sprite.spriteIndex) or ATTR2_PALBANK(4)
      )
  
proc renderNaniteWave(sprite: var Enemy) =
  ## A function to render the Nanite Wave sprite(s).
  if sprite.visible:
    oamMem[sprite.objID].setAttr(
      ATTR0_Y(sprite.pos.y.uint16) or ATTR0_4BPP or ATTR0_SQUARE,
      ATTR1_X(sprite.pos.x.uint16) or ATTR1_SIZE_64x64,
      ATTR2_ID(sprite.spriteIndex) or ATTR2_PALBANK(14)
    )
  elif not sprite.visible:
    oamMem[sprite.objID].hide

proc renderPumpkin(sprite: var Enemy) =
  ## A function to render the Nanite Wave sprite(s).
  if sprite.visible:
    oamMem[sprite.objID].setAttr(
      ATTR0_Y(sprite.pos.y.uint16) or ATTR0_4BPP or ATTR0_SQUARE,
      ATTR1_X(sprite.pos.x.uint16) or ATTR1_SIZE_32x32,
      ATTR2_ID(sprite.spriteIndex) or ATTR2_PALBANK(4)
    )
  elif not sprite.visible:
    oamMem[sprite.objID].hide

proc renderEnemy*(enemy: var Enemy, frames: var uint, room: var Room) =
  ## Rendering function to automatically render the OAM attributes of the enemy sprite(s).
  # TODO: add logic to function
  case enemy.aiType:
    of EnemyAI.Slime:
      enemy.renderSlime(frames)
    of EnemyAI.NaniteWave:
      enemy.renderNaniteWave
    of EnemyAI.Pumpkin:
      enemy.renderPumpkin
    else:   
      discard

proc hideEnemy*() =
  discard