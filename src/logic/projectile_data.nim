##[
  極性 -Kyokusei- (Nim)
  =====================
  Date Modified: 2019-11-24

  ## [Projectile Data File]
  A file used *only* for holding the data for the projectiles.

  ## [License]
  MIT Licensed. View LICENSE file for details.
]##

import tonc

import ../actors

const bulletSprite: uint16 = 638
const bladeSlashSprite: uint16 = 631

var bullet1 = Projectile(
  objID: 1,
  spriteIndex: bulletSprite,
  velocity: 4,
  pos: vec2i(0, 0),
  height: 8,
  width: 8,
  isBullet: true,
  visible: false,
  used: false
)

var bullet2 = Projectile(
  objID: 2,
  spriteIndex: bulletSprite,
  velocity: 4,
  pos: vec2i(0, 0),
  height: 8,
  width: 8,
  isBullet: true,
  visible: false,
  used: false
)

var bullet3 = Projectile(
  objID: 3,
  spriteIndex: bulletSprite,
  velocity: 4,
  pos: vec2i(0, 0),
  height: 8,
  width: 8,
  isBullet: true,
  visible: false,
  used: false
)

var bullet4 = Projectile(
  objID: 4,
  spriteIndex: bulletSprite,
  velocity: 4,
  pos: vec2i(0, 0),
  height: 8,
  width: 8,
  isBullet: true,
  visible: false,
  used: false
)

var bullet5 = Projectile(
  objID: 5,
  spriteIndex: bulletSprite,
  velocity: 4,
  pos: vec2i(0, 0),
  height: 8,
  width: 8,
  isBullet: true,
  visible: false,
  used: false
)

var bladeSlash1 = Projectile(
  objID: 6,
  spriteIndex: bladeSlashSprite,
  velocity: 4,
  pos: vec2i(0, 0),
  height: 16,
  width: 16,
  isBullet: false,
  visible: false,
  used: false
)

var bladeSlash2 = Projectile(
  objID: 7,
  spriteIndex: bladeSlashSprite,
  velocity: 4,
  pos: vec2i(0, 0),
  height: 16,
  width: 16,
  isBullet: false,
  visible: false,
  used: false
)

var bladeSlash3 = Projectile(
  objID: 8,
  spriteIndex: bladeSlashSprite,
  velocity: 4,
  pos: vec2i(0, 0),
  height: 16,
  width: 16,
  isBullet: false,
  visible: false,
  used: false
)

var bladeSlash4 = Projectile(
  objID: 9,
  spriteIndex: bladeSlashSprite,
  velocity: 4,
  pos: vec2i(0, 0),
  height: 16,
  width: 16,
  isBullet: false,
  visible: false,
  used: false
)

var bladeSlash5 = Projectile(
  objID: 10,
  spriteIndex: bladeSlashSprite,
  velocity: 4,
  pos: vec2i(0, 0),
  height: 16,
  width: 16,
  isBullet: false,
  visible: false,
  used: false
)

var bulletList*: array[0..4,Projectile] = [bullet1,
                                           bullet2,
                                           bullet3,
                                           bullet4,
                                           bullet5]

var bladeSlashList*: array[0..4,Projectile] = [bladeSlash1,
                                               bladeSlash2,
                                               bladeSlash3,
                                               bladeSlash4,
                                               bladeSlash5]