url = require 'url'

crypto = require './crypto'
errors = require './errors'
util = require './util'

exports.root = (server) ->

  secure = util.makeHttpsRequiredDecorator server.options.secure

  () ->
    @post 'create', secure () ->
      { href, query, pathname } = url.parse @req.url, true
      if not query.publicKey?
        errors.parameterMissing null, @req.url, @res, 'publicKey'

      else if not server.validatePublicKey query.publicKey
        errors.InvalidValue null, @req.url, @res, 'publicKey', server.publicKeyDescription

      else
        @res.writeHead 200, 'Content-Type': 'application/json'
        @res.end JSON.stringify crypto.hash query.publicKey

    @post 'list', secure () ->
      @res.writeHead 200, 'Content-Type': 'application/json'
      @res.end JSON.stringify domainId

    @path /\/:domainId/, () ->
      @post 'authenticate', secure (domainId) ->
        @res.writeHead 200, 'Content-Type': 'application/json'
        @res.end JSON.stringify domainId

      @post 'authorize', secure (domainId) ->
        @res.writeHead 200, 'Content-Type': 'application/json'
        @res.end JSON.stringify domainId

      @post 'delete', secure (domainId) ->
        @res.writeHead 200, 'Content-Type': 'application/json'
        @res.end JSON.stringify domainId

      @post 'disable', secure (domainId) ->
        @res.writeHead 200, 'Content-Type': 'application/json'
        @res.end JSON.stringify domainId

      @post 'enable', secure (domainId) ->
        @res.writeHead 200, 'Content-Type': 'application/json'
        @res.end JSON.stringify domainId

      @post 'revoke', secure (domainId) ->
        @res.writeHead 200, 'Content-Type': 'application/json'
        @res.end JSON.stringify domainId





