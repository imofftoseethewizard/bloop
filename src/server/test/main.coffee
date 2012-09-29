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

createDomain = (publicKey, next) -> request 'POST', 'domain/create?' + ($.param publicKey: publicKey), next
authenticate = (domainId, next)  -> request 'POST', 'domain/' + domainId + '/authenticate', next
aboutDomain  = (domainId, next)  -> request 'GET', 'domain/' + domainId + '/about', next
listDomains  = (options, next)   -> request 'GET', 'domain/list?' + ($.param options), next

displayKey = (key) ->
  b = blockLength = 55
  (key.slice i, i+b for i in [0..(key.length + b)] by b).join ' '

update = () ->
  ($ (if localStorage.host is LOCAL_HOST then '#localHost' else '#remoteHost')).prop 'checked', true
  ($ '#publicKey').text displayKey localStorage.publicKey
  if not localStorage.domainId?
    ($ '#domainId').text 'None'
    ($ '#createDomain').removeClass 'disabled'
    ($ '#authenticateDomain').addClass 'disabled'
  else
    ($ '#domainId').text localStorage.domainId
    ($ '#createDomain').addClass 'disabled'
    ($ '#authenticateDomain').removeClass 'disabled'

domainOrder = '_id increasing'
visibleDomains = [id: '0']

activeRow = 0
loadDomains = () ->
  if domainOrder in ['_id increasing', '-_id decreasing']
    options =
      count: 10
      orderBy: domainOrder
    listDomains options, (result, err) ->
      if err?
        console.log 'error in list domains', err, result
      else
        table = $('#domainList')[0]
        tbody = table.children[0]
        for d, i in result
          row = $("<tr class=\"value\"><td>#{ d._id }</td><td>#{ d.created }</td><td>#{ d.authorization }</td></tr>")
          if table.rows[i+1]?
            tbody.replaceChild row[0], table.rows[i+1]
          else
            tbody.appendChild row[0]
          row.prop 'index', i+1
          row.prop 'domain', d
          row.click () ->
            activeRow = @index
            for r, i in table.rows
              if i == activeRow
                $(r).addClass 'active'
              else
                $(r).removeClass 'active'
            aboutDomain @domain._id, (result, err) =>
              if err?
                console.log 'failed to get details', @domain._id
              else
                showDomainDetails result
        if activeRow == 0
          activeRow = 1
          ($ table.rows[1]).addClass 'active'
        showDomainDetails table.rows[activeRow].domain

showDomainDetails = (domain) ->
  for k, v of domain
    v = displayKey v if k is 'publicKey'
    $('#domainDetail_' + k).text v

($ document).ready () ->
  ($ '#localUrl').text LOCAL_HOST
  ($ '#remoteUrl').text REMOTE_HOST
  update()
  loadDomains()


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
        loadDomains()

($ '#authenticateDomain').click () ->
  if not ($ this).hasClass 'disabled'
    ($ this).addClass 'disabled'
    authenticate localStorage.domainId, (result, err) ->
      console.log 'authenticate', result, err
      ($ '#createDomain').removeClass 'disabled'
      ($ '#domainId').text result





