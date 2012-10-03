REMOTE_HOST = 'https://mule.nodejitsu.com/'
LOCAL_HOST = 'http://localhost:8080/'

defer = (d, fn) -> setTimeout fn, d

request = (method, url, data, next) ->
  if data?
    console.log 'request data', JSON.stringify data if data?
  $.ajax
    type: method
    url: localStorage.host + url
    crossDomain: true
    dataType: 'json'
    data: data if data?
    xhrFields:
      withCredentials: true

    success: (data, status, xhr) -> next data
    error: (xhr, status, err) ->    next (JSON.parse xhr.responseText), err

openSession  = (next)        -> request 'POST', 'session/open',  undefined, next
closeSession = (next)        -> request 'POST', 'session/close', undefined, next
authenticate  = (doc, next)  -> request 'POST', 'session/authenticate', doc, next

createDomain  = (publicKey, next) -> request 'POST', 'domain/create?' + ($.param publicKey: publicKey), undefined, next
aboutDomain   = (domainId, next)  -> request 'GET', 'domain/' + domainId + '/about', undefined, next
listDomains   = (options, next)   -> request 'GET', 'domain/list?' + ($.param options), undefined, next
countDomains  = (options, next)   -> request 'GET', 'domain/count?' + ($.param options), undefined, next
enableDomain  = (domainId, next)  -> request 'POST', 'domain/' + domainId + '/enable', undefined, next
disableDomain = (domainId, next)  -> request 'POST', 'domain/' + domainId + '/disable', undefined, next
deleteDomain  = (domainId, next)  -> request 'POST', 'domain/' + domainId + '/delete', undefined, next


displayKey = (key) ->
  b = blockLength = 55
  (key.slice i, i+b for i in [0..(key.length + b)] by b).join ' '


savePassword = (domainId, password) ->
  passwords = JSON.parse localStorage.passwords
  passwords[domainId] = password
  localStorage.passwords = JSON.stringify passwords

getPassword = (domainId) -> (JSON.parse localStorage.passwords)[domainId]

#
# Hosts
#

class HostMgr
  constructor: () ->
    HostMgr.instance = this
    localStorage.host or= LOCAL_HOST
    ($ document).ready () => @onDocumentReady()

  onDocumentReady: () ->
    ($ (if localStorage.host is LOCAL_HOST then '#localHost' else '#remoteHost')).prop 'checked', true
    ($ '#localUrl').text LOCAL_HOST
    ($ '#remoteUrl').text REMOTE_HOST

    ($ '[type=radio]').change () ->
      localStorage.host = (if @id is 'localHost' then LOCAL_HOST else REMOTE_HOST)
      SessionMgr.instance.close()

#
# Sessions
#

class SessionMgr
  constructor: () ->
    SessionMgr.instance = this
    ($ document).ready () => @onDocumentReady()

  onDocumentReady: () ->
    @sessionIdField = $ '#sessionId'
    @openSessionBtn = $ '#openSession'
    @openSessionBtn.click () =>
      if not @openSessionBtn.hasClass 'disabled'
        @openSessionBtn.addClass 'disabled'
        openSession (result, err) =>
          if err?
            @openSessionBtn.removeClass 'disabled'
            @sessionIdField.text 'None'
            console.log 'openSession error', err, result
          else
            @session = result
            @closeSessionBtn.removeClass 'disabled'
            @sessionIdField.text result

    @closeSessionBtn = $ '#closeSession'
    @closeSessionBtn.click () =>
      if not @closeSessionBtn.hasClass 'disabled'
        @close()

    @authenticateBtn = $ '#authenticateDomain'
    @authenticateBtn.click () =>
      if not @authenticateBtn.hasClass 'disabled'
        @authenticateBtn.addClass 'disabled'
        # get key values from localstorage and recreate key structure
        key = 'TODO' # TODO: replace cryptico.generateRSAKey (getPassword @activeDomain), 1024
        content = JSON.stringify
          session: @session
          domain:  @activeDomain
          tick:    (new Date).getTime()

        doc =
          guarantor: @activeDomain,
          content:   content
          signature: 'TODO' #TODO: SHA256 then private encrypt content

        authenticate doc, (result, err) =>
          console.log 'authenticate', result, err
          ($ '#createDomain').removeClass 'disabled'

    defer 100, () =>
      @activeDomain = DomainMgr.instance.active
      @updateAuthenticateEnable()

      DomainMgr.instance.on 'activeDomainChanged', (@activeDomain) =>
        @updateAuthenticateEnable()

  updateAuthenticateEnable: () ->
    if (getPassword @activeDomain)?
      @authenticateBtn.removeClass 'disabled'
    else
      @authenticateBtn.addClass 'disabled'

  close: () ->
    @closeSessionBtn.addClass 'disabled'
    closeSession () =>
      @openSessionBtn.removeClass 'disabled'
      @sessionIdField.text 'None'




class DomainMgr extends EventEmitter
  constructor: () ->
    DomainMgr.instance = this
    localStorage.passwords or= '{}'

    @table = null
    @rows = []
    @rowsById = {}
    @active = null
    @domainOrder = '_id increasing'
    @totalDomains = 0
    @pageLength = 10
    @currentPage = 0

    ($ document).ready () => @onDocumentReady()

  onDocumentReady: () ->

    @table = $ '#domainList'
    tbody = $ 'tbody', @table
    for i in [0...@pageLength]
      tbody.append $("<tr><td>&nbsp;</td><td></td><td></td></tr>")

    @refresh()

    @createBtn = $ '#createDomain'
    @createBtn.click () =>
      if not @createBtn.hasClass 'disabled'
        @createBtn.addClass 'disabled'
        defer 0, () =>
          password = util.uuidgen()
          keypair = #TODO cryptico.generateRSAKey password, 1024
          publicKey = # TODO cryptico.publicKeyString keypair
          createDomain publicKey, (domainId, err) =>
            @createBtn.removeClass 'disabled'
            if err?
              console.log 'createDomain error', err, result
            else
              savePassword domainId, password
              @refresh()

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
    @deleteBtn.click () =>
      if not @deleteBtn.hasClass 'disabled'
        deleteDomain @active, () =>
          row = @activeRow[0]
          if row.nextSibling? and row.nextSibling.domain?
            @setActiveDomain (($ row.nextSibling).prop 'domain')._id
          else if row.previousSibling?
            @setActiveDomain (($ row.previousSibling).prop 'domain')._id
          @refresh()

    @nextPageBtn = $ '#nextDomainPage'
    @nextPageBtn.click () =>
      if not @nextPageBtn.hasClass 'disabled'
        @currentPage++
        @refresh()
        @prevPageBtn.removeClass 'disabled'

    @prevPageBtn = $ '#prevDomainPage'
    @prevPageBtn.click () =>
      if not @prevPageBtn.hasClass 'disabled'
        @currentPage--
        if @currentPage == 0
          @prevPageBtn.addClass 'disabled'
        @refresh()
        @nextPageBtn.removeClass 'disabled'



  refresh: () ->
    @fetchDomains (domains) =>
      @activeRow = null
      for r, i in $ 'tr', @table when i > 0
        if i-1 >= domains.length
          ($ r).replaceWith $("<tr><td>&nbsp;</td><td></td><td></td></tr>")
        else
          d = domains[i-1]
          row = $("<tr class=\"value\"><td>#{ d._id }</td><td>#{ d.created }</td><td>#{ d.authorization }</td></tr>")
          ($ r).replaceWith row
          if d._id == @active
            row.addClass 'active'
            @activeRow = row
          if not d.enabled
            row.addClass 'disabled'
          row.prop 'domain', d
          do (d) =>
            row.click () => @setActiveDomain d._id

      # probably got scrolled off the list as a result of a new domain
      if not @activeRow?
        rows = ($ 'tr', @table).toArray()
        while rows.length > 0 and not rows[rows.length-1].domain?
          rows.pop()

        if rows.length > 0
          @setActiveDomain rows[rows.length-1].domain._id

      @updateDomainDetails()

  fetchDomains: (next) ->
    options =
      count: (@currentPage + 1) * @pageLength
      orderBy: @domainOrder
    listDomains options, (result, err) =>
      if err?
        console.log 'error in list domains', err, result
      else
        if not @active?
          @setActiveDomain result[0]._id
        next result.slice @currentPage * @pageLength

    defer 500, () =>
      countDomains { firstId: '0' }, (count, err) =>
        if err?
          console.log 'error in count domains', err, count
        else
          @totalDomains = count
          if @totalDomains >= (@currentPage + 1) * @pageLength
            @nextPageBtn.removeClass 'disabled'
          else
            @nextPageBtn.addClass 'disabled'

  setActiveDomain: (@active) ->
    $('#activeDomainId').text @active
    for r, i in $ 'tr', @table when i > 0 and r.domain?
      if r.domain._id == @active
        @activeRow = $(r)
        @activeRow.addClass 'active'
      else
        $(r).removeClass 'active'

    @emit 'activeDomainChanged', @active
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

        if domain.authorization is 'system'
          @deleteBtn.addClass 'disabled'


new HostMgr
new SessionMgr
new DomainMgr

window.hostMgr = HostMgr.instance
window.sessionMgr = SessionMgr.instance
window.domainMgr = DomainMgr.instance



