##[
  極性 -Kyokusei- (Nim)
  =====================
  Date Modified: 2019-10-24

  ## [Geometry File]
  A file used for dealing with collision and other mathematical functions
  that will be needed for traversing around an area of a room or map.

  ## [License]
  MIT Licensed. View LICENSE file for details.
]##

import tonc

type
  Box* {.bycopy.} = object
    ## A box that will surround any given sprite.
    boundLeft*: uint
    boundRight*: uint
    boundTop*: uint
    boundBottom*: uint
    # top_left*: Vec2i
    # bottom_right*: Vec2i

proc hasCollided*(player: Box, obj: Box): bool =
  ## A function to determine if the player has collided with anything
  # TODO: implement collision detection
  # if player.top_left.x + player.width == obj.top_left.x:
  #   result = true
  # elif player.top_left.y + player.height == obj.top_left.y:
  #   result = false
  # elif player.bottom_right
