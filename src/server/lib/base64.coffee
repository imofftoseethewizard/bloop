# base64 encoding using ArrayBuffers
# Uses - and . instead of + and / to be compatible with urls
#
chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-.='
codes = {}
codes[ch] = i for ch, i in chars
codes['='] = 0

exports.chars = chars
exports.codes = codes

encode = (bytes) ->
  buf = []

  for i in [0...bytes.length] by 3
    b0 = bytes[i]
    b1 = bytes[i+1]
    b2 = bytes[i+2]

    c0 = b0 >> 2
    c1 = ((b0 & 0x03) << 4) | (b1 >> 4)
    c2 = ((b1 & 0x0f) << 2) | (b2 >> 6)
    c3 = b2 & 0x3f

    if isNaN b1      then c2 = c3 = 64
    else if isNaN b2 then c3 = 64

    buf.push c0, c1, c2, c3

  (chars[c] for c in buf).join ''

exports.encode = encode

decode = (s) ->
  N = s.length
  bytes = new Uint8Array new ArrayBuffer 3*N/4 - (Number s[N-2] is '=') - (Number s[N-1] is '=')
  lastIndex = (N-1 >> 2) << 2

  j = 0
  for i in [0...N] by 4
    c0 = codes[s[i]]
    c1 = codes[s[i+1]]
    c2 = codes[s[i+2]]
    c3 = codes[s[i+3]]

    b0 = (c0 << 2) | (c1 >> 4)
    b1 = ((c1 & 0x0f) << 4) | (c2 >> 2)
    b2 = ((c2 & 0x03) << 6) | c3

    bytes[j++] = b0

    if i == lastIndex
      if c2 isnt '=' then bytes[j++] = b1
      if c3 isnt '=' then bytes[j++] = b2
    else
      bytes[j++] = b1
      bytes[j++] = b2

  bytes

exports.decode = decode
