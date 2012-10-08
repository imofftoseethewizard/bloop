assert = do () ->

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

  (cond) -> if not cond then throw stackTrace()

class Residue

class RingMod

  { _add, _div, _lt, _mod, _mul, _shl, _shr, _size, _sub, _zeros } = Long

  # (- M)^-1 mod b
  _cofactor = (ms) ->
    w = (new Long ms).negate().invmod [0, 1]
    ws = if w? then w.digits else [0]
    ws

  @_cofactor = _cofactor

  constructor: (M) ->
    M = (if M instanceof Long then M else new Long M).digits

    return class RingResidue extends Residue

                                    # HAC equivalent
      @M  = M                       # m
      @K  = K  = _size M            # t
      @R  = R  = _shl [1], K        # R = b^K, where b is __base__
      @R2 = R2 = _shl [1], 2*K      # R^2 = b^2*K
      @W  = W  = _cofactor M        # m-prime

      # for Barret reduction

      @B  = B  = _div R2, M         # mu (per 14.42)
      @Rb = Rb = _shl [1], K+1      # R = b^K+1

      ## for pow

      @R_M  = R_M  = _mod R, M
      @R2_M = R2_M = _mod R2, M

      _modM = do () ->
        if _lt M, _shl [1], 1
          (xs) -> _mod xs, M

        else
          (xs) ->
            if (_size xs) >= 2*K
              _mod xs, M

            else
              qs = _shr (_mul (_shr xs.slice(), K-1), B), K+1

              rs_1 = xs.slice 0, K+1
              rs_2 = (_mul qs, M).slice 0, K+1
              _add rs_1, Rb if _lt rs_1, rs_2
              assert not _lt rs_1, rs_2
              rs = _sub rs_1, rs_2

              while not _lt rs, M then _sub rs, M
              rs

      _lift = (xs) -> _modM _shl xs, K

      _reduce = (xs) ->
        for i in [0...K] by 1                 # 14.32.2
          u_i = (_mul [xs[i]], W)[0]          # 14.32.2.1  u_i = (x_i * w) mod b
          _add xs, _shl (_mul M, [u_i]), i    # 14.32.2.2  xs = xs + (u_i * b^i) * ms

        _shr xs, K                            # 14.32.3    xs = xs / b^k
        _sub xs, M if not _lt xs, M           # 14.32.4    if xs > ms then xs = ms - xs
        xs

      _toRing = (xs) -> _reduce xs

      _toLong = (xs) -> _lift xs

      _negate = (xs) -> if _eq xs, [0] then xs else _sub M.slice(), xs

      _mont = (xs, ys) ->
        zs = _zeros.slice 0, K

        y_0 = ys[0]
        for i in [0...K] by 1
          x_i = xs[i]
          u_i = (_add [xs[0]], _mul (_mul [x_i], [y_0]), W)[0]
          _add zs, _add (_mul ys, [x_i]), _mul M, [u_i]
          _shr zs, 1

        _sub zs, M if not _lt zs, M
        zs

      _pow = (xs, ys) ->
        ws = _mont xs, R2_M
        zs = R_M.slice()

        for i in [K..0] by -1
          zs = _mont zs, zs
          zs = _mont zs, ws if _bit ys, i

        _mont zs, [1]


      @_modM:      _modM
      @_lift:      _lift
      @_reduce:    _reduce
      @_toLong:    _toLong
      @_toRing:    _toRing
      @_negate:    _negate
      @_mont:      _mont
      @_pow:       _pow


      constructor: (x) ->
        if x instanceof RingResidue
          @digits = x.digits.slice()

        else
          x = x.toLong() if x instanceof Residue
          x = new Long x if not (x instanceof Long)

          xs = _toRing x.digits.slice()
          xs = _negate xs if x.sign < 0
          @digits = xs

      valueOf: () -> @toLong().valueOf()

      toString: (radix) -> @toLong().toString(radix)

      toLong: () -> new Long _toLong @digits.slice()

      negate: () ->
        z = new RingResidue
        z.digits = _negate xs.slice()
        z

      add: (y) ->
        y = new RingResidue y if not (y instanceof RingResidue)
        z = new RingResidue

        z.digits = _add @digits.slice(), y.digits
        z

      sub: (y) -> @add (new RingResidue y).negate()

      mul: (y) ->
        y = new RingResidue y if not (y instanceof RingResidue)
        z = new RingResidue

        z.digits = _lift _mul @digits, y.digits
        z

      pow: (y) ->
        y = new RingResidue y if not (y instanceof RingResidue)
        z = new RingResidue

        z.digits = _pow @digits, y.digits
        z

  @test: () ->
    { floor, random } = Math

    { _bshl, _eq, _repr, _value } = Long

    randomHex = do () ->
      codex = do () -> i.toString(16) for i in [0...16]
      (n) ->
        (codex[floor 16*random()] for i in [1...n]).join ''

    randomDigits = (bits) -> _repr randomHex bits >> 2
    randomLong = (bits) -> new Long randomDigits bits

    testModuli = (N) ->
      N or= 15
      [[7], [65535], (new Long 2147483647).digits,
       (new Long 200560490131).digits, (_sub (_bshl [1], 61), 1),
       (randomDigits 100 for i in [0...N-5])...]

    testDigits = (M) ->
      [[1], (_sub M.slice(), 1), (_add M.slice(), 1), (randomDigits 200 for i in [0...995])...]

    testResidues = (R) -> new R xs for xs in testDigits R.M

    testRings = (N) ->
      R for R in (new RingMod ms for ms in testModuli N) when not _eq R.W, [0]


    do () ->
      name = 'Barret reduction'
      passed = 0
      try
        for R in testRings()
          for xs in testDigits R.M
            expected = _mod xs, R.M
            actual = R._modM xs
            assert _eq expected, actual
            passed++

        console.log name + ': ' + passed

      catch err
        console.log name + ' test failed.'
        console.log 'M:', R? and R.M
        console.log 'xs:', xs
        console.log 'expected:', expected
        console.log 'actual:', actual
        console.log err
        console.log err.message


    do () ->
      name = 'Montgomery lift-reduce consistency'
      passed = 0
      try
        for R in testRings()
          { _lift, _reduce } = R
          for xs in testDigits R.M
            expected = _mod xs, R.M
            actual = _lift _reduce xs.slice()
            assert _eq expected, actual
            passed++

        console.log name + ': ' + passed

      catch err
        console.log name + ' test failed.'
        console.log 'R.M:', R.M
        console.log 'xs:', xs
        console.log 'expected:', expected
        console.log 'actual:', actual
        console.log err
        console.log err.message


    do () ->
      name = 'M = 7 multiplication consistency'
      passed = 0
      try
        Rmod7 = new RingMod 7
        for i in [0..7]
          x = new Rmod7 i
          for j in [0..7]
            y = new Rmod7 j
            expected = ((new Long x).mul y).mod 7
            actual = new Long x.mul y
            assert expected.eq actual
            passed++

        console.log name + ': ' + passed

      catch err
        console.log name + ' test failed on pass ' + (passed+1) + '.'
        console.log 'x:', x.valueOf() if x?
        console.log 'y:', y.valueOf() if y?
        console.log 'expected:', expected.valueOf() if expected?
        console.log 'actual:', actual.valueOf() if actual?
        console.log err
        console.log err.message


    do () ->
      name = 'multiplication consistency'
      passed = 0
      try
        for R in testRings()
          residues = testResidues R
          L = residues.length >> 1
          for i in [0...L]
            x = residues[i]
            y = residues[L+i]
            expected = ((new Long x).mul y).mod R.M
            actual = new Long x.mul y
            assert expected.eq actual
            passed++

        console.log name + ': ' + passed

      catch err
        console.log name + ' test failed on pass ' + (passed+1) + '.'
        console.log 'M:', R.M.valueOf() if R?
        console.log 'x:', x.valueOf() if x?
        console.log 'y:', y.valueOf() if y?
        console.log 'expected:', expected.valueOf() if expected?
        console.log 'actual:', actual.valueOf() if actual?
        console.log err
        console.log err.message


  @diagnose: () ->
    xs = _repr '55e3ae083d0cbdfec136f83823c2d8ad457638380374d291c'
    m = Long 2147483647

window.Residue = Residue
window.RingMod = RingMod