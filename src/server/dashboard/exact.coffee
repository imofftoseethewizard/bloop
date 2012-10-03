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



c = 1                                   # This determines the maximum size of an integer which can
while 1 << c > 0 then c++               # be reliably manipulated with bitwise operations.
maxBinary  = c-1

logBase    = maxBinary >> 1             # if maxBinary is 30, then the base should be 15, so that
                                        # two digits when multiplied will still be usable with
                                        # bitwise operators

digitMask  = (1 << logBase) - 1         # used to mask of the bits that comprise a digit, also
                                        # used for sign-extension of empty digits during 2's comp
                                        # operation.

signMask   = 0x8000

# Exact numbers.  So-called because in the intended range of their use (very large integers for
# cryptography), floating point numbers are inexact.  It's two fewer syllables than BigInteger,
# and not such a phonetic mess as BigNum.
#
class Exact
  # The Karatsuba multiplication algorithm is only worth performing on numbers of sufficiently
  # large size.  Below that it is just as fast or faster (low overhead) to use the naive n^2
  # method.  This value sets the minimum msb that both operands must have for the K-multiplication
  # algorithm to continue.
  @KaratsubaThresholdBits: 7*logBase

  Zeros = new Uint8Array 10240
  _zeros = (k) -> Array.prototype.slice.call Zeros, 0, k

  # Used to convert hex to a number.
  fromHexCodex = []
  do () ->
    fromHexCodex[i.toString(16)] = i for i in [0...16]
    fromHexCodex[i.toString(16).toUpperCase()] = i for i in [10...16]

  # Used to convert a number to hex.
  toHexCodex = do () -> i.toString(16) for i in [0...16]

  # Allocates an array for the number.
  _alloc = (x, bits) ->
    x.size = ceil bits / logBase
    x.digits = _zeros x.size

  # Returns the sign of the number.
  _sign = (x) -> 1 - ((x.digits[x.size-1] & signMask) >> 14)

  # Sets the sign bit. A value of 0 or more is considered positive.
  _setSign = (x, s) ->
    if s >= 0
      x.digits[x.size-1] &= ~signMask
    else
      x.digits[x.size-1] |= signMask
    x

  # Negation
  _negate = (x) -> _setSign x, -_sign x

  # Computes the index of most significant bit set.
  _msb = (x) ->
    j = x.size-1
    while (d = x.digits[j] & digitMask) == 0 and j > 0
      j--

    if d == 0
      0
    else
      1 + j*logBase + floor ((log d)/LN2)

  # Converts the exact number into a Number.
  _value = (x) ->
    v = 0
    v += (x.digits[j] & digitMask) * (pow 2, j*logBase) for j in [0...x.size]
    v * _sign x

  # Performs addition. z = x + y or x += y
  # If the third argument is not present, then this function uses its first
  # argument to hold the result. It also returns the result.
  _add = (x, y, z) ->
    z or= x
    carry = 0
    for j in [0...z.size]
      x_j = x.digits[j] & digitMask
      y_j = y.digits[j] & digitMask

      z_j = x_j + y_j + carry
      z.digits[j] = z_j & digitMask
      carry = (z_j & signMask) >> logBase

    _setSign z, _sign x
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
        x_j = x.digits[j] & digitMask
        y_j = y.digits[j] & digitMask
        z_j = x_j - y_j + carry
        if z_j < 0
          carry = -1
          z_j += digitMask + 1
        else
          carry = 0
        z.digits[j] = digitMask & z_j

      z.msb = _msb z
      if carry is -1 then _negate _sub y, x, z else z

  # Perform basic multiplication: z = x * y.
  _mul = (x, y, z) ->
    for i in [0...x.size]
      x_i = x.digits[i] & digitMask
      carry = 0
      for j in [0...y.size]
        y_j = y.digits[j] & digitMask
        k = i + j
        z_k = z.digits[k] + x_i * y_j + carry
        carry = z_k >> logBase
        z.digits[k] = z_k & digitMask

      while carry and k < z.size
        k++
        z_k = z.digits[k] + carry
        carry = z_k >> logBase
        z.digits[k] = z_k & digitMask

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
      x.msb += logBase * k
      if x.msb > x.size * logBase
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
      x.msb = max 0, x.msb - logBase * k

    else
      x.digits = _zeros x.size
      x.msb = 0

    x

  _eql = (x, y) ->
    if x.msb isnt y.msb then false
    else if (_sign x) isnt (_sign y) then false
    else
      for i in [0...min x.size, y.size]
        if x.digits[i] isnt y.digits[i] then return false
      true

  # Division.  Unfinished.
  _div = (x, y, q, r) ->
    assert y.msb > 0
    if x.msb < y.msb
      q.digits[i] = 0 for i in [0...q.size]
      r.digits[i] = x.digits[i] for i in [0...r.size]
      return [q, r]

    else
      w = new Exact x
      z = new Exact y, x.size * logBase

      i = floor w.msb / logBase #/
      j = floor z.msb / logBase #/
      while j++ < i then _shl z

  # The internal methods are exposed as Exact._xxx.  The object methods farther below are in a
  # functional object-oriented style; that is, they are presented as member functions which
  # produce fresh values rather than modifying the given arguments or the objects themselves.  The
  # methods with a prefixed _ modify one of their arguments, and generally do not create new exact
  # numbers.
  @_alloc:      _alloc
  @_sign:       _sign
  @_setSign:    _setSign
  @_negate:     _negate
  @_msb:        _msb
  @_value:      _value
  @_add:        _add
  @_mul:        _mul
  @_shl:        _shl
  @_shr:        _shr
  @_eql:        _eql


  constructor: (x, bits) ->

    if x instanceof Exact
      _alloc this, (Number bits) or x.msb
      @digits = x.digits.slice 0, @size
      if @size > x.size
        @digits[i] = 0 for i in [x.size...@size]

      _setSign this, x.sign()
      @msb = if bits >= x.msb then x.msb else _msb this

    else if not x? or (x = round x) is 0
      _alloc this, (Number bits) or logBase
      @msb = 0

    else if -(1 << maxBinary) < x < (1 << maxBinary)
      sign = if x > 0 then 1 else -1
      x = abs x
      _alloc this, max (Number bits) or (log x + 1)/LN2

      @digits[0] = x & digitMask
      @digits[1] = (x >> logBase) & digitMask if @size > 1
      @msb = _msb this

      @negate() if sign is -1

    else
      @fromHex (x.toString 16), bits


  fromHex: (hexDigits, bits) ->
    bits = (Number bits) or logBase

    if hexDigits[0] is '-'
      sign = -1
      hexDigits = hexDigits.slice 1

    else
      sign = 1

    length = hexDigits.length
    _alloc this, max bits, length * 4

    i = length-1
    j = 0
    bits = 0
    acc = 0

    while i >= 0 and (x = fromHexCodex[hexDigits[i--]])?
      acc |= x << bits
      bits += 4
      if bits >= logBase
        @digits[j++] = acc & digitMask
        acc >>= logBase
        bits -= logBase

    if i >= 0
      throw 'Error in hex conversion to exact at digit ' + i + ': ' + hexDigits

    if bits > 0
      @digits[j] = acc

    @msb = _msb this
    @negate() if sign is -1
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
      bits += logBase
      while bits >= 4
        hexDigits[i++] = toHexCodex[acc & 0xf]
        acc >>= 4
        bits -= 4

    if bits > 0
      hexDigits[i] = toHexCodex[acc]

    hexDigits.join ''

  valueOf: () -> _value this

  toString: (radix) -> @valueOf().toString radix

  sign: () -> _sign this

  negate: () -> _negate this

  add: (y) ->
    y = new Exact y if not (y instanceof Exact)
    z = new Exact 0, 1 + max @msb, y.msb

    sign = @sign()
    sign_y = y.sign()

    if sign > sign_y
      _sub this, y, z

    else if sign_y > sign
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

      _setSign z, @sign() * y.sign()

  shl: (k) -> _shl (new Exact this), k
  shr: (k) -> _shr (new Exact this), k

  ashl: (k) ->
    k or= 1
    _shl (new Exact this, @msb + logBase*k), k

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
      sign = @sign() * y.sign()
      x = _setSign (new Exact this), 1
      y = _setSign (new Exact y), 1
      _setSign (Kmul x, y), sign


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

    K = (pow 2, 3*logBase + 1) - 1
    C = (pow 2, 3*logBase) - 1

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

    # randomHex = (n) -> (toHexCodex[floor 16*random()] for i in [1...n]).join ''

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
    randomHex = (n) -> (toHexCodex[floor 16*random()] for i in [1...n]).join ''

    H = ((new Exact 0, 4096).fromHex randomHex 1024 for i in [0...100])
    K = ((new Exact 0, 4096).fromHex randomHex 1024 for i in [0...100])

    startKaratsuba = new Date

    H[i].Kmul K[i] for i in [0...100]

    endKaratsuba = new Date

    startNaive = new Date

    H[i].mul K[i] for i in [0...100]

    endNaive = new Date

    console.log 'Naive', endNaive - startNaive
    console.log 'Karatsuba', endKaratsuba - startKaratsuba


window.Exact = Exact

