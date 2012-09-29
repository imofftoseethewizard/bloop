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

createDomain  = (publicKey, next) -> request 'POST', 'domain/create?' + ($.param publicKey: publicKey), next
authenticate  = (domainId, next)  -> request 'POST', 'domain/' + domainId + '/authenticate', next
aboutDomain   = (domainId, next)  -> request 'GET', 'domain/' + domainId + '/about', next
listDomains   = (options, next)   -> request 'GET', 'domain/list?' + ($.param options), next
enableDomain  = (domainId, next)  -> request 'POST', 'domain/' + domainId + '/enable', next
disableDomain = (domainId, next)  -> request 'POST', 'domain/' + domainId + '/disable', next

displayKey = (key) ->
  b = blockLength = 55
  (key.slice i, i+b for i in [0..(key.length + b)] by b).join ' '

update = () ->
  ($ (if localStorage.host is LOCAL_HOST then '#localHost' else '#remoteHost')).prop 'checked', true
  ($ '#publicKey').text displayKey localStorage.publicKey
  if not localStorage.domainId?
    ($ '#domainId').text 'None'
    ($ '#authenticateDomain').addClass 'disabled'
  else
    ($ '#domainId').text localStorage.domainId
    ($ '#authenticateDomain').removeClass 'disabled'

domainOrder = '_id increasing'
visibleDomains = [id: '0']

class DomainMgr
  constructor: () ->
    @table = null
    @rows = []
    @rowsById = {}
    @active = null

  onDocumentReady: () ->
    @table = $ '#domainList'
    @refresh()

    @createBtn = $ '#createDomain'
    @createBtn.click () =>
      if not @createBtn.hasClass 'disabled'
        @createBtn.addClass 'disabled'
        defer 0, () =>
          createDomainKey()
          createDomain localStorage.publicKey, (result, err) =>
            @createBtn.removeClass 'disabled'
            if err?
              ($ '#domainId').text 'None'
              console.log 'createDomain error', err, result
            else
              ($ '#authenticateDomain').removeClass 'disabled'
              ($ '#domainId').text result
              localStorage.domainId = result
              @setActiveDomain result
              @refresh()

    @authenticateBtn = $ '#authenticateDomain'
    @authenticateBtn.click () =>
      if not @authenticateBtn.hasClass 'disabled'
        @authenticateBtn.addClass 'disabled'
        authenticate localStorage.domainId, (result, err) =>
          console.log 'authenticate', result, err
          ($ '#createDomain').removeClass 'disabled'
          ($ '#domainId').text result

    @toggleEnableBtn = $ '#toggleEnableDomain'
    @toggleEnableBtn.click () =>
      if @toggleEnableBtn.text() is 'Disable'
        @toggleEnableBtn.text 'Enable'
        @deleteBtn.removeClass 'disabled'
        disableDomain @active, () =>
          @updateDomainDetails()
          @activeRow.addClass 'disabled'

      else
        @toggleEnableBtn.text 'Disable'
        @deleteBtn.addClass 'disabled'
        enableDomain @active, () =>
          @updateDomainDetails()
          @activeRow.removeClass 'disabled'

    @deleteBtn = $ '#deleteDomain'

  refresh: () ->
    @fetchDomains (domains) =>
      table = @table[0]
      tbody = table.children[0]
      for d, i in domains
        row = $("<tr class=\"value\"><td>#{ d._id }</td><td>#{ d.created }</td><td>#{ d.authorization }</td></tr>")
        if table.rows[i+1]?
          tbody.replaceChild row[0], table.rows[i+1]
        else
          tbody.appendChild row[0]
        if d._id == @active
          $(row).addClass 'active'
        if not d.enabled
          $(row).addClass 'disabled'
        row.prop 'index', i+1
        row.prop 'domain', d
        do (d) =>
          row.click () => @setActiveDomain d._id

      @updateDomainDetails @active

  fetchDomains: (next) ->
    options =
      count: 10
      orderBy: @domainOrder
    listDomains options, (result, err) =>
      if err?
        console.log 'error in list domains', err, result
      else
        if not @active?
          @setActiveDomain result[0]._id
        next result

  setActiveDomain: (@active) ->
    $('#activeDomainId').text @active
    table = @table[0]
    for r, i in table.rows when i > 0
      if r.domain._id == @active
        @activeRow = $(r)
        @activeRow.addClass 'active'
      else
        $(r).removeClass 'active'

    @updateDomainDetails()

  updateDomainDetails: () ->
    aboutDomain @active, (domain, err) =>
      if err?
        console.log 'failed to get details', @active
      else
        for k, v of domain
          v = displayKey v if k is 'publicKey'
          $('#domainDetail_' + k).text v
        if domain.enabled
          @toggleEnableBtn.text 'Disable'
          @deleteBtn.addClass 'disabled'
        else
          @toggleEnableBtn.text 'Enable'
          @deleteBtn.removeClass 'disabled'

domainMgr = new DomainMgr

($ document).ready () ->
  ($ '#localUrl').text LOCAL_HOST
  ($ '#remoteUrl').text REMOTE_HOST
  update()
  domainMgr.onDocumentReady()


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




