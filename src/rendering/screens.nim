##[
  極性 -Kyokusei- (Nim)
  =====================
  Date Modified: 2019-11-22

  ## [Screens File]
  A file for the functions used in moving the backgrounds around on the screen.

  ## [License]
  MIT Licensed. View LICENSE file for details.
]##

import ../actors
import ../geometry

proc shiftScreenUp*(player: var Player, bgVec: var Offsets, room: var Room) =
  ## Helper function to shift the screen upwards.
  var section: uint = 0
  case room.submap:
  of Submap.sectionOne:
    bgVec.yOffset -= SCREEN_HEIGHT + 32      # plus 32 due to wrap around, and how the screens move.
    REG_BG1VOFS = cast[uint16](bgVec.yOffset)
    player.pos.y = SCREEN_HEIGHT - player.height
    room.submap = Submap.sectionFive
  of Submap.sectionTwo:
    bgVec.yOffset -= SCREEN_HEIGHT + 32      # plus 32 due to wrap around, and how the screens move.
    REG_BG1VOFS = cast[uint16](bgVec.yOffset)
    player.pos.y = SCREEN_HEIGHT - player.height
    room.submap = Submap.sectionSix
  of Submap.sectionThree:
    bgVec.yOffset -= SCREEN_HEIGHT
    REG_BG1VOFS = cast[uint16](bgVec.yOffset)
    player.pos.y = SCREEN_HEIGHT - player.height
    room.submap = Submap.sectionOne
  of Submap.sectionFour:
    bgVec.yOffset -= SCREEN_HEIGHT
    REG_BG1VOFS = cast[uint16](bgVec.yOffset)
    player.pos.y = SCREEN_HEIGHT - player.height
    room.submap = Submap.sectionTwo
  of Submap.sectionFive:
    bgVec.yOffset -= SCREEN_HEIGHT
    REG_BG1VOFS = cast[uint16](bgVec.yOffset)
    player.pos.y = SCREEN_HEIGHT - player.height
    room.submap = Submap.sectionThree
  of Submap.sectionSix:
    bgVec.yOffset -= SCREEN_HEIGHT
    REG_BG1VOFS = cast[uint16](bgVec.yOffset)
    player.pos.y = SCREEN_HEIGHT - player.height
    room.submap = Submap.sectionFour
  
proc shiftScreenRight*(player: var Player, bgVec: var Offsets, room: var Room) =
  ## Helper function to shift the screen rightwards.
  bgVec.xOffset += SCREEN_WIDTH
  REG_BG1HOFS = cast[uint16](bgVec.xOffset)
  player.pos.x = 0
  case room.submap:
  of Submap.sectionOne:
    room.submap = Submap.sectionTwo
  of Submap.sectionThree:
    room.submap = Submap.sectionFour
  of Submap.sectionFive:
    room.submap = Submap.sectionSix
  else:
    discard
    
proc shiftScreenLeft*(player: var Player, bgVec: var Offsets, room: var Room) =
  ## Helper function to shift the screen leftwards.
  bgVec.xOffset -= SCREEN_WIDTH
  REG_BG1HOFS = cast[uint16](bgVec.xOffset)
  player.pos.x = (SCREEN_WIDTH - player.width) - 1
  case room.submap:
  of Submap.sectionTwo:
    room.submap = Submap.sectionOne
  of Submap.sectionFour:
    room.submap = Submap.sectionThree
  of Submap.sectionSix:
    room.submap = Submap.sectionFive
  else:
    discard
    
proc shiftScreenDown*(player: var Player, bgVec: var Offsets, room: var Room) =
  ## Helper function to shift the screen downwards.
  case room.submap:
  of Submap.sectionOne:
    bgVec.yOffset += SCREEN_HEIGHT
    REG_BG1VOFS = cast[uint16](bgVec.yOffset)
    player.pos.y = 1
    room.submap = Submap.sectionThree
  of Submap.sectionTwo:
    bgVec.yOffset += SCREEN_HEIGHT
    REG_BG1VOFS = cast[uint16](bgVec.yOffset)
    player.pos.y = 1
    room.submap = Submap.sectionFour
  of Submap.sectionThree:
    bgVec.yOffset += SCREEN_HEIGHT
    REG_BG1VOFS = cast[uint16](bgVec.yOffset)
    player.pos.y = 1
    room.submap = Submap.sectionFive
  of Submap.sectionFour:
    bgVec.yOffset += SCREEN_HEIGHT
    REG_BG1VOFS = cast[uint16](bgVec.yOffset)
    player.pos.y = 1
    room.submap = Submap.sectionSix
  of Submap.sectionFive:
    bgVec.yOffset += SCREEN_HEIGHT + 32      # plus 32 due to wrap around, and how the screens move.
    REG_BG1VOFS = cast[uint16](bgVec.yOffset)
    player.pos.y = 1
    room.submap = Submap.sectionOne
  of Submap.sectionSix:
    bgVec.yOffset += SCREEN_HEIGHT + 32      # plus 32 due to wrap around, and how the screens move.
    REG_BG1VOFS = cast[uint16](bgVec.yOffset)
    player.pos.y = 1
    room.submap = Submap.sectionTwo
    
proc moveScreen*(player: var Player, bgVec: var Offsets, room: var Room) =
  ## Function to move the displayed Submap.section(s) of the mapping data of the backgrounds
  case room.submap:
  of Submap.sectionOne:
    if player.pos.x+player.width == SCREEN_WIDTH:
      shiftScreenRight(player, bgVec, room)
    if player.pos.y == 0:
      shiftScreenUp(player, bgVec, room)
    elif player.pos.y + player.height == SCREEN_HEIGHT:
      shiftScreenDown(player, bgVec, room)
    
  of Submap.sectionTwo:
    if player.pos.x == 0:
      shiftScreenLeft(player, bgVec, room)
    if player.pos.y == 0:
      shiftScreenUp(player, bgVec, room)
    elif player.pos.y + player.height == SCREEN_HEIGHT:
      shiftScreenDown(player, bgVec, room)
    
  of Submap.sectionThree:
    if player.pos.x + player.width == SCREEN_WIDTH:
      shiftScreenRight(player, bgVec, room)
    if player.pos.y == 0:
      shiftScreenUp(player, bgVec, room)
    elif player.pos.y + player.height == SCREEN_HEIGHT:
      shiftScreenDown(player, bgVec, room)
    
  of Submap.sectionFour:
    if player.pos.x == 0:
      shiftScreenLeft(player, bgVec, room)
    if player.pos.y == 0:
      shiftScreenUp(player, bgVec, room)
    elif player.pos.y + player.height == SCREEN_HEIGHT:
      shiftScreenDown(player, bgVec, room)
    
  of Submap.sectionFive:
    if player.pos.x+player.width == SCREEN_WIDTH:
      shiftScreenRight(player, bgVec, room)
    if player.pos.y == 0:
      shiftScreenUp(player, bgVec, room)
    elif player.pos.y + player.height == SCREEN_HEIGHT:
      shiftScreenDown(player, bgVec, room)
  
  of Submap.sectionSix:
    if player.pos.x == 0:
      shiftScreenLeft(player, bgVec, room)
    if player.pos.y == 0:
      shiftScreenUp(player, bgVec, room)
    elif player.pos.y + player.height == SCREEN_HEIGHT:
      shiftScreenDown(player, bgVec, room)