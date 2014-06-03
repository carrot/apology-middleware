fs = require 'fs'
path = require 'path'
accepts = require 'accepts'

###*
 * Configures options and returns a middleware function.
 * @param  {String} [file='public/index.html'] - path to custom error page.
 * @return {Function} middleware function
###
module.exports = (file = path.join(__dirname, '/../public/index.html')) ->
  if arguments.length > 1
    # support passing `root` as first arg for backwards compatibility. remove
    # this later
    file = path.join(arguments...)

  return (err, req, res, next) ->
    res.statusCode = (
      if err.status
        err.status
      else if res.statusCode < 400
        500
    )
    accept = accepts(req)

    if accept.type('html')
      fs.readFile file, 'utf8', (err, html) ->
        if err
          res.statusCode = 500
          next(err)
        else
          res.setHeader 'Content-Type', 'text/html; charset=utf-8'
          res.end html
    else if accept.type('json')
      error =
        message: err.message
        stack: err.stack

      for prop of err
        continue
      json = JSON.stringify(error: error)
      res.setHeader 'Content-Type', 'application/json'
      res.end json
    else
      # send plain text
      res.setHeader 'Content-Type', 'text/plain'
      res.end err.stack
