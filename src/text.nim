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

proc displayText*(id: uint) =
  ## Call the Tonc Text Engine wrapped procedures to display text, given an ID.
  ## This procedure is extremely ugly, and only exists because Nim on the GBA doesn't have
  ## a copyMem procedure in the `system` module; Unsure as to why that is.
  case id:
    of 0..10:
      # tteInitChr4cDefault(0, BG_CBB(0) or BG_SBB(31))
      # tteSetColor()
      tteInitChr4c(0, BG_CBB(0) or BG_SBB(31), 0xF000, bytes2word(1,2,0,0), CLR_LIME, addr verdana9Font, nil)
      tteWrite("#{90,20} Printing from case 1 of displayText()")
      # tteWriteEx(90, 20, "Printing from case 1 of displayText()", CLR_FUCHSIA)
    else:
      tteInitChr4cDefault(0, BG_CBB(0) or BG_SBB(31))
      tteWrite("default case")