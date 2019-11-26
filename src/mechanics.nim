##[
  極性 -Kyokusei- (Nim)
  =====================
  Date Modified: 2019-11-25

  ## [Mechanics File]
  A file used for various gameplay mechanics within the game.

  ## [License]
  MIT Licensed. View LICENSE file for details.
]##

import geometry

type
  GravityPolarity {.pure.} = enum
    ## A pure enum type for determining the current gravity.
    Down
    Up

type
  FormePolarity {.pure.} = enum
    ## A pure enum type for determining the current forme.
    Keen
    Impulse

type
  Direction = enum
    ## An enum type for determining the direction an object sprite is moving.
    dUp
    dDown
    dRight
    dLeft
