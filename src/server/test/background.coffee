$.ajax
  type: 'GET'
  url: 'http://localhost:8080/session/open'
  crossDomain: true
  dataType: 'json'

  # required so that Set-Cookie/Cookie headers work.
  xhrFields:
    withCredentials: true

  success: (data, status, xhr) ->
    console.log 'success', data, status
    checkStatus data

  error: (xhr, status, err) ->
    console.log 'error', status, err


checkStatus = (sessionId) ->
  $.ajax
    type: 'GET'
    url: 'http://localhost:8080/status'
    crossDomain: true
    dataType: 'json'
    xhrFields:
      withCredentials: true

    success: (data, status, xhr) ->
      console.log 'success', data, status

    error: (xhr, status, err) ->
      console.log 'error', status, err
