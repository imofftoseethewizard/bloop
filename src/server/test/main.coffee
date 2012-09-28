REMOTE_HOST = 'https://mule.nodejitsu.com/'
LOCAL_HOST = 'http://localhost:8080/'

localStorage.host or= LOCAL_HOST

createDomainKey = () ->
  password = localStorage.password = util.uuidgen()
  keypair = cryptico.generateRSAKey password, 1024
  localStorage.publicKey = cryptico.publicKeyString keypair
  delete localStorage.domainId

if not localStorage.publicKey? then createDomainKey()

defer = (d, fn) -> setTimeout fn, d

request = (method, url, next) ->
  $.ajax
    type: method
    url: localStorage.host + url
    crossDomain: true
    dataType: 'json'
    xhrFields:
      withCredentials: true

    success: (data, status, xhr) -> next data
    error: (xhr, status, err) ->    next (JSON.parse xhr.responseText), err

openSession  = (next) -> request 'POST', 'session/open',  next
closeSession = (next) -> request 'POST', 'session/close', next

createDomain = (publicKey, next) -> request 'POST', ('domain/create?' + $.param publicKey: publicKey), next
authenticate = (domainId, next) -> request 'POST', 'domain/' + domainId + '/authenticate', next
aboutDomain = (domainId, next) -> request 'GET', 'domain/' + domainId + '/about', next

displayKey = (key) ->
  b = blockLength = 40
  (key.slice i, i+b for i in [0..(key.length + b)] by b).join ' '

update = () ->
  ($ (if localStorage.host is LOCAL_HOST then '#localHost' else '#remoteHost')).prop 'checked', true
  ($ '#localUrl').text LOCAL_HOST
  ($ '#remoteUrl').text REMOTE_HOST
  ($ '#publicKey').text displayKey localStorage.publicKey
  if not localStorage.domainId?
    ($ '#domainId').text 'None'
    ($ '#createDomain').removeClass 'disabled'
    ($ '#authenticateDomain').addClass 'disabled'
  else
    ($ '#domainId').text localStorage.domainId
    ($ '#createDomain').addClass 'disabled'
    ($ '#authenticateDomain').removeClass 'disabled'



($ document).ready () -> update()

#
# Sessions
#

($ '[type=radio]').change () ->
  localStorage.host = (if @id is 'localHost' then LOCAL_HOST else REMOTE_HOST)
  ($ '#openSession').removeClass 'disabled'
  ($ '#closeSession').addClass 'disabled'
  ($ '#sessionId').text 'None'

($ '#openSession').click () ->
  if not ($ this).hasClass 'disabled'
    ($ this).addClass 'disabled'
    openSession (result, err) =>
      if err?
        ($ this).removeClass 'disabled'
        ($ '#sessionId').text 'None'
        console.log 'openSession error', err, result
      else
        ($ '#closeSession').removeClass 'disabled'
        ($ '#sessionId').text result

($ '#closeSession').click () ->
  if not ($ this).hasClass 'disabled'
    ($ this).addClass 'disabled'
    closeSession () ->
      ($ '#openSession').removeClass 'disabled'
      ($ '#sessionId').text 'None'

#
# Domains
#

($ '#newDomainKey').click () ->
  if not ($ this).hasClass 'disabled'
    ($ this).addClass 'disabled'
    defer 0, () =>
      createDomainKey()
      ($ this).removeClass 'disabled'
      ($ '#createDomain').removeClass 'disabled'
      ($ '#authenticateDomain').addClass 'disabled'
      update()

($ '#createDomain').click () ->
  if not ($ this).hasClass 'disabled'
    ($ this).addClass 'disabled'
    createDomain localStorage.publicKey, (result, err) =>
      if err?
        ($ this).removeClass 'disabled'
        ($ '#domainId').text 'None'
        console.log 'createDomain error', err, result
      else
        ($ '#authenticateDomain').removeClass 'disabled'
        ($ '#domainId').text result
        localStorage.domainId = result

($ '#authenticateDomain').click () ->
  if not ($ this).hasClass 'disabled'
    ($ this).addClass 'disabled'
    authenticate localStorage.domainId, (result, err) ->
      console.log 'authenticate', result, err
      ($ '#createDomain').removeClass 'disabled'
      ($ '#domainId').text result

($ '#aboutDomain').click () ->
  if not ($ this).hasClass 'disabled'
    aboutDomain localStorage.domainId, (result, err) ->
      console.log 'aboutDomain', result, err


