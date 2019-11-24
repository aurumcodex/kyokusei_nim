##[
  極性 -Kyokusei- (Nim)
  =====================
  Date Modified: 2019-11-22

  ## [Rendering File]
  A file used for incorporating the sprite data and background data
  into user-made memory loading functions.

  ## [License]
  MIT Licensed. View LICENSE file for details.
]##

import tonc

import actors
import geometry
import ffi_c

type
  RoomId* = enum
    ## An enum type for determing which backgrounds to load in the dedicated
    ## rendering functions for the backgrounds.
    riOne
    riTwo
    riThree
    riFour

type
  Room* = object
    ## A data type that holds some info about the current room.
    roomID*: RoomID
    submap*: Submap

#[Sprite, Palette, and Map Data Loading]#
# Check out the Nim file in `rendering/data.nim` for the functions listed there.
include rendering/data

#[Screen Movement]#
# Check out the Nim file in `rendering/screens.nim` for the functions listed there.
include rendering/screens

#[Rendering Functions]#
proc renderPlayer*(player: var Player) =
  ## Rendering function to automatically render the OAM attributes of the player sprite(s).
  # TODO: add logic
  discard

proc renderEnemy*(enemy: var Enemy) =
  ## Rendering function to automatically render the OAM attributes of the enemy sprite(s).
  # TODO: add logic
  discard