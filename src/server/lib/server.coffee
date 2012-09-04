cryptico = require 'cryptico'

class Server
  @cryptographyDescriptor =
    pairType:      'RSA 512',
    symmetricType: 'AES 256',
    hashFunction:  'SHA 256'

  privateKey = cryptico.generateRSAKey 'TODO: load or generate password', 512
  @pubilcKey = cryptico.publicKeyString privateKey

  @contact         = 'TODO: read from config'
  @softwareName    = 'TBD'
  @softwareVersion = 'TODO: from build process'
  @softwareOrigin  = "What is the human spirit? I'm off to see the wizard."

  @about = (req, res, next) ->
    cryptographyDescriptor: Server.cryptographyDescriptor,
    publicKey:              Server.publicKey,
    contact:                Server.contact,
    softwareName:           Server.softwareName,
    softwareVersion:        Server.softwareVersion,
    softwareOrigin:         Server.softwareOrigin,


module.exports = Server

