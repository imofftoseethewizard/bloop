cookie = require 'cookie'
util = require './util'

sessions = {}

exports.middleware = (options) ->
  options = options or {}
  key = options.key or 'sessionId'
  path = options.path or '/'

  (req, res, next) ->
    req.session = {}

    if (req.url.indexOf path) is 0
      res.session = req.session = sessions[req.cookies[key]] or {}
      res.on 'header', () ->

        # These two headers are needed to allow cross-domain XHR.
        # XHR must have the withCredentials flag set to true.
        res.setHeader 'Access-Control-Allow-Credentials', 'true'
        res.setHeader 'Access-Control-Allow-Origin', req.headers.origin or '*'

        if res.session.id?
          res.setHeader 'Set-Cookie', cookie.serialize key, res.session.id,
            path: path
        else
          res.setHeader 'Set-Cookie', cookie.serialize key, '',
            expires: new Date 0
            path: path

    next()

exports.root = (server) ->
  () ->
    # TODO change to post after static test page created
    @get /\/open/, () ->
      sessionId = util.uuidgen()
      session = id: sessionId
      sessions[sessionId] = session
      @res.session = session
      @res.writeHead 200, 'Content-Type': 'application/json'
      @res.end JSON.stringify sessionId

    # TODO change to post after static test page created
    @get /\/close/, () ->
      if (sessionId = @req.session.id)?
        delete sessions[sessionId]
      @res.session = {}
      @res.writeHead 200, 'Content-Type': 'application/json'
      @res.end 'true'





