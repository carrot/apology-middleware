send = require 'send'

###*
 * Configures options and returns a middleware function.
 *
 * @param  {String} file - path to custom error page. Default 'lib/404.html'
 * @return {Function} middleware function
###

module.exports = (file) ->
  opts =
    error_page: file || path.join('lib', '404.html')

  return (err, req, res, next) ->
    res.statusCode = 404
    send(req, path.resolve(opts.error_page)).pipe(res)
