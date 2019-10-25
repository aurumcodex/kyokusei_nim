##[
  極性 -Kyokusei- (Nim)
  =====================
  Date Modified: 2019-10-24

  ## [Actors File]
  A file used for various characters and things that the player can interact
  with and/or control.

  ## [License]
  MIT Licensed. View LICENSE file for details.
]##

import tonc

import geometry

type
  Player* = object
    boundaries*: Box
    spriteIndex*: int
    deaths*: uint

type
  Enemy* = object
    boundaries*: Box
    spriteIndex*: int
    deaths*: uint