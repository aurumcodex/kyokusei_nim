##[
  極性 -Kyokusei- (Nim)
  =====================
  Date Modified: 2019-11-23

  ## [Actors File]
  A file used for various characters and things that the user can interact
  with and/or control.

  ## [License]
  MIT Licensed. View LICENSE file for details.
]##

import tonc

import geometry

const EchoSprite*: uint16 = 518
const EraSprite*:  uint16 = 513

type
  LookDir* {.pure.} = enum
    ## A pure enum type to determine what direction the player is facing.
    Left
    Right

type
  Gravity* {.pure.} = enum
    ## A pure enum type to determine what gravity state to be in.
    Invert
    Normal

type
  Polarity* {.pure.} = enum
    ## A pure enum type to determine what polarity state to be in.
    Impulse
    Keen

type
  AnimState* = enum
    ## An enum type to determine if the sprite is in a moving state or not.
    asIdle
    asMove

type
  ActorType* {.pure.} = enum
    ## A pure enum type 
    Player
    Enemy
    Projectile
    Item

type
  EnemyAI* {.pure.} = enum
    ## A pure enum type to set which sprites will follow which AI patterns (as simple as they are).
    Slime
    Chroncha
    NaniteWave
    Trent
    Sentry
    Pumpkin

type
  Projectile* = object
    ## A Projectile data typethat serves as a struct to hold positional data, among other things.
    actorType*: ActorType
    objID*: uint8
    spriteIndex*: uint16
    velocity*: uint
    pos*: Vec2i
    height*: uint
    width*: uint
    isBullet*: bool
    visible*: bool
    used*: bool

type
  Player* = object
    ## A Player data type that holds various points of data.
    actorType*: ActorType
    objID*: uint
    spriteIndex*: uint16
    animState*: AnimState
    HP*: int
    ammoCount*: uint
    ammoList*: array[0..4, Projectile]
    damage*: int
    pos*: Vec2i
    height*: int
    width*: int
    gravity*: Gravity
    polarity*: Polarity
    verticalMove*: bool
    isEcho*: bool

type
  Dummy* = object
    

type
  Enemy* = object
    ## An Enemy data type that holds various points of data.
    actorType*: ActorType
    objID*: uint8
    spriteIndex*: uint16
    animState*: AnimState
    HP*: int
    damage*: int
    pos*: Vec2i
    height*: int
    width*: int
    scoreValue*: uint
    aiType*: EnemyAI
    visible*: bool

type
  Item* = object
    ## An Item data type to hold data for an item's position on screen,
    ## and if it's been picked up or not.
    actorType*: ActorType
    objID*: uint8
    spriteIndex*: uint16
    pos*: Vec2i
    height*: uint
    width*: uint
    visible*: bool
    used*: bool
    
proc manhattanDistance*[T, U](obj: T, target: U): int =
  ## Function to asisst in determining the shortest distance to the target sprite from a source sprite.
  result = abs(obj.pos.x - target.pos.x) + abs(obj.pos.y - target.pos.y)
    
proc xCollision*[T,U](obj: T, target: U): bool =
  ## Generic function to detect if collision occurs in terms of X position.
  return ((target.pos.x > obj.pos.x) and (target.pos.x < obj.pos.x+obj.width)) or
         ((target.pos.x+target.width > obj.pos.x) and (target.pos.x+target.width < obj.pos.x+obj.width))

proc yCollision*[T,U](obj: T, target: U): bool =
  ## Generic function to detect if collision occurs in terms of Y position.
  return ((target.pos.y > obj.pos.y) and (target.pos.y < obj.pos.y+obj.height)) or
         ((target.pos.y+target.height > obj.pos.y) and (target.pos.y+target.height < obj.pos.y+obj.height))

proc hasCollided*[T,U](obj: T, target: U, frames: uint): bool =
  ## A generic function to determine if something has collided with something else.
  if frames mod 2 == 0:
    result = xCollision(obj, target) and yCollision(obj, target)

