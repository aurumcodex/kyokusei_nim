##[
  極性 -Kyokusei- (Nim)
  =====================
  Date Modified: 2019-11-25

  ## [Enemy Data File]
  A file used to hold the enemy data.

  ## [License]
  MIT Licensed. View LICENSE file for details.
]##

var slime = Enemy(
  objID: 3,
  spriteIndex: 549'u16,
  animState: asIdle,
  lookDir: LookDir.Left,
  HP: 10,
  damage: 2,
  pos: vec2i(SCREEN_WIDTH-20, SCREEN_HEIGHT-20),
  height: 16,
  width: 16,
  scoreValue: 10,
  aiType: EnemyAI.Slime,
  visible: false
)

var chroncha = Enemy(
  objID: 4,
  spriteIndex: 527'u16,
  animState: asIdle,
  lookDir: LookDir.Left,
  HP: 10,
  damage: 2,
  pos: vec2i(40, 40),
  height: 16,
  width: 16,
  scoreValue: 20,
  aiType: EnemyAI.Chroncha,
  visible: false
)

var naniteWave = Enemy(
  objID: 5,
  spriteIndex: 713'u16,
  animState: asIdle,
  lookDir: LookDir.Left,
  HP: 10,
  damage: 2,
  pos: vec2i(90, 90),
  height: 64,
  width: 64,
  scoreValue: 50,
  aiType: EnemyAI.NaniteWave,
  visible: false
)

var trent = Enemy(
  objID: 6,
  spriteIndex: 527'u16,
  animState: asIdle,
  lookDir: LookDir.Left,
  HP: 10,
  damage: 2,
  pos: vec2i(40, 90),
  height: 32,
  width: 16,
  scoreValue: 20,
  aiType: EnemyAI.Trent,
  visible: false
)

var sentryL = Enemy(
  objID: 7,
  spriteIndex: 539'u16,
  animState: asIdle,
  lookDir: LookDir.Left,
  HP: 10,
  damage: 2,
  pos: vec2i(16, 90),
  height: 16,
  width: 16,
  scoreValue: 15,
  aiType: EnemyAI.Sentry,
  visible: false
)

var sentryR = Enemy(
  objID: 8,
  spriteIndex: 539'u16,
  animState: asIdle,
  lookDir: LookDir.Right,
  HP: 10,
  damage: 2,
  pos: vec2i(30, 90),
  height: 16,
  width: 16,
  scoreValue: 15,
  aiType: EnemyAI.Sentry,
  visible: false
)

var pumpkin = Enemy(
  objID: 9,
  spriteIndex: 612'u16,
  animState: asIdle,
  lookDir: LookDir.Left,
  HP: 10,
  damage: 2,
  pos: vec2i(150, 16),
  height: 32,
  width: 32,
  scoreValue: 777,
  aiType: EnemyAI.Pumpkin,
  visible: false
)