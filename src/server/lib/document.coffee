fs = require 'fs'
path = require 'path'
version = require './version'

readManifest = (path) ->
writeManifest = (path, data) ->
  manifest = fs.open 'manifest.json', 'w'
  manifest.write JSON.stringify data
  manifest.close()

saveContent = (path, version,  content) ->
  store = fs.open path + version
  store.write content
  store.close()
  version

create = (path, content) ->
  fs.mkdir path
  writeManifest path, versions: ['', ['1']]
  saveContent path, '1', content

save = (path, content, baseVersion) ->
  data = readManifest.path
  (nextVersion = version.next data.versions, baseVersion)? or fail()
  version.add data.versions, nextVersion
  saveContent path, nextVersion, content

fetch = (path, version) ->


