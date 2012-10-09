class RSAKey
  @generate: (bits, e) ->


class RSAPublicKey extends RSAKey
  constructor: (@n, @e) ->
    super()


class RSAPrivateKey extends RSAPublicKey
  constructor: (n, e, @d) ->
    super n, e


class RSACodec
  constructor: (@key) ->

  # Uses public portion of key
  encode: (x) ->

  # Uses private portion of key
  decode: (x) ->

  encrypt: (p) ->

  decrypt: (c) ->

