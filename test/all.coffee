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

  it 'emits approximately l.ticksPerSecond tick events per second', (t) ->
    l = gloop
      ticksPerSecond: 400
    count = 0
    
    l.on 'tick', ->
      count += 1
    fraction = 0.25
    expected = l.ticksPerSecond * fraction

    l.start()

    setTimeout ->
      l.stop()
      # We have to give it a little breathing room:
      t.true count <= expected + expected*0.1
      t.true count >= expected - expected*0.1
      t.end()
    , 1000 * fraction

  it 'stops emitting ticks after `stop` is called', (t) ->
    l = gloop()
    
    l.start()

    setTimeout ->
      ticked = false
      l.stop()
      l.on 'tick', ->
        ticked = true
      t.false ticked
      t.end()
    , 50

  it 'emits `frame` events independently of `tick` events', (t) ->
    tickCount = 0
    frameCount = 0

    l = gloop
      ticksPerSecond: 20 # Something much lower than the "standard" 60hz framerate
    
    l.on 'tick', ->
      tickCount += 1

    l.on 'frame', ->
      frameCount += 1

    l.start()

    setTimeout ->
      l.stop()
      t.true tickCount > 0
      t.true frameCount > 0
      t.true tickCount < frameCount
      t.end()
    , 100

  it 'allows us to modify the tick-rate with `timeScale`', (t) ->
    l = gloop()
    
    count = 0
    
    l.on 'tick', ->
      count += 1

    l.timeScale = 1.5
    l.start()
    fraction = 0.25
    expected = l.ticksPerSecond * l.timeScale * fraction

    setTimeout ->
      l.stop()
      # We have to give it a little breathing room:
      t.true count <= expected + expected*0.1
      t.true count >= expected - expected*0.1
      t.end()
    , 1000 * fraction