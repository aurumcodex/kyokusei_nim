##[
  極性 -Kyokusei- (Nim)
  =====================
  Date Modified: 2019-11-25

  ## [Render Enemy File]
  A file used for the rendering of enemies within certain rooms.
  ** Meant to be Included

  ## [License]
  MIT Licensed. View LICENSE file for details.
]##

include ../logic/enemy_ai

proc renderRoomEnemy*(enemy: var Enemy) =
  ## Renders the room with a given enemy type.
  case enemy.EnemyAI:
  of EnemyAI.Slime:
    
