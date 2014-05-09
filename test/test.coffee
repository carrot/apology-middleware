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
    chai.request(@app).get('/not-found.html').res (res) ->
      res.should.have.status(404)
      res.should.be.html
      base = fs.readFileSync(path.join(__dirname, '..', 'lib', '404.html'), 'utf8')
      res.text.should.equal(base)
      done()

describe 'custom', ->

  before ->
    @app = connect()
            .use((req, res, next)-> next('forced error'))
            .use(apology(path.join(base_path, 'custom.html')))

  it 'should return custom 404', (done) ->
    chai.request(@app).get('/not-found.html').res (res) ->
      res.should.have.status(404)
      res.should.be.html
      res.text.should.equal("<p>custom</p>\n")
      done()
