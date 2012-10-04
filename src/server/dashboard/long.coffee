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
  _base2 = _base*_base
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
          # Inlined for performance
          # zs = _add zs, (_mul ys, xs[j] or 0), j
          #
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

      as = _kmul xs_h, ys_h
      bs = _kmul (_add xs_h, xs_l), (_add ys_h, ys_l)
      cs = _kmul xs_l, ys_l

      if _lt bs, as
        ds_sign = -1
        ds = _add (_sub as.slice(), bs), cs

      else
        _sub bs, as
        if _lt bs, cs
          ds_sign = -1
          ds = _sub cs.slice(), bs
        else
          ds_sign = 1
          ds = _sub bs, cs

      _shl as, 2*k
      _shl ds, k
      _add as, cs

      if ds_sign is 1
         _add as, ds
      else
        _sub as, ds

      as


  # This is implemented directly from the algorithm given in the Handbook of Applied Cryptography,
  # by A. Menezes, P. van Oorschot, and S. Vanstone, CRC Press, 1996.  In particular Chapter 14,
  # section 14.2.5, on page 598.  (The book is available online as PS and PDF downloads from
  # http://cacr.uwaterloo.ca/hac/.)  The numbers below refer to the steps in Algorithm 14.20.
  #
  # While this implementation does not presume that its inputs are normalized (HAC 14.23), it will
  # perform much better if they are.  In particular, this means that y_t0 >= _base >> 1.  This can
  # be achieved by the application of _bshl to xs and ys before calling this function.  It does not
  # affect the result, as the ratio of xs and ys is unchanged.
  #
  # The arguments are signless magnitudes. The sign convention for division or modulo should be
  # handled by the caller.

  _divmod = (xs, ys) ->
    b = _base
    b2 = _base2

    n = (_size xs)-1
    t = (_size ys)-1
    k = n - t

    ys_t0 = ys[t]
    ys_t1 = ys[t-1]

    ws = xs.slice()
    zs = ys.slice()

    # 14.20.1
    qs = []
    qs[k] = 0

    # 14.20.2
    _shl zs, k
    while not _lt ws, zs
      qs[k]++
      _sub ws, zs

    # 14.20.3
    for i in [n...t]
      w_i0 = ws[i]
      w_i1 = ws[i-1]

      # 14.20.3.1
      if w_i0 == ys_t0
        qs[i-t-1] = _base - 1

      else
        qs[i-t-1] = (w_i0 * b + w_i1) / ys_t0 & _mask

      # 14.20.3.2
      while qs[i-t-1] * (ys_t0 * b + ys_t1) > w_i0 * b2 + w_i1 * b + ws[i-2]
        qs[i-t-1]--

      # 14.20.3.3-4
      _shr zs, 1
      vs = _mul zs.slice(), qs[i-t-1]
      if _lt ws, vs
        _add ws, zs
        qs[i-t-1]--

      _sub ws, vs

    # 14.20.3.4-5
    [qs, ws]


  _shl = (xs, k) ->
    [].splice.apply xs, [0, 0, (_zeros.slice 0, k)...]
#    zs = _zeros.slice 0, k
#    [].push.apply zs, xs
#    zs
    xs


  _shr = (xs, k) ->
    xs.splice 0, k
    xs
#    xs.slice k


  _bshl = (xs, k) ->
    b = k % _radix
    j = (k - b)/_radix #

    _shl xs, j if j > 0

    c = 0
    zs = xs
    for i in [0...xs.length]
      z_i = (xs[i] << b) | c
      c = (z_i & _MASK) >>> _radix
      zs[i] = z_i & _mask

    zs[xs.length] = c if c

    zs


  _bshr = (xs, k) ->
    b = k % _radix
    j = (k - b)/_radix

    _shr xs, j if j > 0

    c = 0
    zs = xs
    for i in [xs.length-1..0]
      z_i = (xs[i] or 0) | c
      c = (z_i & _mask) << _radix
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
  @divmod: _divmod
  @shl:    _shl
  @shr:    _shr
  @bshl:   _bshl
  @bshr:   _bshr

  constructor: (x) ->
    if x instanceof Long
      @digits = x.digits.slice()
      @sign = x.sign

    else if x instanceof Array
      @digits = x
      @sign = 1

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


  divmod: (y) ->
    y = new Long y
    ys = y.digits
    ys_size = _size ys

    if ys_size is 0
      [Infinity, new Long]

    else
      xs = @digits.slice()
      y_t = ys[ys_size-1]
      c = 1
      while (y_t >>= 1) > 0 then c++

      # Section 14.23 in Handbook of Applied Cryptography (see comment above _divmod).
      k = _radix - c
      _bshl xs, k
      _bshl ys, k

      [qs, rs] = _divmod xs, ys
      _bshr ys, k

      q = new Long qs
      r = new Long _bshr rs, k

      # Euclidean Division convention:
      #   0 <= r < q
      #   sign q is @sign for positive y
      #   sign q is -@sign for negative y
      #

      q.sign = @sign * y.sign

      if @sign < 0 and (_size rs) > 0
        r.digits = _sub ys, rs
        _add qs, [1]

      if (_size q.digits) is 0 and q.sign is -1
        q.sign = 1

      [q, r]

  shl:  (k) -> new Long _shl  @digits.slice(), k
  shr:  (k) -> new Long _shr  @digits.slice(), k
  bshl: (k) -> new Long _bshl @digits.slice(), k
  bshr: (k) -> new Long _bshr @digits.slice(), k

  @test: () ->
    for i in [1..._radix*2]
      try
        assert (_value _bshl [1], i) == pow 2, i
      catch err
        console.log '_bshl test failed for i = ' + i
        console.log err
        console.log err.message

    for i in [1..._radix*2]
      try
        assert (_value (_bshr (_bshl [1], i), i)) == 1
      catch err
        console.log '_bshr test failed for i = ' + i
        console.log err
        console.log err.message

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


    h = new Long 50
    for i in [1...10]
      k = new Long i

      try
        [q, r] = h.divmod k
        if k is 0
          assert q is Infinity and (Number r) is 0
        else
          assert (Number k) * (Number q) + (Number r) == Number h

      catch err
        console.log 'positive-positive divmod test #' + i + ' failed for ' + (Number h) + ' and ' + (Number k)
        console.log '[' + (floor h/k) + ', ' + (h % k) + '] != [' + (Number q) + ', ' + (Number r) + ']'
        console.log err
        console.log err.message
        N = 0

    h = new Long 50
    for i in [1...10]
      k = new Long -i

      try
        [q, r] = h.divmod k
        if k is 0
          assert q is Infinity and (Number r) is 0
        else
          assert (Number k) * (Number q) + (Number r) == Number h

      catch err
        console.log 'positive-negative divmod test #' + i + ' failed for ' + (Number h) + ' and ' + (Number k)
        console.log '[' + (floor h/k) + ', ' + (h % i) + '] != [' + (Number q) + ', ' + (Number r) + ']'
        console.log err
        console.log err.message
        N = 0

    h = new Long -50
    for i in [1...10]
      k = new Long i

      try
        [q, r] = h.divmod k
        if k is 0
          assert q is Infinity and (Number r) is 0
        else
          assert (Number k) * (Number q) + (Number r) == Number h

      catch err
        console.log 'negative-positive divmod test #' + i + ' failed for ' + (Number h) + ' and ' + (Number k)
        console.log '[' + (floor h/k) + ', ' + (-h % i) + '] != [' + (Number q) + ', ' + (Number r) + ']'
        console.log err
        console.log err.message
        N = 0

    h = new Long -50
    for i in [1...10]
      k = new Long -i

      try
        [q, r] = h.divmod k
        if k is 0
          assert q is Infinity and (Number r) is 0
        else
          assert (Number k) * (Number q) + (Number r) == Number h

      catch err
        console.log 'negative-negative divmod test #' + i + ' failed for ' + (Number h) + ' and ' + (Number k)
        console.log '[' + (floor h/k) + ', ' + (-h % i) + '] != [' + (Number q) + ', ' + (Number r) + ']'
        console.log err
        console.log err.message
        N = 0

    i = 0
    while i < I
      K = pow 2, i++
      C1 = floor K / 2
      C2 = floor C1 / 2
      N = min C2, 100
      while N-- > 0
        k = floor K * random() - C1
        h = floor K * random() - C2

        try
          [q, r] = (new Long h).divmod new Long k
          if k is 0
            assert q is Infinity and (Number r) is 0
          else
            assert k * (Number q) + (Number r) == h

        catch err
          console.log 'stochastic divmod test #' + i + ' failed for ' + h + ' and ' + k
          console.log '[' + (floor h/k) + ', ' + (((h % k) + h) % k) + '] != [' + (Number q) + ', ' + (Number r) + ']'
          console.log err
          console.log err.message
          N = 0

    undefined

  @testKaratsubaThreshold: () ->
    # Performance on a Dell E4300 Linux Chromium platform while performing 100 4096-bit
    # multiplications
    #   Naive:                  180ms
    #   Karatsuba (limit = 40): 120ms
    #
    codex = do () -> i.toString(16) for i in [0...16]
    randomHex = (n) -> (codex[floor 16*random()] for i in [1...n]).join ''

    H = []
    K = []
    for j in [0...100]
      H[j] = h_j = new Long
      K[j] = k_j = new Long

      h_j.digits = _long randomHex 1024
      k_j.digits = _long randomHex 1024

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