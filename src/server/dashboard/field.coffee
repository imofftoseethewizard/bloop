class Residue

class Field

  { _add, _div, _invmod, _lt, _mod, _mul, _shl, _shr, _size, _sub, _zeros } = Long

  # ((b - m) mod b)^-1 mod b
  _cofactor = (ms) -> (((new Long [0, 1]).sub [ms[0]]).invmod [0, 1]).digits[0]

  constructor: (M) ->             # HAC equivalent
    @M  = M  = (new Long M if not (M instanceof Long)).digits
                                  # m
    @K  = K  = _size M            # t
    @R  = R  = _shl [1], K        # R = b^K, where b is __base__
    @R2 = R2 = _shl [1], 2*K      # R^2 = b^2*K
    @W  = W  = _cofactor M        # m-prime

    # for Barret reduction

    @B  = B  = _div R2, M               # mu (per 14.42)
    @Rb = Rb = _shl [1], K+1      # R = b^K+1

    ## Precomputed values for pow

    @R_M  = R_M  = _mod R, M
    @R2_M = R2_M = _mod R2, M


    return class FieldResidue extends Residue

      _modM = (xs) ->
        qs = _shr (_mul (_shr xs.slice(), K-1), B), K+1

        rs_1 = xs.slice 0, K+1
        rs_2 = (_mul qs, M).slice 0, K+1
        _add rs_1, Rb if _lt rs_1, rs_2
        rs = _sub rs_1, rs_2

        while _lt M, rs then _sub rs, M
        rs

      _reduce = (xs) ->
        zs = []

        for i in [0...K]                      # 14.32.2
          u_i = (_mul [xs[i]], [W])[0]        # 14.32.2.1  u_i = (x_i * w) mod b
          _add zs, _shl (_mul M, [u_i]), i    # 14.32.2.2  zs = zs + (u_i * b^i) * ms

        _shr zs, K                            # 14.32.3    zs = zs / b^k
        _sub zs, M if not _lt zs, M           # 14.32.4    if zs > ms then zs = ms - zs
        zs

      _toField = (xs) -> _modM _shl xs.slice(), K

      _toLong = (xs) -> _reduce xs

      _negate = (xs) -> if _eq xs, [0] then xs else _sub M.slice(), xs

      _mont = (xs, ys) ->
        zs = _zeros.slice 0, K

        y_0 = ys[0]
        for i in [0...K]
          x_i = xs[i]
          u_i = (_add [xs[0]], _mul (_mul [x_i], [y_0]), [W])[0]
          _add zs, _add (_mul ys, [x_i]), _mul M, [u_i]
          _shr zs, 1

        _sub zs, M if not _lt zs, M
        zs

      _pow = (xs, ys) ->
        ws = _mont xs, R2_M
        zs = R_M.slice()

        for i in [K..0]
          zs = _mont zs, zs
          zs = _mont zs, ws if _bit ys, i

        _mont zs, [1]


      constructor: (x) ->
        if x instanceof FieldResidue
          @digits = x.digits.slice()

        else
          x = x.toLong() if x instanceof Residue
          x = new Long x if not (x instanceof Long)

          xs = _toField x.digits
          xs = _negate xs if x.sign < 0
          @digits = xs

      valueOf: () -> @toLong().valueOf()

      toString: (radix) -> @toLong().toString(radix)

      toLong: () -> new Long _toLong @digits

      negate: () ->
        z = new FieldResidue
        z.digits = _negate xs.slice()
        z

      add: (y) ->
        y = new FieldResidue y if not (y instanceof FieldResidue)
        z = new FieldResidue

        z.digits = _add @digits.slice(), y.digits
        z

      sub: (y) -> @add (new FieldResidue y).negate()

      mul: (y) ->
        y = new FieldResidue y if not (y instanceof FieldResidue)
        z = new FieldResidue

        z.digits = _mont @digits, y.digits
        z

      pow: (y) ->
        y = new FieldResidue y if not (y instanceof FieldResidue)
        z = new FieldResidue

        z.digits = _pow @digits, y.digits
        z


window.Residue = Residue
window.Field = Field