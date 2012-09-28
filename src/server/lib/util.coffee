{ floor, random } = Math

idgen = (length) ->
  a = new Uint8Array new ArrayBuffer length
  a[i] = floor 256*random() for i in [0...length]
  a

makeHttpsRequiredDecorator = (requireHttps) ->
  secure = (fn) ->
    if not requireHttps
      fn
    else
      (args...) ->
        if @req.headers['x-forwarded-proto'] is 'https'
          fn.apply this, args
        else
          @res.writeHead 426
          @res.end JSON.stringify
            type: 'HTTPS Required'
            domain: 'none'
            method: 'session/open'
            parameters: {}

exports.idgen = idgen

exports.makeHttpsRequiredDecorator = makeHttpsRequiredDecorator
