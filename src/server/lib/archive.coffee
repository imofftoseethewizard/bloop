url = require 'url'
path = require 'path'
fs = require 'fs'
spawn = (require 'child_process').spawn

connect = require 'connect'
utils = connect.utils

Continuation = (require '../common/util').Continuation

fail = (str) ->
  try
    throw new Error str
  catch err
    # cut this function out of the stack trace
    stack = err.stack.split '\n'
    stack.splice 1, 1
    err.stack = stack.join '\n'
    return err


reply = (res, type, url, body='') ->
  content = type + ' ' + url
  if body.length > 0
    content += '\n' + body
  res.setHeader 'Content-Length', content.length
  res.end content


error = (req, res, err) ->
  reply res, 'error', req.originalUrl, err.message + '\n' + err.stack

VERSIONS_FILE = '__versions__.json'

class Archive
  constructor: (@options) ->

  respondent: (req, res, next) ->
    if not @validateUrl req.url
      error req, res, 'permission denied: ' + (url.parse req.url).pathname

    else if @constructor.isDirectoryUrl req.url
      switch req.method
        when 'DELETE'      then @deleteDirectory req, res, next
        when 'GET', 'HEAD' then @getDirectory    req, res, next
        when 'POST', 'PUT' then @createDirectory req, res, next
        else error req, res, 'invalid method: ' + req.method
    else
      switch req.method
        when 'DELETE'      then @deleteDocument  req, res, next
        when 'GET', 'HEAD' then @getDocument     req, res, next
        when 'POST', 'PUT' then @saveDocument    req, res, next
        else error req, res, 'invalid method: ' + req.method

  getDirectory:  (req, res, next) -> next()

  deleteDocument: (req, res, next) -> next()
  getDocument:    (req, res, next) -> next()
  saveDocument:   (req, res, next) -> next()

  @isDirectoryUrl: (urlString) -> urlString[urlString.length-1] is '/'
  @isDocumentUrl: (urlString) -> not @isDirectoryUrl urlString


class FileSystemArchive extends Archive

  validateUrl: (reqUrl) ->
    relPath = path.relative @options.root, path.join @options.root, (url.parse reqUrl, true).pathname
    (relPath.substring 0, 3) isnt '../'

  resolveUrl: (reqUrl) -> path.join @options.root, (url.parse reqUrl, true).pathname

  deleteDirectory: (req, res, next) ->
    FileSystemDirectory.remove (@resolveUrl req.url),
      (err) ->
        if err?
          error req, res, err
        else
          reply res, 'deleted', req.originalUrl


  getDirectory: (req, res, next) ->
    dir = new FileSystemDirectory @resolveUrl req.url
    dir.read (err, body) =>
      if err?
        if err.message is 'path refers to a document'
          @getDocumentIndex req, res, next
        else
          error req, res, err
      else         reply res, 'directory', req.originalUrl, body


  createDirectory: (req, res, next) ->
    dir = new FileSystemDirectory @resolveUrl req.url
    dir.create (err) =>
      if err? then error req, res, err
      else         @getDirectory req, res, next


  deleteDocument: (req, res, next) ->
    reqUrl = url.parse req.url, true
    if reqUrl.query.version?
      error req, res, fail 'error ' + req.originalUrl + '\n' + 'version deletion is not supported'
    else
      FileSystemDocument.remove (@resolveUrl req.url),
        (err) ->
          if err?
            error req, res, err
          else
            reply res, 'deleted', req.originalUrl


  getDocument: (req, res, next) ->
    { query } = url.parse req.url, true
    if query.version is 'index'
      @getDocumentIndex req, res, next
    else
      @getDocumentVersion req, res, next


  getDocumentIndex: (req, res, next) ->
    doc = new FileSystemDocument @resolveUrl req.url
    doc.index (err, index, stat) ->
      if err?
        error req, res, err
      else
        if not res.getHeader 'Date'          then res.setHeader 'Date',          (new Date).toUTCString()
        if not res.getHeader 'Cache-Control' then res.setHeader 'Cache-Control', 'public, max-age=0'
        if not res.getHeader 'Last-Modified' then res.setHeader 'Last-Modified', stat.mtime.toUTCString()

        if (utils.conditionalGET req) and not utils.modified req, res
          utils.notModified res

        else if req.method is 'HEAD'
          res.end()

        else
          reply res, 'index', (url.parse req.originalUrl).pathname, index


  getDocumentVersion: (req, res, next) ->
    doc = new FileSystemDocument (@resolveUrl req.url), (url.parse req.url, true).query.version
    doc.find().then (err, version, fsPath) ->
      if err?
        error req, res, err
      else
        fs.stat fsPath,
          (err, stats) ->
            if err?
              error req, res, err
            else
              if not res.getHeader 'Date'          then res.setHeader 'Date',          (new Date).toUTCString()
              if not res.getHeader 'Cache-Control' then res.setHeader 'Cache-Control', 'public, max-age=0'
              if not res.getHeader 'Last-Modified' then res.setHeader 'Last-Modified', stats.mtime.toUTCString()

              if (utils.conditionalGET req) and not utils.modified req, res
                utils.notModified res

              else if req.method is 'HEAD'
                res.end()

              else
                origUrl = url.parse req.originalUrl
                intro = 'document ' + origUrl.pathname + '?version=' + version + '.0\n'
                res.setHeader 'Content-Length', intro.length + stats.size
                res.write intro

                stream = fs.createReadStream fsPath

                stream.setEncoding 'utf8'
                stream.addListener 'error', (err) ->
                  console.error err.stack
                  stream.destroy()

                stream.pipe res


  saveDocument: (req, res, next) ->
    doc = new FileSystemDocument (@resolveUrl req.url), (url.parse req.url, true).query.version
    doc.save req, (err, version) ->
      if err? then error req, res, err
      else         reply res, 'receipt', (url.parse req.originalUrl).pathname + '?version=' + version + '.0'


class Document
  constructor: (@version) ->
    @versions = ['']

  resolveVersion: (s='') ->
    if s is ''
      v = []
    else
      (Document.validateVersion s) or fail 'Invalid version specifier: ' + s
      v = Document.parseVersion s

    tree = @versions
    while tree instanceof Array
      if v.length > 0
        tree = tree[v.shift()]
      else
        tree = tree[tree.length-1]

    if v.length is 0 and typeof tree is 'string'
      tree
    else
      null

  nextVersion: (s='') ->
    if s is '' then return String @versions.length

    (Document.validateVersion s) or fail 'Invalid version specifier: ' + s
    v = Document.parseVersion s

    tree = @versions
    while v.length > 0 and tree instanceof Array
      tree = tree[v.shift()]

    if v.length > 0
      null
    else if tree instanceof Array
      if tree[0] is ''
        String tree.length
      else
        tree[0] + '.' + tree.length
    else if tree?
      tree
    else
      null

  addVersion: (s='') ->
    if s is ''
      @versions.push [(s = String @versions.length)]
      return s

    (Document.validateVersion s) or fail 'Invalid version specifier: ' + s
    v = Document.parseVersion s

    tree = @versions
    while v.length > 1 and tree instanceof Array
      tree = tree[v.shift()]

    if v.length is 1 and tree instanceof Array and tree.length is v[0]
      tree.push [Document.normalizeVersion s]
      s

    else
      null

  @parseVersion: (s) -> Number n for n in s.split '.'
  @validateVersion: (s) -> (s.match /^[.\d]+$/) and not (s.match /^0*(\.|$)|\.0*\./)
  @normalizeVersion: (s) -> s.replace /\.0+/g, '.'


class FileSystemDocument extends Document
  constructor: (@path, version) ->
    super version

  @serial: 0

  @remove: (fsPath, next) ->
    fs.readDir fsPath,
      (err, files) ->
        if err? then next err
        else if VERSIONS_FILE not in files then next fail 'not a document'
        else
          count = files.length
          reported = false
          for f in files
            fs.unlink (path.join fsPath, f),
              (err) ->
                if err?
                  if not reported then next err
                  reported = true
                else
                  count--
                  if count is 0 then fs.rmdir fsPath, (err) -> next err


  index: (next) ->
    fs.readFile (path.join @path, VERSIONS_FILE),
      (err, data) =>
        if err? then next err
        else
          try
            @versions = JSON.parse data
            result = []
            format = (items) ->
              for x in items
                if x.length is 1
                  result.push x[0]
                else
                  result.push x[0] + '.0'
                  format x[1...]

            format @versions[1...]
            fs.stat @path,
              (err, stats) ->
                if err? then next err
                else next null, (result.join '\n'), stats
          catch err
            return next err

  find: () ->
    coda = new Continuation this

    fs.readFile (path.join @path, VERSIONS_FILE), 'utf8',
      (err, data) =>
        if err?
          coda.complete fail 'cannot read document version list'
        else
          try
            @versions = JSON.parse data
            version = @resolveVersion @version
            if not version? then coda.complete fail 'version not found'
            else                 coda.complete null, version, path.join @path, version + '.0'
          catch err
            coda.complete fail 'document version list is corrupted'
    coda


  save: (src, next) ->
    NONE     = 0x00
    CONTENT  = 0x01
    TARGET   = 0x02
    VERSIONS = 0x04
    ALL      = 0x07

    ready = NONE
    everything = ALL
    failed = completed = null
    tmp = dest = null

    # called either when there is a terminal error, or when all of the prerequisites for
    # save are ready
    #
    complete = () =>
      if not completed?
        completed = true
        version = @nextVersion @version
        if not version?
          abort fail 'version out of range'
        else
          @addVersion version
          # fs.rename doesn't work here unless the two paths are guaranteed to be on the
          # same mount point.  Spawning mv is more general.
          spawn 'mv', [tmp, (path.join @path, version + '.0')]
          fs.writeFile (path.join @path, VERSIONS_FILE), JSON.stringify @versions
          next null, version

    abort = (err) =>
      if not failed?
        failed = true

        fs.unlink tmp if tmp?
        tmp = null

        next err

    # called when a prerequisite has been satisfied
    #
    notifyReady = (what) =>
      if not failed?
        ready |= what
        complete() if everything is ready

    # ensures that the document directory is present
    #
    prepareTarget = () =>
      coda = new Continuation this

      try
        dir = new FileSystemDirectory @path

        dir.create (err) =>
          if err? then abort err
          else
            fs.readdir @path,
              (err, files) =>
                if files.length is 0 or VERSIONS_FILE in files
                  coda.complete()
                else
                  abort fail 'target is a directory'
      coda


    # reads and parses the document versions file
    #
    readVersions = () =>
      coda = new Continuation this

      fs.readFile (path.join @path, VERSIONS_FILE), 'utf8',
        (err, data) =>
          if err?
            if err.code is 'ENOENT'
              coda.complete()
            else
              abort fail 'cannot read document version list'
          else
            try
              @versions = JSON.parse data
              coda.complete()
            catch err
              abort fail 'document version list is corrupted'
      coda

    # capture streamed document contents into a temporary file
    #
    receiveContent = (src) =>
      coda = new Continuation this

      tmp = path.join '/tmp', 'archive.' + process.pid + '-' + FileSystemDocument.serial++
      try
        dest = fs.createWriteStream tmp
        dest.addListener 'close', () -> coda.complete()

        src.pipe dest
        src.addListener 'error', (err) -> abort fail 'failed while saving document contents'

      catch err
        abort err

      coda
    # cleans up after a failure
    #


    # ensure that a directory at @path exists and that it is either empty or is a document
    prepareTarget().then () -> notifyReady TARGET

    # read the versions file
    readVersions().then () -> notifyReady VERSIONS

    # pipe document contents into a temporary file
    (receiveContent src).then () -> notifyReady CONTENT



class FileSystemDirectory

  constructor: (@path) ->

  @remove: (fsPath, next) ->
    fs.stat fsPath,
      (err, stats) ->
        if err?
          switch err.code
            when 'ENOENT' then next fail 'directory not found'
            else next err
        else
          if not stats.isDirectory()
            next fail 'not a directory'
          else
            fs.readdir fsPath,
              (err, files) ->
                if files.length is 0
                  fs.rmdir fsPath, next
                else
                  next fail 'directory not empty'


  create: (next) ->
    components = (c for c in @path.split '/' when c isnt '')
    for c in components
      if c.match /^_/ then return next fail 'illegal path component: ' + c

    base = ''
    paths = (base += '/' + c for c in components)
    missing = []
    check = () =>
      if paths.length is 0
        return next fail 'reached root while searching for extant base.'
      p = paths.pop()
      fs.stat p,
        (err, stats) =>
          if err?
            if err.code is 'ENOENT'
              missing.push p
              check()
            else
              next err
          else
            if stats.isDirectory()
              if p is @path then next()
              else
                path.exists (path.join p, VERSIONS_FILE),
                  (present) ->
                    if present
                      next fail 'path component is a document: ' + p
                    else
                      build()
            else
              next fail 'path component is not a directory: ' + p

    build = () ->
      if missing.length is 0
        next()
      else
        p = missing.pop()
        fs.mkdir p,
          (err) ->
            if err? then next err
            else
              build()

    check()


  read: (next) ->
    count = 0
    results = []

    entryCompleted = () ->
      count--
      if count is 0 then next null, results.join '\n'

    listFiles = (err, files) =>
      if err?
        switch err.code
          when 'ENOENT' then next fail 'directory not found'
          else next err
      else
        count = files.length
        if files.length is 0 then next null, ''
        else
          for f in files
            do (f) =>
              if f is VERSIONS_FILE
                next fail 'path refers to a document'
              else
                fs.stat (path.join @path, f),
                  (err, stats) =>
                    if stats.isDirectory()
                      path.exists (path.join @path, f, VERSIONS_FILE),
                        (present) ->
                          if present
                            results.push f
                          else
                            results.push f + '/'
                          entryCompleted()
                    else
                      entryCompleted()

    fs.readdir @path, listFiles



exports = module.exports = (options) ->
  switch options.type
    when 'filesystem'
      archive = new FileSystemArchive options
      (req, res, next) => archive.respondent req, res, next

    else (req, res, next) -> next()

exports.Archive = Archive
exports.FileSystemArchive = FileSystemArchive
exports.Document = Document
exports.FileSystemDocument = FileSystemDocument
exports.FileSystemDirectory = FileSystemDirectory
