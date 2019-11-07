##[
  極性 -Kyokusei- (Nim)
  =====================
  Date Modified: 2019-11-5

  ## [Foreign Function Interface File]
  A file used for various utility functions from C files.

  ## [License]
  MIT Licensed. View LICENSE file for details.
]##

proc writeData*(dataID: uint32) {.importc: "write_data", header: "c_files/text.h", discardable.}