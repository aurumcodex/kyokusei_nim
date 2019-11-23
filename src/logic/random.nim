##[
  極性 -Kyokusei- (Nim)
  =====================
  Date Modified: 2019-11-22

  ## [Random File]
  A file for the ability to generate random numbers.
  Uses the `xorwow` algorithm to generate numbers.

  More info at: https://en.wikipedia.org/wiki/Xorshift#xorwow

  ## [License]
  MIT Licensed. View LICENSE file for details.
]##

type
  XorWowState* = object
    ## Struct to hold information about the current random state.
    a*: uint
    b*: uint
    c*: uint
    d*: uint
    counter*: uint

proc xorwowRNG*(state: var XorWowState): uint =
  ## Takes a state and generates a number from the given state.
  ## Slightly modified from the link below.
  ## More Info can be found at: https://en.wikipedia.org/wiki/Xorshift#xorwow
  # static:
  var s: uint = state.a

  var temp = state.d
  state.d = state.c
  state.c = state.b
  state.b = s

  temp = temp xor temp shl 4
  temp = temp xor temp shr 2
  temp = temp xor (s xor (s shl 4))

  state.a = temp

  state.counter += 1000
  result = temp + state.counter