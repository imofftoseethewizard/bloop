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

class Primes

  top = new Long 2

  primes = [top, (new Long 3), (new Long 5)]

  @get: (n) ->
    while n > primes.length-1
      x = top.add 1
      primes.push x if @check x
      top = x

    primes[n]

  @check: (x) ->
    prime = false
    if x.bit 0
      t = x.msb() >> 1
      i = 0
      ok = true

      while ok and (p = @get(i++))? and t >= p.msb()
        ok = (x.mod p).gt 0

      prime = ok

    prime

  @all: () -> primes.slice()

  @find: (bits) ->
    start = new Date
    i = 0
    p = null
    while not p?
      x = Long.random bits
      t = new IntegratedPrimalityTest x
      while t.check() then null
      if t.result then p = x
      i++

    p: p
    trials: i
    time: (new Date) - start


class PrimalityTest
  check: () ->
    @next() if not @finished()
    @result = true if not @result? and @trials.length == 0
    not @finished()

  progress: () -> if @finished() then 1 else (@T - @trials.length) / @T

  finished: () -> @result? or @trials.length is 0


class LowPrimesTest extends PrimalityTest

  constructor: (@N, @options) ->
    @options or= {}

    @T = @options.trials or @N.msb()
    @interval = @options.interval or 100

    Primes.get @T
    @trials = Primes.all().slice 0, @T

  next: () ->
    start = new Date
    while not @finished() and (new Date) - start < @interval
      p = @trials.pop()
      result = false if (@N.mod p).gt 0


class MillerRabinTest extends PrimalityTest
  { floor, random } = Math

  { _bit, _bshr, _repr } = Long

  randomHex = do () ->
    codex = do () -> i.toString(16) for i in [0...16]
    (n) ->
      (codex[floor 16*random()] for i in [1...n]).join ''

  randomDigits = (bits) -> _repr randomHex bits >> 2

  randomLong = (bits) -> new Long randomDigits bits

  @randomLong: randomLong

  constructor: (@N, @options) ->
    @options or= {}

    @T = @options.trials or 20

    if (N.eq 1) or (N.bit 0) is 0
      @result = false
      return

    @result = null
    @T or= 100
    @s = 0

    @m = @N.sub 1
    xs = @m.digits.slice()

    while (_bit xs, 0) is 0
      @s++
      _bshr xs, 1

    @r = new Long xs

    Primes.get @T * 10

    primes = Primes.all().slice()
    count = primes.length
    # for i in [0...count] by 1
    #   j = floor count * random()
    #   [primes[i], primes[j]] = [primes[j], primes[i]]

    @RmodN = R = new RingMod @N
    @trials = (new R p for p in primes.slice 0, @T)

  next: () ->
    a = @trials.pop()
    y = a.pow @r
    if not (y.eq 1) and not y.eq @m
      j = 1
      while not @result? and j < @s and not y.eq @m
        y = y.pow 2
        @result = false if y.eq 1
        j++

      @result = false if not y.eq @m

  @test: () ->
    name = 'basic consistency'
    passed = 0
    try
      for bits in [10..30] by 10
        console.log 'bits: ' + bits
        for i in [0...100]
          x = (randomLong bits).add (new Long 1).bshl bits
          t = new MillerRabinTest x, bits >> 1
          while t.check() then null
          expected = Primes.check x
          actual = t.result
          assert expected is actual
          passed++

      console.log name + ': ' + passed

    catch err
      console.log name + ' test failed on pass ' + (passed+1) + '.'
      console.log 'x:', x.valueOf() if x?
      console.log 'expected:', expected
      console.log 'actual:', actual
      console.log err
      console.log err.message


class IntegratedPrimalityTest extends PrimalityTest

  constructor: (@N, @options) ->
    @options or= {}
    @lp = new LowPrimesTest @N, @options.LowPrimes
    @mr = new MillerRabinTest @N, @options.MillerRabin

  progress: () -> (@lp.progress() + @mr.progress()) / 2

  check: () ->
    @next() if not @finished()
    not @finished()

  next: () ->
    if not @lp.finished() then @lp.check()
    else if not @mr.finished() then @mr.check()

    if not @result?
      @result = false if @lp.result? and not @lp.result
      @result = @mr.result if @mr.result?

  finished: () -> @result? or @lp.finished() and @mr.finished()


window.Primes = Primes
Primes.MillerRabinTest = MillerRabinTest
Primes.LowPrimesTest = LowPrimesTest
Primes.IntegratedTest = IntegratedPrimalityTest