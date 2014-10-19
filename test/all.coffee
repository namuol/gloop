tape = require 'tape'
gloop = require '../index'

describe = (item, cb) ->
  it = (capability, test) ->
    tape.test item + ' ' + capability, (t) ->
      test(t)

  cb it

describe 'a gloop', (it) ->
  it 'can be started and stopped', (t) ->
    l = gloop()
    l.start()
    l.stop()
    t.end()

  it 'emits a `start` event when it is started', (t) ->
    l = gloop()
    emitted = false
    l.on 'start', ->
      emitted = true
    l.start()
    t.true emitted
    l.stop()
    t.end()

  it 'emits a `stop` event when it is stopped', (t) ->
    l = gloop()
    emitted = false
    l.on 'stop', ->
      emitted = true
    l.start()
    l.stop()
    t.true emitted
    t.end()

  it 'emits l.ticksPerSecond tick events per second', (t) ->
    l = gloop
      ticksPerSecond: 80
    count = 0
    
    l.on 'tick', ->
      count += 1
    
    l.start()

    setTimeout ->
      l.stop()
      t.true count <= 82
      t.true count >= 78
      t.end()
    , 1000
