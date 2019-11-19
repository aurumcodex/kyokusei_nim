##[
  極性 -Kyokusei- (Nim)
  =====================
  Date Modified: 2019-11-5

  ## [Foreign Function Interface File]
  A file used for various utility functions from C files.
  (This file might be removed and combined with `text.nim`, as there's only one proc here.)

  ## [License]
  MIT Licensed. View LICENSE file for details.
]##

# proc writeData*(dataID: uint32) {.importc: "write_data", header: "../src/c_files/text.h".}

proc printScore*(score: uint) {.importc: "print_score", header: "../src/c_files/text.h".}
  ## Sends the `score` variable to the C implementation in order to print the score.