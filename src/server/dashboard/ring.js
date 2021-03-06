// Generated by CoffeeScript 1.3.3
(function() {
  var Residue, RingMod, assert,
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

  Residue = (function(_super) {

    __extends(Residue, _super);

    function Residue() {
      return Residue.__super__.constructor.apply(this, arguments);
    }

    return Residue;

  })(Long);

  RingMod = (function() {
    var _add, _bit, _cofactor, _div, _lt, _mod, _msb, _mul, _shl, _shr, _size, _sub, _trim, _zeros;

    _add = Long._add, _bit = Long._bit, _div = Long._div, _lt = Long._lt, _mod = Long._mod, _msb = Long._msb, _mul = Long._mul, _shl = Long._shl, _shr = Long._shr, _size = Long._size, _sub = Long._sub, _trim = Long._trim, _zeros = Long._zeros;

    _cofactor = function(ms) {
      var w, ws;
      w = (new Long(ms)).negate().invmod([0, 1]);
      ws = w != null ? w.digits : [0];
      return ws;
    };

    RingMod._cofactor = _cofactor;

    function RingMod(M) {
      var RingResidue;
      M = (M instanceof Long ? M : new Long(M)).digits;
      return RingResidue = (function(_super) {
        var B, K, R, R2, R2_M, R_M, Rb, W, _lift, _modM, _mont, _negate, _pow, _reduce, _toLong, _toRing;

        __extends(RingResidue, _super);

        RingResidue.M = M;

        RingResidue.K = K = _size(M);

        RingResidue.R = R = _shl([1], K);

        RingResidue.R2 = R2 = _shl([1], 2 * K);

        RingResidue.W = W = _cofactor(M);

        RingResidue.B = B = _div(R2, M);

        RingResidue.Rb = Rb = _shl([1], K + 1);

        RingResidue.R_M = R_M = _mod(R, M);

        RingResidue.R2_M = R2_M = _mod(R2, M);

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

        _lift = function(xs) {
          return _modM(_shl(xs, K));
        };

        _reduce = function(xs) {
          var i, u_i, _i;
          for (i = _i = 0; _i < K; i = _i += 1) {
            u_i = (_mul([xs[i]], W))[0];
            _add(xs, _shl(_mul(M, [u_i]), i));
          }
          _shr(xs, K);
          if (!_lt(xs, M)) {
            _sub(xs, M);
          }
          return xs;
        };

        _toRing = function(xs) {
          return _reduce(xs);
        };

        _toLong = function(xs) {
          return _lift(xs);
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
          for (i = _i = 0; _i < K; i = _i += 1) {
            x_i = xs[i];
            u_i = (_mul(W, _add([zs[0]], _mul([x_i], [y_0]))))[0];
            _add(zs, _add(_mul(ys, [x_i]), _mul(M, [u_i])));
            _shr(zs, 1);
          }
          if (!_lt(zs, M)) {
            _sub(zs, M);
          }
          return zs;
        };

        _pow = function(xs, ys) {
          var i, t, ws, zs, _i;
          ws = _mont(xs, R2_M);
          zs = R_M.slice();
          t = _msb(ys);
          for (i = _i = t; _i >= 0; i = _i += -1) {
            zs = _mont(zs, zs);
            if (_bit(ys, i)) {
              zs = _mont(zs, ws);
            }
          }
          return _mont(zs, [1]);
        };

        RingResidue._modM = _modM;

        RingResidue._lift = _lift;

        RingResidue._reduce = _reduce;

        RingResidue._toLong = _toLong;

        RingResidue._toRing = _toRing;

        RingResidue._negate = _negate;

        RingResidue._mont = _mont;

        RingResidue._pow = _pow;

        RingResidue.prototype.Long = RingResidue;

        function RingResidue(x) {
          RingResidue.__super__.constructor.call(this, x);
          if (this.sign < 0) {
            this.digits = _negate(this.digits);
          }
          if (!_lt(this.digits, M)) {
            this.digits = _trim(_lift(_reduce(this.digits)));
          }
          this.sign = 1;
        }

        RingResidue.prototype.negate = function() {
          var z;
          z = new this.Long(this);
          z.digits = _negate(z.digits);
          return z;
        };

        RingResidue.prototype.abs = function() {
          return new this.Long(this);
        };

        RingResidue.prototype.mul = function(y) {
          var z;
          if (!(y instanceof this.Long)) {
            y = new this.Long(y);
          }
          z = new this.Long;
          z.digits = _lift(_mont(this.digits, y.digits));
          return z;
        };

        RingResidue.prototype.kmul = function(y) {
          return this.mul(y);
        };

        RingResidue.prototype.pow = function(y) {
          var z;
          if (!(y instanceof this.Long)) {
            y = new this.Long(y);
          }
          z = new this.Long;
          z.digits = _pow(this.digits, y.digits);
          return z;
        };

        return RingResidue;

      })(Residue);
    }

    RingMod.test = function() {
      var floor, random, randomDigits, randomHex, randomLong, testDigits, testModuli, testResidues, testRings, _bshl, _eq, _repr, _value;
      floor = Math.floor, random = Math.random;
      _bshl = Long._bshl, _eq = Long._eq, _repr = Long._repr, _value = Long._value;
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
      testModuli = function(N) {
        var i;
        N || (N = 15);
        return [[7], [65535], (new Long(2147483647)).digits, (new Long(200560490131)).digits, _sub(_bshl([1], 61), 1)].concat(__slice.call((function() {
            var _i, _ref, _results;
            _results = [];
            for (i = _i = 0, _ref = N - 5; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
              _results.push(randomDigits(100));
            }
            return _results;
          })()));
      };
      testDigits = function(M) {
        var i;
        return [[1], _sub(M.slice(), 1), _add(M.slice(), 1)].concat(__slice.call((function() {
            var _i, _results;
            _results = [];
            for (i = _i = 0; _i < 995; i = ++_i) {
              _results.push(randomDigits(200));
            }
            return _results;
          })()));
      };
      testResidues = function(R) {
        var xs, _i, _len, _ref, _results;
        _ref = testDigits(R.M);
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          xs = _ref[_i];
          _results.push(new R(xs));
        }
        return _results;
      };
      testRings = function(N) {
        var R, ms, _i, _len, _ref, _results;
        _ref = (function() {
          var _j, _len, _ref, _results1;
          _ref = testModuli(N);
          _results1 = [];
          for (_j = 0, _len = _ref.length; _j < _len; _j++) {
            ms = _ref[_j];
            _results1.push(new RingMod(ms));
          }
          return _results1;
        })();
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          R = _ref[_i];
          if (!_eq(R.W, [0])) {
            _results.push(R);
          }
        }
        return _results;
      };
      (function() {
        var R, actual, expected, name, passed, xs, _i, _j, _len, _len1, _ref, _ref1;
        name = 'Barret reduction';
        passed = 0;
        try {
          _ref = testRings();
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            R = _ref[_i];
            _ref1 = testDigits(R.M);
            for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
              xs = _ref1[_j];
              expected = _mod(xs, R.M);
              actual = R._modM(xs);
              assert(_eq(expected, actual));
              passed++;
            }
          }
          return console.log(name + ': ' + passed);
        } catch (err) {
          console.log(name + ' test failed.');
          console.log('M:', (R != null) && R.M);
          console.log('xs:', xs);
          console.log('expected:', expected);
          console.log('actual:', actual);
          console.log(err);
          return console.log(err.message);
        }
      })();
      (function() {
        var R, actual, expected, name, passed, xs, _i, _j, _len, _len1, _lift, _reduce, _ref, _ref1;
        name = 'Montgomery lift-reduce consistency';
        passed = 0;
        try {
          _ref = testRings();
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            R = _ref[_i];
            _lift = R._lift, _reduce = R._reduce;
            _ref1 = testDigits(R.M);
            for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
              xs = _ref1[_j];
              expected = _mod(xs, R.M);
              actual = _lift(_reduce(xs.slice()));
              assert(_eq(expected, actual));
              passed++;
            }
          }
          return console.log(name + ': ' + passed);
        } catch (err) {
          console.log(name + ' test failed.');
          console.log('R.M:', R.M);
          console.log('xs:', xs);
          console.log('expected:', expected);
          console.log('actual:', actual);
          console.log(err);
          return console.log(err.message);
        }
      })();
      (function() {
        var Rmod7, actual, expected, i, j, name, passed, x, y, _i, _j;
        name = 'M = 7 multiplication consistency';
        passed = 0;
        try {
          Rmod7 = new RingMod(7);
          for (i = _i = 0; _i <= 7; i = ++_i) {
            x = new Rmod7(i);
            for (j = _j = 0; _j <= 7; j = ++_j) {
              y = new Rmod7(j);
              expected = ((new Long(x)).mul(y)).mod(7);
              actual = x.mul(y);
              assert(expected.eq(actual));
              passed++;
            }
          }
          return console.log(name + ': ' + passed);
        } catch (err) {
          console.log(name + ' test failed on pass ' + (passed + 1) + '.');
          if (x != null) {
            console.log('x:', x.valueOf());
          }
          if (y != null) {
            console.log('y:', y.valueOf());
          }
          if (expected != null) {
            console.log('expected:', expected.valueOf());
          }
          if (actual != null) {
            console.log('actual:', actual.valueOf());
          }
          console.log(err);
          return console.log(err.message);
        }
      })();
      (function() {
        var L, R, actual, expected, i, name, passed, residues, x, y, _i, _j, _len, _ref;
        name = 'multiplication consistency';
        passed = 0;
        try {
          _ref = testRings();
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            R = _ref[_i];
            residues = testResidues(R);
            L = residues.length >> 1;
            for (i = _j = 0; 0 <= L ? _j < L : _j > L; i = 0 <= L ? ++_j : --_j) {
              x = residues[i];
              y = residues[L + i];
              expected = ((new Long(x)).mul(y)).mod(R.M);
              actual = x.mul(y);
              assert(expected.eq(actual));
              passed++;
            }
          }
        } catch (err) {
          console.log(name + ' test failed on pass ' + (passed + 1) + '.');
          if (R != null) {
            console.log('M:', R.M.valueOf());
          }
          if (x != null) {
            console.log('x:', '0x' + x.toString(16));
          }
          if (y != null) {
            console.log('y:', '0x' + y.toString(16));
          }
          if (expected != null) {
            console.log('expected:', expected.valueOf());
          }
          if (actual != null) {
            console.log('actual:', actual.valueOf());
          }
          console.log(err);
          console.log(err.message);
        }
        return console.log(name + ': ' + passed);
      })();
      (function() {
        var Rmod7, actual, expected, i, j, name, passed, x, y, _i, _j;
        name = 'M = 7 pow consistency';
        passed = 0;
        try {
          Rmod7 = new RingMod(7);
          for (i = _i = 0; _i <= 7; i = ++_i) {
            x = new Rmod7(i);
            for (j = _j = 0; _j <= 256; j = ++_j) {
              y = new Rmod7(j);
              expected = (new Long(x)).powmod(y, 7);
              actual = x.pow(y);
              assert(expected.eq(actual));
              passed++;
            }
          }
          return console.log(name + ': ' + passed);
        } catch (err) {
          console.log(name + ' test failed on pass ' + (passed + 1) + '.');
          if (x != null) {
            console.log('x:', x.valueOf());
          }
          if (y != null) {
            console.log('y:', y.valueOf());
          }
          if (expected != null) {
            console.log('expected:', expected.valueOf());
          }
          if (actual != null) {
            console.log('actual:', actual.valueOf());
          }
          console.log(err);
          return console.log(err.message);
        }
      })();
      return (function() {
        var R, actual, expected, name, passed, x, y, _i, _j, _len, _len1, _ref, _ref1;
        name = 'pow consistency';
        passed = 0;
        try {
          _ref = testRings();
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            R = _ref[_i];
            _ref1 = testResidues(R);
            for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
              x = _ref1[_j];
              y = new R(floor(256 * random()));
              expected = (new Long(x)).powmod(y, R.M);
              actual = x.pow(y);
              assert(expected.eq(actual));
              passed++;
            }
          }
          return console.log(name + ': ' + passed);
        } catch (err) {
          console.log(name + ' test failed on pass ' + (passed + 1) + '.');
          if (x != null) {
            console.log('x:', x.valueOf());
          }
          if (y != null) {
            console.log('y:', y.valueOf());
          }
          if (expected != null) {
            console.log('expected:', expected.valueOf());
          }
          if (actual != null) {
            console.log('actual:', actual.valueOf());
          }
          console.log(err);
          return console.log(err.message);
        }
      })();
    };

    return RingMod;

  })();

  window.Residue = Residue;

  window.RingMod = RingMod;

}).call(this);
