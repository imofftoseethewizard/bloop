fs = require 'fs'
path = require 'path'
url = require 'url'

# The pid file is used to identify and terminate this process.
#
fs.writeFile (path.join __dirname, '..','pid'), process.pid,
  (err) ->
    if err? then throw 'unable to write pid file'

connect = require 'connect'

client  = require './client'
object  = require './object'
server  = require './server'
session = require './session'

app = connect()

app.use connect.cookieParser()
app.use connect.session
  key: 'session.id'
  store: session.Store
  secret: String Math.random()

# should read this from a config file
# app.use connect.static path.resolve __dirname, '..', '..', 'client'

app.use '/about',   server.about
app.use '/client',  client.Interface.http
app.use '/object',  object.Interface.http
app.use '/session', session.Interface.http

# app.use '/documents', archive type: 'filesystem', root: path.resolve __dirname, '..', 'data'

app.listen 3000, '192.168.0.198'


