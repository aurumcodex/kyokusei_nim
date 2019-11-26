##[
  極性 -Kyokusei- (Nim)
  =====================
  Date Modified: 2019-11-25

  ## [Actors File]
  A file used for various characters and things that the user can interact
  with and/or control.

  ## [License]
  MIT Licensed. View LICENSE file for details.
]##

import tonc

import collision
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
    UserInterface

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
    lookDir*: LookDir
    velocity*: uint
    pos*: Vec2i
    damage*: int
    height*: uint
    width*: uint
    isEcho*: bool
    isBullet*: bool
    visible*: bool
    used*: bool

type
  Player* = object
    ## A Player data type that holds various points of data.
    actorType*: ActorType
    objID*: uint8
    spriteIndex*: uint16
    animState*: AnimState
    lookDir*: LookDir
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
    visible*: bool
    takingDamage*: bool

type
  Dummy* = object
    ## An NPC type of actor. Does absolutely nothing but stand around.
    actorType*: ActorType
    objID*: uint8
    spriteIndex*: uint16
    pos*: Vec2i

type
  Enemy* = object
    ## An Enemy data type that holds various points of data.
    actorType*: ActorType
    objID*: uint8
    spriteIndex*: uint16
    animState*: AnimState
    lookDir*: LookDir
    HP*: int
    damage*: int
    pos*: Vec2i
    height*: int
    width*: int
    scoreValue*: uint
    aiType*: EnemyAI
    visible*: bool
    isEcho*: bool
    isBullet*: bool

type
  Item* = object
    ## An Item data type to hold data for an item's position on screen,
    ## and if it's been picked up or not.
    actorType*: ActorType
    objID*: uint8
    spriteIndex*: uint16
    lookDir*: LookDir
    pos*: Vec2i
    height*: int
    width*: int
    visible*: bool
    isEcho*: bool
    isBullet*: bool

type
  UserInterface* = object
    ## A data type to hold some information about the user interface.
    actorType*: ActorType
    objID*: uint8
    spriteIndex*: uint16
    pos*: Vec2i
    used*: bool

proc manhattanDistance*[T, U](obj: T, target: U): int =
  ## Function to asisst in determining the shortest distance to the target sprite from a source sprite.
  return abs(obj.pos.x - target.pos.x) + abs(obj.pos.y - target.pos.y)

proc takeProjectileDamage*[T](obj: T, projectile: Projectile) =
  if obj.hasCollided(projectile):
    obj.HP -= projectile.damage

proc enemyCollision*(player: var Player, enemy: var Enemy, frames: uint) =
  ## Detects if the player has collided with an enemy sprite, and deals damage.
  if player.hasCollided(enemy, frames) and frames mod 2 == 0:
    tteWrite("ouch")
    if player.polarity == Polarity.Keen:
      if enemy.HP > 0:
        enemy.HP -= player.damage
      else:
        enemy.HP = enemy.HP
    else:
      if not (enemy.aiType == EnemyAI.Pumpkin):
        if player.HP >= 0:
          player.HP -= enemy.damage

proc collectItem*(player: var Player, item: var Item) =
  item.visible = false
  if player.HP < 10 and player.HP > 0:
    player.HP += 2

proc checkHealth*[T](obj: var T) =
  if obj.HP <= 0:
    obj.visible = false
  else:
    obj.visible = true