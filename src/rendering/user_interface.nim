##[
  極性 -Kyokusei- (Nim)
  =====================
  Date Modified: 2019-11-25

  ## [User Interface File]
  A file used for incorporating the sprite data and background data
  into user-made memory loading functions.

  ## [License]
  MIT Licensed. View LICENSE file for details.
]##

const heartSprite: uint16 = 713
const damageSprite: uint16 = 714

var heart1 = UserInterface(
  actorType: ActorType.UserInterface,
  objID: 20,
  spriteIndex: heartSprite,
  pos: vec2i(0, 30),
  used: false
)

var heart2 = UserInterface(
  actorType: ActorType.UserInterface,
  objID: 21,
  spriteIndex: heartSprite,
  pos: vec2i(0, 38),
  used: false
)

var heart3 = UserInterface(
  actorType: ActorType.UserInterface,
  objID: 22,
  spriteIndex: heartSprite,
  pos: vec2i(0, 46),
  used: false
)

var heart4 = UserInterface(
  actorType: ActorType.UserInterface,
  objID: 23,
  spriteIndex: heartSprite,
  pos: vec2i(0, 54),
  used: false
)

var heart5 = UserInterface(
  actorType: ActorType.UserInterface,
  objID: 24,
  spriteIndex: heartSprite,
  pos: vec2i(0, 62),
  used: false
)

var hearts: array[0..4, UserInterface] = [heart1, heart2, heart3, heart4, heart5]

proc checkState*(hearts: var array[0..4, UserInterface], player: Player) =
  case player.HP:
    of 8..9:
      hearts[4].used = true
      hearts[4].spriteIndex = damageSprite
    of 6..7:
      hearts[3].used = true
      hearts[3].spriteIndex = damageSprite
    of 4..5:
      hearts[2].used = true
      hearts[2].spriteIndex = damageSprite
    of 2..3:
      hearts[1].used = true
      hearts[1].spriteIndex = damageSprite
    of 0..1:
      hearts[0].used = true
      hearts[0].spriteIndex = damageSprite
    else:
      discard