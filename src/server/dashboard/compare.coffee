{ abs, ceil, floor, LN2, log, max, min, pow, random, round } = Math

makeString = (ch, n) -> (ch for i in [0...n]).join ''
indents = do () -> (makeString ' ', i for i in [0...100])

stackTrace = () ->
  try
    (null)()
  catch err
    calls = (err.stack.split '\n').slice 3
    calls.reverse()
    lines = (indents[i] + call.slice 4 for call, i in calls)
    lines.join '\n'

assert = (cond) -> if not cond then throw stackTrace()

test = (N, K) ->
  K or= Long28.KaratsubaLimit

  codex = do () -> i.toString(16) for i in [0...16]
  randomHex = (n) -> (codex[floor 16*random()] for i in [1...n]).join ''

  C0 = 2000
  C1 = C0 >> 1

  H = (randomHex N for j in [0...C0])

  # jsbn
  Bn = (new BigInteger H[j], 16 for j in [0...C0])

  # Long
  Lo = (new Long H[j] for j in [0...C0])

  # Long
  Lo26 = (new Long26 H[j] for j in [0...C0])

  # Long
  Lo28 = (new Long28 H[j] for j in [0...C0])

  # Long
  Lo30 = (new Long30 H[j] for j in [0...C0])

  time = (fn) ->
    start = new Date
    fn()
    (new Date) - start

  R_bn = []
  R_lo = []
  R_lo26 = []
  R_lo28 = []
  R_lo30 = []

  time_Bn = time () ->
    for j in [0...C1]
      R_bn.push (r = new BigInteger)
      Bn[j].multiplyTo Bn[j+C1], r

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

  Long28.KarastubaLimit = K

  console.log 'jsbn:      ' + time_Bn
  console.log 'long:      ' + time_Lo
  console.log 'long26:    ' + time_Lo26
  console.log 'long28:    ' + time_Lo28
  console.log 'long30:    ' + time_Lo30

  console.log 'checking consistency...'
  try
    for j in [0...C1]
      H_bn = R_bn[j].toString 16
      H_lo = R_lo[j].toString 16
      H_lo26 = R_lo26[j].toString 16
      H_lo28 = R_lo28[j].toString 16
      H_lo30 = R_lo30[j].toString 16

      assert H_bn is H_lo
      assert H_lo is H_lo26
      assert H_lo26 is H_lo28
      # assert H_lo28A is H_lo28B
      assert H_lo28 is H_lo30

    console.log 'ok'

  catch err
    console.log 'consistency failure: '
    console.log 'H_bn:   ' + H_bn
    console.log 'H_lo:   ' + H_lo
    console.log 'H_lo26: ' + H_lo26
    # console.log 'H_lo28A: ' + H_lo28A
    # console.log 'H_lo28B: ' + H_lo28B
    console.log 'H_lo28: ' + H_lo28
    console.log 'H_lo30: ' + H_lo30
    console.log R_lo[j]
    console.log err
    console.log err.message


Long.testComparison = test
