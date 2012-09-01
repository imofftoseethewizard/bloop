fs = require 'fs'
path = require 'path'
url = require 'url'

fs.writeFile (path.join __dirname, '..','pid'), process.pid,
  (err) ->
    if err? then throw 'unable to write pid file'

connect = require 'connect'
archive = require './archive'

app = connect()

# should read this from a config file
# app.use connect.static path.resolve __dirname, '..', '..', 'client'

app.use '/documents', archive type: 'filesystem', root: path.resolve __dirname, '..', 'data'

app.listen 3000, '192.168.0.198'


