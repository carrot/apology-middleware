send    = require 'send'

###*
 * Configures options and returns a middleware function.
 *
 * Options:
 * - error_page: Path to custom error page. Default 'lib/404.html'
 *
 * @param  {String} root - path to the root directory to server
 * @param  {Object} opts - options object, described above
 * @return {Function} middleware function
###

module.exports = (opts = {}) ->
  opts =
    error_page: opts.error_page || path.join('lib', '404.html')

  return (err, req, res, next) ->
    res.statusCode = 404
    send(req, path.resolve(opts.error_page)).pipe(res)
