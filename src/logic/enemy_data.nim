#[enemy_data.nim :: dummy file]#

var slime = Enemy(
  objID: 3,
  spriteIndex: 549'u16,
  animState: asIdle,
  lookDir: LookDir.Left,
  HP: 10,
  damage: 2,
  pos: vec2i(50, 12),
  height: 16,
  width: 16,
  scoreValue: 10,
  aiType: EnemyAI.Slime,
  visible: true
)

var chroncha = Enemy(
  objID: 4,
  spriteIndex: 527'u16,
  animState: asIdle,
  lookDir: LookDir.Left,
  HP: 10,
  damage: 2,
  pos: vec2i(90, 90),
  height: 16,
  width: 16,
  scoreValue: 20,
  aiType: EnemyAI.Chroncha,
  visible: true
)

var naniteWave = Enemy(
  objID: 5,
  spriteIndex: 642'u16,
  animState: asIdle,
  lookDir: LookDir.Left,
  HP: 10,
  damage: 2,
  pos: vec2i(90, 90),
  height: 64,
  width: 64,
  scoreValue: 50,
  aiType: EnemyAI.NaniteWave,
  visible: true
)

var trent = Enemy(
  objID: 6,
  spriteIndex: 527'u16,
  animState: asIdle,
  lookDir: LookDir.Left,
  HP: 10,
  damage: 2,
  pos: vec2i(90, 90),
  height: 32,
  width: 16,
  scoreValue: 20,
  aiType: EnemyAI.Trent,
  visible: true
)

var sentryL = Enemy(
  objID: 7,
  spriteIndex: 539'u16,
  animState: asIdle,
  lookDir: LookDir.Left,
  HP: 10,
  damage: 2,
  pos: vec2i(90, 90),
  height: 16,
  width: 16,
  scoreValue: 15,
  aiType: EnemyAI.Sentry,
  visible: true
)

var sentryR = Enemy(
  objID: 8,
  spriteIndex: 539'u16,
  animState: asIdle,
  lookDir: LookDir.Right,
  HP: 10,
  damage: 2,
  pos: vec2i(90, 90),
  height: 16,
  width: 16,
  scoreValue: 15,
  aiType: EnemyAI.Sentry,
  visible: true
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
  visible: true
)