
rpc = require './rpc'
crypto = require './crypto'


class Session
  @serial = 1
  @salt = String Math.random()

  @newId: () ->
    while Store.get (id = crypto.hash @salt + (@serial++))
      ;
    id

# Storage for sessions.
# See http://http://www.senchalabs.org/connect/middleware-session.html
#
class Store
  @store = {}
  @count = 0

  @get: (id, next) -> next @store[id]
  @set: (id, session, next) ->
    @count++ if not @store[id]?
    @store[id] = session
    next()

  @destroy: (id, session, next) ->
    @count-- if @store[id]?

    delete @store[id]
    next()

  @length: (next) -> next @count
  @clear: (next) ->
    @store = {}
    @count = 0
    next()


class Interface extends rpc.Interface

  @defineMethods
      name: 'new'
      handler: (req, res) ->
        @reply res, (req.session.id = Session.newId())
    ,

      name: 'sign'
      targetRequired: true
      requiredParameters: ['client-id', 'signature']
      optionalParameters: ['application-id']
      handler: (req, res) ->
        arguments = req.rpc.arguments

        clientId      = arguments['client-id']
        applicationId = arguments['application-id']
        sessionId     = req.rpc.target
        signature     = arguments['signature']

        client = Client.getById req.rpc.session.clientId

        if applicationId?
          text = applicationId + sessionId
          key = client.getApplicationKey applicationId
        else
          text = clientId + sessionId
          key = client.publicKey

        challenge = crypto.hash text
        hash = key and crypto.decrypt signature, key

        if sessionId isnt req.rpc.session.id or hash isnt challenge
          @error res, 'invalid signature'

        else
          req.session.clientId = clientId
          req.session.applicationId = applicationId

          @reply res, ''


module.exports.Interface = Interface
module.exports.Store = Store