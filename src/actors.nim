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
  Stats* = object
    maxHP: int
    maxAP: int
    atk: int
    def: int

type
  AnimState* = enum
    asIdle
    asMove

type
  Player* = object
    ## A Player data type that holds various points of data.
    objID*: uint
    spriteIndex*: uint16
    HP*: int
    AP*: int
    pos*: Vec2i
    height*: int
    width*: int
    # bounds: Box
    stats: Stats
    gravity*: Gravity
    polarity*: Polarity

type
  Enemy* = object
    ## An Enemy data type that holds various points of data.
    objID*: uint8
    spriteIndex*: uint16
    animState*: AnimState
    HP*: int
    AP*: int
    pos*: Vec2i
    height*: int
    width*: int
    stats: Stats
    
proc manhattanDistance*(player: Player, enemy: Enemy): int =
  ## Function to asisst in determining the shortest distance to the player sprite from an enemy.
  result = abs(player.pos.x - enemy.pos.x) + abs(player.pos.y - player.pos.y)
    
proc xCollision*(p: Player, e: Enemy): bool =
  ## Detect if collision occurs in terms of X position.
  return ((e.pos.x > p.pos.x) and (e.pos.x < p.pos.x+p.width)) or
         ((e.pos.x+e.width > p.pos.x) and (e.pos.x+e.width < p.pos.x+p.width))

proc yCollision*(p: Player, e: Enemy): bool =
  ## Detect if collision occurs in terms of Y position.
  return ((e.pos.y > p.pos.y) and (e.pos.y < p.pos.y+p.height)) or
         ((e.pos.y+e.height > p.pos.y) and (e.pos.y+e.height < p.pos.y+p.height))

proc hasCollided*(player: Player, enemy: Enemy, frames: uint): bool =
  ## A function to determine if the player has collided with any object sprites.
  if frames mod 2 == 0:
    result = xCollision(player, enemy) and yCollision(player, enemy)

proc roomOneCollision*(submap: Submap): bool =
  ## Checks the 
  return false

proc backgroundCollision*(player: var Player, frameCount: uint) =
  if frameCount mod 3 == 0:
    if player.pos.x <= 13:
      player.pos.x = 12
    # elif player.pos.x <= 304:
    #   player.pos.x = 304
    elif player.pos.y <= 1:
      player.pos.y = 0
    elif player.pos.y + player.height >= 144:
      player.pos.y = 144-player.height

