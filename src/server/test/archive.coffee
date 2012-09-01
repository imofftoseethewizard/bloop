http = require 'http'
fs = require 'fs'
path = require 'path'
spawn = (require 'child_process').spawn

{ AsyncTestBlock, AsyncTestUnit } = require '../common/test'

fail = (str) ->
  try
    throw new Error str
  catch err
    # cut this function out of the stack trace
    stack = err.stack.split '\n'
    stack.splice 1, 1
    err.stack = stack.join '\n'
    return err

class Test_directories extends AsyncTestBlock
  name: 'directories'

  initialize: (ready) ->
    rm = spawn 'rm', ['-rf', path.resolve __dirname, '../data/test/directories' ]
    rm.addListener 'exit', ready

  prepare: () ->
    @options =
      host: '192.168.0.198'
      port: 3000

  cleanup: () ->
    @options = null

  request: (done) ->
    body = ''
    check = () =>
      if (body.slice 0, @expected.length) isnt @expected
        done fail 'expected:\n' + @expected + '\nactual:\n' + body + '\n'
      else
        done()

    req = http.request @options, (res) ->
      res.setEncoding 'utf8'
      res.addListener 'data', (chunk) -> body += chunk
      res.addListener 'error', done
      res.addListener 'end', check

    req.end()


  tests:
    postSimple: (done) ->
      @options.path = '/documents/test/directories/foo/'
      @options.method = 'post'

      body = ''
      check = () =>
        if not (body is 'directory ' + @options.path)
          done fail 'expected "directory ' + @options.path + '": \nactual: "' + body + '"'
        else
          done()

      req = http.request @options, (res) ->
        res.setEncoding 'utf8'
        res.addListener 'data', (chunk) -> body += chunk
        res.addListener 'error', done
        res.addListener 'end', check

      req.end()

    postExists: (done) ->
      # depends on prior test succeeding
      @options.path = '/documents/test/directories/foo/'
      @options.method = 'post'

      body = ''
      check = () =>
        if not (body is 'directory ' + @options.path)
          done fail 'expected "directory ' + @options.path + '": \nactual: "' + body + '"'
        else
          done()

      req = http.request @options, (res) ->
        res.setEncoding 'utf8'
        res.addListener 'data', (chunk) -> body += chunk
        res.addListener 'error', done
        res.addListener 'end', check

      req.end()


    postExistsNonEmpty: (done) ->
      # depends on prior test succeeding
      @options.path = '/documents/test/directories/'
      @options.method = 'post'

      body = ''
      @expected = 'directory ' + @options.path + '\nfoo/'
      check = () =>
        if not body is @expected
          done fail 'expected "' + @expected + '": \nactual: "' + body + '"'
        else
          done()

      req = http.request @options, (res) ->
        res.setEncoding 'utf8'
        res.addListener 'data', (chunk) -> body += chunk
        res.addListener 'error', done
        res.addListener 'end', check

      req.end()


    postErrorTooManyParents: (done) ->
      # depends on prior test succeeding
      @options.path = '/documents/test/../../../../../../../'
      @options.method = 'post'

      body = ''
      @expected = 'directory ' + @options.path + '\nfoo/'
      check = () =>
        if not ((body.slice 0, 5) is 'error')
          done fail 'expected an error: \nactual: "' + body + '"'
        else
          done()

      req = http.request @options, (res) ->
        res.setEncoding 'utf8'
        res.addListener 'data', (chunk) -> body += chunk
        res.addListener 'error', done
        res.addListener 'end', check

      req.end()


    deleteSimple: (done) ->
      # depends on postSimple succeeding
      @options.path = '/documents/test/directories/foo/'
      @options.method = 'delete'

      body = ''
      check = () =>
        if not (body is 'deleted ' + @options.path)
          done fail 'expected "deleted ' + @options.path + '": \nactual: "' + body + '"'
        else
          done()

      req = http.request @options, (res) ->
        res.setEncoding 'utf8'
        res.addListener 'data', (chunk) -> body += chunk
        res.addListener 'error', done
        res.addListener 'end', check

      req.end()


    deleteAbsent: (done) ->
      # depends on prior succeeding
      @options.path = '/documents/test/directories/foo/'
      @options.method = 'delete'

      body = ''
      check = () =>
        if not ((body.slice 0, 5) is 'error')
          done fail 'expected an error: \nactual: "' + body + '"'
        else
          done()

      req = http.request @options, (res) ->
        res.setEncoding 'utf8'
        res.addListener 'data', (chunk) -> body += chunk
        res.addListener 'error', done
        res.addListener 'end', check

      req.end()

    deleteNotEmpty: (done) ->
      # depends on postSimple succeeding
      @options.path = '/documents/test/'
      @options.method = 'delete'

      body = ''
      check = () =>
        if not ((body.slice 0, 5) is 'error')
          done fail 'expected an error: \nactual: "' + body + '"'
        else
          done()

      req = http.request @options, (res) ->
        res.setEncoding 'utf8'
        res.addListener 'data', (chunk) -> body += chunk
        res.addListener 'error', done
        res.addListener 'end', check

      req.end()


    deleteWithVersion: (done) ->
      # depends on postSimple succeeding
      @options.path = '/documents/test/directories/?version=1'
      @options.method = 'delete'

      body = ''
      check = () =>
        if not ((body.slice 0, 5) is 'error')
          done fail 'expected an error: \nactual: "' + body + '"'
        else
          done()

      req = http.request @options, (res) ->
        res.setEncoding 'utf8'
        res.addListener 'data', (chunk) -> body += chunk
        res.addListener 'error', done
        res.addListener 'end', check

      req.end()


    getPresent: (done) ->
      @options.path = '/documents/test/'
      @options.method = 'get'

      body = ''
      @expected = 'directory /documents/test/\ndirectories/\ndocuments/'

      check = () =>
        if body isnt @expected
          done fail 'expected:\n' + @expected + '\nactual:\n' + body + '\n'
        else
          done()

      req = http.request @options, (res) ->
        res.setEncoding 'utf8'
        res.addListener 'data', (chunk) -> body += chunk
        res.addListener 'error', done
        res.addListener 'end', check

      req.end()



    getAbsent: (done) ->
      @options.path = '/documents/test/not-there/'
      @options.method = 'get'
      @expected = 'error /documents/test/not-there/\ndirectory not found'
      @request done

    getDocument: (done) ->
      options =
        host: '192.168.0.198'
        port: 3000
        path: '/documents/test/directories/foo'
        method: 'post'

      next = () =>
        @options.path = '/documents/test/directories/foo/'
        @options.method = 'get'
        @expected = 'error /documents/test/directories/foo/\npath refers to a document'
        @request done

      req = http.request options, next
      content = 'Test document.'
      req.setHeader 'Content-Length', content.length
      req.end content, 'utf8'


class Test_documents extends AsyncTestBlock
  name: 'documents'

  initialize: (ready) ->
    root = path.resolve __dirname, '../data/test/documents'
    rm = spawn 'rm', ['-rf', root ]
    rm.addListener 'exit', () -> fs.mkdir root, ready

  prepare: () ->
    @options =
      host: '192.168.0.198'
      port: 3000

  cleanup: () ->
    @options = null

  request: (done) ->
    body = ''

    check = () =>
      if (body.slice 0, @expected.length) isnt @expected
        done fail 'expected:\n' + @expected + '\nactual:\n' + body + '\n'
      else
        done()

    req = http.request @options, (res) ->
      res.setEncoding 'utf8'
      res.addListener 'data', (chunk) -> body += chunk
      res.addListener 'error', done
      res.addListener 'end', check

    req.addListener 'error', (err) -> console.log err.message + '\n' + err.stack

    if @body is ''
      req.end()
    else
      req.end @body



  tests:
    postSimple1: (done) ->
      @options.path = '/documents/test/documents/foo'
      @options.method = 'post'
      @body = 'Test document foo v1.'

      @expected = 'receipt /documents/test/documents/foo?version=1.0'

      @request done

    postSimple2: (done) ->
      @options.path = '/documents/test/documents/foo'
      @options.method = 'post'
      @body = 'Test document foo v2.'

      @expected = 'receipt /documents/test/documents/foo?version=2.0'

      @request done

    postWithVersion1: (done) ->
      @options.path = '/documents/test/documents/foo?version=1'
      @options.method = 'post'
      @body = 'Test document foo v1.1'

      @expected = 'receipt /documents/test/documents/foo?version=1.1.0'

      @request done

    postWithVersion2: (done) ->
      @options.path = '/documents/test/documents/foo?version=1'
      @options.method = 'post'
      @body = 'Test document foo v1.2'

      @expected = 'receipt /documents/test/documents/foo?version=1.2.0'

      @request done

    postWithVersion4: (done) ->
      @options.path = '/documents/test/documents/foo?version=4'
      @options.method = 'post'
      @body = 'Test document foo v1.2'

      @expected = 'error /documents/test/documents/foo?version=4\nversion out of range'

      @request done

    postOverDirectory: (done) ->
      @options.path = '/documents/test/documents'
      @options.method = 'post'
      @body = 'Test document. Error.'

      @expected = 'error /documents/test/documents\ntarget is a directory'

      @request done

    getSimple: (done) ->
      @options.path = '/documents/test/documents/foo'
      @options.method = 'get'
      @body = ''

      @expected = 'document /documents/test/documents/foo?version=2.0\nTest document foo v2.'

      @request done

    getIndex: (done) ->
      @options.path = '/documents/test/documents/foo?version=index'
      @options.method = 'get'
      @body = ''

      @expected = 'index /documents/test/documents/foo\n1.0\n1.1\n1.2\n2'

      @request done


class Test_stochastic extends AsyncTestBlock

class TestArchive extends AsyncTestUnit
  name: 'Archive'
  blocks: [ Test_directories,
            Test_documents,
            Test_stochastic ]


(new TestArchive).run()

