#[player_data.nim :: dummy file]#

var player = Player(
  objID: 0,
  spriteIndex: EchoSprite,
  animState: asIdle,
  lookDir: LookDir.Left,
  HP: 10,
  ammoCount: 5,
  # ammoList: bulletList,
  damage: 10,
  pos: vec2i(100, 10),
  height: 32, # 32 when playing as Echo, 16 as Era
  width: 16,
  gravity: Gravity.Normal,
  polarity: Polarity.Impulse,
  verticalMove: false,
  isEcho: true
)

include projectile_data

player.ammoList = bladeSlashList
# player.ammoList = bulletList