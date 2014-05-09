fs = require 'fs'

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
    res.setHeader('Content-Type', 'text/html')
    res.write(fs.readFileSync(path.resolve(opts.error_page)))
    res.end()
