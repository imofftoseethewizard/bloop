# TODO: set means to enforce https only for method call

class Interface

  @parseHttpRequest: (req) ->
    reqUrl = url.parse req.url
    components = reqUrl.pathname.split '/'

    if components.length is 4
      target = components[2]
      method = components[3]

    else if components.length is 3
      if components[2].match /^[-a-z]+$/
        method = components[2]
      else
        target = components[2]

    arguments = {}
    arguments[k] = v for [k, v] in (term.split '=' for term in reqUrl.query.split '&')

    req.rpc =
      category:  components[1]
      verb:      req.method
      method:    method
      target:    target
      arguments: arguments

  @reply: (res, result) ->
    content = JSON.stringify result
    res.setHeader 'Content-Length', content.length
    res.end content, 'application/json'


  @error: (res, text) ->
    @reply res, error: text

  @http: (req, res) ->

    @parseHttpRequest req

    if (method = @methods[req.rpc.method or '<default>'])?
      method req, res
    else
      @error res, 'not found'


  @checkSyntax: (handler, options) ->
    targetRequired = options.targetRequired
    targetOptional = options.targetOptional

    requiredParameters = options.requiredParameters or []
    optionalParameters = options.optionalParameters or []

    accepted = {}
    accepted[p] = true for p in requiredParameters
    accepted[p] = true for p in optionalParameters

    verb = options.verb or 'POST'

    (req, res) =>
      if req.rpc.verb? and req.rpc.verb isnt verb
        return @error res, 'invalid request'

      if targetRequired and not req.rpc.target?
        return @error res, 'invalid request'

      if not targetRequired and not targetOptional and req.rpc.target?
        return @error res, 'invalid request'

      arguments = req.rpc.arguments
      for p in requiredParameters
        if not arguments[p]?
          return @error res, 'invalid request'

      for k, v of arguments
        if not accepted[k]
          return @error res, 'invalid request'

      handler req, res


  @auth: (handler, privilegeRequired) ->
    if not privilegeRequired?
      handler
    else
      (req, res) =>
        client = Client.getById req.session.clientId
        if client? and client.checkPrivilege privilegeRequired
          handler req, res
        else
          @error res, 'unauthorized'


  @method: (options) ->
    handler = options.handler or (req, res) -> @error res, 'not implemented'
    @checkSyntax (@auth handler, options), options

  @defineMethods: (specifiers...) ->
    @methods = {}
    for s in specifiers
      @methods[s.name or '<default>'] = @method s

module.exports.Interface = Interface