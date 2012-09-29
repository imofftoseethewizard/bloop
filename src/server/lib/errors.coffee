url = require 'url'

errors = [
  [400, 'Internal Error'],
  [400, 'Invalid Value'],
  [403, 'Not Allowed'],
  [404, 'Not Found'],
  [400, 'Parameter Missing'] ]

error = (code, type) ->
  (domainId, req, res, fault, constraint) ->
    { pathname, query } = url.parse req.url, true
    res.writeHead code
    res.end JSON.stringify
      type: type
      domain: domainId or 'none'
      method: pathname
      parameters: query
      fault: fault
      constraint: constraint

exports[type.replace ' ', ''] = error code, type for [code, type] in errors

