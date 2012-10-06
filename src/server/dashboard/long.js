// Generated by CoffeeScript 1.3.3
(function() {
  var LN2, Long, abs, assert, ceil, exports, floor, indents, log, makeString, max, min, pow, random, round, stackTrace,
    __slice = [].slice;

  abs = Math.abs, ceil = Math.ceil, floor = Math.floor, LN2 = Math.LN2, log = Math.log, max = Math.max, min = Math.min, pow = Math.pow, random = Math.random, round = Math.round;

  makeString = function(ch, n) {
    var i;
    return ((function() {
      var _i, _results;
      _results = [];
      for (i = _i = 0; 0 <= n ? _i < n : _i > n; i = 0 <= n ? ++_i : --_i) {
        _results.push(ch);
      }
      return _results;
    })()).join('');
  };

  indents = (function() {
    var i, _i, _results;
    _results = [];
    for (i = _i = 0; _i < 100; i = ++_i) {
      _results.push(makeString(' ', i));
    }
    return _results;
  })();

  stackTrace = function() {
    var call, calls, i, lines;
    try {
      return null();
    } catch (err) {
      calls = (err.stack.split('\n')).slice(3);
      calls.reverse();
      lines = (function() {
        var _i, _len, _results;
        _results = [];
        for (i = _i = 0, _len = calls.length; _i < _len; i = ++_i) {
          call = calls[i];
          _results.push(indents[i] + call.slice(4));
        }
        return _results;
      })();
      return lines.join('\n');
    }
  };

  assert = function(cond) {
    if (!cond) {
      throw stackTrace();
    }
  };

  Long = (function() {
    var __base2__, __base__, __demibase__, __demimask__, __demiradix__, __mask__, __mul, __radix__, _add, _bit, _bitset, _bshl, _bshr, _divmod, _eq, _hex, _kmul, _lt, _mantissa, _mul, _mulA, _mulmod, _pow, _powmod, _repr, _setRadix, _shl, _shr, _size, _sub, _trim, _value, _width, _zeros;

    Long.KaratsubaLimit = 64;

    _mantissa = (function() {
      var c;
      c = 0;
      while ((pow(2, c)) === 1 + pow(2, c)) {
        c++;
      }
      return c;
    })();

    _width = (function() {
      var c;
      c = 0;
      while (~~(pow(2, c))) {
        c++;
      }
      return c;
    })();

    __radix__ = 28;

    __base__ = 1 << __radix__;

    __base2__ = pow(__base__, 2);

    __mask__ = __base__ - 1;

    __demiradix__ = __radix__ >> 1;

    __demibase__ = 1 << __demiradix__;

    __demimask__ = __demibase__ - 1;

    _setRadix = function(radix) {
      __radix__ = radix;
      __base__ = 1 << __radix__;
      __base2__ = pow(__base__, 2);
      __mask__ = __base__ - 1;
      __demiradix__ = __radix__ >> 1;
      __demibase__ = 1 << __demiradix__;
      return __demimask__ = __demibase__ - 1;
    };

    _zeros = [].slice.call(new Uint8Array(10240));

    _repr = (function() {
      var codex, i, _i;
      codex = [];
      for (i = _i = 0; _i < 16; i = ++_i) {
        codex[i.toString(16)] = i;
      }
      return function(hex) {
        var acc, bits, x, zs, _j, _ref;
        zs = [];
        bits = 0;
        acc = 0;
        for (i = _j = _ref = hex.length - 1; _ref <= 0 ? _j <= 0 : _j >= 0; i = _ref <= 0 ? ++_j : --_j) {
          x = codex[hex[i]] || 0;
          acc |= x << bits;
          bits += 4;
          if (bits >= __radix__) {
            zs.push(acc & __mask__);
            acc >>>= __radix__;
            bits -= __radix__;
          }
        }
        if (bits > 0) {
          zs.push(acc);
        }
        return zs;
      };
    })();

    _hex = (function() {
      var codex, i;
      codex = (function() {
        var _i, _results;
        _results = [];
        for (i = _i = 0; _i < 16; i = ++_i) {
          _results.push(i.toString(16));
        }
        return _results;
      })();
      return function(xs) {
        var acc, bits, chs, x, _i, _j, _len, _ref, _ref1;
        chs = [];
        bits = 0;
        acc = 0;
        for (i = _i = 0, _ref = _size(xs); 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
          _ref1 = [xs[i] & __demimask__, xs[i] >> __demiradix__];
          for (_j = 0, _len = _ref1.length; _j < _len; _j++) {
            x = _ref1[_j];
            acc |= x << bits;
            bits += __demiradix__;
            while (bits >= 4) {
              chs.push(codex[acc & 0xf]);
              acc >>>= 4;
              bits -= 4;
            }
          }
        }
        if (bits > 0) {
          chs.push(codex[acc]);
        }
        while (chs[chs.length - 1] === '0') {
          chs.pop();
        }
        return chs.reverse().join('');
      };
    })();

    _bitset = function(xs, k, v) {
      var i, j;
      j = k % __radix__;
      i = (k - j) / __radix__;
      if (!(v != null) || v) {
        return xs[i] |= 1 << j;
      } else {
        return xs[i] &= ~(1 << j);
      }
    };

    _bit = function(xs, k) {
      var i, j;
      j = k % __radix__;
      i = (k - j) / __radix__;
      return (xs[i] || 0) >>> j;
    };

    _size = function(xs) {
      var i;
      i = xs.length - 1;
      while ((xs[i] || 0) === 0 && i >= 0) {
        i--;
      }
      return i + 1;
    };

    _lt = function(xs, ys) {
      var i, x_i, y_i, _i, _ref;
      for (i = _i = _ref = (max(xs.length, ys.length)) - 1; _ref <= 0 ? _i <= 0 : _i >= 0; i = _ref <= 0 ? ++_i : --_i) {
        x_i = xs[i] || 0;
        y_i = ys[i] || 0;
        if (x_i < y_i) {
          return true;
        }
        if (x_i > y_i) {
          return false;
        }
      }
      return false;
    };

    _eq = function(xs, ys) {
      var i, _i, _ref;
      for (i = _i = _ref = (max(xs.length, ys.length)) - 1; _ref <= 0 ? _i <= 0 : _i >= 0; i = _ref <= 0 ? ++_i : --_i) {
        if ((xs[i] || 0) !== (ys[i] || 0)) {
          return false;
        }
      }
      return true;
    };

    _value = function(xs) {
      var i, k, _i, _ref;
      k = 0;
      for (i = _i = _ref = xs.length - 1; _ref <= 0 ? _i <= 0 : _i >= 0; i = _ref <= 0 ? ++_i : --_i) {
        k = __base__ * k + (xs[i] || 0);
      }
      return k;
    };

    _add = function(xs, ys, k) {
      var c, i, z_i, zs, _i, _ref;
      k || (k = 0);
      c = 0;
      zs = xs;
      for (i = _i = k, _ref = ys.length + k; k <= _ref ? _i < _ref : _i > _ref; i = k <= _ref ? ++_i : --_i) {
        z_i = (xs[i] || 0) + (ys[i - k] || 0) + c;
        c = z_i >>> __radix__;
        zs[i] = z_i & __mask__;
      }
      while (c) {
        z_i = (xs[i] || 0) + c;
        c = z_i >>> __radix__;
        zs[i] = z_i & __mask__;
        i++;
      }
      return zs;
    };

    _sub = function(xs, ys, k) {
      var c, i, n_xs, z_i, zs, _i, _ref;
      k || (k = 0);
      c = 0;
      zs = xs;
      for (i = _i = k, _ref = ys.length + k; k <= _ref ? _i < _ref : _i > _ref; i = k <= _ref ? ++_i : --_i) {
        z_i = (xs[i] || 0) - (ys[i - k] || 0) - c;
        if (z_i < 0) {
          c = 1;
          z_i += __base__;
        } else {
          c = 0;
        }
        zs[i] = z_i & __mask__;
      }
      n_xs = _size(xs);
      while (c && i < n_xs) {
        z_i = (xs[i] || 0) - c;
        if (z_i < 0) {
          c = 1;
          z_i += __base__;
        } else {
          c = 0;
        }
        zs[i] = z_i & __mask__;
        i++;
      }
      return zs;
    };

    _trim = function(xs) {
      xs.length = _size(xs);
      return xs;
    };

    _mulA = function(xs, ys) {
      var c, i, j, k, m, n, n_xs, n_ys, x_h, x_l, yh_i, yl_i, z_j, zs, _i;
      n_xs = xs.length;
      n_ys = ys.length;
      zs = _zeros.slice(0, n_xs + n_ys);
      if (n_xs > 0 && n_ys > 0) {
        for (j = _i = 0; _i < n_xs; j = _i += 1) {
          x_l = xs[j] & __demimask__;
          x_h = xs[j] >> __demiradix__;
          i = c = 0;
          k = j;
          n = n_ys;
          while (--n >= 0) {
            yl_i = ys[i] & __demimask__;
            yh_i = ys[i++] >> __demiradix__;
            m = x_h * yl_i + yh_i * x_l;
            z_j = zs[j] + x_l * yl_i + ((m & __demimask__) << __demiradix__) + c;
            c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h * yh_i;
            zs[j++] = z_j & __mask__;
          }
          zs[j] = c;
        }
      }
      return _trim(zs);
    };

    __mul = function(xs, ys) {
      var c, i, j, k, m, n, n_xs, n_ys, x_h, x_l, yh_i, yl_i, z_j, zs, _i;
      n_xs = xs.length;
      n_ys = ys.length;
      zs = _zeros.slice(0, n_xs + n_ys);
      if (n_xs > 0 && n_ys > 0) {
        for (j = _i = 0; _i < n_xs; j = _i += 1) {
          x_l = xs[j] & __demimask__;
          x_h = xs[j] >> __demiradix__;
          i = c = 0;
          k = j;
          n = n_ys;
          while (--n >= 0) {
            yl_i = ys[i] & __demimask__;
            yh_i = ys[i++] >> __demiradix__;
            m = x_h * yl_i + yh_i * x_l;
            z_j = zs[j] + x_l * yl_i + ((m & __demimask__) << __demiradix__) + c;
            c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h * yh_i;
            zs[j++] = z_j & __mask__;
          }
          zs[j] = c;
        }
      }
      return _trim(zs);
    };

    _mul = (function() {
      var j, mul;
      if (typeof Multipliers__radix__ !== "undefined" && Multipliers__radix__ !== null) {
        mul = (function() {
          var _i, _results;
          _results = [];
          for (j = _i = 0; _i <= 63; j = ++_i) {
            _results.push(Multipliers__radix__['_mul' + j]);
          }
          return _results;
        })();
        mul[0] = function() {
          return [0];
        };
        return function(xs, ys) {
          var n_xs, n_ys, _ref;
          n_xs = xs.length;
          n_ys = ys.length;
          if (n_xs < n_ys) {
            _ref = [ys, n_ys, xs, n_xs], xs = _ref[0], n_xs = _ref[1], ys = _ref[2], n_ys = _ref[3];
          }
          return _trim((mul[n_ys] || __mul)(xs, ys));
        };
      } else {
        return __mul;
      }
    })();

    _kmul = function(xs, ys) {
      var as, bs, cs, ds, k, n_xs, n_ys, xs_h, xs_l, ys_h, ys_l;
      n_xs = xs.length;
      n_ys = ys.length;
      if ((k = min(n_xs, n_ys)) < Long__radix__.KaratsubaLimit) {
        return _mul(xs, ys);
      } else {
        k >>= 1;
        xs_l = xs.slice(0, k);
        ys_l = ys.slice(0, k);
        xs_h = xs.slice(k);
        ys_h = ys.slice(k);
        as = _kmul(xs_h, ys_h);
        bs = _kmul(_add(xs_h, xs_l), _add(ys_h, ys_l));
        cs = _kmul(xs_l, ys_l);
        ds = _sub(_sub(bs, as), cs);
        _shl(as, 2 * k);
        _shl(ds, k);
        _add(as, cs);
        _add(as, ds);
        return as;
      }
    };

    _divmod = function(xs, ys) {
      var c, divmod, k, qs, rs, y_t, _ref;
      divmod = function(xs, ys) {
        var b, b2, i, k, n, qs, t, vs, x_i0, x_i1, ys_t0, ys_t1, _i;
        b = __base__;
        b2 = __base2__;
        n = (_size(xs)) - 1;
        t = (_size(ys)) - 1;
        k = n - t;
        ys_t0 = ys[t];
        ys_t1 = ys[t - 1] || 0;
        qs = [];
        qs[k] = 0;
        _shl(ys, k);
        while (!_lt(xs, ys)) {
          qs[k]++;
          _sub(xs, ys);
        }
        for (i = _i = n; n <= t ? _i < t : _i > t; i = n <= t ? ++_i : --_i) {
          x_i0 = xs[i] || 0;
          x_i1 = xs[i - 1] || 0;
          if (x_i0 === ys_t0) {
            qs[i - t - 1] = __base__ - 1;
          } else {
            qs[i - t - 1] = (x_i0 * b + x_i1) / ys_t0 & __mask__;
          }
          while (qs[i - t - 1] * (ys_t0 * b + ys_t1) > x_i0 * b2 + x_i1 * b + (xs[i - 2] || 0)) {
            qs[i - t - 1]--;
          }
          _shr(ys, 1);
          vs = _mul(ys.slice(), [qs[i - t - 1]]);
          if (_lt(xs, vs)) {
            _add(xs, ys);
            qs[i - t - 1]--;
          }
          _sub(xs, vs);
        }
        return [qs, xs];
      };
      y_t = ys[(_size(ys)) - 1];
      c = 1;
      while ((y_t >>= 1) > 0) {
        c++;
      }
      k = __radix__ - c;
      xs = _bshl(xs.slice(), k);
      ys = _bshl(ys.slice(), k);
      _ref = divmod(xs, ys), qs = _ref[0], rs = _ref[1];
      return [qs, _bshr(rs, k)];
    };

    _pow = function(xs, k) {
      var zs;
      zs = [1];
      xs = xs.slice();
      while (k > 0) {
        if (k & 1) {
          zs = _kmul(zs, xs);
        }
        xs = _kmul(xs, xs);
        k >>>= 1;
      }
      return zs;
    };

    _mulmod = function(xs, ys, ms) {
      return (_divmod(_kmul(xs, ys), ms))[1];
    };

    _powmod = function(xs, ys, ms) {
      var zs;
      xs = xs.slice();
      ys = ys.slice();
      zs = [1];
      while (true) {
        if (ys[0] & 1) {
          zs = _mulmod(zs, xs, ms);
        }
        _bshr(ys, 1);
        if ((_size(ys)) === 0) {
          return zs;
        }
        xs = _mulmod(xs, xs, ms);
      }
    };

    _shl = function(xs, k) {
      [].splice.apply(xs, [0, 0].concat(__slice.call(_zeros.slice(0, k))));
      return xs;
    };

    _shr = function(xs, k) {
      xs.splice(0, k);
      return xs;
    };

    _bshl = function(xs, k) {
      var b, b_l, b_r, c, i, j, mask_h, mask_l, x_i, z_i, zs, _i, _ref;
      b = k % __radix__;
      j = (k - b) / __radix__;
      if (j > 0) {
        _shl(xs, j);
      }
      b_l = b;
      b_r = __radix__ - b_l;
      mask_l = (1 << b_r) - 1;
      mask_h = ~mask_l;
      c = 0;
      zs = xs;
      for (i = _i = 0, _ref = xs.length; _i < _ref; i = _i += 1) {
        x_i = xs[i];
        z_i = (x_i & mask_l) << b_l | c;
        c = (x_i & mask_h) >>> b_r;
        zs[i] = z_i & __mask__;
      }
      if (c) {
        zs[xs.length] = c;
      }
      return zs;
    };

    _bshr = function(xs, k) {
      var b, b_l, b_r, c, i, j, mask_h, mask_l, x_i, z_i, zs, _i, _ref;
      b = k % __radix__;
      j = (k - b) / __radix__;
      if (j > 0) {
        _shr(xs, j);
      }
      b_r = b;
      b_l = __radix__ - b_r;
      mask_l = (1 << b_r) - 1;
      mask_h = ~mask_l;
      c = 0;
      zs = xs;
      for (i = _i = _ref = xs.length - 1; _i >= 0; i = _i += -1) {
        x_i = xs[i];
        z_i = (x_i & mask_h) >>> b_r | c;
        c = (x_i & mask_l) << b_l;
        zs[i] = z_i & __mask__;
      }
      return zs;
    };

    Long._setRadix = _setRadix;

    Long._getRadix = function() {
      return __radix__;
    };

    Long._repr = _repr;

    Long._hex = _hex;

    Long._size = _size;

    Long._trim = _trim;

    Long._value = _value;

    Long._lt = _lt;

    Long._eq = _eq;

    Long._add = _add;

    Long._sub = _sub;

    Long._mul = _mul;

    Long._kmul = _kmul;

    Long._pow = _pow;

    Long._divmod = _divmod;

    Long._mulmod = _mulmod;

    Long._powmod = _powmod;

    Long._shl = _shl;

    Long._shr = _shr;

    Long._bshl = _bshl;

    Long._bshr = _bshr;

    function Long(x) {
      if (x instanceof Long) {
        this.digits = x.digits.slice();
        this.sign = x.sign;
      } else if (x instanceof Array) {
        this.digits = x;
        this.sign = 1;
      } else if (x instanceof String || typeof x === 'string') {
        this.digits = _repr(x);
        this.sign = 1;
      } else {
        x = (Number(x)) || 0;
        this.digits = _repr(x.toString(16));
        this.sign = x >= 0 ? 1 : -1;
      }
    }

    Long.prototype.valueOf = function() {
      return this.sign * _value(this.digits);
    };

    Long.prototype.toString = function(radix) {
      if (radix === 16) {
        return (this.sign === -1 ? '-' : '') + _hex(this.digits);
      } else {
        return this.valueOf().toString(radix);
      }
    };

    Long.prototype.negate = function() {
      if (_size(this.digits > 0)) {
        return this.sign *= -1;
      } else {
        return this.sign = 1;
      }
    };

    Long.prototype.abs = function() {
      return this.sign = 1;
    };

    Long.prototype.add = function(y) {
      var x, z, _ref;
      x = this;
      if (!(y instanceof Long)) {
        y = new Long(y);
      }
      z = new Long;
      if (x.sign < y.sign) {
        _ref = [y, x], x = _ref[0], y = _ref[1];
      }
      if (x.sign > y.sign) {
        if (_lt(x.digits, y.digits)) {
          z.digits = _sub(y.digits.slice(), x.digits);
          z.sign = -1;
        } else {
          z.digits = _sub(x.digits.slice(), y.digits);
          z.sign = 1;
        }
      } else {
        z.digits = _add(x.digits.slice(), y.digits);
        z.sign = x.sign;
      }
      return z;
    };

    Long.prototype.sub = function(y) {
      return this.add((new Long(y)).negate());
    };

    Long.prototype.mul = function(y) {
      var x, z;
      x = this;
      if (!(y instanceof Long)) {
        y = new Long(y);
      }
      z = new Long;
      z.digits = _mul(x.digits, y.digits);
      z.sign = (_size(z.digits)) === 0 ? 1 : x.sign * y.sign;
      return z;
    };

    Long.prototype.kmul = function(y) {
      var x, z;
      x = this;
      if (!(y instanceof Long)) {
        y = new Long(y);
      }
      z = new Long;
      z.digits = _kmul(x.digits, y.digits);
      z.sign = x.sign * y.sign;
      return z;
    };

    Long.prototype.divmod = function(y) {
      var q, qs, r, rs, xs, ys, _ref;
      if (!(y instanceof Long)) {
        y = new Long(y);
      }
      xs = this.digits;
      ys = y.digits;
      if ((_size(ys)) === 0) {
        return [Infinity, new Long];
      } else {
        _ref = _divmod(xs, ys), qs = _ref[0], rs = _ref[1];
        q = new Long(qs);
        r = new Long(rs);
        q.sign = this.sign * y.sign;
        if (this.sign < 0 && (_size(rs)) > 0) {
          r.digits = _sub(ys.slice(), rs);
          _add(qs, [1]);
        }
        if ((_size(q.digits)) === 0 && q.sign === -1) {
          q.sign = 1;
        }
        return [q, r];
      }
    };

    Long.prototype.div = function(y) {
      return (this.divmod(y))[0];
    };

    Long.prototype.mod = function(y) {
      return (this.divmod(y))[1];
    };

    Long.prototype.pow = function(y) {
      var z;
      y = Number(y);
      if (y < 0) {
        y = 0;
      }
      z = new Long(_pow(this.digits, y));
      z.sign = y & 1 ? this.sign : 1;
      return z;
    };

    Long.prototype.mulmod = function(y, m) {
      var zs;
      if (!(y instanceof Long)) {
        y = new Long(y);
      }
      if (!(m instanceof Long)) {
        m = new Long(m);
      }
      zs = _mulmod(this.digits, y.digits, m.digits);
      if (this.sign * y.sign < 0 && _size(zs > 0)) {
        zs = _sub(m.digits.slice(), zs);
      }
      return new Long(zs);
    };

    Long.prototype.powmod = function(y, m) {
      var zs;
      if (!(y instanceof Long)) {
        y = new Long(y);
      }
      if (!(m instanceof Long)) {
        m = new Long(m);
      }
      zs = _powmod(this.digits, y.digits, m.digits);
      if (this.sign < 0 && y.digits[0] & 1 && _size(zs > 0)) {
        zs = _sub(m.digits.slice(), zs);
      }
      return new Long(zs);
    };

    Long.prototype.shl = function(k) {
      return new Long(_shl(this.digits.slice(), k));
    };

    Long.prototype.shr = function(k) {
      return new Long(_shr(this.digits.slice(), k));
    };

    Long.prototype.bshl = function(k) {
      return new Long(_bshl(this.digits.slice(), k));
    };

    Long.prototype.bshr = function(k) {
      return new Long(_bshr(this.digits.slice(), k));
    };

    Long.test = function() {
      var B, C, C1, C2, H, I, K, M, N, b, codex, h, i, j, k, m, product, q, r, randomHex, result, sum, x, y, _aa, _i, _j, _k, _l, _len, _m, _n, _o, _p, _q, _r, _ref, _ref1, _ref10, _ref11, _ref12, _ref13, _ref14, _ref15, _ref16, _ref17, _ref2, _ref3, _ref4, _ref5, _ref6, _ref7, _ref8, _ref9, _s, _t, _u, _v, _w, _x, _y, _z;
      (function() {
        var H, codex, i, randomHex, result, _i, _results;
        codex = (function() {
          var i, _i, _results;
          _results = [];
          for (i = _i = 0; _i < 16; i = ++_i) {
            _results.push(i.toString(16));
          }
          return _results;
        })();
        randomHex = function(n) {
          var i;
          return ((function() {
            var _i, _results;
            _results = [];
            for (i = _i = 1; 1 <= n ? _i < n : _i > n; i = 1 <= n ? ++_i : --_i) {
              _results.push(codex[floor(16 * random())]);
            }
            return _results;
          })()).join('');
        };
        _results = [];
        for (i = _i = 0; _i < 10; i = ++_i) {
          try {
            H = (randomHex(30)).replace(/^0+/, '');
            _results.push(assert((result = _hex(_repr(H))) === H));
          } catch (err) {
            console.log('_hex and _repr test failed for H = ' + H);
            console.log(result);
            console.log(err);
            _results.push(console.log(err.message));
          }
        }
        return _results;
      })();
      for (i = _i = 1, _ref = __radix__ * 2; 1 <= _ref ? _i < _ref : _i > _ref; i = 1 <= _ref ? ++_i : --_i) {
        try {
          k = floor(__base__ * random());
          assert((_value(_bshl([k], i))) === k * pow(2, i));
        } catch (err) {
          console.log('_bshl test failed for i = ' + i + '; k = ' + k);
          console.log('' + (k * pow(2, i)) + ' != ' + _value(_bshl([k], i)));
          console.log(err);
          console.log(err.message);
        }
      }
      for (i = _j = 1, _ref1 = __radix__ * 2; 1 <= _ref1 ? _j < _ref1 : _j > _ref1; i = 1 <= _ref1 ? ++_j : --_j) {
        try {
          assert((_value(_bshr(_bshl([k], i), i))) === k);
        } catch (err) {
          console.log('_bshl/_bshr consistency test failed for i = ' + i + '; k = ' + k);
          console.log('' + k + ' != ' + _value(_bshl([k], i)));
          console.log(err);
          console.log(err.message);
        }
      }
      i = 0;
      while ((pow(2, i)) < 1 + (pow(2, i))) {
        K = pow(2, i++);
        for (k = _k = _ref2 = K - 100, _ref3 = K + 100; _ref2 <= _ref3 ? _k < _ref3 : _k > _ref3; k = _ref2 <= _ref3 ? ++_k : --_k) {
          x = new Long(k);
          try {
            assert(k === Number(x));
          } catch (err) {
            console.log('linear construction test #' + i + ' failed for ' + k);
            console.log('' + k + ' != ' + Number(x));
            console.log(err);
            break;
          }
        }
        for (k = _l = _ref4 = -K - 100, _ref5 = -K + 100; _ref4 <= _ref5 ? _l < _ref5 : _l > _ref5; k = _ref4 <= _ref5 ? ++_l : --_l) {
          x = new Long(k);
          try {
            assert(k === Number(x));
          } catch (err) {
            console.log('linear construction test #' + i + ' failed for ' + k);
            console.log('' + k + ' != ' + Number(x));
            console.log(err);
            break;
          }
        }
      }
      K = (pow(2, 3 * __radix__ + 1)) - 1;
      C = (pow(2, 3 * __radix__)) - 1;
      m = Infinity;
      M = -Infinity;
      N = 1000;
      while (N-- > 0) {
        k = floor(K * random() - C);
        try {
          assert(k === Number(new Long(k)));
        } catch (err) {
          console.log('stochastic construction test #' + (1000 - N + 1) + ' failed for ' + k);
          console.log('' + k + ' != ' + Number(x));
          console.log(err);
          N = 0;
        }
        m = min(m, k);
        M = max(M, k);
      }
      i = 0;
      while ((pow(2, i)) < 1 + (pow(2, i))) {
        K = pow(2, i++);
        for (k = _m = _ref6 = K - 100, _ref7 = K + 100; _ref6 <= _ref7 ? _m < _ref7 : _m > _ref7; k = _ref6 <= _ref7 ? ++_m : --_m) {
          x = new Long(k);
          y = new Long(-k);
          try {
            assert(0 === Number(x.add(y)));
          } catch (err) {
            console.log('linear negate test #' + i + ' failed for ' + k);
            console.log('' + (Number(x.add(y))) + ' != 0');
            console.log(err);
            break;
          }
          try {
            assert(0 === Number(y.add(x)));
          } catch (err) {
            console.log('linear negate test #' + i + ' failed for ' + -k);
            console.log('' + (Number(y.add(x))) + ' != 0');
            console.log(err);
            break;
          }
        }
      }
      i = 0;
      while ((pow(2, i)) < 1 + (pow(2, i))) {
        K = pow(2, i++);
        C = floor(K / 2);
        N = min(C, 100);
        while (N-- > 0) {
          k = floor(K * random() - C);
          h = floor(K * random() - C);
          try {
            sum = Number((new Long(h)).add(new Long(k)));
            assert(h + k === sum);
          } catch (err) {
            console.log('stochastic sum test #' + i + ' failed for ' + k + ' and ' + h);
            console.log('' + (k + h) + ' != ' + sum);
            console.log(err);
            N = 0;
          }
        }
      }
      I = floor((i - 1) / 2);
      i = 0;
      while (i < I) {
        K = pow(2, i++);
        for (k = _n = _ref8 = K - 100, _ref9 = K + 100; _ref8 <= _ref9 ? _n < _ref9 : _n > _ref9; k = _ref8 <= _ref9 ? ++_n : --_n) {
          x = new Long(k);
          try {
            assert(x * x === Number(x.mul(x)));
          } catch (err) {
            console.log('linear square test #' + i + ' failed for ' + k);
            console.log('' + (Number(x.mul(x))) + ' != ' + (x * x));
            console.log(err);
            break;
          }
        }
      }
      i = 0;
      while (i < I) {
        K = pow(2, i++);
        C = floor(K / 2);
        N = min(C, 100);
        while (N-- > 0) {
          k = floor(K * random() - C);
          h = floor(K * random() - C);
          try {
            product = Number((new Long(h)).mul(new Long(k)));
            assert(h * k === product);
          } catch (err) {
            console.log('stochastic product test #' + i + ' failed for ' + k + ' and ' + h);
            console.log('' + (k * h) + ' != ' + product);
            console.log(err);
            N = 0;
          }
        }
      }
      i = 0;
      while (i < I) {
        K = pow(2, i++);
        for (k = _o = _ref10 = K - 100, _ref11 = K + 100; _ref10 <= _ref11 ? _o < _ref11 : _o > _ref11; k = _ref10 <= _ref11 ? ++_o : --_o) {
          x = new Long(k);
          try {
            assert(x * x === Number(x.mul(x)));
          } catch (err) {
            console.log('linear Karatsuba square test #' + i + ' failed for ' + k);
            console.log('' + (Number(x.mul(x))) + ' != ' + (x * x));
            console.log(err);
            break;
          }
        }
      }
      i = 0;
      while (i < I) {
        K = pow(2, i++);
        C = floor(K / 2);
        N = min(C, 100);
        while (N-- > 0) {
          k = floor(K * random() - C);
          h = floor(K * random() - C);
          try {
            product = Number((new Long(h)).kmul(new Long(k)));
            assert(h * k === product);
          } catch (err) {
            console.log('stochastic Karatsuba product test #' + i + ' failed for ' + k + ' and ' + h);
            console.log('' + (k * h) + ' != ' + product);
            console.log(err);
            N = 0;
          }
        }
      }
      codex = (function() {
        var _p, _results;
        _results = [];
        for (i = _p = 0; _p < 16; i = ++_p) {
          _results.push(i.toString(16));
        }
        return _results;
      })();
      randomHex = function(n) {
        return ((function() {
          var _p, _results;
          _results = [];
          for (i = _p = 1; 1 <= n ? _p < n : _p > n; i = 1 <= n ? ++_p : --_p) {
            _results.push(codex[floor(16 * random())]);
          }
          return _results;
        })()).join('');
      };
      for (i = _p = 4; _p < 10; i = ++_p) {
        N = pow(2, i);
        H = [];
        K = [];
        for (j = _q = 0; _q < 100; j = ++_q) {
          h = new Long(_repr(randomHex(N)));
          k = new Long(_repr(randomHex(N)));
          try {
            assert(_eq(h.mul(k), h.kmul(k)));
          } catch (err) {
            console.log('stochastic multiplication consistency test failed');
            console.log(err, err.message);
            console.log('H: ');
            console.log(_hex(h.digits));
            console.log('K: ');
            console.log(_hex(k.digits));
            break;
          }
        }
      }
      (function() {
        var i_long, j_long, _r, _results;
        try {
          _results = [];
          for (i = _r = 0; _r <= 100; i = _r += 4) {
            i_long = (new Long(1)).bshl(i);
            _results.push((function() {
              var _results1, _s;
              _results1 = [];
              for (j = _s = 0; _s <= 100; j = _s += 4) {
                j_long = (new Long(1)).bshl(j);
                H = _hex((i_long.mul(j_long)).digits);
                _results1.push(assert(H.length === (i >> 2) + (j >> 2) + 1 && ((H.match(/^10*$/)) != null)));
              }
              return _results1;
            })());
          }
          return _results;
        } catch (err) {
          console.log('simple multiplication grid test failed for i = ' + i + '; j = ' + j);
          console.log('result: "' + H + '"');
          console.log(err);
          return console.log(err.message);
        }
      })();
      (function() {
        var _r, _results;
        try {
          _results = [];
          for (i = _r = 1; _r <= 50; i = ++_r) {
            h = new Long(makeString('f', i));
            H = _hex((h.mul(h)).digits);
            _results.push(assert(H.length === 2 * i && ((H.match(/^f*e0*1$/)) != null)));
          }
          return _results;
        } catch (err) {
          console.log('0xfff...fff multiplication test failed for i = ' + i);
          console.log('result: "' + H + '"');
          console.log(err);
          return console.log(err.message);
        }
      })();
      h = new Long(50);
      for (i = _r = 1; _r < 10; i = ++_r) {
        k = new Long(i);
        try {
          _ref12 = h.divmod(k), q = _ref12[0], r = _ref12[1];
          if (k === 0) {
            assert(q === Infinity && (Number(r)) === 0);
          } else {
            assert((Number(k)) * (Number(q)) + (Number(r)) === Number(h));
          }
        } catch (err) {
          console.log('positive-positive divmod test #' + i + ' failed for ' + (Number(h)) + ' and ' + (Number(k)));
          console.log('[' + (floor(h / k)) + ', ' + (h % k) + '] != [' + (Number(q)) + ', ' + (Number(r)) + ']');
          console.log(err);
          console.log(err.message);
          N = 0;
        }
      }
      h = new Long(50);
      for (i = _s = 1; _s < 10; i = ++_s) {
        k = new Long(-i);
        try {
          _ref13 = h.divmod(k), q = _ref13[0], r = _ref13[1];
          if (k === 0) {
            assert(q === Infinity && (Number(r)) === 0);
          } else {
            assert((Number(k)) * (Number(q)) + (Number(r)) === Number(h));
          }
        } catch (err) {
          console.log('positive-negative divmod test #' + i + ' failed for ' + (Number(h)) + ' and ' + (Number(k)));
          console.log('[' + (floor(h / k)) + ', ' + (h % i) + '] != [' + (Number(q)) + ', ' + (Number(r)) + ']');
          console.log(err);
          console.log(err.message);
          N = 0;
        }
      }
      h = new Long(-50);
      for (i = _t = 1; _t < 10; i = ++_t) {
        k = new Long(i);
        try {
          _ref14 = h.divmod(k), q = _ref14[0], r = _ref14[1];
          if (k === 0) {
            assert(q === Infinity && (Number(r)) === 0);
          } else {
            assert((Number(k)) * (Number(q)) + (Number(r)) === Number(h));
          }
        } catch (err) {
          console.log('negative-positive divmod test #' + i + ' failed for ' + (Number(h)) + ' and ' + (Number(k)));
          console.log('[' + (floor(h / k)) + ', ' + (-h % i) + '] != [' + (Number(q)) + ', ' + (Number(r)) + ']');
          console.log(err);
          console.log(err.message);
          N = 0;
        }
      }
      h = new Long(-50);
      for (i = _u = 1; _u < 10; i = ++_u) {
        k = new Long(-i);
        try {
          _ref15 = h.divmod(k), q = _ref15[0], r = _ref15[1];
          if (k === 0) {
            assert(q === Infinity && (Number(r)) === 0);
          } else {
            assert((Number(k)) * (Number(q)) + (Number(r)) === Number(h));
          }
        } catch (err) {
          console.log('negative-negative divmod test #' + i + ' failed for ' + (Number(h)) + ' and ' + (Number(k)));
          console.log('[' + (floor(h / k)) + ', ' + (-h % i) + '] != [' + (Number(q)) + ', ' + (Number(r)) + ']');
          console.log(err);
          console.log(err.message);
          N = 0;
        }
      }
      i = 0;
      while (i < I) {
        K = pow(2, i++);
        C1 = floor(K / 2);
        C2 = floor(C1 / 2);
        N = min(C2, 100);
        while (N-- > 0) {
          k = floor(K * random() - C1);
          h = floor(K * random() - C2);
          try {
            _ref16 = (new Long(h)).divmod(new Long(k)), q = _ref16[0], r = _ref16[1];
            if (k === 0) {
              assert(q === Infinity && (Number(r)) === 0);
            } else {
              assert(k * (Number(q)) + (Number(r)) === h);
            }
          } catch (err) {
            console.log('stochastic divmod test #' + i + ' failed for ' + h + ' and ' + k);
            console.log('[' + (floor(h / k)) + ', ' + (((h % k) + h) % k) + '] != [' + (Number(q)) + ', ' + (Number(r)) + ']');
            console.log(err);
            console.log(err.message);
            N = 0;
          }
        }
      }
      for (i = _v = 0; _v < 100; i = ++_v) {
        _ref17 = [2, 5];
        for (_w = 0, _len = _ref17.length; _w < _len; _w++) {
          k = _ref17[_w];
          B = [0, 0, 0x4000000, 0x40000, 0x2000, 0x400];
          b = ceil(B[k] * random());
          try {
            result = Number((new Long(b)).pow(k));
            assert((pow(b, k)) === result);
          } catch (err) {
            console.log('systematic pow test #' + i + ' failed for ' + b + ' and ' + k);
            console.log('' + (pow(b, k)) + ' != ' + result);
            console.log(err);
            console.log(err.message);
            N = 0;
          }
        }
      }
      for (i = _x = 4; _x < 10; i = ++_x) {
        N = pow(2, i);
        for (j = _y = 0; _y < 100; j = ++_y) {
          h = new Long(_repr(randomHex(N)));
          k = new Long(_repr(randomHex(N)));
          m = new Long(_repr(randomHex(N)));
          try {
            assert(_eq((h.mul(k)).mod(m), h.mulmod(k, m)));
          } catch (err) {
            console.log('stochastic mulmod consistency test failed');
            console.log(err, err.message);
            console.log('h: ');
            console.log(_hex(h.digits));
            console.log('k: ');
            console.log(_hex(k.digits));
            console.log('m: ');
            console.log(_hex(m.digits));
            console.log(err);
            console.log(err.message);
            break;
          }
        }
      }
      for (i = _z = 4; _z < 10; i = ++_z) {
        N = pow(2, i);
        k = 7 - (i >> 1);
        for (j = _aa = 0; _aa < 100; j = ++_aa) {
          h = new Long(_repr(randomHex(N)));
          m = new Long(_repr(randomHex(N)));
          try {
            assert(_eq((h.pow(k)).mod(m), h.powmod(k, m)));
          } catch (err) {
            console.log('stochastic powmod consistency test failed for exponent ' + k);
            console.log(err, err.message);
            console.log('h: ');
            console.log(_hex(h.digits));
            console.log('m: ');
            console.log(_hex(m.digits));
            console.log(err);
            console.log(err.message);
            break;
          }
        }
      }
      return void 0;
    };

    Long.testKaratsubaThreshold = function() {
      var H, K, codex, endKaratsuba, endNaive, i, j, randomHex, startKaratsuba, startNaive, _i, _j;
      codex = (function() {
        var i, _i, _results;
        _results = [];
        for (i = _i = 0; _i < 16; i = ++_i) {
          _results.push(i.toString(16));
        }
        return _results;
      })();
      randomHex = function(n) {
        var i;
        return ((function() {
          var _i, _results;
          _results = [];
          for (i = _i = 1; 1 <= n ? _i < n : _i > n; i = 1 <= n ? ++_i : --_i) {
            _results.push(codex[floor(16 * random())]);
          }
          return _results;
        })()).join('');
      };
      H = (function() {
        var _i, _results;
        _results = [];
        for (j = _i = 0; _i < 1000; j = ++_i) {
          _results.push(new Long(randomHex(2048)));
        }
        return _results;
      })();
      K = (function() {
        var _i, _results;
        _results = [];
        for (j = _i = 0; _i < 1000; j = ++_i) {
          _results.push(new Long(randomHex(2048)));
        }
        return _results;
      })();
      startKaratsuba = new Date;
      for (i = _i = 0; _i < 1000; i = ++_i) {
        H[i].kmul(K[i]);
      }
      endKaratsuba = new Date;
      startNaive = new Date;
      for (i = _j = 0; _j < 1000; i = ++_j) {
        H[i].mul(K[i]);
      }
      endNaive = new Date;
      console.log('Naive', endNaive - startNaive);
      return console.log('Karatsuba', endKaratsuba - startKaratsuba);
    };

    return Long;

  })();

  exports = window;

  exports.Long__radix__ = Long;

  exports.Long = Long;

}).call(this);
