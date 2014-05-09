fs = require 'fs'

###*
 * Configures options and returns a middleware function.
 *
 * @param  {String} file - path to custom error page. Default 'lib/404.html'
 * @return {Function} middleware function
###

module.exports = (root, file) ->
  fallback = path.join(__dirname, '404.html')
  error_page = fallback

  if not file and root
    error_page = path.resolve(root)

  if file and root
    error_page = path.join(root, file)

  return (err, req, res, next) ->
    res.statusCode = 404
    res.setHeader('Content-Type', 'text/html')

    if not fs.lstatSync(error_page).isDirectory()
      res.write(fs.readFileSync(error_page))
    else
      res.write(fs.readFileSync(fallback))

    res.end()
