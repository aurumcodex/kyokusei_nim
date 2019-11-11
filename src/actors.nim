##[
  極性 -Kyokusei- (Nim)
  =====================
  Date Modified: 2019-10-26

  ## [Actors File]
  A file used for various characters and things that the player can interact
  with and/or control.

  ## [License]
  MIT Licensed. View LICENSE file for details.
]##

import tonc

import geometry

type
  Gravity* = enum
    gInvert
    gNormal

type
  Polarity* = enum
    pImpulse
    pKeen

type
  Stats* = tuple
    maxHP: int
    maxAP: int
    curHP: int
    curAP: int
    atk: int
    def: int

# type
#   Actor* = ref object of RootObj
#     spriteIndex*: int
#     bounds*: Box

type
  Player* = tuple
    ## A Player data type that holds various points of data.
    objID: uint
    spriteIndex: int
    HP: int
    AP: int
    pos: Vec2i
    height: int
    width: int
    # bounds: Box
    # stats: Stats
    # gravity*: Gravity
    # polarity*: Polarity

type
  Enemy* = tuple
    ## An Enemy data type that holds various points of data.
    objID: uint
    spriteIndex: int
    HP: int
    AP: int
    pos: Vec2i
    height: int
    width: int
    # stats: Stats

