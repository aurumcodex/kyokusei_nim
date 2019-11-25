##[enemy_ai.nim :: dummy file]##

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


proc slimeAI(enemy: var Enemy, rngState: var XorWowState, frames: uint, room: Room) =
  var rng: uint = xorwowRNG(rngState)
  if enemy.aiType == EnemyAI.Slime:
    if rng mod frames > 60'u:
      if enemy.lookDir == LookDir.Left and enemy.animState == asIdle:
        enemy.lookDir = LookDir.Right
        enemy.animState = asMove
        if enemy.backgroundCollision(room):
          enemy.pos.x -= 1
        else: enemy.pos.x += 0
      if enemy.lookDir == LookDir.Right and enemy.animState == asIdle:
        enemy.lookDir = LookDir.Left
        enemy.animState = asMove
        if enemy.backgroundCollision(room):
          enemy.pos.x -= 1
        else: enemy.pos.x += 0
    else:
      enemy.animState = asIdle
      enemy.pos.x += 0


proc runAI*(enemy: var Enemy, rngState: var XorWowState, frames: uint, room: Room) =
  if enemy.aiType == EnemyAI.Slime:
    enemy.slimeAI(rngState, frames, room)