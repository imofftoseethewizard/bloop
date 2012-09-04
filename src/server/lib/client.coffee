###################################################################################################
#
# Client
#
# Clients come in several flavors.  The simplest are the clients without authorization to create
# and own resources on the server.  They have accounts on the server so they can access resources
# owned by other clients, but to which they have been granted access.  These clients only possess
# an id and a public key.  Clients who have been authorized create resources have more information
# associated with them.  In addition, they have allocation limits, usage statistics, and
# accounting and contact information.  Lastly, there are clients which perform system management
# functions.  The system stores similar data about these as about authorized clients.
#
#
# Storage
#
#   Client information will be accessed during most API calls.  All client data will be kept in
# memory so that all access will be synchronous.  Modifications to client data will be
# asynchronous, but those should be relatively rare, as they are primarily administrative tasks.
#
#
# Database
#
#   Client data is stored in two tables: the main client table, and a secondary table that holds
# the applications registered for the client.
#
# Client Table
#
#   id                                  integer primary key
#   public key                          fixed length string
#   external id                         fixed length string
#   privilege                           enum: none, user, system
#   public queue id                     fixed length string nullable
#   admin public key                    fixed length string nullable
#   allotment                           integer default 0
#   max queues                          integer default 0
#   max relays                          integer default 0
#   max connections                     integer default 0
#   usage                               integer default 0
#   queue count                         integer default 0
#   relay count                         integer default 0
#   connection count                    integer default 0
#   email address                       fixed length string
#
# Applications Table
#
#   id                                  integer primary key
#   public key                          fixed length string
#   external id                         fixed length string
#   client id                           integer
#

require rpc = './rpc'

class KeyedRegistry

  constructor: (@createEntity) ->
    @entities = {}
    @entitiesByKey = {}

  getById: (id) -> @entities[id]
  getByKey: (key) -> @entitiesByKey[key]

  register: (key) ->
    hash = crypto.hash key
    if (client = @entities[hash])? and client.key isnt key
      null
    else
      @entities[hash] = @createEntity hash, key
      hash

class Database
  constructor: (@driver) ->

class SQLite3Database extends Database
  constructor: (driver) ->
    super driver

    @getTableStmt = @driver.prepare "SELECT '(?)' FROM sqlite_master WHERE type='table'"
    @getTableColumnsStmt = @driver.prepare "PRAGMA table_info ('(?)')"

  getTable: (name, next) -> @getTableStmt.get name, next
  getTableColumns: (name, next) -> @getTableColumnsStmt.all name, next


class PersistentEntity
  @scheduleUpdate: (entity) ->
    setTimeout (-> entity.update()), 0

  @setDatabase: (@db) ->
    @db.getTableColumns @tableName,
      (err, rows) =>
        columns = {}
        if rows.length is 0
          @createTable () => @tableReady()
        else
          for r in rows
            # From the sqlite3 source for PRAGMA table_info:
            #
            # sqlite3VdbeSetColName(v, 0, COLNAME_NAME, "cid", SQLITE_STATIC);
            # sqlite3VdbeSetColName(v, 1, COLNAME_NAME, "name", SQLITE_STATIC);
            # sqlite3VdbeSetColName(v, 2, COLNAME_NAME, "type", SQLITE_STATIC);
            # sqlite3VdbeSetColName(v, 3, COLNAME_NAME, "notnull", SQLITE_STATIC);
            # sqlite3VdbeSetColName(v, 4, COLNAME_NAME, "dflt_value", SQLITE_STATIC);
            # sqlite3VdbeSetColName(v, 5, COLNAME_NAME, "pk", SQLITE_STATIC);
            #
            { cid, name, type, notnull, dflt_value, pk } = row
            columns[name] = row
            if not @columns[name]?
              throw 'Table changed'

          for name, column of @columns
            if not columns[name]?
              throw 'Table changed'

          @tableReady()

  @createTable: (next) ->
    columnDefs = (c.name + ' ' + c.type for c in @columns).join ', '
    @db.run "CREATE TABLE IF NOT EXISTS #{ @tableName } ( #{ columnDefs } )", next

  constructor: () ->
    @needsUpdate = true

  setNeedsUpdate: () ->
    @needsUpdate = true
    PersistentEntity.scheduleUpdate this

  update: () ->
    @needsUpdate = false



class ClientApplcation extends PersistentEntity

  constructor: (@client, @externalId, @key) ->
    super()


class Client extends PersistentEntity

  @define Properties
      id: 'integer primary key'
    ,
      public_key: 'string
#   id                                  integer primary key
#   public key                          fixed length string
#   external id                         fixed length string
#   privilege                           enum: none, user, system
#   public queue id                     fixed length string nullable
#   admin public key                    fixed length string nullable
#   allotment                           integer default 0
#   max queues                          integer default 0
#   max relays                          integer default 0
#   max connections                     integer default 0
#   usage                               integer default 0
#   queue count                         integer default 0
#   relay count                         integer default 0
#   connection count                    integer default 0
#   email address                       fixed length string
  @clients = new KeyedRegistry (hash, key) -> new Client hash key

  @getByExternalId:   (externalId) -> @clients.getById externalId
  @getByPublicKey:    (publicKey)  -> @clients.getByKey publicKey
  @registerPublicKey: (publicKey)  -> @clients.register publicKey


  constructor: (@externalId, @publicKey, @publicQueue) ->
    @applications = new KeyedRegistry (hash, key) => new ClientApplication this, hash, key
    super()

  setAdminKey: (@adminKey) -> @setNeedsUpdate()

  registerQueue: (@publicQueue) -> @setNeedsUpdate()

  registerApplication: (key) -> @applications.register key

  getApplicationKey: (applicationId) ->
    (application = @applications.getById applicationId)? and application.key


class Interface extends rpc.Interface
  @defineMethods
      verb: 'GET'
      targetOptional: true
      optionalParameters: ['public-key']
      handler: (req, res) =>
        client = null
        target = req.rpc.target
        publicKey = req.rpc.arguments['public-key']

        if target? and publicKey?
          @error res, 'invalid request'

        else
          if target?
            client = Client.getByExternalId target
          else
            client = Client.getByPublicKey publicKey

          if not client?
            @error res, 'not found'

          else
            @reply res,
              id:          client.externalId
              publicKey:   client.publicKey
              publicQueue: client.publicQueue or 'none'
    ,

      name: 'set-admin-key'
      auth: 'client'
      readBody: true
      handler: (req, res) =>
        client = Client.getById req.rpc.session.clientId
        externalId = client.setAdminKey req.body
        if externalId?
          @reply res, externalId
        else
          @error res, 'hash collision', 'public-key': publicKey
    ,

      name: 'authorize'
      auth: 'system'
      targetRequired: true
      optionalParameters: ['allotment', 'max-queues', 'max-relays', 'max-connections']
    ,

      name: 'register'
      requiredParameters: ['public-key']
      readBody: true
      handler:
        externalId = Client.registerPublicKey req.body
        if externalId?
          @reply res, externalId
        else
          @error res, 'hash collision', 'public-key': publicKey
    ,

      name: 'register-application'
      auth: 'client'
      readBody: true
      handler: (req, res) =>
        client = Client.getById req.rpc.session.clientId
        externalId = client.registerApplication req.body
        if externalId?
          @reply res, externalId
        else
          @error res, 'hash collision', 'public-key': publicKey
    ,

      name: 'register-queue'
      auth: 'client'
      requiredParameters: ['queue-id']
      handler: (req, res) =>
        client = Client.getById req.rpc.session.clientId
        queueId = client.registerQueue req.rpc.arguments['queue-id']
        if queueId?
          @reply res, ''
        else
          @error res, 'not found'



module.exports.Interface = Interface