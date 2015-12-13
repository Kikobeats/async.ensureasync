'use strict'

var ensureAsync = require('..')
var should = require('should')

describe('ensure async ::', function () {
  it('defer sync functions', function (done) {
    var sync = true
    ensureAsync(function (arg1, arg2, cb) {
      arg1.should.be.equal(1)
      arg2.should.be.equal(2)
      cb(null, 4, 5)
    })(1, 2, function (err, arg4, arg5) {
      (err != null).should.be.equal(false)
      arg4.should.be.equal(4)
      arg5.should.be.equal(5)
      sync.should.be.equal(false)
      done()
    })
    sync = false
  })

  it('do not defer async functions', function (done) {
    var sync = false
    ensureAsync(function (arg1, arg2, cb) {
      arg1.should.be.equal(1)
      arg2.should.be.equal(2)
      setImmediate(function () {
        sync = true
        cb(null, 4, 5)
        sync = false
      })
    })(1, 2, function (err, arg4, arg5) {
      (err != null).should.be.equal(false)
      arg4.should.be.equal(4)
      arg5.should.be.equal(5)
      sync.should.be.equal(true)
      done()
    })
  })

  it('double wrapping', function (done) {
    var sync = true
    ensureAsync(ensureAsync(function (arg1, arg2, cb) {
      arg1.should.be.equal(1)
      arg2.should.be.equal(2)
      cb(null, 4, 5)
    }))(1, 2, function (err, arg4, arg5) {
      (err != null).should.be.equal(false)
      arg4.should.be.equal(4)
      arg5.should.be.equal(5)
      sync.should.be.equal(false)
      done()
    })
    sync = false
  })
})
