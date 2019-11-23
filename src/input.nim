##[
  極性 -Kyokusei- (Nim)
  =====================
  Date Modified: 2019-11-19

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


proc invert*(player: var Player, room: Room) =
  # if keyIsDown(KEY_A):
    if player.gravity == gNormal:
      player.gravity = gInvert
    if player.gravity == gInvert:
      oamMem[player.objID].setAttr(
        ATTR0_Y(player.pos.y.uint16) or ATTR0_4BPP or ATTR0_SQUARE,
        ATTR1_X(player.pos.x.uint16) or ATTR1_VFLIP or ATTR1_SIZE_16,
        ATTR2_ID(player.spriteIndex) or ATTR2_PALBANK(0)
      )
      while not backgroundCollision(player, room):
        player.pos.y -= 1
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