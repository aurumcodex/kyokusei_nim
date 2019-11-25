##[
  極性 -Kyokusei- (Nim)
  =====================
  Date Modified: 2019-11-11

  ## [Geometry File]
  A file used for dealing with collision and other mathematical functions
  that will be needed for traversing around an area of a room or map.

  ## [License]
  MIT Licensed. View LICENSE file for details.
]##

import tonc

# import actors

type
  Box* = tuple
    ## A box that will surround any given sprite.
    topVect: Vec2i
    bottomVect: Vec2i # this one is basically topVect + the width and height of the sprite.

type
  Offsets* = object
    xOffset*: int
    yOffset*: int

type
  Submap* {.pure.}= enum
    ## A pure enum type for the various "submaps" of the backgrounds.
    ## Used for various changes to the background offsets, and for determining which
    ## collision function(s) to use.
    sectionOne
    sectionTwo
    sectionThree
    sectionFour
    sectionFive
    sectionSix

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