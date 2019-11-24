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
import rendering


proc autoMove*(player: var Player, room: Room) =
  if player.gravity == Gravity.Invert:
    player.pos.y -= 2
    oamMem[player.objID].setPos(player.pos)


proc move*(player: var Player, room: Room) =
  ## Function to move around on the screen.
  if keyIsDown(KEY_LEFT):
    if player.backgroundCollision(room):
      player.pos.x -= 0
    else:
      player.pos.x -= 1
    
  if keyIsDown(KEY_RIGHT):
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

# proc invert*(player: var Player, room: Room, delay: var uint) =
#   # keyRepeatLimits(0, 0)
#   if keyIsDown(KEY_A):
#     if player.gravity == Gravity.Normal and delay <= 10'u:
#       player.gravity = Gravity.Invert
#       oamMem[player.objID].setAttr(
#         ATTR0_Y(player.pos.y.uint16) or ATTR0_4BPP or ATTR0_TALL,
#         ATTR1_X(player.pos.x.uint16) or ATTR1_VFLIP or ATTR1_SIZE_16x32,
#         ATTR2_ID(player.spriteIndex) or ATTR2_PALBANK(0)
#       )
#       # while delay <= 10:
#       #   if delay == 10:
#       #     delay = 11
#       #     break
#       # player.pos.y -= 2
#       # oamMem[player.objID].setPos(player.pos)
#       player.autoMove(room)
#     if player.gravity == Gravity.Invert and delay >= 10'u:
#       player.gravity = Gravity.Normal
#       oamMem[player.objID].setAttr(
#         ATTR0_Y(player.pos.y.uint16) or ATTR0_4BPP or ATTR0_TALL,
#         ATTR1_X(player.pos.x.uint16) or ATTR1_SIZE_16x32,
#         ATTR2_ID(player.spriteIndex) or ATTR2_PALBANK(0)
#       )
#     # if player.gravity == Gravity.Invert:
#     #   oamMem[player.objID].setAttr(
#     #     ATTR0_Y(player.pos.y.uint16) or ATTR0_4BPP or ATTR0_SQUARE,
#     #     ATTR1_X(player.pos.x.uint16) or ATTR1_VFLIP or ATTR1_SIZE_16,
#     #     ATTR2_ID(player.spriteIndex) or ATTR2_PALBANK(0)
#     #   )
#     #   while not backgroundCollision(player, room):
#     #     player.pos.y -= 1
#     #     oamMem[player.objID].setPos(player.pos)

proc fireShot*(player: var Player) =
  ##
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
    if player.isEcho:
      player.height = 16
      player.spriteIndex = EraSprite
      player.pos.y += 16
      player.isEcho = false
      oamMem[player.objID].setAttr(
        ATTR0_Y(player.pos.y.uint16) or ATTR0_4BPP or ATTR0_SQUARE,
        ATTR1_X(player.pos.x.uint16) or ATTR1_SIZE_16,
        ATTR2_ID(player.spriteIndex) or ATTR2_PALBANK(0)
      )

proc getInput*(player: var Player, room: Room, delay: var uint) =
  ##
  if keyIsDown(KEY_DIR):
    player.move(room)
  if keyIsDown(KEY_A):
    # player.invert(room)
    # player.invert(room, delay)
    discard
  if keyIsDown(KEY_B):
    player.fireShot
    discard
  if keyIsDown(KEY_START):
    discard
  if keyIsDown(KEY_SELECT):
    player.changeSprite(delay)
  if keyIsDown(KEY_L):
    player.shiftPolarity(Polarity.Impulse)
    discard
  if keyIsDown(KEY_R):
    player.shiftPolarity(Polarity.Keen)