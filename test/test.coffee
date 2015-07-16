'use strict'
require 'setimmediate'

ensureAsync = require '..'
should      = require 'should'


describe 'ensure async ::', ->

  it 'defer sync functions', (done) ->
    sync = true
    # console.log 'step 1'
    # console.log 'sync:', sync

    ensureAsync((arg1, arg2, cb) ->
      # console.log 'step 2'
      # console.log 'sync:', sync
      arg1.should.be.equal 1
      arg2.should.be.equal 2
      cb null, 4, 5
      return
    ) 1, 2, (err, arg4, arg5) ->
      # console.log 'step 3'
      # console.log 'sync:', sync
      (err?).should.be.equal false
      arg4.should.be.equal 4
      arg5.should.be.equal 5
      sync.should.be.equal false
      done()
      return

    sync = false

  it 'do not defer async functions', (done) ->
    sync = false
    ensureAsync((arg1, arg2, cb) ->
      arg1.should.be.equal 1
      arg2.should.be.equal 2
      setImmediate ->
        sync = true
        cb null, 4, 5
        sync = false
        return
      return
    ) 1, 2, (err, arg4, arg5) ->
      (err?).should.be.equal false
      arg4.should.be.equal 4
      arg5.should.be.equal 5
      sync.should.be.equal true
      done()
      return

  it 'double wrapping', (done) ->
    sync = true
    ensureAsync(ensureAsync((arg1, arg2, cb) ->
      arg1.should.be.equal 1
      arg2.should.be.equal 2
      cb null, 4, 5
      return
    )) 1, 2, (err, arg4, arg5) ->
      (err?).should.be.equal false
      arg4.should.be.equal 4
      arg5.should.be.equal 5
      sync.should.be.equal false
      done()
      return
    sync = false
