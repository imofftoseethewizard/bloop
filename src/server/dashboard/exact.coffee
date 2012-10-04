# Arbitrary precision base 32768 arithmetic.
#
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



# Exact numbers.  So-called because in the intended range of their use (very large integers for
# cryptography), floating point numbers are inexact.  It's two fewer syllables than BigInteger,
# and not such a phonetic mess as BigNum.
#
class Exact
  _maxBinary  = do () ->
    c = 1                               # This determines the maximum size of an integer which can
    while 1 << c > 0 then c++           # be reliably manipulated with bitwise operations.
    c-1

  _radix  = _maxBinary >> 1             # if maxBinary is 30, then the base should be 15, so that
                                        # two digits when multiplied will still be usable with
                                        # bitwise operators

  _digitMask  = (1 << _radix) - 1       # used to mask of the bits that comprise a digit.
  _upperMask  = -1 ^ _digitMask


  # A cache of lots of zeros to speed initialization.
  _zeros = do () ->
    Zeros = new Uint8Array 10240
    (k) -> Array.prototype.slice.call Zeros, 0, k

  # Used to convert hex to a number.
  _fromHexCodex = do () ->
    codex = []
    codex[i.toString(16)] = i for i in [0...16]
    codex[i.toString(16).toUpperCase()] = i for i in [10...16]
    codex

  # Used to convert a number to hex.
  _toHexCodex = do () -> i.toString(16) for i in [0...16]

  # Allocates an array for the number.
  _alloc = (x, bits) ->
    x.size = ceil bits / _radix
    x.digits = _zeros x.size

  _set = (x, k) ->
    if k instanceof Exact
      x.digits = k.digits.slice()
      x.msb = k.msb
      x.sign = k.sign
      x.size = k.size
    else
      x.digits = _zeros x.size
      x.digits[0] = (abs k) & _digitMask
      x.sign = if k >= 0 then 1 else -1
      x.msb = _msb x

  # Computes the index of most significant bit set.
  _msb = (x) ->
    j = x.size-1
    while (d = x.digits[j]) == 0 and j > 0
      j--

    if d == 0
      0
    else
      1 + j*_radix + floor ((log d)/LN2)

  # Converts the exact number into a Number.
  _value = (x) ->
    v = 0
    v += x.digits[j] * (pow 2, j*_radix) for j in [0...x.size]
    x.sign * v

  _negate = (x) ->
    x.sign *= -1
    x

  _abs = (x) ->
    x.sign = 1
    x

  # Performs addition. z = x + y or x += y
  # If the third argument is not present, then this function uses its first
  # argument to hold the result. It also returns the result.
  _add = (x, y, z) ->
    z or= x
    carry = 0
    for j in [0...z.size]
      x_j = x.digits[j] or 0
      y_j = y.digits[j] or 0

      z_j = x_j + y_j + carry
      z.digits[j] = z_j & _digitMask
      carry = z_j >> _radix

    z.sign = x.sign
    z.msb = _msb z
    z

  # Performs subtraction. z = x - y
  # Unlike _add, this function must be supplied with a destination
  # for the result as the third argument.
  _sub = (x, y, z) ->
    if y.msb > x.msb
      _negate _sub y, x, z
    else
      carry = 0
      for j in [0...z.size]
        x_j = x.digits[j] or 0
        y_j = y.digits[j] or 0
        z_j = x_j - y_j + carry
        if z_j < 0
          carry = -1
          z_j += _digitMask + 1
        else
          carry = 0
        z.digits[j] = _digitMask & z_j

      z.msb = _msb z
      if carry is -1 then _negate _sub y, x, z else z

  # Performs subtraction. x -= y
  # This function ignores the signs of x and y, and stores its result in x.
  # Caller should ensure that the magnitude of x greater than or equal y.
  _msub = (x, y) ->
    z = x
    xs = x.digits
    ys = y.digits
    zs = z.digits
    carry = 0
    for j in [0...z.size]
      x_j = xs[j] or 0
      y_j = ys[j] or 0
      z_j = x_j - y_j + carry
      if z_j < 0
        carry = -1
        z_j += _digitMask + 1
      else
        carry = 0
      zs[j] = _digitMask & z_j

      z.msb = _msb z
    z

  # Perform basic multiplication: z = x * y.
  _mul = (x, y, z) ->
    for i in [0...x.size]
      x_i = x.digits[i]
      carry = 0
      for j in [0...y.size]
        y_j = y.digits[j]
        k = i + j
        z_k = z.digits[k] + x_i * y_j + carry
        carry = z_k >> _radix
        z.digits[k] = z_k & _digitMask

      while carry and k < z.size
        k++
        z_k = z.digits[k] + carry
        carry = z_k >> _radix
        z.digits[k] = z_k & _digitMask

      assert carry is 0

    z.msb = _msb z
    z

  # Shift number left by k digits.
  # k should be an integer greater than zero.
  # This function modifies its first argument.
  _shl = (x, k) ->
    k or= 1
    if k < x.size
      x.digits.unshift.apply x.digits, _zeros k
      x.digits.splice x.size, k
      x.msb += _radix * k
      if x.msb > x.size * _radix
        x.msb = _msb x
    else
      x.digits = _zeros x.size
      x.msb = 0

    x


  # Shift number right by k digits.
  # k should be an integer greater than zero.
  # This function modifies its first argument.
  _shr = (x, k) ->
    k or= 1
    if k < x.size
      x.digits.push.apply x.digits, _zeros k
      x.digits.splice 0, k
      x.msb = max 0, x.msb - _radix * k

    else
      x.digits = _zeros x.size
      x.msb = 0

    x

  # Shift number left by k bits.
  # k should be an integer greater than zero.
  # This function modifies its first argument.
  _bitShl = (x, k) ->
    b = k % _radix
    j = (k - b)/_radix

    if j > 0 then _shl x, j

    ds = x.digits

    carry = 0
    for i in [0...@size]
      d = (ds[i] << b) | carry
      carry = (d & _upperMask) >> _radix
      ds[i] = d & _digitMask

    x

  # Shift number right by k bits.
  # k should be an integer greater than zero.
  # This function modifies its first argument.
  _bitShr = (x, k) ->
    b = k % _radix
    j = (k - b)/_radix

    if j > 0 then _shr x, j

    ds = x.digits

    carry = 0
    for i in [@size-1..0]
      d = ds[i] | carry
      carry = (d & _upperMask) << _radix
      ds[i] = (d >> b) & _digitMask

    x


  # Test if two exact numbers are equal.
  _eql = (x, y) ->
    if x.msb isnt y.msb then false
    else if x.sign isnt y.sign then false
    else
      for i in [0...min x.size, y.size]
        if x.digits[i] isnt y.digits[i] then return false
      true

   _rel = (x, y) ->
    if x.sign > y.sign then '>'
    else if x.sign < y.sign then '<'
    else if x.msb > y.msb
      if x.sign >= 0 then '>' else '<'
    else if x.msb < y.msb
      if x.sign >= 0 then '<' else '>'
    else
      x_ds = x.digits
      y_ds = y.digits
      if x.sign >= 0
        for i in [0...min x.size, y.size]
          x_i = x_ds[i]
          y_i = y_ds[i]
          if x_i > y_i then return '>'
          if x_i < y_i then return '<'
        '='
      else
        for i in [0...min x.size, y.size]
          x_i = x_ds[i]
          y_i = y_ds[i]
          if x_i > y_i then return '<'
          if x_i < y_i then return '>'
        '='

  _lt = (x, y) -> (_rel x, y) is '<'
  _gt = (x, y) -> (_rel x, y) is '>'

  _lte = (x, y) -> not (_rel x, y) is '>'
  _gte = (x, y) -> not (_rel x, y) is '<'

  # The following relations ignore the sign of the number and deal only with
  # the magnitude.
  _mrel = (x, y) ->
    if x.msb > y.msb then '>'
    else if x.msb < y.msb then '<'
    else
      x_ds = x.digits
      y_ds = y.digits
      for i in [0...min x.size, y.size]
        x_i = x_ds[i]
        y_i = y_ds[i]
        if x_i > y_i then return '>'
        if x_i < y_i then return '<'
      '='

  _mlt = (x, y) -> (_mrel x, y) is '<'
  _mgt = (x, y) -> (_mrel x, y) is '>'

  _mlte = (x, y) -> not (_mrel x, y) is '>'
  _mgte = (x, y) -> not (_mrel x, y) is '<'

  # Normalized division algorithm.  The most significant bit of the divisor y should be just below
  # a digit boundary; that is y.msb % radix is radix-1.  This ensures that the division operation
  # is efficient.  It is also assumed that y is non zero.  The signs of x and y are ignored. The
  # resulting quotient and remainder will be in q and r, respectively.  See HAC 14.20.
  #
  # x and y are destroyed by this function, and the results are returned in q and r.
  #
  _normdiv = (x, y, q, r) ->
    _set q, 0

    # If x is less than y, then there is nothing to do.
    if _mgte x, y
      xs = x.digits
      ys = y.digits

      n = floor x.msb/_radix #/
      t = floor y.msb/_radix #/

      # k is the position of y's msb relative to its original position.  it is also the position
      # at which the quotient is modified.
      k = n - t

      # Move y up to be comparable in size to x.
      _shl y, k

      # If x is still greater than y.  If y were not normalized, then the 'if' would need to be a
      # 'while'.
      if _mgte x, y
        _inc q, k
        _msub x, y

      # Two most significant digits of the divisor
      y_t   = ys[t]
      y_t_1 = ys[t-1]

      for i in [n...t]
        k = i - t - 1

        x_i = xs[i]

        if x_i == y_i
          _setDigit q, k, _digitMask

        else
          # Estimate the kth digit of q. HAC 14.20:3.1
          est_q_k_num = _base2*x_i + (xs[i-1] << _radix) + xs[i-2]
          est_q_k_denom = (y_t << _radix) + y_t_1
          est_q_k = est_q_k_num/est_q_k_denom & _digitMask

          if est_q_k * est_q_k_denom > est_q_k_num
            est_q_k--

          _setDigit q, k, est_q_k

          _shr y, 1
          z = _dmul y, k, qs[k]

          if _mlt x, z
            _add x, y
            _dec q, k

          _msub x, z

    _set r, x

  # Division.  Unfinished.
  _div = (x, y, q, r) ->
    assert y.msb > 0
    if x.msb < y.msb
      q.digits[i] = 0 for i in [0...q.size]
      r.digits[i] = x.digits[i] for i in [0...r.size]
      return [q, r]

    else
      w = new Exact x
      z = new Exact y, x.size * _radix

      i = floor w.msb / _radix #/
      j = floor z.msb / _radix #/
      while j++ < i then _shl z


  # The Karatsuba multiplication algorithm is only worth performing on numbers of sufficiently
  # large size.  Below that it is just as fast or faster (low overhead) to use the naive n^2
  # method.  This value sets the minimum msb that both operands must have for the K-multiplication
  # algorithm to continue.
  @KaratsubaThresholdBits: 3*_radix


  # The internal methods are exposed as Exact._xxx.  The object methods farther below are in a
  # functional object-oriented style; that is, they are presented as member functions which
  # produce fresh values rather than modifying the given arguments or the objects themselves.  The
  # methods with a prefixed _ modify one of their arguments, and generally do not create new exact
  # numbers.
  @_alloc:      _alloc
  @_negate:     _negate
  @_abs:        _abs
  @_msb:        _msb
  @_value:      _value
  @_add:        _add
  @_mul:        _mul
  @_shl:        _shl
  @_shr:        _shr
  @_eql:        _eql
  @_rel:        _rel
  @_gt:         _gt
  @_gte:        _gte
  @_lt:         _lt
  @_lte:        _lte

  constructor: (x, bits) ->

    if x instanceof Exact
      _alloc this, (Number bits) or x.msb
      @digits = x.digits.slice 0, @size
      if @size > x.size
        @digits[i] = 0 for i in [x.size...@size]

      @sign = x.sign
      @msb = if bits >= x.msb then x.msb else _msb this

    else if not x? or (x = round x) is 0
      _alloc this, (Number bits) or _radix
      @sign = 1
      @msb = 0

    else if -(1 << _maxBinary) < x < (1 << _maxBinary)
      @sign = if x > 0 then 1 else -1
      x = abs x
      _alloc this, max (Number bits) or (log x + 1)/LN2

      @digits[0] = x & _digitMask
      @digits[1] = (x >> _radix) & _digitMask if @size > 1
      @msb = _msb this

    else
      @fromHex (x.toString 16), bits


  fromHex: (hexDigits, bits) ->
    bits = (Number bits) or _radix

    if hexDigits[0] is '-'
      @sign = -1
      hexDigits = hexDigits.slice 1

    else
      @sign = 1

    length = hexDigits.length
    _alloc this, max bits, length * 4

    i = length-1
    j = 0
    bits = 0
    acc = 0

    while i >= 0 and (x = _fromHexCodex[hexDigits[i--]])?
      acc |= x << bits
      bits += 4
      if bits >= _radix
        @digits[j++] = acc & _digitMask
        acc >>= _radix
        bits -= _radix

    if i >= 0
      throw 'Error in hex conversion to exact at digit ' + i + ': ' + hexDigits

    if bits > 0
      @digits[j] = acc

    @msb = _msb this
    this

  toHex: () ->
    hexDigits = []
    i = 0
    j = 0
    size = @size
    bits = 0
    acc = 0

    while j < size
      acc |= @digits[j++] << bits
      bits += _radix
      while bits >= 4
        hexDigits[i++] = _toHexCodex[acc & 0xf]
        acc >>= 4
        bits -= 4

    if bits > 0
      hexDigits[i] = _toHexCodex[acc]

    hexDigits.join ''

  valueOf: () -> _value this

  toString: (radix) -> @valueOf().toString radix

  negate: () -> _negate this

  abs: () ->
    if @sign is -1 then _negate new Exact this else this

  add: (y) ->
    y = new Exact y if not (y instanceof Exact)
    z = new Exact 0, 1 + max @msb, y.msb

    if @sign > y.sign
      _sub this, y, z

    else if y.sign > @sign
      _sub y, this, z

    else
      _add this, y, z

  sub: (y) ->
    @add (new Exact y).negate()

  mul: (y) ->
    y = new Exact y if not (y instanceof Exact)

    if @msb is 0 or y.msb is 0
      new Exact

    else
      z = new Exact 0, @msb + y.msb

      _mul this, y, z

      z.sign = @sign * y.sign
      z

  shl: (k) -> _shl (new Exact this), k
  shr: (k) -> _shr (new Exact this), k

  ashl: (k) ->
    k or= 1
    _shl (new Exact this, @msb + _radix*k), k

  bitShl: (k) ->
    _bitShl new Exact this, @msb + k


  Kmul: (y) ->
    K = Exact.KaratsubaThresholdBits
    Kmul = (x, y) ->
      if x.msb <= K or y.msb <= K
        _mul x, y, new Exact 0, x.msb + y.msb

      else
        p = floor (min x.msb, y.msb) / 2 #/

        x_l = new Exact x, p
        y_l = new Exact y, p

        k = x_l.size
        assert k == y_l.size

        x_h = x.shr k # x.shr and y.shr return new objects
        y_h = y.shr k

        a = Kmul x_h, y_h
        b = Kmul (_add x_h, x_l), (_add y_h, y_l)  # _add places result into first argument
        c = Kmul x_l, y_l
        d = _sub (_sub b, a, b), c, b

        _add ((_add (a.ashl k), d).ashl k), c

    y = new Exact y if not (y instanceof Exact)

    if @msb is 0 or y.msb is 0
      new Exact

    else
      sign = @sign * y.sign
      x = new Exact this
      y = new Exact y
      x.sign = y.sign = 1
      z = Kmul x, y
      z.sign = sign
      z


  @test: () ->
    i = 0
    while (pow 2, i) < 1 + (pow 2, i)
      K = pow 2, i++
      for k in [K-100...K+100]
        x = new Exact k
        try
          assert k == Number x

        catch err
          console.log 'linear construction test #' + i + ' failed for ' + k
          console.log '' + k + ' != ' + Number x
          console.log err

          break

      for k in [-K-100...-K+100]
        x = new Exact k
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
        assert k == Number new Exact k

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
        x = new Exact k
        y = new Exact -k
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
          sum = Number (new Exact h).add new Exact k
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
        x = new Exact k
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
          product = Number (new Exact h).mul new Exact k
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
    # i = 0
    # while i < I
    #   K = pow 2, i++
    #   for k in [K-100...K+100]
    #     x = new Exact k
    #     try
    #       assert x * x == Number x.mul x

    #     catch err
    #       console.log 'linear Karatsuba square test #' + i + ' failed for ' + k
    #       console.log '' + (Number x.mul x) + ' != ' + (x * x)
    #       console.log err

    #       break

    # i = 0
    # while i < I
    #   K = pow 2, i++
    #   C = floor K / 2
    #   N = min C, 100
    #   while N-- > 0
    #     k = floor K * random() - C
    #     h = floor K * random() - C

    #     try
    #       product = Number (new Exact h).Kmul new Exact k
    #       assert h * k == product

    #     catch err
    #       console.log 'stochastic Karatsuba product test #' + i + ' failed for ' + k + ' and ' + h
    #       console.log '' + (k * h) + ' != ' + product
    #       console.log err
    #       N = 0

    # randomHex = (n) -> (_toHexCodex[floor 16*random()] for i in [1...n]).join ''

    # for i in [4...10]
    #   N = pow 2, i
    #   H = ((new Exact 0, N*4).fromHex randomHex N for j in [0...100])
    #   K = ((new Exact 0, N*4).fromHex randomHex N for j in [0...100])

    #   for j in [0...100]
    #     try
    #       assert _eql (H[j].mul K[j]), H[j].Kmul K[j]

    #     catch err
    #       console.log 'stochastic multiplication consistency test failed'
    #       console.log 'H: '
    #       console.log H[j].toHex()
    #       console.log 'K: '
    #       console.log K[j].toHex()
    #       break

    undefined

  @testKaratsubaThreshold: () ->
    randomHex = (n) -> (_toHexCodex[floor 16*random()] for i in [1...n]).join ''

    H = ((new Exact 0, 10240).fromHex randomHex 2560 for i in [0...100])
    K = ((new Exact 0, 10240).fromHex randomHex 2560 for i in [0...100])

    startKaratsuba = new Date

    H[i].Kmul K[i] for i in [0...100]

    endKaratsuba = new Date

    startNaive = new Date

    H[i].mul K[i] for i in [0...100]

    endNaive = new Date

    console.log 'Naive', endNaive - startNaive
    console.log 'Karatsuba', endKaratsuba - startKaratsuba


window.Exact = Exact

