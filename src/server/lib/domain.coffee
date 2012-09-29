events = require 'events'
mongoose = require 'mongoose'
url = require 'url'

crypto = require './crypto'
errors = require './errors'
util = require './util'

round = Math.round
isInteger = (x) -> not (isNaN x) and x == round x

class DomainMgr extends events.EventEmitter
  constructor: (@server) ->
    @server.once 'dbReady', () => @dbInit()

  dbInit: () ->
    NonNegativeNumber =
      type: Number
      min:  0

    ref = (model) ->
      type: mongoose.Schema.Types.ObjectId
      ref: model

    schema = new mongoose.Schema
      _id:             String
      created:         { type: Date, default: Date.now }
      enabled:         Boolean
      publicKey:       String
      authorization:   String
      parent:          ref 'Domain'
      children:        [ref 'Domain']
      ancestors:       String
      defaultBlock:    ref 'Block'
      defaultQueue:    ref 'Queue'
      defaultRelay:    ref 'Relay'
      maxStorageBytes: NonNegativeNumber
      maxQueues:       NonNegativeNumber
      maxRelays:       NonNegativeNumber
      maxConnections:  NonNegativeNumber
      maxSubdomains:   NonNegativeNumber

    @model = @server.db.model 'Domain', schema
    @emit 'modelReady'


exports.root = (server) ->

  Domain = null
  domainMgr = new DomainMgr server
  domainMgr.once 'modelReady', () ->
    Domain = domainMgr.model

    Domain.validOrders = 'id +id -id created +created -created'.split()

#    Domain.find().remove()

    if (publicKey = server.options.admin.publicKey)?
      Domain.findOne { publicKey: publicKey }, 'id', (err, domain) =>
        if err
          console.log 'unable to query for admin domain'

        else
          if not domain?
            domain = new Domain
              _id:             server.idgen()
              enabled:         true
              publicKey:       publicKey
              authorization:   'system'
              parent:          null
              children:        []
              ancestors:       ''
              defaultBlock:    null
              defaultQueue:    null
              defaultRelay:    null
              maxStorageBytes: 0
              maxQueues:       0
              maxRelays:       0
              maxConnections:  0
              maxSubdomains:   0

            domain.save (err) ->
              if err?
                console.log 'error saving admin domain'

  secure = util.makeHttpsRequiredDecorator server.options.secure

  () ->
    @post 'create', secure () ->
      { href, query, pathname } = url.parse @req.url, true
      if not query.publicKey?
        errors.ParameterMissing null, @req, @res, 'publicKey'

      else if not server.validatePublicKey query.publicKey
        errors.InvalidValue null, @req, @res, 'publicKey', server.publicKeyDescription

      else
        Domain.findOne { publicKey: query.publicKey }, 'id', (err, domain) =>
          if err
            errors.InternalError null, @req, @res, err

          else
            if not domain?
              domain = new Domain
                _id:             server.idgen()
                enabled:         true
                publicKey:       query.publicKey
                authorization:   'none'
                parent:          null
                children:        []
                ancestors:       ''
                defaultBlock:    null
                defaultQueue:    null
                defaultRelay:    null
                maxStorageBytes: 0
                maxQueues:       0
                maxRelays:       0
                maxConnections:  0
                maxSubdomains:   0

              domain.save (err) ->
                if err?
                  console.log 'error saving new domain'

            if domain?
                @res.writeHead 200, 'Content-Type': 'application/json'
                @res.end JSON.stringify domain.id

    @get 'list', secure () ->
      { href, query, pathname } = url.parse @req.url, true
      { domain, count, firstId, lastId, createdAfter, createdBefore, orderBy } = query

      # validate arguments
      #
      # domain: either a descendant of session domain, or session domain has system authorization, or nothing
      #
      if count? and (not (isInteger (count = Number count)) or count < 0)
        return errors.InvalidValue null, @req, @res, query.count, 'Count must be a non-negative integer, if specified.'

      if createdAfter? and isNaN (createdAfter = Date createdAfter)
        return errors.InvalidValue null, @req, @res, query.createdAfter, 'createdAfter must be a valid date, if specified.'

      if createdBefore? and isNaN (createdBefore = Date createdBefore)
        return errors.InvalidValue null, @req, @res, query.createdBefore, 'createdBefore must be a valid date, if specified.'

      if orderBy? and not orderBy in Domain.validOrders
        return errors.InvalidValue null, @req, @res, query.createdBefore, 'orderBy must be must be one of [id, +id, -id, created, +created, -created], if specified.'

      query = Domain.find()
      query.find ancestors: new RegExp domain if domain?

      (query.where '_id').gte firstId if firstId?
      (query.where '_id').lt  lastId  if lastId?

      (query.where 'created').gte createdAfter  if createdAfter?
      (query.where 'created').lt  createdBefore if createdBefore?

      query.limit count
      (query.sort orderBy.split()...) if orderBy?
      query.select 'id created publicKey enabled authorization'

      query.exec (err, results) =>
        if err
          errors.InternalError null, @req, @res, err
        else
          @res.writeHead 200, 'Content-Type': 'application/json'
          @res.end JSON.stringify results

    @path /\/:domainId/, () ->
      @get 'about', secure (domainId) ->
        Domain.findById domainId, (err, domain) =>
          if err?
            errors.InternalError null, @req, @res, err

          else
            if not domain?
              errors.NotFound null, @req, @res, domainId, 'domain'
            else
              @res.writeHead 200, 'Content-Type': 'application/json'
              @res.end JSON.stringify domain.toObject()
                # id:            domain.id
                # created:       domain.created
                # publicKey:     domain.publicKey
                # enabled:       domain.enabled
                # authorization: domain.authorization

      @post 'authenticate', secure (domainId) ->
        @res.writeHead 200, 'Content-Type': 'application/json'
        @res.end JSON.stringify domainId

      @post 'authorize', secure (domainId) ->
        @res.writeHead 200, 'Content-Type': 'application/json'
        @res.end JSON.stringify domainId

      @post 'delete', secure (domainId) ->
        Domain.findById domainId, (err, domain) =>
          if err?
            errors.InternalError null, @req, @res, err

          else if not domain?
            errors.NotFound null, @req, @res, domainId

          else
            if domain.authorization isnt 'system'
              domain.remove (err) =>
                if err?
                  errors.InternalError null, @req, @res, err
                else
                  @res.writeHead 200, 'Content-Type': 'application/json'
                  @res.end JSON.stringify domainId
            else
              errors.NotAllowed domainId, @req, @res, 'system', 'System authority domains cannot be deleted.'

      @post 'disable', secure (domainId) ->
        Domain.findByIdAndUpdate domainId, { enabled: false }, (err, domain) =>
          if err?
            errors.InternalError null, @req, @res, err

          else if not domain?
            errors.NotFound null, @req, @res, domainId

          else
            @res.writeHead 200, 'Content-Type': 'application/json'
            @res.end JSON.stringify domainId

      @post 'enable', secure (domainId) ->
        Domain.findByIdAndUpdate domainId, { enabled: true }, (err, domain) =>
          if err
            errors.InternalError null, @req, @res, err

          else if not domain?
            errors.NotFound null, @req, @res, domainId

          else
            @res.writeHead 200, 'Content-Type': 'application/json'
            @res.end JSON.stringify domainId

      @post 'revoke', secure (domainId) ->
        @res.writeHead 200, 'Content-Type': 'application/json'
        @res.end JSON.stringify domainId
