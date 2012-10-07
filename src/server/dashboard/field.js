// Generated by CoffeeScript 1.3.3
(function() {
  var Field, Residue, assert,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __slice = [].slice;

  assert = (function() {
    var indents, makeString, stackTrace;
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
    return function(cond) {
      if (!cond) {
        throw stackTrace();
      }
    };
  })();

  Residue = (function() {

    function Residue() {}

    return Residue;

  })();

  Field = (function() {
    var _add, _cofactor, _div, _invmod, _lt, _mod, _mul, _shl, _shr, _size, _sub, _zeros;

    _add = Long._add, _div = Long._div, _invmod = Long._invmod, _lt = Long._lt, _mod = Long._mod, _mul = Long._mul, _shl = Long._shl, _shr = Long._shr, _size = Long._size, _sub = Long._sub, _zeros = Long._zeros;

    _cofactor = function(ms) {
      var w, ws;
      w = ((new Long([0, 1])).sub([ms[0]])).invmod([0, 1]);
      ws = w != null ? w.digits : [0];
      return ws;
    };

    function Field(M) {
      var FieldResidue;
      M = (M instanceof Long ? M : new Long(M)).digits;
      return FieldResidue = (function(_super) {
        var B, K, R, R2, R2_M, R_M, Rb, W, _modM, _mont, _negate, _pow, _reduce, _toField, _toLong;

        __extends(FieldResidue, _super);

        FieldResidue.M = M;

        FieldResidue.K = K = _size(M);

        FieldResidue.R = R = _shl([1], K);

        FieldResidue.R2 = R2 = _shl([1], 2 * K);

        FieldResidue.W = W = _cofactor(M);

        FieldResidue.B = B = _div(R2, M);

        FieldResidue.Rb = Rb = _shl([1], K + 1);

        FieldResidue.R_M = R_M = _mod(R, M);

        FieldResidue.R2_M = R2_M = _mod(R2, M);

        _modM = (function() {
          if (_lt(M, _shl([1], 1))) {
            return function(xs) {
              return _mod(xs, M);
            };
          } else {
            return function(xs) {
              var qs, rs, rs_1, rs_2;
              if ((_size(xs)) >= 2 * K) {
                return _mod(xs, M);
              } else {
                qs = _shr(_mul(_shr(xs.slice(), K - 1), B), K + 1);
                rs_1 = xs.slice(0, K + 1);
                rs_2 = (_mul(qs, M)).slice(0, K + 1);
                if (_lt(rs_1, rs_2)) {
                  _add(rs_1, Rb);
                }
                assert(!_lt(rs_1, rs_2));
                rs = _sub(rs_1, rs_2);
                while (!_lt(rs, M)) {
                  _sub(rs, M);
                }
                return rs;
              }
            };
          }
        })();

        _reduce = function(xs) {
          var i, u_i, zs, _i;
          zs = [];
          for (i = _i = 0; 0 <= K ? _i < K : _i > K; i = 0 <= K ? ++_i : --_i) {
            u_i = (_mul([xs[i]], [W]))[0];
            _add(zs, _shl(_mul(M, [u_i]), i));
          }
          _shr(zs, K);
          if (!_lt(zs, M)) {
            _sub(zs, M);
          }
          return zs;
        };

        _toField = function(xs) {
          return _modM(_shl(xs.slice(), K));
        };

        _toLong = function(xs) {
          return _reduce(xs);
        };

        _negate = function(xs) {
          if (_eq(xs, [0])) {
            return xs;
          } else {
            return _sub(M.slice(), xs);
          }
        };

        _mont = function(xs, ys) {
          var i, u_i, x_i, y_0, zs, _i;
          zs = _zeros.slice(0, K);
          y_0 = ys[0];
          for (i = _i = 0; 0 <= K ? _i < K : _i > K; i = 0 <= K ? ++_i : --_i) {
            x_i = xs[i];
            u_i = (_add([xs[0]], _mul(_mul([x_i], [y_0]), [W])))[0];
            _add(zs, _add(_mul(ys, [x_i]), _mul(M, [u_i])));
            _shr(zs, 1);
          }
          if (!_lt(zs, M)) {
            _sub(zs, M);
          }
          return zs;
        };

        _pow = function(xs, ys) {
          var i, ws, zs, _i;
          ws = _mont(xs, R2_M);
          zs = R_M.slice();
          for (i = _i = K; K <= 0 ? _i <= 0 : _i >= 0; i = K <= 0 ? ++_i : --_i) {
            zs = _mont(zs, zs);
            if (_bit(ys, i)) {
              zs = _mont(zs, ws);
            }
          }
          return _mont(zs, [1]);
        };

        FieldResidue._modM = _modM;

        FieldResidue._reduce = _reduce;

        FieldResidue._toLong = _toLong;

        FieldResidue._toField = _toField;

        FieldResidue._negate = _negate;

        FieldResidue._mont = _mont;

        FieldResidue._pow = _pow;

        function FieldResidue(x) {
          var xs;
          if (x instanceof FieldResidue) {
            this.digits = x.digits.slice();
          } else {
            if (x instanceof Residue) {
              x = x.toLong();
            }
            if (!(x instanceof Long)) {
              x = new Long(x);
            }
            xs = _toField(x.digits);
            if (x.sign < 0) {
              xs = _negate(xs);
            }
            this.digits = xs;
          }
        }

        FieldResidue.prototype.valueOf = function() {
          return this.toLong().valueOf();
        };

        FieldResidue.prototype.toString = function(radix) {
          return this.toLong().toString(radix);
        };

        FieldResidue.prototype.toLong = function() {
          return new Long(_toLong(this.digits));
        };

        FieldResidue.prototype.negate = function() {
          var z;
          z = new FieldResidue;
          z.digits = _negate(xs.slice());
          return z;
        };

        FieldResidue.prototype.add = function(y) {
          var z;
          if (!(y instanceof FieldResidue)) {
            y = new FieldResidue(y);
          }
          z = new FieldResidue;
          z.digits = _add(this.digits.slice(), y.digits);
          return z;
        };

        FieldResidue.prototype.sub = function(y) {
          return this.add((new FieldResidue(y)).negate());
        };

        FieldResidue.prototype.mul = function(y) {
          var z;
          if (!(y instanceof FieldResidue)) {
            y = new FieldResidue(y);
          }
          z = new FieldResidue;
          z.digits = _mont(this.digits, y.digits);
          return z;
        };

        FieldResidue.prototype.pow = function(y) {
          var z;
          if (!(y instanceof FieldResidue)) {
            y = new FieldResidue(y);
          }
          z = new FieldResidue;
          z.digits = _pow(this.digits, y.digits);
          return z;
        };

        return FieldResidue;

      })(Residue);
    }

    Field.test = function() {
      var floor, random, randomDigits, randomHex, randomLong, _bshl, _eq, _repr;
      floor = Math.floor, random = Math.random;
      _bshl = Long._bshl, _eq = Long._eq, _repr = Long._repr;
      randomHex = (function() {
        var codex;
        codex = (function() {
          var i, _i, _results;
          _results = [];
          for (i = _i = 0; _i < 16; i = ++_i) {
            _results.push(i.toString(16));
          }
          return _results;
        })();
        return function(n) {
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
      })();
      randomDigits = function(bits) {
        return _repr(randomHex(bits >> 2));
      };
      randomLong = function(bits) {
        return new Long(randomDigits(bits));
      };
      return (function() {
        var F, Ms, actual, expected, i, ms, xs;
        return Ms = (function() {
          var _i, _len, _ref, _results;
          try {
            _ref = [[7], [65535], (new Long(2147483647)).digits, (new Long(200560490131)).digits, _sub(_bshl([1], 61), 1)].concat(__slice.call((function() {
                var _j, _results1;
                _results1 = [];
                for (i = _j = 0; _j < 15; i = ++_j) {
                  _results1.push(randomDigits(100));
                }
                return _results1;
              })()));
            _results = [];
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              ms = _ref[_i];
              F = new Field(ms);
              _results.push((function() {
                var _j, _len1, _ref1, _results1;
                _ref1 = [[1], _sub(F.M.slice(), 1), _add(F.M.slice(), 1)].concat(__slice.call((function() {
                    var _k, _results2;
                    _results2 = [];
                    for (i = _k = 0; _k < 995; i = ++_k) {
                      _results2.push(randomDigits(200));
                    }
                    return _results2;
                  })()));
                _results1 = [];
                for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
                  xs = _ref1[_j];
                  expected = _mod(xs, ms);
                  actual = F._modM(xs);
                  _results1.push(assert(_eq(expected, actual)));
                }
                return _results1;
              })());
            }
            return _results;
          } catch (err) {
            console.log('Field modM test failed.');
            console.log('ms:', ms);
            console.log('xs:', xs);
            console.log('expected:', expected);
            console.log('actual:', actual);
            console.log(err);
            return console.log(err.message);
          }
        })();
      })();
    };

    Field.diagnose = function() {
      var m, xs;
      xs = _repr('55e3ae083d0cbdfec136f83823c2d8ad457638380374d291c');
      return m = Long(2147483647);
    };

    return Field;

  })();

  window.Residue = Residue;

  window.Field = Field;

}).call(this);
