connect = require 'connect'
path    = require 'path'
fs      = require 'fs'

describe 'basic', ->

  before ->
    @app = connect()
            .use((req, res, next)-> next('forced error'))
            .use(apology())

  it 'should be registered as middleware', ->
    (-> connect().use(apology())).should.not.throw()

  it 'should return default 404', (done) ->
    chai.request(@app).get('/not-found.html').end (res) ->
      res.should.have.status(404)
      res.should.be.html
      base = fs.readFileSync(path.join(__dirname, '..', 'lib', '404.html'), 'utf8')
      res.text.should.equal(base)
      done()

describe 'custom with only root path', ->

  before ->
    @app = connect()
            .use((req, res, next)-> next('forced error'))
            .use(apology(base_path))

  it 'should return default 404 when only root path is passed', (done) ->
    chai.request(@app).get('/not-found.html').end (res) ->
      res.should.have.status(404)
      res.should.be.html
      base = fs.readFileSync(path.join(__dirname, '..', 'lib', '404.html'), 'utf8')
      res.text.should.equal(base)
      done()

describe 'custom with absolute path', ->
  before ->
    custom = path.join(base_path, 'custom.html')
    @app = connect()
            .use((req, res, next)-> next('forced error'))
            .use(apology(custom))

  it 'should return custom 404', (done) ->
    chai.request(@app).get('/not-found.html').end (res) ->
      res.should.have.status(404)
      res.should.be.html
      res.text.should.equal("<p>custom</p>\n")
      done()

describe 'custom with root path and file', ->
  before ->
    @app = connect()
            .use((req, res, next)-> next('forced error'))
            .use(apology(base_path, 'custom.html'))

  it 'should return custom 404', (done) ->
    chai.request(@app).get('/not-found.html').end (res) ->
      res.should.have.status(404)
      res.should.be.html
      res.text.should.equal("<p>custom</p>\n")
      done()
