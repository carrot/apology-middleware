axis         = require 'axis'
rupture      = require 'rupture'
autoprefixer = require 'autoprefixer-stylus'

module.exports =
  ignores: [
    '**/layout.*'
    '**/_*'
    '.gitignore'
    'lib/**'
    'assets/**'
    'test/**'
    '*.md' # specific to this project
    '.editorconfig'
    '.npmignore'
    '.travis.yml'
    'Makefile'
  ]
  stylus:
    use: [axis(), rupture(), autoprefixer()]
