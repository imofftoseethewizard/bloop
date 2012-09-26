HOST_REMOTE = 'https://mule.nodejitsu.com/'
HOST_LOCAL = 'http://localhost:8080/'

localStorage.host or= HOST_LOCAL

($ '[type=radio]').change () ->
  localStorage.host = (if @id is 'host_local' then HOST_LOCAL else HOST_REMOTE)
  ($ '#session_open').removeClass 'disabled'
  ($ '#session_close').addClass 'disabled'
  ($ '#sessionId').text 'None'

($ '#session_open').click () ->
  if not ($ this).hasClass 'disabled'
    ($ this).addClass 'disabled'
    openSession (result, err) ->
      if err?
        ($ this).removeClass 'disabled'
        ($ '#sessionId').text 'None'
        console.log 'session_open error', err
      else
        ($ '#session_close').removeClass 'disabled'
        ($ '#sessionId').text result

($ '#session_close').click () ->
  if not ($ this).hasClass 'disabled'
    ($ this).addClass 'disabled'
    closeSession () ->
      ($ '#session_open').removeClass 'disabled'
      ($ '#sessionId').text 'None'


($ document).ready () ->
  ($ (if localStorage.host is HOST_LOCAL then '#host_local' else '#host_remote')).prop 'checked', true
  ($ '#local_url').text HOST_LOCAL
  ($ '#remote_url').text HOST_REMOTE

openSession = (next) ->
  $.ajax
    type: 'POST'
    url: localStorage.host + 'session/open'
    crossDomain: true
    dataType: 'json'

    # required so that Set-Cookie/Cookie headers work.
    xhrFields:
      withCredentials: true

    success: (data, status, xhr) -> next data
    error: (xhr, status, err) ->    next null, err

closeSession = (next) ->
  $.ajax
    type: 'GET'
    url: localStorage.host + 'status'
    crossDomain: true
    dataType: 'json'
    xhrFields:
      withCredentials: true

    success: (data, status, xhr) -> next data
    error: (xhr, status, err) ->    next data, err


