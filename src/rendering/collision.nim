##[
  極性 -Kyokusei- (Nim)
  =====================
  Date Modified: 2019-10-24

  ## [Collision File]
  A file used for determining collision and other functions.
  (dummy file)

  ## [License]
  MIT Licensed. View LICENSE file for details.
]##

import tonc

import ../actors
import ../geometry

from ../rendering import Room, RoomId

proc roomOneCollision[T](player: var T, submap: Submap): bool =
  ## This is *extremely* crude, but since the nim-tonc doesn't fully wrap the tonclib perfectly,
  ## this is what will be used for determining collision within the first room.
  case submap:
  of sectionOne:
    if player.pos.x == 12:
      player.pos.x = 13
      # tteEraseScreen()
      # tteWrite("#{P:120,80} collision")
      return true
    if player.pos.y + player.height == SCREEN_HEIGHT - 15:
      player.pos.y = SCREEN_HEIGHT - player.height - 17
      # tteWrite("#{P:120,0} collision")
      return true
      
  of sectionTwo:
    if player.pos.x + player.width <= 64:
      if (player.pos.x + player.width) == 64:
        player.pos.x = 63 - player.width
        return true
      if player.pos.y + player.height == SCREEN_HEIGHT - 15:
        player.pos.y = SCREEN_HEIGHT - player.height - 17
        return true
        
    if player.pos.x >= 127 and player.pos.x+player.width <= SCREEN_WIDTH - player.width:     
      if player.pos.x == 127:
        player.pos.x = 128
        return true
      if (player.pos.x + player.width) == SCREEN_WIDTH - 16:
        player.pos.x = ((SCREEN_WIDTH - 16) - player.width) - 1
        return true
      if (player.pos.y + player.height) == 18 and (player.pos.x >= 152 and player.pos.x <= SCREEN_WIDTH - 16):
        player.pos.y = 17 - player.height
        return true
      if player.pos.y == 23 and (player.pos.x >= 152 and player.pos.x <= SCREEN_WIDTH - 16):
        player.pos.y = 23 - player.height
        return true
      if (player.pos.x + player.width) == 152 and (player.pos.y >= 17 and player.pos.y <= 23):
        player.pos.x = 152 - player.width
        return true
      if (player.pos.y + player.height) == 64 and (player.pos.x >= 152 and player.pos.x <= 192):
        player.pos.y = 64 - player.height
        return true

  of sectionThree:
    if player.pos.x == 16:
      player.pos.x = 17
      return true

    if player.pos.x >= 177:
      if player.pos.y + player.height == SCREEN_HEIGHT - 8:
        player.pos.y = ((SCREEN_HEIGHT - 8) - player.height) - 1
        return true

    if player.pos.x == 177 and 
      (player.pos.y + player.height >= 24 and player.pos.y + player.height <= SCREEN_HEIGHT - 8):
      player.pos.x = 178
      return true

  of sectionFour:
    if player.pos.x + player.width == SCREEN_WIDTH - 16:
      player.pos.x = ((SCREEN_WIDTH - 16) - player.width) - 1
      return true
    if (player.pos.x == 127 and
        ((player.pos.y <= 5) or (player.pos.y + player.height >= SCREEN_HEIGHT - 8))):
      player.pos.x = 128
      return true
    if player.pos.y + player.height == SCREEN_HEIGHT - 4:
      player.pos.y = (SCREEN_HEIGHT - 4) - player.height
      return true

    if player.pos.x >= 0 and player.pos.x + player.width <= 128:
      if player.pos.y == 4:
        player.pos.y = 5
        return true
      if player.pos.y + player.height == SCREEN_HEIGHT - 8:
        player.pos.y = ((SCREEN_HEIGHT - 8) - player.height) - 1
        return true

  else:
    return false


proc backgroundCollision*[T](player: var T, room: Room): bool =
  case room.roomID:
    of riOne:
      case room.submap:
      of Submap.sectionOne:
        return roomOneCollision(player, Submap.sectionOne)
      of Submap.sectionTwo:
        return roomOneCollision(player, Submap.sectionTwo)
      of Submap.sectionThree:
        return roomOneCollision(player, Submap.sectionThree)
      of Submap.sectionFour:
        return roomOneCollision(player, Submap.sectionFour)
      of Submap.sectionFive:
        return roomOneCollision(player, Submap.sectionFive)
      of Submap.sectionSix:
        return roomOneCollision(player, Submap.sectionSix)

    else:
      discard
