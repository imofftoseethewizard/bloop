{ abs, ceil, floor, LN2, log, max, min, pow, random, round } = Math

test = () ->
  codex = do () -> i.toString(16) for i in [0...16]
  randomHex = (n) -> (codex[floor 16*random()] for i in [1...n]).join ''

  C0 = 1000
  C1 = C0 >> 1

  H = (randomHex 1024 for j in [0...C0])

  # jsbn
  Bn = (new BigInteger H[j], 16 for j in [0...C0])

  # BigInt
  Bi = (biFromHex H[j] for j in [0...C0])

  # Long
  long = Long.long
  Lo = (new Long long H[j] for j in [0...C0])

  # bare Long utils
  _lo = (long H[j] for j in [0...C0])

  time = (fn) ->
    start = new Date
    fn()
    (new Date) - start

  R_bn = []
  R_bi = []
  R_lo = []

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

  console.log 'jsbn:    ' + time_Bn
  # console.log 'BigInt:  ' + time_Bi
  console.log 'long:    ' + time_Lo

Long.testComparison = test
