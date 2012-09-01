if (typeof module) is 'undefined'
  exports = (window.common = window.common or {}).test = {}
else
  exports = module.exports

makeString = (ch, n) -> (ch for i in [0...n]).join ''

exports.stackTrace = () ->
  try
    (null)()
  catch e
    calls = (e.stack.split '\n').slice 3
    calls.reverse()
    ((makeString ' ', i) + call.slice 4 for call, i in calls).join '\n'

exports.fail = (args...) ->
  console.log stackTrace()
  console.log args...

SECONDS = 1000

class TestBlock
  constructor: () ->
    @logTitles = true
    @logFailures = true
    @logCompletions = true

  initialize: () ->
  prepare: () ->
  cleanup: () ->
  finalize: () ->

  log: (args...) ->
    console.log args...

  run: () ->
    log = @log
    @logTitles and log 'Testing ' + @name + ':'
    @count = 0
    @passed = 0
    for name, fn of @tests
      @logTitles and log '  ' + name
      @prepare()
      @result = null
      @expected = null
      @count++
      try
        if fn.call this
          @passed++
        else
          if @logFailures
            @log @name + '.' + name + ' failed:', @result
            if @expected?
              log '  expected: ', @expected
      catch error
        log 'test ' + @name + '.' + name + ' failed with an error: ', error
        log error.stack
      @cleanup()
    @logCompletions and log @name + ': all tests complete (' + @passed + '/' + @count + ')'

  tests: { }

exports.TestBlock = TestBlock

class AsyncTestBlock extends TestBlock
  constructor: () ->
    super()
    @timeout = 5*SECONDS

  initialize: (run) -> run()
  finalize: (done) -> done()

  run: (done) ->
    log = @log
    @logTitles and log 'Testing ' + @name + ':'
    @count = 0
    @passed = 0
    tests = ([name, fn] for name, fn of @tests)

    run = () =>
      if tests.length is 0
        @logCompletions and log @name + ': all tests complete (' + @passed + '/' + @count + ')'
        done()
      else
        [name, fn] = tests.shift()

        @logTitles and log '  ' + name
        @prepare()
        @result = null
        @expected = null
        @count++
        timer = null

        next = (err) =>
          if timer
            clearTimeout timer
            if not err?
              @passed++
            else
              if @logFailures
                @log @name + '.' + name + ' failed:', String err
                if @expected?
                  log '  expected: ', @expected

            @cleanup()
            run()

        cancel = () =>
          timer = null
          if @logFailures
            @log @name + '.' + name + ' timed out'
            if @expected?
              log '  expected: ', @expected
          @cleanup()
          run()

        try
          timer = setTimeout cancel, @timeout
          fn.call this, next
        catch error
          log 'test ' + @name + '.' + name + ' failed with an error: ', error
          log error.stack

    run()

  tests: { }

exports.AsyncTestBlock = AsyncTestBlock

class TestUnit
  constructor: () ->
    @logTitles = true
    @logCompletions = true

  run: () ->
    @logTitles and console.log 'Testing ' + @name + ':'
    @count = 0
    @passed = 0
    for block in @blocks
      if not (block instanceof TestBlock) and block.prototype instanceof TestBlock
        block = new block
      block.initialize()
      block.run()
      block.finalize()
      @count += block.count
      @passed += block.passed
    @logCompletions and console.log @name + ': all tests complete (' + @passed + '/' + @count + ')'

exports.TestUnit = TestUnit


class AsyncTestUnit extends TestUnit
  run: (done=(->)) ->
    @logTitles and console.log 'Testing ' + @name + ':'
    @count = 0
    @passed = 0

    blocks = @blocks.slice 0

    run = () =>
      if blocks.length is 0
        @logCompletions and console.log @name + ': all tests complete (' + @passed + '/' + @count + ')'
        done()
      else
        block = blocks.shift()
        if not (block instanceof AsyncTestBlock) and block.prototype instanceof AsyncTestBlock
          block = new block

        next = () =>
          @count += block.count
          @passed += block.passed

          block.finalize () -> run()

        block.initialize () -> block.run next

    run()

exports.AsyncTestUnit = AsyncTestUnit

