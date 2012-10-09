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

class Long
  #
  @KaratsubaLimit: 64

  _mantissa = do () ->
    c = 0
    while (pow 2, c) == 1 + pow 2, c then c++
    c

  _width = do () ->
    c = 0                               # This determines the maximum size of an integer which can
    while ~~(pow 2, c) then c++         # be reliably manipulated with bitwise operations.
    c

  ## %% Begin Remove for Specialize %%
  __radix__  = 28
  __base__   = 1 << __radix__
  __base2__  = pow __base__, 2
  __mask__   = __base__ - 1

  __demiradix__ = __radix__ >> 1
  __demibase__  = 1 << __demiradix__
  __demimask__  = __demibase__ - 1

  _setRadix = (radix) ->
    __radix__  = radix
    __base__   = 1 << __radix__
    __base2__  = pow __base__, 2
    __mask__   = __base__ - 1

    __demiradix__ = __radix__ >> 1
    __demibase__  = 1 << __demiradix__
    __demimask__  = __demibase__ - 1

  ## %% End Remove for Specialize %%

  _zeros = [].slice.call new Uint8Array 10240

  _repr = do () ->
    codex = []
    codex[i.toString 16] = i for i in [0...16]

    (hex) ->
      zs = []
      bits = 0
      acc = 0

      for i in [hex.length-1..0]
        x = codex[hex[i]] or 0
        acc |= x << bits
        bits += 4
        if bits >= __radix__
          zs.push acc & __mask__
          acc >>>= __radix__
          bits -= __radix__

      zs.push acc if bits > 0
      zs

  _hex = do () ->
    codex = (i.toString(16) for i in [0...16])

    (xs) ->
      chs = []
      bits = 0
      acc = 0

      for i in [0..._size xs]
        for x in [xs[i] & __demimask__, xs[i] >> __demiradix__]
          acc |= x << bits
          bits += __demiradix__
          while bits >= 4
            chs.push codex[acc & 0xf]
            acc >>>= 4
            bits -= 4

      chs.push codex[acc] if bits > 0
      while chs[chs.length-1] is '0' then chs.pop()

      chs.reverse().join ''

  _random = (bits) ->
    xs = []
    while bits > __radix__
      xs.push floor __base__ * random()
      bits -= __radix__

    if bits > 0
      xs.push floor (1 << bits) * random()

    xs

  _bitset = (xs, k, v) ->
    j = k % __radix__
    i = (k - j)/__radix__
    if not v? or v
      xs[i] |= 1 << j
    else
      xs[i] &= ~(1 << j)

  _bit = (xs, k) ->
    j = k % __radix__
    i = (k - j)/__radix__
    (xs[i] or 0) >>> j & 1

  _bitcount = (xs) ->
    c = 0
    c++ for i in [0...xs.length] if _bit xs, i
    c

  _msb = (xs) ->
    k = _size xs
    j = __radix__ * k
    x_k = xs[k-1]

    while --j >= 0 and not (x_k & (1 << (__radix__ - 1)))
      x_k <<= 1

    j

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
      k = __base__ * k + (xs[i] or 0)
    k


  _add = (xs, ys, k) ->
    k or= 0
    c = 0
    zs = xs
    for i in [k...ys.length+k]
      z_i = (xs[i] or 0) + (ys[i-k] or 0) + c
      c = z_i >>> __radix__
      zs[i] = z_i & __mask__

    while c
      z_i = (xs[i] or 0) + c
      c = z_i >>> __radix__
      zs[i] = z_i & __mask__
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
        z_i += __base__
      else
        c = 0
      zs[i] = z_i & __mask__

    n_xs = _size xs
    while c and i < n_xs
      z_i = (xs[i] or 0) - c
      if z_i < 0
        c = 1
        z_i += __base__
      else
        c = 0
      zs[i] = z_i & __mask__
      i++

    zs

  _trim = (xs) ->
    xs.length = _size xs
    xs

  __mul = (xs, ys) ->
    n_xs = xs.length
    n_ys = ys.length

    zs = _zeros.slice 0, n_xs + n_ys

    if n_xs > 0 and n_ys > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        i = c = 0
        k = j
        n = n_ys
        while --n >= 0
          yl_i = ys[i] & __demimask__
          yh_i = ys[i++] >> __demiradix__
          m = x_h*yl_i + yh_i*x_l
          z_j = zs[j] + x_l*yl_i + ((m & __demimask__) << __demiradix__) + c
          c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*yh_i
          zs[j++] = z_j & __mask__
        zs[j] = c
    _trim zs


  _mul = do () ->

    if Multipliers__radix__?
      mul = (Multipliers__radix__['_mul' + j] for j in [0..63])
      mul[0] = () -> [0]

      (xs, ys) ->
        n_xs = xs.length
        n_ys = ys.length

        if n_xs < n_ys
          [xs, n_xs, ys, n_ys] = [ys, n_ys, xs, n_xs]

        _trim (mul[n_ys] or __mul) xs, ys

    else
      __mul


  _kmul = (xs, ys) ->
    n_xs = xs.length
    n_ys = ys.length

    if (k = min n_xs, n_ys) < Long__radix__.KaratsubaLimit
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

      ds = _sub (_sub bs, as), cs

      _shl as, 2*k
      _shl ds, k
      _add as, cs
      _add as, ds
      as


  # This is implemented directly from the algorithm given in the Handbook of Applied Cryptography,
  # by A. Menezes, P. van Oorschot, and S. Vanstone, CRC Press, 1996.  In particular Chapter 14,
  # section 14.2.5, on page 598.  (The book is available online as PS and PDF downloads from
  # http://cacr.uwaterloo.ca/hac/.)  The numbers below refer to the steps in Algorithm 14.20.
  #
  # While this implementation does not presume that its inputs are normalized (HAC 14.23), it will
  # perform much better if they are.  In particular, this means that y_t0 >= __base__ >> 1.  This can
  # be achieved by the application of _bshl to xs and ys before calling this function.  It does not
  # affect the result, as the ratio of xs and ys is unchanged.
  #
  # The arguments are signless magnitudes. The sign convention for division or modulo should be
  # handled by the caller.

  _divmod = (xs, ys) ->
    divmod = (xs, ys) ->
      b = __base__
      b2 = __base2__

      n = (_size xs)-1
      t = (_size ys)-1
      k = n - t

      if k < 0 then return [[0], xs]

      ys_t0 = ys[t]
      ys_t1 = ys[t-1] or 0

      # 14.20.1
      qs = []
      qs[k] = 0

      # 14.20.2
      _shl ys, k
      while not _lt xs, ys
        qs[k]++
        _sub xs, ys

      # 14.20.3
      for i in [n...t] by -1
        x_i0 = xs[i]   or 0
        x_i1 = xs[i-1] or 0

        # 14.20.3.1
        if x_i0 == ys_t0
          qs[i-t-1] = __base__ - 1

        else
          # While HAC 14.20.3.1 has floor where round is below, and while this is ideally correct,
          # in the world of slightly inaccurate floating point numbers, this is unfortunately too
          # sharp of an estimate to keep the estimated quotient reliably above the true quotient.
          #
          # Ex. On linux running Chromium 18.0.1025.168 with 28-bit wide digits,
          #
          #   xs = 4478077875
          #   ys = 144756289
          #
          # produces the remainder 144756290 because the estimate for qs[0] is too low: on the
          # second and final iteration of the loop, the expression
          #
          #   (x_i0 * b + x_i1) / ys_t0
          #
          # yields 248970242.99999997 when the true digit should be 248970243.
          #
          qs[i-t-1] = (round (x_i0 * b + x_i1) / ys_t0) & __mask__

        # 14.20.3.2
        #
        # Javascript generally only has 53 bits of mantissa.  Each of the operands to the
        # comparator below could be as wide as 3*__radix__.  That would limit __radix__ to 17 or
        # less, resulting in much diminished performance.  Hence the computation is carried out in
        # Long instead.
        #
        while _lt [xs[i-2], x_i1, x_i0], _mul [ys_t1, ys_t0], [qs[i-t-1]]
          qs[i-t-1]--

        # 14.20.3.3-4
        _shr ys, 1
        vs = _mul ys, [qs[i-t-1]]
        if _lt xs, vs
          _add xs, ys
          qs[i-t-1]--

        _sub xs, vs

      # 14.20.3.4-5
      [qs, xs]


    # Note 14.23 on normalization
    y_t = ys[(_size ys)-1]
    c = 1
    while (y_t >>= 1) > 0 then c++

    k = __radix__ - c
    ws = _bshl xs.slice(), k
    zs = _bshl ys.slice(), k

    [qs, rs] = divmod ws, zs

    # assert _eq xs, _add (_mul qs, ys), _bshr rs.slice(), k

    [qs, _bshr rs, k]


  _div = (xs, ys) -> (_divmod xs, ys)[0]
  _mod = (xs, ys) -> (_divmod xs, ys)[1]


  _pow = (xs, k) ->
    zs = [1]
    xs = xs.slice()
    while k > 0
      zs = _kmul zs, xs if k & 1
      xs = _kmul xs, xs
      k >>>= 1

    zs


  _mulmod = (xs, ys, ms) -> (_divmod (_kmul xs, ys), ms)[1]


  _powmod = (xs, ys, ms) ->
    xs = xs.slice()
    ys = ys.slice()
    zs = [1]
    while true
      zs = _mulmod zs, xs, ms if ys[0] & 1
      _bshr ys, 1
      if (_size ys) is 0 then return zs
      xs = _mulmod xs, xs, ms


  _shl = (xs, k) ->
    [].splice.apply xs, [0, 0, (_zeros.slice 0, k)...]
    xs


  _shr = (xs, k) ->
    xs.splice 0, k
    xs


  _bshl = (xs, k) ->
    b = k % __radix__
    j = (k - b)/__radix__ #

    _shl xs, j if j > 0

    b_l = b
    b_r = __radix__ - b_l

    mask_l = (1 << b_r) - 1
    mask_h = ~mask_l

    c = 0
    zs = xs
    for i in [0...xs.length] by 1
      x_i = xs[i]
      z_i = (x_i & mask_l) << b_l | c
      c = (x_i & mask_h) >>> b_r
      zs[i] = z_i & __mask__

    zs[xs.length] = c if c

    zs


  _bshr = (xs, k) ->
    b = k % __radix__
    j = (k - b)/__radix__

    _shr xs, j if j > 0

    b_r = b
    b_l = __radix__ - b_r

    mask_l = (1 << b_r) - 1
    mask_h = ~mask_l

    c = 0
    zs = xs
    for i in [xs.length-1..0] by -1
      x_i = xs[i]
      z_i = (x_i & mask_h) >>> b_r | c
      c = (x_i & mask_l) << b_l
      zs[i] = z_i & __mask__

    zs

  ## %% Begin Remove for Specialize %%
  @_setRadix:  _setRadix
  ## %% End Remove for Specialize %%
  @_getRadix:  () -> __radix__
  @_zeros:     _zeros
  @_repr:      _repr
  @_hex:       _hex
  @_size:      _size
  @_bit:       _bit
  @_bitset:    _bitset
  @_bitcount:  _bitcount
  @_msb:       _msb
  @_trim:      _trim
  @_value:     _value
  @_lt:        _lt
  @_eq:        _eq
  @_add:       _add
  @_sub:       _sub
  @_mul:       _mul
  @_kmul:      _kmul
  @_pow:       _pow
  @_divmod:    _divmod
  @_div:       _div
  @_mod:       _mod
  @_mulmod:    _mulmod
  @_powmod:    _powmod
  @_shl:       _shl
  @_shr:       _shr
  @_bshl:      _bshl
  @_bshr:      _bshr

  # This member is used to provide generic constructors in the functions below, so that the value
  # type will propagate through a computation.  This supports the use of Long member functions
  # generically with Residue subclasses.

  Long:       Long

  @random: (bits) -> new Long _random bits

  constructor: (x) ->
    if x instanceof Long
      @digits = x.digits.slice()
      @sign = x.sign

    else if x instanceof Array
      @digits = x
      @sign = 1

    else if x instanceof String or typeof x is 'string'
      @digits = _repr x
      @sign = 1

    else
      x = (Number x) or 0
      @digits = _repr x.toString 16
      @sign = if x >= 0 then 1 else -1

  valueOf: () -> @sign * _value @digits
  toString: (radix) ->
    if radix is 16
      (if @sign is -1 then '-' else '') + _hex @digits
    else
      @valueOf().toString radix

  negate: () ->
    z = new @Long this
    z.sign = if (_size z.digits) > 0 then -1 * z.sign else 1
    z


  abs: () ->
    z = new @Long this
    z.sign = 1
    z


  add: (y) ->
    x = this
    y = new @Long y if not (y instanceof Long)
    z = new @Long

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

  sub: (y) -> @add (new @Long y).negate()

  mul: (y) ->
    x = this
    y = new @Long y if not (y instanceof Long)
    z = new @Long

    z.digits = _mul x.digits, y.digits
    z.sign = if (_size z.digits) is 0 then 1 else x.sign * y.sign

    z

  kmul: (y) ->
    x = this
    y = new @Long y if not (y instanceof Long)
    z = new @Long

    z.digits = _kmul x.digits, y.digits
    z.sign = x.sign * y.sign
    z


  divmod: (y) ->
    x = this
    y = new @Long y if not (y instanceof Long)

    xs = x.digits
    ys = y.digits

    if (_size ys) is 0
      [Infinity, new @Long]

    else
      [qs, rs] = _divmod xs, ys
      # assert _eq xs, _add (_mul qs, ys), rs

      q = new @Long qs
      r = new @Long rs

      # Euclidean division convention:
      #   0 <= r < q
      #   sign q is @sign for positive y
      #   sign q is -@sign for negative y
      #

      q.sign = x.sign * y.sign

      if x.sign < 0 and (_size rs) > 0
        r.digits = _sub ys.slice(), rs
        _add qs, [1]

      if (_size q.digits) is 0 and q.sign is -1
        q.sign = 1

      # assert x.eq r.add y.mul q
      [q, r]

  div: (y) -> (@divmod y)[0]
  mod: (y) -> (@divmod y)[1]

  bit: (k) -> _bit @digits, k
  bitset: (k, v) -> _bitset @digits, k, v
  bitcount: () -> _bitcount @digits

  msb: () -> _msb @digits

  eq: (y) ->
    if y instanceof Array
      ys = y
      sign_y = 1
    else
      y = new @Long y if not (y instanceof @Long)
      ys = y.digits
      sign_y = y.sign


    @sign is sign_y and _eq @digits, ys

  lt: (y) ->
    if y instanceof Array
      ys = y
      sign_y = 1
    else
      y = new @Long y if not (y instanceof @Long)
      ys = y.digits
      sign_y = y.sign

    if @sign < sign_y then true
    else if @sign > sign_y then false
    else if @sign is 1 then _lt @digits, ys
    else _lt ys, @digits

  gt: (y) -> (new @Long y if not (y instanceof @Long)).lt this

  gte: (y) -> not @lt y
  lte: (y) -> not @gt y

  extendedGcd: (y) ->
    a = new @Long 1
    b = new @Long 0
    c = new @Long 0
    d = new @Long 1

    g = new @Long 1

    u = new @Long 0
    v = new @Long 0

    x = this
    y = new @Long y if not (y instanceof @Long)

    if (x.eq [0]) or (y.eq [0]) then return [a, b, c, d, Infinity, u, v]

    while (x.bit 0) is 0 and (y.bit 0) is 0
      x = x.bshr 1
      y = y.bshr 1
      g = g.mul 2

    u = x
    v = y

    while true
      while (u.bit 0) is 0
        u = u.bshr 1
        if (a.bit 0) is 0 and (b.bit 0) is 0
          a = a.bshr 1
          b = b.bshr 1
        else
          a = (a.add y).bshr 1
          b = (b.sub x).bshr 1
        # assert u.eq (a.mul x).add b.mul y

      while (v.bit 0) is 0
        v = v.bshr 1
        if (c.bit 0) is 0 and (d.bit 0) is 0
          c = c.bshr 1
          d = d.bshr 1
        else
          c = (c.add y).bshr 1
          d = (d.sub x).bshr 1
        # assert v.eq (c.mul x).add d.mul y

      if u.gte v
        u = u.sub v
        a = a.sub c
        b = b.sub d
      else
        v = v.sub u
        c = c.sub a
        d = d.sub b

      if u.eq [0]
        return [a, b, c, d, g, u, v]


  invmod: (m) ->
    m = new @Long m if not (m instanceof @Long)

    if (m = m.abs()).lte [1]
      null
    else
      [a, b, c, d, g, u, v] = m.extendedGcd @abs()

      if g is Infinity or not (g.mul v).eq [1]
        null
      else
        d = d.add m if d.lt [0]
        d = m.sub d if @sign < 0
        d


  gcd: (y) ->
    y = new @Long y if not (y instanceof Long)
    [a, b, c, d, g, u, v] = @abs().extendedGcd y.abs()
    h = if g is Infinity then new @Long else g.mul v
    h


  pow: (y) ->
    y = Number y
    y = 0 if y < 0

    z = new @Long _pow @digits, y
    z.sign = if y & 1 then @sign else 1

    z

  mulmod: (y, m) ->
    y = new @Long y if not (y instanceof Long)
    m = new @Long m if not (m instanceof Long)

    zs = _mulmod @digits, y.digits, m.digits
    if @sign * y.sign < 0 and _size zs > 0
      zs = _sub m.digits.slice(), zs

    new @Long zs

  powmod: (y, m) ->
    y = new @Long y if not (y instanceof Long)
    m = new @Long m if not (m instanceof Long)

    zs = _powmod @digits, y.digits, m.digits
    if @sign < 0 && y.digits[0] & 1 and _size zs > 0
      zs = _sub m.digits.slice(), zs

    new @Long zs


  shl: (k) ->
    z = new @Long
    z.digits = _shl @digits.slice(), k
    z.sign = @sign
    z

  shr: (k) ->
    z = new @Long
    z.digits = _shr @digits.slice(), k
    z.sign = @sign
    z

  bshl: (k) ->
    z = new @Long
    z.digits = _bshl @digits.slice(), k
    z.sign = @sign
    z

  bshr: (k) ->
    z = new @Long
    z.digits = _bshr @digits.slice(), k
    z.sign = @sign
    z


  @test: () ->
    do () ->
      # test _repr and _hex functions

      codex = do () -> i.toString(16) for i in [0...16]
      randomHex = (n) -> (codex[floor 16*random()] for i in [1...n]).join ''

      for i in [0...10]
        try
          H = (randomHex 30).replace /^0+/, ''
          assert (result = _hex _repr H) == H
        catch err
          console.log '_hex and _repr test failed for H = ' + H
          console.log result
          console.log err
          console.log err.message


    for i in [1...__radix__*2]
      try
        k = floor __base__ * random()
        assert (_value _bshl [k], i) == k * pow 2, i
      catch err
        console.log '_bshl test failed for i = ' + i + '; k = ' + k
        console.log '' + (k * pow 2, i) + ' != ' + _value _bshl [k], i
        console.log err
        console.log err.message

    for i in [1...__radix__*2]
      try
        assert (_value (_bshr (_bshl [k], i), i)) == k
      catch err
        console.log '_bshl/_bshr consistency test failed for i = ' + i + '; k = ' + k
        console.log '' + k + ' != ' + _value _bshl [k], i
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

    K = (pow 2, 3*__radix__ + 1) - 1
    C = (pow 2, 3*__radix__) - 1

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
        h = new Long _repr randomHex N
        k = new Long _repr randomHex N

        try
          assert _eq (h.mul k), h.kmul k

        catch err
          console.log 'stochastic multiplication consistency test failed'
          console.log err, err.message
          console.log 'H: '
          console.log _hex h.digits
          console.log 'K: '
          console.log _hex k.digits
          break

    do () ->
      try
        for i in [0..100] by 4
          i_long = (new Long 1).bshl i
          for j in [0..100] by 4
            j_long = (new Long 1).bshl j
            H = _hex (i_long.mul j_long).digits
            assert H.length is (i >> 2) + (j >> 2) + 1 and (H.match /^10*$/)?
      catch err
        console.log 'simple multiplication grid test failed for i = ' + i + '; j = ' + j
        console.log 'result: "' + H + '"'
        console.log err
        console.log err.message

    do () ->
      try
        for i in [1..50]
          h = new Long makeString 'f', i
          H = _hex (h.mul h).digits
          assert H.length is 2 * i and (H.match /^f*e0*1$/)?
      catch err
        console.log '0xfff...fff multiplication test failed for i = ' + i
        console.log 'result: "' + H + '"'
        console.log err
        console.log err.message

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

    @test.divmod()
    @test.invmod()

    for i in [0...100]
      for k in [2, 5]
        B = [0, 0, 0x4000000, 0x40000, 0x2000, 0x400]
        b = ceil B[k] * random()

        try
          result = Number (new Long b).pow k
          assert (pow b, k) == result

        catch err
          console.log 'systematic pow test #' + i + ' failed for ' + b + ' and ' + k
          console.log '' + (pow b, k) + ' != ' + result
          console.log err
          console.log err.message
          N = 0


    for i in [4...10]
      N = pow 2, i
      for j in [0...100]
        h = new Long _repr randomHex N
        k = new Long _repr randomHex N
        m = new Long _repr randomHex N

        try
          assert _eq ((h.mul k).mod m), h.mulmod k, m

        catch err
          console.log 'stochastic mulmod consistency test failed'
          console.log err, err.message
          console.log 'h: '
          console.log _hex h.digits
          console.log 'k: '
          console.log _hex k.digits
          console.log 'm: '
          console.log _hex m.digits
          console.log err
          console.log err.message
          break

    for i in [4...10]
      N = pow 2, i
      k = 7 - (i >> 1)
      for j in [0...100]
        h = new Long _repr randomHex N
        m = new Long _repr randomHex N

        try
          assert _eq ((h.pow k).mod m), h.powmod k, m

        catch err
          console.log 'stochastic powmod consistency test failed for exponent ' + k
          console.log err, err.message
          console.log 'h: '
          console.log _hex h.digits
          console.log 'm: '
          console.log _hex m.digits
          console.log err
          console.log err.message
          break


    undefined


  @test.divmod = () ->
    randomHex = do () ->
      codex = do () -> i.toString(16) for i in [0...16]
      (n) ->
        (codex[floor 16*random()] for i in [1...n]).join ''

    randomDigits = (bits) -> _repr randomHex bits >> 2
    randomLong = (bits) -> new Long randomDigits bits

    name = 'divmod basic functionality'
    passed = 0
    try
      for bits in [12..60] by 4
        for i in [0...30]
          m = randomLong bits
          C = new Long _bshl [1], bits
          for j in [0...30]
            x = (randomLong bits+1).add C
            [q, r] = x.divmod m
            actual = r.add m.mul q
            expected = x
            assert actual.eq expected

            passed++

      console.log name + ': ' + passed

    catch err
      console.log name + ' test failed.'
      console.log 'm:', m? and m.valueOf()
      console.log 'x:', x? and x.valueOf()
      console.log 'q:', q? and q.valueOf()
      console.log 'r:', r? and r.valueOf()
      console.log 'expected:', expected
      console.log 'actual:', actual? and actual.valueOf()
      console.log err
      console.log err.message


  @test.invmod = () ->
    randomHex = do () ->
      codex = do () -> i.toString(16) for i in [0...16]
      (n) ->
        (codex[floor 16*random()] for i in [1...n]).join ''

    randomDigits = (bits) -> _repr randomHex bits >> 2
    randomLong = (bits) -> new Long randomDigits bits

    name = 'invmod basic functionality'
    passed = 0
    try
      for bits in [12..60] by 4
        for i in [0...30]
          m = randomLong bits
          C = new Long _bshl [1], bits
          for j in [0...30]
            x = (randomLong bits+1).sub C
            x_inv = x.invmod m
            if x_inv?
              xx_inv = x.mul x_inv
              actual = xx_inv.mod m
              expected = [1]
              assert actual.eq expected
            else if m.abs().lte [1]
              actual = x_inv
              expected = false
            else
              actual = x.gcd m
              expected = 'greater than 1'
              assert actual.gt [1]

            passed++

      console.log name + ': ' + passed

    catch err
      console.log name + ' test failed.'
      console.log 'm:', m? and m.valueOf()
      console.log 'x:', x? and x.valueOf()
      console.log 'x_inv:', x_inv? and x_inv.valueOf()
      console.log 'xx_inv:', xx_inv? and xx_inv.valueOf()
      console.log 'expected:', expected
      console.log 'actual:', actual? and actual.valueOf()
      console.log err
      console.log err.message


  @testKaratsubaThreshold: () ->
    # Performance on a Dell E4300 Linux Chromium platform while performing 100 4096-bit
    # multiplications
    #   Naive:                  180ms
    #   Karatsuba (limit = 40): 120ms
    #
    codex = do () -> i.toString(16) for i in [0...16]
    randomHex = (n) -> (codex[floor 16*random()] for i in [1...n]).join ''

    H = (new Long randomHex 2048 for j in [0...1000])
    K = (new Long randomHex 2048 for j in [0...1000])

    startKaratsuba = new Date

    H[i].kmul K[i] for i in [0...1000]

    endKaratsuba = new Date

    startNaive = new Date

    H[i].mul K[i] for i in [0...1000]

    endNaive = new Date

    console.log 'Naive', endNaive - startNaive
    console.log 'Karatsuba', endKaratsuba - startKaratsuba


exports = window
exports.Long__radix__ = Long
## %% Begin Remove for Specialize %%
exports.Long = Long
## %% End Remove for Specialize %%
