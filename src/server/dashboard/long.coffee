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

  # Used in one of the multipliers
  __demiradix__ = __radix__ >> 1
  __demibase__  = 1 << __demiradix__
  __demimask__  = __demibase__ - 1

  _setRadix = (radix) ->
    __radix__  = radix
    __base__   = 1 << __radix__
    __base2__  = pow __base__, 2
    __mask__   = __base__ - 1

    # Used in one of the multipliers
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
    (xs[i] or 0) >>> j

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

  _mul = (xs, ys) ->
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


  _mul32 = (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
    y_24 = ys[24]
    y_25 = ys[25]
    y_26 = ys[26]
    y_27 = ys[27]
    y_28 = ys[28]
    y_29 = ys[29]
    y_30 = ys[30]
    y_31 = ys[31]

    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length

    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        i = c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__

        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__

        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__

        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__

        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__

        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__

        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__

        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__

        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__

        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__

        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__

        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__

        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__

        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__

        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__

        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__

        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__

        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__

        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__

        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__

        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__

        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__

        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__

        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__

        y_l = y_24 & __demimask__
        y_h = y_24 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__

        y_l = y_25 & __demimask__
        y_h = y_25 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__

        y_l = y_26 & __demimask__
        y_h = y_26 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__

        y_l = y_27 & __demimask__
        y_h = y_27 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__

        y_l = y_28 & __demimask__
        y_h = y_28 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__

        y_l = y_29 & __demimask__
        y_h = y_29 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__

        y_l = y_30 & __demimask__
        y_h = y_30 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__

        y_l = y_31 & __demimask__
        y_h = y_31 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__

        zs[j] = c
    _trim zs

  _kmul = (xs, ys) ->
    n_xs = xs.length
    n_ys = ys.length

    if (k = min n_xs, n_ys) < Long__radix__.KaratsubaLimit
      if n_ys is 32
        _mul32 xs, ys
      else
        _mul xs, ys

    else
      k = (k & ~0x1f) >> 1

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
      for i in [n...t]
        x_i0 = xs[i]   or 0
        x_i1 = xs[i-1] or 0

        # 14.20.3.1
        if x_i0 == ys_t0
          qs[i-t-1] = __base__ - 1

        else
          qs[i-t-1] = (x_i0 * b + x_i1) / ys_t0 & __mask__

        # 14.20.3.2
        while qs[i-t-1] * (ys_t0 * b + ys_t1) > x_i0 * b2 + x_i1 * b + (xs[i-2] or 0)
          qs[i-t-1]--

        # 14.20.3.3-4
        _shr ys, 1
        vs = _mul ys.slice(), [qs[i-t-1]]
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
    xs = _bshl xs.slice(), k
    ys = _bshl ys.slice(), k

    [qs, rs] = divmod xs, ys

    [qs, _bshr rs, k]


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
  @_repr:      _repr
  @_hex:       _hex
  @_size:      _size
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
  @_mulmod:    _mulmod
  @_powmod:    _powmod
  @_shl:       _shl
  @_shr:       _shr
  @_bshl:      _bshl
  @_bshr:      _bshr

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
    y = new Long y if not (y instanceof Long)

    xs = @digits
    ys = y.digits

    if (_size ys) is 0
      [Infinity, new Long]

    else
      [qs, rs] = _divmod xs, ys

      q = new Long qs
      r = new Long rs

      # Euclidean Division convention:
      #   0 <= r < q
      #   sign q is @sign for positive y
      #   sign q is -@sign for negative y
      #

      q.sign = @sign * y.sign

      if @sign < 0 and (_size rs) > 0
        r.digits = _sub ys.slice(), rs
        _add qs, [1]

      if (_size q.digits) is 0 and q.sign is -1
        q.sign = 1

      [q, r]

  div: (y) -> (@divmod y)[0]
  mod: (y) -> (@divmod y)[1]

  pow: (y) ->
    y = Number y
    y = 0 if y < 0

    z = new Long _pow @digits, y
    z.sign = if y & 1 then @sign else 1

    z

  mulmod: (y, m) ->
    y = new Long y if not (y instanceof Long)
    m = new Long m if not (m instanceof Long)

    zs = _mulmod @digits, y.digits, m.digits
    if @sign * y.sign < 0 and _size zs > 0
      zs = _sub m.digits.slice(), zs

    new Long zs

  powmod: (y, m) ->
    y = new Long y if not (y instanceof Long)
    m = new Long m if not (m instanceof Long)

    zs = _powmod @digits, y.digits, m.digits
    if @sign < 0 && y.digits[0] & 1 and _size zs > 0
      zs = _sub m.digits.slice(), zs

    new Long zs


  shl:  (k) -> new Long _shl  @digits.slice(), k
  shr:  (k) -> new Long _shr  @digits.slice(), k
  bshl: (k) -> new Long _bshl @digits.slice(), k
  bshr: (k) -> new Long _bshr @digits.slice(), k

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
