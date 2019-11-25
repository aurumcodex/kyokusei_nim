##[
  極性 -Kyokusei- (Nim)
  =====================
  Date Modified: 2019-11-23

  ## [Input File]
  A file for dealing with user input and manipulating
  the player's sprites and states.

  ## [License]
  MIT Licensed. View LICENSE file for details.
]##

import tonc

import actors
import collision
import geometry

include logic/projectile_data

proc autoMove*(sprite: var Player, room: Room) =
  if sprite.gravity == Gravity.Invert:
    if not sprite.backgroundCollision(room):
      sprite.pos.y -= 1
    oamMem[sprite.objID].setPos(sprite.pos)
  elif sprite.gravity == Gravity.Normal:
    if not sprite.backgroundCollision(room):
      sprite.pos.y += 1
      if sprite.verticalMove == false:
        sprite.pos.y -= 0
    oamMem[sprite.objID].setPos(sprite.pos)

proc autoMove*(sprite: var Projectile, room: Room) =
  discard

proc move*(player: var Player, room: Room) =
  ## Function to move around on the screen.
  if keyIsDown(KEY_LEFT):
    player.lookDir = LookDir.Left
    if player.backgroundCollision(room):
      player.pos.x -= 0
    else:
      player.pos.x -= 1
    
  if keyIsDown(KEY_RIGHT):
    player.lookDir = LookDir.Right
    if backgroundCollision(player, room):
      player.pos.x += 0
    else:
      player.pos.x += 1

  if keyIsDown(KEY_UP):
    if backgroundCollision(player, room):
      player.pos.y -= 0
    else:
      player.pos.y -= 1

  if keyIsDown(KEY_DOWN): 
    if backgroundCollision(player, room):
      player.pos.y += 0
    else:
      player.pos.y += 1

proc invert*(player: var Player, room: Room, delay: var uint) =
  ## "Inverts" the player sprite in terms of gravity.
  keyRepeatLimits(0, 0)
  if player.gravity == Gravity.Normal and player.verticalMove == false and delay <= 10'u:
    player.gravity = Gravity.Invert
    player.verticalMove = true
    player.autoMove(room)
  if player.gravity == Gravity.Invert and player.verticalMove == false and delay >= 10'u:
    player.gravity = Gravity.Normal
    player.verticalMove = true

proc fireShot*(player: var Player) =
  ## A function to fire off a projectile sprite from the center of the player sprite.
  ##
  ## (Currently very glitchy, and doesn't fire off projectiles)
  case player.ammoCount:
    of 1, 2, 3, 4, 5:
      player.ammoList[player.ammoCount].visible = true
      player.ammoList[player.ammoCount].velocity = 3
    else:
      discard

proc shiftPolarity*(player: var Player, forme: Polarity) =
  ## 
  keyRepeatLimits(0, 0)
  if player.polarity == Polarity.Keen:
    if forme == Polarity.Impulse:
      player.polarity = forme
  elif player.polarity == Polarity.Impulse:
    if forme == Polarity.Keen:
      player.polarity = forme

proc changeSprite*(player: var Player, delay: uint) =
  ##
  keyRepeatLimits(0, 0)
  if keyIsDown(KEY_SELECT):
    if player.isEcho and delay <= 10'u:
      player.height = 16
      player.spriteIndex = EraSprite
      player.pos.y += 16
      player.isEcho = false
      player.ammoCount = 5
      player.ammoList = bulletList
      oamMem[player.objID].setAttr(
        ATTR0_Y(player.pos.y.uint16) or ATTR0_4BPP or ATTR0_SQUARE,
        ATTR1_X(player.pos.x.uint16) or ATTR1_SIZE_16,
        ATTR2_ID(player.spriteIndex) or ATTR2_PALBANK(0)
      )
    elif not player.isEcho and delay >= 10'u:
      player.height = 32
      player.spriteIndex = EchoSprite
      player.pos.y -= 16
      player.isEcho = true
      if player.polarity == Polarity.Keen:
        oamMem[player.objID].setAttr(
          ATTR0_Y(player.pos.y.uint16) or ATTR0_4BPP or ATTR0_SQUARE,
          ATTR1_X(player.pos.x.uint16) or ATTR1_SIZE_16,
          ATTR2_ID(player.spriteIndex) or ATTR2_PALBANK(2)
        )
      else:
        oamMem[player.objID].setAttr(
          ATTR0_Y(player.pos.y.uint16) or ATTR0_4BPP or ATTR0_SQUARE,
          ATTR1_X(player.pos.x.uint16) or ATTR1_SIZE_16,
          ATTR2_ID(player.spriteIndex) or ATTR2_PALBANK(1)
        )

proc getInput*(player: var Player, room: Room, delay: var uint) =
  ##
  if keyIsDown(KEY_DIR):
    player.move(room)
  if keyIsDown(KEY_A):
    # player.invert(room)
    player.invert(room, delay)
    discard
  if keyIsDown(KEY_B):
    player.fireShot
    discard
  if keyIsDown(KEY_START):
    # testing with this button
    if delay < 2'u:
      player.HP -= 2
    # discard
  if keyIsDown(KEY_SELECT):
    player.changeSprite(delay)
  if keyIsDown(KEY_L):
    player.shiftPolarity(Polarity.Impulse)
  if keyIsDown(KEY_R):
    player.shiftPolarity(Polarity.Keen)