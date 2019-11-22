##[
  極性 -Kyokusei- (Nim)
  =====================
  Date Modified: 2019-11-21

  ## [Projectile Data File]
  A file used *only* for holding the data for the projectiles.

  ## [License]
  MIT Licensed. View LICENSE file for details.
]##

import tonc

import ../actors

const bulletSprite: uint16 = 638

var bullet1 = Projectile(
    objID: 9,
    spriteIndex: bulletSprite,
    velocity: 4,
    pos: vec2i(player.pos.x+player.width, player.pos.y+(player.height div 2)),
    height: 8,
    width: 8,
    isBullet: true,
    visible: false
)

var bullet2 = Projectile(
    objID: 10,
    spriteIndex: bulletSprite,
    velocity: 4,
    pos: vec2i(player.pos.x+player.width, player.pos.y+(player.height div 2)),
    height: 8,
    width: 8,
    isBullet: true,
    visible: false
)

var bullet3 = Projectile(
    objID: 11,
    spriteIndex: bulletSprite,
    velocity: 4,
    pos: vec2i(player.pos.x+player.width, player.pos.y+(player.height div 2)),
    height: 8,
    width: 8,
    isBullet: true,
    visible: false
)

var bullet4 = Projectile(
    objID: 12,
    spriteIndex: bulletSprite,
    velocity: 4,
    pos: vec2i(player.pos.x+player.width, player.pos.y+(player.height div 2)),
    height: 8,
    width: 8,
    isBullet: true,
    visible: false
)

var bullet5 = Projectile(
    objID: 13,
    spriteIndex: bulletSprite,
    velocity: 4,
    pos: vec2i(player.pos.x+player.width, player.pos.y+(player.height div 2)),
    height: 8,
    width: 8,
    isBullet: true,
    visible: false
)

var bullet6 = Projectile(
    objID: 14,
    spriteIndex: bulletSprite,
    velocity: 4,
    pos: vec2i(player.pos.x+player.width, player.pos.y+(player.height div 2)),
    height: 8,
    width: 8,
    isBullet: true,
    visible: false
)

var bullet7 = Projectile(
    objID: 15,
    spriteIndex: bulletSprite,
    velocity: 4,
    pos: vec2i(player.pos.x+player.width, player.pos.y+(player.height div 2)),
    height: 8,
    width: 8,
    isBullet: true,
    visible: false
)