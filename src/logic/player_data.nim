##[
  極性 -Kyokusei- (Nim)
  =====================
  Date Modified: 2019-11-25

  ## [Player Data File]
  A file used to hold the player data.

  ## [License]
  MIT Licensed. View LICENSE file for details.
]##

var player = Player(
  objID: 0,
  spriteIndex: EchoSprite,
  animState: asIdle,
  lookDir: LookDir.Left,
  HP: 10,
  ammoCount: 5,
  damage: 10,
  pos: vec2i(20, 10),
  height: 32, # 32 when playing as Echo, 16 as Era
  width: 16,
  gravity: Gravity.Normal,
  polarity: Polarity.Impulse,
  verticalMove: false,
  isEcho: true,
  visible: true,
  takingDamage: false
)

include projectile_data

player.ammoList = bladeSlashList