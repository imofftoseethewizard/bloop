exports = window.util = {}

idgen = (separators...) ->
  { round, random } = Math

  randomHex4 = () -> ('0000' + (round random()*0x10000).toString 16).slice -4

  parts = (randomHex4() + (s or '') for s in separators)
  parts.push randomHex4()

  parts.join ''

# http://en.wikipedia.org/wiki/Universally_unique_identifier
uuidgen = () ->  idgen '', '-', '-', '-', '-', '', ''

exports.idgen = idgen
exports.uuidgen = uuidgen