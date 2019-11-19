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