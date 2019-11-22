##[
  極性 -Kyokusei- (Nim)
  =====================
  Date Modified: 2019-11-21

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
  AnimState* = enum
    asIdle
    asMove

type
  Player* = object
    ## A Player data type that holds various points of data.
    objID*: uint
    spriteIndex*: uint16
    animState*: AnimState
    HP*: int
    ammoCount*: uint
    damage*: int
    pos*: Vec2i
    height*: int
    width*: int
    # gravity*: Gravity
    polarity*: Polarity


type
  Enemy* = object
    ## An Enemy data type that holds various points of data.
    objID*: uint8
    spriteIndex*: uint16
    animState*: AnimState
    HP*: int
    damage*: int
    pos*: Vec2i
    height*: int
    width*: int
    scoreValue*: uint

type
  Projectile* = object
    ## A Projectile data typethat serves as a struct to hold positional data, among other things.
    objID*: uint8
    spriteIndex*: uint16
    velocity*: uint
    pos*: Vec2i
    height*: uint
    width*: uint
    isBullet*: bool
    visible*: bool
    
proc manhattanDistance*(player: Player, enemy: Enemy): int =
  ## Function to asisst in determining the shortest distance to the player sprite from an enemy.
  result = abs(player.pos.x - enemy.pos.x) + abs(player.pos.y - player.pos.y)
    
proc xCollision*[T,U](a1: T, a2: U): bool =
  ## Generic function to detect if collision occurs in terms of X position.
  return ((a2.pos.x > a1.pos.x) and (a2.pos.x < a1.pos.x+a1.width)) or
         ((a2.pos.x+a2.width > a1.pos.x) and (a2.pos.x+a2.width < a1.pos.x+a1.width))

proc yCollision*[T,U](p: T, e: U): bool =
  ## Generic function to detect if collision occurs in terms of Y position.
  return ((e.pos.y > p.pos.y) and (e.pos.y < p.pos.y+p.height)) or
         ((e.pos.y+e.height > p.pos.y) and (e.pos.y+e.height < p.pos.y+p.height))

proc hasCollided*[T,U](a1: T, a2: U, frames: uint): bool =
  ## A generic function to determine if something has collided with something else.
  if frames mod 2 == 0:
    result = xCollision(a1, a2) and yCollision(a1, a2)

