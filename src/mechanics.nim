##[
  極性 -Kyokusei- (Nim)
  =====================
  Date Modified: 2019-10-24

  ## [Mechanics File]
  A file used for various gameplay mechanics within the game.

  ## [License]
  MIT Licensed. View LICENSE file for details.
]##

#put these back into the main file.
# import sprites
# import geometry
# import mechanics

type
  GravityPolarity {.pure.} = enum
    Down
    Up

type
  FormePolarity {.pure.} = enum
    Keen
    Impulse

type
  Direction = enum
    dUp
    dDown
    dRight
    dLeft

# type
