##[
  極性 -Kyokusei- (Nim)
  =====================
  Date Modified: 2019-11-25

  ## [Enemy AI File]
  A file used for bestowiung action instructions to the enemy sprites.
  (They aren't that smart, currently.)

  ## [License]
  MIT Licensed. View LICENSE file for details.
]##

import tonc

import ../actors
import ../collision
import ../geometry
import rngs

include enemy_data

proc genEnemy*(room: var Room): Enemy =
  case room.roomID:
  of riOne:
    case room.submap:
      of Submap.sectionOne:
        return naniteWave
      of Submap.sectionTwo:
        return trent
      of Submap.sectionThree:
        return sentryR
      of Submap.sectionFour:
        return slime
      of Submap.sectionFive:
        return trent
      of Submap.sectionSix:
        return pumpkin
  else:
    # Discard, due to the rest of the rooms not being implemented yet.
    discard


proc slimeAI*(enemy: var Enemy, rngState: var XorWowState, frames: uint, room: Room) =
  ## A function for executing the AI assigned to enemies using the Slime AI.
  var rng: uint = xorwowRNG(rngState)
  if enemy.aiType == EnemyAI.Slime:
    if enemy.lookDIr == LookDir.Left:
      if not enemy.backgroundCollision(room) and enemy.pos.x >= -SCREEN_WIDTH: enemy.pos.x -= 1
      else: enemy.pos.x -= 0
    elif enemy.lookDIr == LookDIr.Right:
      if not enemy.backgroundCollision(room) and enemy.pos.x <= SCREEN_WIDTH*2: enemy.pos.x += 1
      else: enemy.pos.x += 0
    # this commented code block is for when the RNG gets introduced properly
    # if rng mod frames > 60'u:
    #   if enemy.lookDir == LookDir.Left and enemy.animState == asIdle:
    #     enemy.lookDir = LookDir.Right
    #     enemy.animState = asMove
    #     if enemy.backgroundCollision(room):
    #       enemy.pos.x -= 1
    #     else: enemy.pos.x += 0
    #   if enemy.lookDir == LookDir.Right and enemy.animState == asIdle:
    #     enemy.lookDir = LookDir.Left
    #     enemy.animState = asMove
    #     if enemy.backgroundCollision(room):
    #       enemy.pos.x -= 1
    #     else: enemy.pos.x += 0
    # else:
    #   enemy.animState = asIdle
    #   enemy.pos.x += 0

proc naniteWaveAI*(enemy: var Enemy, floating: bool) =
  if enemy.pos.y >= 60 and floating:
    enemy.pos.y -= 2
  elif enemy.pos.y <= 90 and not floating:
    enemy.pos.y += 2


proc runAI*(enemy: var Enemy, rngState: var XorWowState, frames: uint, room: Room, floating: bool) =
  ## Function to run the various enemy AIs.
  # TODO: Add more enemy AIs, and make respective functions more difficult.
  if enemy.aiType == EnemyAI.Slime:
    enemy.slimeAI(rngState, frames, room)
  if enemy.aiType == EnemyAI.NaniteWave:
    enemy.naniteWaveAI(floating)
  if enemy.aiType == EnemyAI.Pumpkin:
    discard # discard here, as the pumpkin does nothing special.