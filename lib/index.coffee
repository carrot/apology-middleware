fs = require 'fs'

###*
 * Configures options and returns a middleware function.
 *
 * @param  {String} file - path to custom error page. Default 'lib/404.html'
 * @return {Function} middleware function
###

module.exports = (root, file) ->
  error_page = path.join('lib', '404.html')

  if not file and root
    error_page = path.resolve(root)

  if file and root
    error_page = path.join(root, file)

  return (err, req, res, next) ->
    res.statusCode = 404
    res.setHeader('Content-Type', 'text/html')
    res.write(fs.readFileSync(error_page))
    res.end()
