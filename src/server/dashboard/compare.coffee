{ abs, ceil, floor, LN2, log, max, min, pow, random, round } = Math

test = () ->
  codex = do () -> i.toString(16) for i in [0...16]
  randomHex = (n) -> (codex[floor 16*random()] for i in [1...n]).join ''

  C0 = 2000
  C1 = C0 >> 1

  H = (randomHex 2048 for j in [0...C0])

  # jsbn
  Bn = (new BigInteger H[j], 16 for j in [0...C0])

  # BigInt
  Bi = (biFromHex H[j] for j in [0...C0])

  # Long
  long = Long.long
  Lo = (new Long long H[j] for j in [0...C0])

  # Long
  long26 = Long26.long
  Lo26 = (new Long26 long26 H[j] for j in [0...C0])

  # Long
  long28 = Long28.long
  Lo28 = (new Long28 long28 H[j] for j in [0...C0])

  # Long
  long30 = Long30.long
  Lo30 = (new Long30 long30 H[j] for j in [0...C0])

  time = (fn) ->
    start = new Date
    fn()
    (new Date) - start

  R_bn = []
  R_bi = []
  R_lo = []
  R_lo26 = []
  R_lo28 = []
  R_lo30 = []

  time_Bn = time () ->
    for j in [0...C1]
      R_bn.push (r = new BigInteger)
      Bn[j].multiplyTo Bn[j+C1], r

  # time_Bi = time () ->
  #   for j in [0...C1]
  #     R_bi.push biMultiply Bi[j], Bi[j+C1]

  time_Lo = time () ->
    for j in [0...C1]
      R_lo.push Lo[j].kmul Lo[j+C1]

  time_Lo26 = time () ->
    for j in [0...C1]
      R_lo26.push Lo26[j].kmul Lo26[j+C1]

  time_Lo28 = time () ->
    for j in [0...C1]
      R_lo28.push Lo28[j].kmul Lo28[j+C1]

  time_Lo30 = time () ->
    for j in [0...C1]
      R_lo30.push Lo30[j].kmul Lo30[j+C1]

  console.log 'jsbn:      ' + time_Bn
  # console.log 'BigInt:    ' + time_Bi
  console.log 'long:      ' + time_Lo
  console.log 'long26:    ' + time_Lo26
  console.log 'long28:    ' + time_Lo28
  console.log 'long30:    ' + time_Lo30

Long.testComparison = test
