rpc = require './rpc'

class PersistentObject


class Interface extends rpc.Interface
  @defineMethods
      name: 'new'
      optionalParameters: ['transaction']
      readBody: true # TODO: streaming
      handler: (req, res) ->
        client = Client.getByExternalId req.session.clientId
        application = C
        obj = new PersistentObject
        obj.receiveContent req, (
    ,

      verb: 'GET'
      targetRequired: true
    ,

      name: 'delete'
      auth: 'client'
      targetRequired: true
      optionalParameters: ['transaction']
    ,

      name: 'modify'
      auth: 'client'
      targetRequired: true
      requiredParameters: ['hash']
      optionalParameters: ['transaction']
      readBody: true
    ,

      name: 'replace'
      auth: 'client'
      targetRequired: true
      optionalParameters: ['transaction']
      readBody: true
    ,

      name: 'update'
      auth: 'client'
      targetRequired: true
      optionalParameters: ['transaction']
      readBody: true
    ,

      name: 'limit'
      auth: 'client'
      targetRequired: true
      requiredParameters: ['content-length']



module.exports.Interface = Interface