##[
  極性 -Kyokusei- (Nim)
  =====================
  Date Modified: 2019-11-18

  ## [Foreign Function Interface File]
  A file used for various utility functions from C files.
  (This file might be removed and combined with `text.nim`, as there's only one proc here.)

  ## [License]
  MIT Licensed. View LICENSE file for details.
]##

# proc writeData*(dataID: uint32) {.importc: "write_data", header: "../src/c_files/text.h".}

proc printScore*(score: uint) {.importc: "print_score", header: "../src/c_files/text.h".}
  ## Sends the `score` variable to the C implementation in order to print the score.

proc printPlayerPos*(x: int, y: int) {.importc: "print_player_pos", header: "../src/c_files/text.h".}
  ## Sends the x and y variables to the C function in order to print player position.

proc printSection*(submap: int) {.importc: "print_section", header: "../src/c_files/text.h".}
  ## Sends the int representation of the enum type Submap to be printed.