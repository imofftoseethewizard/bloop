parseUrl = (require 'url').parse

exports.parameterMissing = (domainId, url, res, name) ->
  { pathname, query } = parse url, true
  res.writeHead 400
  res.end JSON.stringify
    type: 'Parameter Missing'
    domain: domainId or 'none'
    method: pathname
    parameters: query
    fault: name
    constraint: 'required parameter'
