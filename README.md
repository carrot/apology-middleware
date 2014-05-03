# Apology Middleware

[![npm](http://img.shields.io/npm/v/apology-middleware.svg?style=flat)](https://badge.fury.io/js/apology-middleware) [![tests](http://img.shields.io/travis/carrot/apology-middleware/master.svg?style=flat)](https://travis-ci.org/carrot/apology-middleware) [![dependencies](http://img.shields.io/gemnasium/carrot/apology-middleware.svg?style=flat)](https://david-dm.org/carrot/apology-middleware)

Middleware for custom error pages

> **Note:** This project is in early development, and versioning is a little different. [Read this](http://markup.im/#q4_cRZ1Q) for more details.

### Why should you care?

Let's say that you are using [connect](https://github.com/senchalabs/connect) to serve a static site. Occasionally, and by no fault of yours of course, some one may request a URL that you don't have. Your app will gladly return a 404 code for you, but sometimes that's not enough. Apology Middleware is for those times when you want to serve a custom HTML document for those pesky 404s.  

### Installation

`npm install apology-middleware --save`

### Usage

This library can be used with connect, express, and any other server stack that accepts the same middleware format. A very basic usage example:

```js
var http = require('http');
    connect = require('connect'),
    apology = require('apology-middleware'),
    static  = require('serve-static');

var app = connect()

app.use(apology({error_page: '4oh4.html'})
app.use(static());

var server = http.createServer(app).listen(1111)
```

As you can see, you can simply pass an `error_page` object that's value points to the file you wish to serve. If you don't specify an `error_page` or point to one that doesn't exist (404-ception, whoa) then apology will serve our standard error file (don't worry, it's quite handsome).

### License & Contributing

- Details on the license [can be found here](LICENSE.md)
- Details on running tests and contributing [can be found here](contributing.md)
