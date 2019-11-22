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
import rendering
import rendering/collision

proc jump*(player: var Player) =
  ## A function to allow the player (as Echo) to jump around.
  const height = 20
  var base = player.pos.y
  if keyIsDown(KEY_A):
    while player.pos.y < base + height:
      player.pos.y += 1
      oamMem[player.objID].setPos(player.pos)
      if player.pos.y == base + height:
        player.pos.y -= 1

  discard

# proc invert*(player: var Player, room: Room) =
#   # if keyIsDown(KEY_A):
#     if player.gravity == gNormal:
#       player.gravity = gInvert
#     if player.gravity == gInvert:
#       oamMem[player.objID].setAttr(
#         ATTR0_Y(player.pos.y.uint16) or ATTR0_4BPP or ATTR0_SQUARE,
#         ATTR1_X(player.pos.x.uint16) or ATTR1_VFLIP or ATTR1_SIZE_16,
#         ATTR2_ID(player.spriteIndex) or ATTR2_PALBANK(0)
#       )
#       while not backgroundCollision(player, room):
#         player.pos.y += 1
#         oamMem[player.objID].setPos(player.pos)


proc verticalMove*(player: Player) =
  discard

proc move*(player: Player) =
  ## Function to move around on the screen.