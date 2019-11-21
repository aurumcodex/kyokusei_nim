##[
  極性 -Kyokusei- (Nim)
  =====================
  Date Modified: 2019-11-5

  ## [Main File]
  A file used for displaying text to the screen.

  ## [License]
  MIT Licensed. View LICENSE file for details.
]##

import tonc

import ffi_c

proc displayText*(id: uint) =
  ## Call the Tonc Text Engine wrapped procedures to display text, given an ID.
  ## This procedure is extremely ugly, and only exists because Nim on the GBA doesn't have
  ## a copyMem nor a copyStr procedure in the `system` module; Unsure as to why that is.
  tteSetMargins(16, 100, 224, 120)
  case id:
    of 0..10:
      # tteInitChr4cDefault(1, BG_CBB(4) or BG_SBB(10))
      # tteSetColor()
      tteInitChr4c(0, BG_CBB(4) or BG_SBB(10), 0xF000, bytes2word(1,2,0,0), CLR_LIME, addr verdana9Font, nil)
      tteSetMargins(16, 10, 224, 40)
      tteWrite("#{P:16,20} Printing from case 1 of displayText()")
      # tteWriteEx(90, 20, "Printing from case 1 of displayText()", CLR_FUCHSIA)
    of 11..20:
      tteInitChr4c(0, BG_CBB(4) or BG_SBB(10), 0xF000, bytes2word(1,2,0,0), CLR_BLUE, addr verdana9Font, nil)
      tteWrite("#{P:0, 20} Printing from case 2 of displayText()")
    of 42:
      tteInitChr4c(0, BG_CBB(4) or BG_SBB(10), 0xF000, bytes2word(1,2,0,0), CLR_MEDGRAY, addr verdana9Font, nil)
      tteSetMargins(16, 10, 224, 40)
      tteWrite("#{P:16,20}player has collided with slime")
    else:
      tteInitChr4cDefault(0, BG_CBB(4) or BG_SBB(10))
      tteWrite("default case")