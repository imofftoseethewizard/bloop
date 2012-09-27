idgen = (separators...) ->
  { round, random } = Math

  randomHex4 = () -> ('0000' + (round random()*0x10000).toString 16).slice -4

  parts = (randomHex4() + (s or '') for s in separators)
  parts.push randomHex4()

  parts.join ''

# http://en.wikipedia.org/wiki/Universally_unique_identifier
uuidgen = () ->  idgen '', '-', '-', '-', '-', '', ''

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
exports.uuidgen = uuidgen

exports.makeHttpsRequiredDecorator = makeHttpsRequiredDecorator
