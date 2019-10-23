# This is just an example to get you started. A typical binary package
# uses this file as the main entry point of the application.

# when isMainModule:
#   echo("Hello, World!")

import tonc
import panicoverride

proc main() =
  REG_DISPCNT = DCNT_BG0

  tteInitChr4cDefault(0, BG_CBB(0) or BG_SBB(31))
  tteWrite("#{P:92,68}")
  tteWrite("I'M ON A SCREEEEEEEEEEN")
  tteWrite("#{P:92,100}")
  tteWrite("WEeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");

  while true:
    discard

main()