# Apology Middleware

[![npm](http://img.shields.io/npm/v/apology-middleware.svg?style=flat)](https://badge.fury.io/js/apology-middleware) [![tests](http://img.shields.io/travis/carrot/apology-middleware/master.svg?style=flat)](https://travis-ci.org/carrot/apology-middleware)
[![coverage](http://img.shields.io/coveralls/carrot/apology-middleware.svg?style=flat)](https://coveralls.io/r/carrot/apology-middleware) [![dependencies](http://img.shields.io/gemnasium/carrot/apology-middleware.svg?style=flat)](https://david-dm.org/carrot/apology-middleware)

Middleware for custom error pages

> **Note:** This project is in early development, and versioning is a little different. [Read this](http://markup.im/#q4_cRZ1Q) for more details.

### Why should you care?

Let's say that you are using [connect](https://github.com/senchalabs/connect) to serve a static site. Occasionally, and by no fault of yours of course, some one may request a URL that you don't have. Your app will gladly return a 404 code for you, but sometimes that's not enough. Apology Middleware is for those times when you want to serve a custom HTML document for those pesky 404s.  

### Installation

`npm install apology-middleware --save`

### Usage

This library can be used with connect, express, and any other server stack that accepts the same middleware format.

There are a few different ways to interact with apology. The first is to simply pass an absolute path to the html file you wish to serve. It should be noted, apology automatically sets the content type as `text/html`.

```js
var http = require('http');
    connect = require('connect'),
    apology = require('apology-middleware'),
    serveStatic  = require('serve-static');

var app = connect()
            .use(apology('/path/to/4oh4.html')
            .use(serveStatic(__dirname));

var server = http.createServer(app).listen(1111)
```

Apology can optionally take two arguments, a `root` and a `file`. These two will automatically be joined.

```js
apology(__dirname, 'custom.html');
```

If you don't specify a custom error page then apology will serve our standard error file for you (don't worry, it's quite handsome).

### License & Contributing

- Details on the license [can be found here](LICENSE.md)
- Details on running tests and contributing [can be found here](contributing.md)
