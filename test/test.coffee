connect = require 'connect'
path = require 'path'
fs = require 'fs'
alchemist = require 'alchemist-middleware'

describe 'basic', ->
  before ->
    @app = connect().use(alchemist('./')).use(apology())

  it 'should be registered as middleware', ->
    (-> connect().use(apology())).should.not.throw()

  it 'should return default 404', (done) ->
    chai.request(@app).get('/not-found.html').res (res) ->
      res.should.have.status(404)
      res.should.be.html
      base = fs.readFileSync(
        path.join(__dirname, '../public/index.html')
        'utf8'
      )
      res.text.should.equal(base)
      done()

describe 'custom with relative path', ->
  before ->
    @app = connect()
            .use(alchemist('./'))
            .use(apology('not-found.html'))

  it 'should return 500 when passed error page is missing', (done) ->
    chai.request(@app).get('/not-found.html').res (res) ->
      res.should.have.status(500)
      res.should.be.html
      res.text.should.equal("Error: ENOENT, open 'not-found.html'\n\n")
      done()

describe 'custom with absolute path', ->
  before ->
    custom = path.join(base_path, 'custom.html')
    @app = connect()
            .use(alchemist('./'))
            .use(apology(custom))

  it 'should return custom 404', (done) ->
    chai.request(@app).get('/not-found.html').res (res) ->
      res.should.have.status(404)
      res.should.be.html
      res.text.should.equal("<p>custom</p>\n")
      done()

describe 'forced error', ->
  before ->
    @app = connect()
            .use((req, res, next)-> next('forced error'))
            .use(apology())

  it 'should return 500', (done) ->
    chai.request(@app).get('/not-found.html').res (res) ->
      res.should.have.status(500)
      res.should.be.html
      done()
