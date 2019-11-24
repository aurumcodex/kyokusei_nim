##[
  極性 -Kyokusei- (Nim)
  =====================
  Date Modified: 2019-11-24

  ## [Collision File]
  A file used for determining collision for any sprites that are classified as `obj`.

  ## [License]
  MIT Licensed. View LICENSE file for details.
]##

import tonc

import actors
import geometry

from rendering import Room, RoomId

#[Object Collision]#
proc xCollision[T,U](obj: T, target: U): bool =
  ## Generic function to detect if collision occurs in terms of X position.
  return ((target.pos.x > obj.pos.x) and (target.pos.x < obj.pos.x+obj.width)) or
         ((target.pos.x+target.width > obj.pos.x) and (target.pos.x+target.width < obj.pos.x+obj.width))

proc yCollision[T,U](obj: T, target: U): bool =
  ## Generic function to detect if collision occurs in terms of Y position.
  return ((target.pos.y > obj.pos.y) and (target.pos.y < obj.pos.y+obj.height)) or
         ((target.pos.y+target.height > obj.pos.y) and (target.pos.y+target.height < obj.pos.y+obj.height))

proc hasCollided*[T,U](obj: T, target: U, frames: uint): bool =
  ## A generic function to determine if something has collided with something else.
  if frames mod 2 == 0:
    result = xCollision(obj, target) and yCollision(obj, target)


#[Background Collision]#
proc roomOneCollision[T](obj: var T, submap: Submap): bool =
  ## A generic function for determining 
  ## This is *extremely* crude, but since the nim-tonc doesn't fully wrap the tonclib perfectly,
  ## this is what will be used for determining collision within the first room.
  ## Collision detection for backgrounds is quite a bit harder than object sprite collision,
  ## and is no where as clean as the Unreal Engine's implementation(s) for it.
  case submap:
  #[Section One Collision]#
  of Submap.sectionOne:
    if obj.pos.x == 12:
      obj.pos.x = 13
      return true
    if obj.pos.y + obj.height == SCREEN_HEIGHT - 15:
      obj.pos.y = SCREEN_HEIGHT - obj.height - 17
      return true

  #[Section Two Collision]#
  of Submap.sectionTwo:
    if obj.pos.x + obj.width <= 64:
      if (obj.pos.x + obj.width) == 64:
        obj.pos.x = 63 - obj.width
        return true
      if obj.pos.y + obj.height == SCREEN_HEIGHT - 15:
        obj.pos.y = SCREEN_HEIGHT - obj.height - 17
        return true
        
    if obj.pos.x >= 127 and obj.pos.x+obj.width <= SCREEN_WIDTH - obj.width:     
      if obj.pos.x == 127:
        obj.pos.x = 128
        return true
      if (obj.pos.x + obj.width) == SCREEN_WIDTH - 16:
        obj.pos.x = ((SCREEN_WIDTH - 16) - obj.width) - 1
        return true
      if (obj.pos.x + obj.width >= 152 and obj.pos.x <= SCREEN_WIDTH - 16):
        if obj.pos.y + obj.height == 40:
          obj.pos.y = (40 - obj.height) - 1
        if obj.pos.y == 48:
          obj.pos.y = 49
          return true
      if (obj.pos.y + obj.height) >= 40 and (obj.pos.y <= 48):
        if obj.pos.x + obj.width == 152:
          obj.pos.x = (152 - obj.width) - 1
          return true
      if (obj.pos.x + obj.width) == 152 and (obj.pos.y >= 17 and obj.pos.y <= 23):
        obj.pos.x = (152 - obj.width) - 1
        return true
      if (obj.pos.x >= 127 and obj.pos.x <= 192):
        if obj.pos.y + obj.height == 88:
          obj.pos.y = (88 - obj.height) - 1
        if obj.pos.y == 95:
          obj.pos.y = 96
          return true
      if obj.pos.y + obj.height >= 88 and (obj.pos.y <= 95):
        if obj.pos.x == 192:
          obj.pos.x = 193
          return true

  #[Section Three Collision]#
  of Submap.sectionThree:
    if obj.pos.x == 16:
      obj.pos.x = 17
      return true
    if obj.pos.y == 4:
      obj.pos.y = 5
      return true
    if obj.pos.x >= 176:
      if obj.pos.y + obj.height == SCREEN_HEIGHT - 8:
        obj.pos.y = ((SCREEN_HEIGHT - 8) - obj.height) - 1
        return true
    if obj.pos.x == 176 and 
      (obj.pos.y + obj.height >= 24 and obj.pos.y + obj.height <= SCREEN_HEIGHT - 8):
      obj.pos.x = 177
      return true
    if obj.pos.x >= 176 and obj.pos.x <= 200:
      if obj.pos.y + obj.height == 51:
        obj.pos.y = 50 - obj.height
        return true
    if obj.pos.x + obj.width >= 48 and obj.pos.x + obj.width <= 176:
      if obj.pos.y + obj.height == 24:
        obj.pos.y = (24 - obj.height) - 1
        return true
    if obj.pos.x + obj.width >= 48 and obj.pos.x + obj.width <= 176:
      if obj.pos.y == 40:
        obj.pos.y = 41
        return true
    if obj.pos.y + obj.height >= 24 and obj.pos.y <= 40:
      if obj.pos.x + obj.width == 48:
        obj.pos.x = (47 - obj.width)
        return true
    if obj.pos.y + obj.height >= 72 and obj.pos.y <= 88:
      if obj.pos.x == 102:
        obj.pos.x = 103
        return true
    if obj.pos.y > 40:
      if obj.pos.x + obj.width == 160:
        obj.pos.x = (160 - obj.width) - 1
        return true
    if obj.pos.x >= 16 and obj.pos.x <= 102:
      if obj.pos.y + obj.height == 72:
        obj.pos.y = (72 - obj.height) - 1
        return true
      if obj.pos.y == 88:
        obj.pos.y = 89
        return true

  #[Section Four Collision]#
  of Submap.sectionFour:
    if obj.pos.x + obj.width == SCREEN_WIDTH - 16:
      obj.pos.x = ((SCREEN_WIDTH - 16) - obj.width) - 1
      return true
    if (obj.pos.x == 127 and
        ((obj.pos.y <= 5) or (obj.pos.y + obj.height >= SCREEN_HEIGHT - 8))):
      obj.pos.x = 128
      return true
    if obj.pos.y + obj.height == SCREEN_HEIGHT - 4:
      obj.pos.y = ((SCREEN_HEIGHT - 4) - obj.height) - 1
      return true

    if obj.pos.x >= 0 and obj.pos.x #[+ obj.width]# <= 128:
      if obj.pos.y == 4:
        obj.pos.y = 5
        return true
      if obj.pos.y + obj.height == SCREEN_HEIGHT - 8:
        obj.pos.y = ((SCREEN_HEIGHT - 8) - obj.height) - 1
        return true
    
    if obj.pos.x + obj.width >= 160 and obj.pos.x + obj.width <= SCREEN_WIDTH - 16:
      if obj.pos.y + obj.height == 48:
        obj.pos.y = (48 - obj.height) - 1
        return true
      if obj.pos.y == 56:
        obj.pos.y = 57
        return true

    if obj.pos.y + obj.height >= 48 and obj.pos.y <= 56:
      if obj.pos.x + obj.width == 160:
        obj.pos.x = (160 - obj.width) - 1
        return true

  #[Section Five Collision]#
  of Submap.sectionFive:
    if obj.pos.y > 70:
      if obj.pos.x == 12:
        obj.pos.x = 13
        return true
      if obj.pos.y == 124:
        obj.pos.y = 125
        return true
      
    else:
      if obj.pos.x == 16:
        obj.pos.x = 17
        return true
      if obj.pos.y + obj.height == 48:
        obj.pos.y = (47 - obj.height)
        return true
      if obj.pos.y == 8:
        if obj.pos.x + obj.width == 160:
          obj.pos.y = 8
          return true
      
      if obj.pos.x + obj.width == 160 and obj.pos.y <= 8:
        obj.pos.x = (160 - obj.width) - 1
        return true
      elif obj.pos.x + obj.width >= 160:
        if obj.pos.y == 8:
          obj.pos.y = 9
          return true

  #[Section Six Collision]#
  of Submap.sectionSix:
    if obj.pos.y > 70:
      if obj.pos.x + obj.width == SCREEN_WIDTH - 16:
        obj.pos.x = ((SCREEN_WIDTH - 16) - obj.width) - 1
        return true
      if obj.pos.x + obj.width == SCREEN_WIDTH - 16:
        obj.pos.x = (SCREEN_WIDTH - 16) - obj.width
        return true
      if obj.pos.x >= 32 and obj.pos.x + obj.width <= 200:
        if obj.pos.y == 116:
          obj.pos.y = 117
          return true
        if obj.pos.x == 32:
          # if obj.pos.y == 116:
          obj.pos.x = 33
          return true
        if obj.pos.x + obj.width == (SCREEN_WIDTH - 40):
          # if obj.pos.y == 116:
          obj.pos.x = ((SCREEN_WIDTH - 40) - obj.width) - 1
          return true
      if (obj.pos.x >= 0 and obj.pos.x <= 32) or (obj.pos.x >= (SCREEN_WIDTH - 40)):
        if obj.pos.y == 124:
          obj.pos.y = 125
          return true
      if obj.pos.x >= 64 and obj.pos.x <= 128:
        if obj.pos.y + obj.height == SCREEN_HEIGHT - 8:
          obj.pos.y = ((SCREEN_HEIGHT - 8) - obj.height) - 1
          return true
      if obj.pos.y + obj.height >= SCREEN_HEIGHT - 8 and obj.pos.y + obj.height <= SCREEN_HEIGHT:
        if obj.pos.x + obj.width == 64:
          obj.pos.x = 63 - obj.width
          return true
        if obj.pos.x == 128:
          obj.pos.x = 129
          return true
      # if obj.pos.x >= 32 and obj.pos.x + obj.width <= 200:
      #   if 
    else:
      if obj.pos.y == 8:
        obj.pos.y = 9
        return true
      if obj.pos.y + obj.height == 48:
        obj.pos.y = (48 - obj.height) - 1
        return true
      if obj.pos.x == SCREEN_WIDTH:
        # renderVictory()
        discard # discard for now

proc backgroundCollision*[T](obj: var T, room: Room): bool =
  ## Genericized function for determining if an object sprite has collided with
  ## certain areas of the background.
  case room.roomID:
    of riOne:
      case room.submap:
      of Submap.sectionOne:
        return roomOneCollision(obj, Submap.sectionOne)
      of Submap.sectionTwo:
        return roomOneCollision(obj, Submap.sectionTwo)
      of Submap.sectionThree:
        return roomOneCollision(obj, Submap.sectionThree)
      of Submap.sectionFour:
        return roomOneCollision(obj, Submap.sectionFour)
      of Submap.sectionFive:
        return roomOneCollision(obj, Submap.sectionFive)
      of Submap.sectionSix:
        return roomOneCollision(obj, Submap.sectionSix)

    else:
      # discard, since the rest of the functions for the other backgrounds haven't been implemented.
      discard

