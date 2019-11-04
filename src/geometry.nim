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
    height*: uint
    width*: uint
    top_left*: Vec2i
    bottom_right*: Vec2i