events = require 'events'
mongoose = require 'mongoose'

domain  = require './domain'
session = require './session'

class Server extends events.EventEmitter

  constructor: (@options) ->
    db = options.db
    dbUrl = 'mongodb://' + db.user + ':' + db.password + '@' + db.host + ':' + db.port + '/' + db.name
    cx = mongoose.createConnection dbUrl
    cx.on 'error', () -> console.log 'Unable to open database: ' + dbUrl
    cx.once 'open', () =>
      @db = cx
      @emit 'dbReady'

  about: () ->
    cryptographyDescriptor:
      keypair: ''
      symmetricKey: ''
      hashFunction: 'sha 512'
    publicKey: '<public key>'
    contact:
      email: 'foo@bar.com'
    softwareName: 'Mule'
    softwareVersion: '0.0.1'
    softwareOrigin: 'Bleepworks'

  # 128 bits is minimum key size / 8 (bits/byte) * 4/3 for (base64 characters/byte) = 21.333...
  validatePublicKey: (key) -> key.match /^[\w\d+/=]{21,}$/



exports.sessions = session.middleware

exports.root = (options) ->
  server = new Server options

  () ->
    @path /\/domain/,  domain.root  server
    @path /\/session/, session.root server

    @get /\/about/, () ->
      @res.writeHead 200, 'Content-Type': 'application/json'
      @res.end JSON.stringify server.about()

    @get /\/status/, () ->
      @res.writeHead 200, 'Content-Type': 'application/json'
      @res.end JSON.stringify
        cookies: @req.cookies
        db:
          authenticated: server.authenticated

