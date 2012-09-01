if (typeof module) is 'undefined'
  exports = (window.common = window.common or {}).util = {}
else
  exports = module.exports

makeString = exports.makeString = (ch, i) -> (ch for j in [0...i]).join ''

stackTrace = exports.stackTrace = () ->
  try
    (null)()
  catch err
    calls = (err.stack.split '\n').slice 3
    ((makeString ' ', i) + line.slice 4 for line, i in calls.reverse()).join '\n'


class Continuation
  DEBUG = false

  @serial = 0
  @End = {}

  constructor: (@context) ->
    @id = Continuation.serial++
    @results = Continuation.End

    DEBUG and @stack = stackTrace()
    DEBUG and console.log 'new Continuation ' + @id + '\n' + stackTrace()


  complete: (@results...) ->
    DEBUG and console.log 'Continuation.complete', @id
    DEBUG and console.log stackTrace()

    @resume() if @handler?


  then: (@handler, context) ->
    DEBUG and console.log 'Continuation.then', @id, @handler
    DEBUG and console.log stackTrace()

    @context = context or @context
    @next = new Continuation @context

    @resume() if @results isnt Continuation.End

    @next


  resume: () ->
    DEBUG and console.log 'Continuation.resume', @id
    DEBUG and console.log stackTrace()

    try
      @next.complete @handler.apply @context, @results
    catch err
      console.log 'Exception thrown in continuation ' + @id + ':\n' + err.stack + '\nOriginating at:\n' + @stack
      throw err


exports.Continuation = Continuation