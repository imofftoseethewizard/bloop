{ abs, ceil, floor, LN2, log, max, min, pow, random, round } = Math

makeString = (ch, i) ->  (ch for i in [0...i]).join ''
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

class Long
  @KaratsubaLimit: 40

  _mantissa = do () ->
    c = 0
    while (pow 2, c) == 1 + pow 2, c then c++
    c

  _width = do () ->
    c = 0                               # This determines the maximum size of an integer which can
    while ~~(pow 2, c) then c++         # be reliably manipulated with bitwise operations.
    c

  _radix = _width >> 1
  _base = 1 << _radix
  _mask = _base - 1
  _MASK = ~_mask

  _zeros = [].slice.call new Uint8Array 10240

  _long = do () ->
    codex = []
    codex[i.toString 16] = i for i in [0...16]

    (hex) ->
      zs = []
      j = 0
      bits = 0
      acc = 0

      for i in [hex.length-1..0]
        x = codex[hex[i]] or 0
        acc |= x << bits
        bits += 4
        if bits >= _radix
          zs[j++] = acc & _mask
          acc >>>= _radix
          bits -= _radix

      zs[j] = acc if bits > 0
      zs

  _hex = do () ->
    codex = (i.toString(16) for i in [0...16])

    (xs) ->
      chs = []
      for i in [(_size xs)-1..0]
        x_i = xs[i] or 0
        chs.push codex[x_i >> 4]
        chs.push codex[x_i & 0xf]
      chs.join ''


  _size = (xs) ->
    i = xs.length-1
    while (xs[i] or 0) is 0 and i >= 0 then i--
    i+1


  _lt = (xs, ys) ->
    for i in [(max xs.length, ys.length)-1..0]
      x_i = xs[i] or 0
      y_i = ys[i] or 0
      if x_i < y_i then return true
      if x_i > y_i then return false
    false


  _eq = (xs, ys) ->
    for i in [(max xs.length, ys.length)-1..0]
      if (xs[i] or 0) isnt (ys[i] or 0) then return false
    true


  _value = (xs) ->
    k = 0
    for i in [xs.length-1..0]
      k = _base * k + (xs[i] or 0)
    k


  _add = (xs, ys, k) ->
    k or= 0
    c = 0
    zs = xs
    for i in [k...ys.length+k]
      z_i = (xs[i] or 0) + (ys[i-k] or 0) + c
      c = z_i >>> _radix
      zs[i] = z_i & _mask

    while c
      z_i = (xs[i] or 0) + c
      c = z_i >>> _radix
      zs[i] = z_i & _mask
      i++

    zs

  _sub = (xs, ys, k) ->
    k or= 0
    c = 0
    zs = xs
    for i in [k...ys.length+k]
      z_i = (xs[i] or 0) - (ys[i-k] or 0) - c
      if z_i < 0
        c = 1
        z_i += _mask + 1
      else
        c = 0
      zs[i] = z_i & _mask

    xs_size = _size xs
    while c and i < xs_size
      z_i = (xs[i] or 0) - c
      if z_i < 0
        c = 1
        z_i += _mask + 1
      else
        c = 0
      zs[i] = z_i & _mask
      i++

    zs


  _mul = (xs, ys) ->
    zs = []
    if not (ys instanceof Array)
      k = ys or 0
      c = 0
      for i in [0...xs.length]
        z_i = k * (xs[i] or 0) + c
        c = z_i >>> _radix
        zs[i] = z_i & _mask

      while c > 0
        z_i = k * (xs[i] or 0) + c
        c = z_i >>> _radix
        zs[i++] = z_i & _mask

    else
      if (_size xs) > 0 and (_size ys) > 0
        for j in [0...xs.length]

          # zs = _add zs, (_mul ys, xs[j] or 0), j
          x_j = xs[j] or 0
          c = 0
          for i in [j...ys.length+j]
            z_i = (zs[i] or 0) + x_j*(ys[i-j] or 0) + c
            c = z_i >>> _radix
            zs[i] = z_i & _mask

          while c
            z_i = (zs[i] or 0) + c
            c = z_i >>> _radix
            zs[i] = z_i & _mask
            i++

    zs


  _kmul = (xs, ys) ->
    if (k = min (_size xs), _size ys) <= Long.KaratsubaLimit
      _mul xs, ys

    else
      k >>= 1
      xs_l = xs.slice 0, k
      ys_l = ys.slice 0, k

      xs_h = xs.slice k
      ys_h = ys.slice k

      a = _kmul xs_h, ys_h
      b = _kmul (_add xs_h, xs_l), (_add ys_h, ys_l)  # _add places result into first argument
      c = _kmul xs_l, ys_l

      if _lt b, a
        d_sign = -1
        d = _add (_sub a.slice(), b), c

      else
        _sub b, a
        if _lt b, c
          d_sign = -1
          d = _sub c.slice(), b
        else
          d_sign = 1
          d = _sub b, c

      # _shl a, 2*k
      [].splice.apply a, [0, 0, (_zeros.slice 0, 2*k)...]

      # _shl d, k
      [].splice.apply d, [0, 0, (_zeros.slice 0, k)...]

      _add a, c

      if d_sign is 1 then _add a, d
      else                _sub a, d

      a

  _shl = (xs, k) ->
    zs = _zeros.slice 0, k
    [].push.apply zs, xs
    zs


  _shr = (xs, k) -> xs.slice k


  _bshl = (xs, k) ->
    b = k % _radix
    j = (k - b)/_radix #

    xs = _shl xs, j if j > 0

    c = 0
    zs = []
    for i in [0...xs.length]
      z_i = (xs[i] << b) | c
      c = (z_i & _MASK) >>> _radix
      zs[i] = z_i & _mask

    zs


  _bshr = (xs, k) ->
    b = k % _radix
    j = (k - b)/_radix

    xs = _shr xs, j if j > 0

    c = 0
    zs = []
    for i in [xs.length-1..0]
      z_i = (xs[i] or 0) | c
      c = (z_i & _MASK) << _radix
      zs[i] = (z_i >>> b) & _mask

    zs

  @long:   _long
  @size:   _size
  @value:  _value
  @lt:     _lt
  @eq:     _eq
  @add:    _add
  @sub:    _sub
  @mul:    _mul
  @kmul:   _kmul
  @shl:    _shl
  @shr:    _shr
  @bshl:   _bshl
  @bshr:   _bshr

  constructor: (x) ->
    if x instanceof Long
      @digits = x.digits.slice()
      @sign = x.sign

    else
      x = (Number x) or 0
      @digits = _long x.toString 16
      @sign = if x >= 0 then 1 else -1

  valueOf: () -> @sign * _value @digits
  toString: (radix) -> @valueOf().toString radix

  negate: () ->
    if _size @digits > 0
      @sign *= -1
    else
      @sign = 1

  abs: () -> @sign = 1

  add: (y) ->
    x = this
    y = new Long y if not (y instanceof Long)
    z = new Long

    if x.sign < y.sign
      [x, y] = [y, x]

    if x.sign > y.sign
      if _lt x.digits, y.digits
        z.digits = _sub y.digits.slice(), x.digits
        z.sign = -1
      else
        z.digits = _sub x.digits.slice(), y.digits
        z.sign = 1

    else
      z.digits = _add x.digits.slice(), y.digits
      z.sign = x.sign

    z

  sub: (y) -> @add (new Long y).negate()

  mul: (y) ->
    x = this
    y = new Long y if not (y instanceof Long)
    z = new Long

    z.digits = _mul x.digits, y.digits
    z.sign = if (_size z.digits) is 0 then 1 else x.sign * y.sign

    z

  kmul: (y) ->
    x = this
    y = new Long y if not (y instanceof Long)
    z = new Long

    z.digits = _kmul x.digits, y.digits
    z.sign = x.sign * y.sign
    z

  shl: (k) -> _shl (new Long this), k
  shr: (k) -> _shr (new Long this), k
  bshl: (k) -> _bshl (new Long this), k
  bshr: (k) -> _bshr (new Long this), k



  @test: () ->
    i = 0
    while (pow 2, i) < 1 + (pow 2, i)
      K = pow 2, i++
      for k in [K-100...K+100]
        x = new Long k
        try
          assert k == Number x

        catch err
          console.log 'linear construction test #' + i + ' failed for ' + k
          console.log '' + k + ' != ' + Number x
          console.log err

          break

      for k in [-K-100...-K+100]
        x = new Long k
        try
          assert k == Number x

        catch err
          console.log 'linear construction test #' + i + ' failed for ' + k
          console.log '' + k + ' != ' + Number x
          console.log err

          break

    K = (pow 2, 3*_radix + 1) - 1
    C = (pow 2, 3*_radix) - 1

    m = Infinity
    M = -Infinity

    N = 1000
    while N-- > 0
      k = floor K * random() - C

      try
        assert k == Number new Long k

      catch err
        console.log 'stochastic construction test #' + (1000 - N + 1) + ' failed for ' + k
        console.log '' + k + ' != ' + Number(x)
        console.log err
        N = 0

      m = min m, k
      M = max M, k


    i = 0
    while (pow 2, i) < 1 + (pow 2, i)
      K = pow 2, i++
      for k in [K-100...K+100]
        x = new Long k
        y = new Long -k
        try
          assert 0 == Number x.add y

        catch err
          console.log 'linear negate test #' + i + ' failed for ' + k
          console.log '' + (Number x.add y) + ' != 0'
          console.log err

          break

        try
          assert 0 == Number y.add x

        catch err
          console.log 'linear negate test #' + i + ' failed for ' + -k
          console.log '' + (Number y.add x) + ' != 0'
          console.log err

          break

    i = 0
    while (pow 2, i) < 1 + (pow 2, i)
      K = pow 2, i++
      C = floor K / 2
      N = min C, 100
      while N-- > 0
        k = floor K * random() - C
        h = floor K * random() - C

        try
          sum = Number (new Long h).add new Long k
          assert h + k == sum

        catch err
          console.log 'stochastic sum test #' + i + ' failed for ' + k + ' and ' + h
          console.log '' + (k + h) + ' != ' + sum
          console.log err
          N = 0


    I = floor (i-1) / 2 # So squares still fit in accurate JS arithmetic
    i = 0               # i falls through from above.
    while i < I
      K = pow 2, i++
      for k in [K-100...K+100]
        x = new Long k
        try
          assert x * x == Number x.mul x

        catch err
          console.log 'linear square test #' + i + ' failed for ' + k
          console.log '' + (Number x.mul x) + ' != ' + (x * x)
          console.log err

          break

    i = 0
    while i < I
      K = pow 2, i++
      C = floor K / 2
      N = min C, 100
      while N-- > 0
        k = floor K * random() - C
        h = floor K * random() - C

        try
          product = Number (new Long h).mul new Long k
          assert h * k == product

        catch err
          console.log 'stochastic product test #' + i + ' failed for ' + k + ' and ' + h
          console.log '' + (k * h) + ' != ' + product
          console.log err
          N = 0

    undefined


    # The following tests are commented out because the present implementation of the Karatsuba
    # multiplication algorithm doesn't perform better than the naive one, even for 4Kb numbers.
    # The naive one can multiply 100 pairs of 4Kb numbers in about 280ms (Dell E4300, Linux,
    # Chromium); the K-multiplier takes about 3 times as long.
    #
    #
    i = 0
    while i < I
      K = pow 2, i++
      for k in [K-100...K+100]
        x = new Long k
        try
          assert x * x == Number x.mul x

        catch err
          console.log 'linear Karatsuba square test #' + i + ' failed for ' + k
          console.log '' + (Number x.mul x) + ' != ' + (x * x)
          console.log err

          break

    i = 0
    while i < I
      K = pow 2, i++
      C = floor K / 2
      N = min C, 100
      while N-- > 0
        k = floor K * random() - C
        h = floor K * random() - C

        try
          product = Number (new Long h).kmul new Long k
          assert h * k == product

        catch err
          console.log 'stochastic Karatsuba product test #' + i + ' failed for ' + k + ' and ' + h
          console.log '' + (k * h) + ' != ' + product
          console.log err
          N = 0

    codex = do () -> i.toString(16) for i in [0...16]
    randomHex = (n) -> (codex[floor 16*random()] for i in [1...n]).join ''

    for i in [4...10]
      N = pow 2, i
      H = []
      K = []
      for j in [0...100]
        H[j] = h_j = new Long
        K[j] = k_j = new Long

        h_j.digits = _long randomHex N
        k_j.digits = _long randomHex N

      for j in [0...100]
        try
          assert _eq (H[j].mul K[j]), H[j].kmul K[j]

        catch err
          console.log 'stochastic multiplication consistency test failed'
          console.log err, err.message
          console.log 'H: '
          console.log _hex H[j].digits
          console.log 'K: '
          console.log _hex K[j].digits
          break

    undefined

  @testKaratsubaThreshold: () ->
    codex = do () -> i.toString(16) for i in [0...16]
    randomHex = (n) -> (codex[floor 16*random()] for i in [1...n]).join ''

    H = []
    K = []
    for j in [0...100]
      H[j] = h_j = new Long
      K[j] = k_j = new Long

      h_j.digits = _long randomHex 2048
      k_j.digits = _long randomHex 2048

    startKaratsuba = new Date

    H[i].kmul K[i] for i in [0...100]

    endKaratsuba = new Date

    startNaive = new Date

    H[i].mul K[i] for i in [0...100]

    endNaive = new Date

    console.log 'Naive', endNaive - startNaive
    console.log 'Karatsuba', endKaratsuba - startKaratsuba


exports = window
exports.Long = Long