{EventEmitter} = require 'events'
raf = require 'raf'

class GameLoop extends EventEmitter
  @defaults:
    timeScale: 1
    ticksPerSecond: 120

  constructor: (properties) ->
    @timeScale = properties?.timeScale ? GameLoop.defaults.timeScale
    @ticksPerSecond = properties?.ticksPerSecond ? GameLoop.defaults.ticksPerSecond
    @dt = 1000/@ticksPerSecond
    @__accum = 0

  start: ->
    @emit 'start'
    run = =>
      @_loop()
      @_handle = raf run

    @_handle = raf run

  stop: ->
    @emit 'stop'
    raf.cancel @_handle

  _loop: ->
    now = Date.now()
    @__lastCall ?= now
    delta = now - @__lastCall
    count = 0
    
    @__lastCall = now
    @__accum = Math.min (@dt/@timeScale)*10, @__accum + delta
    while (@__accum >= @dt/@timeScale) and count < 20
      count += 1
      @emit 'tick', @dt
      @__accum -= @dt/@timeScale

    @emit 'draw', (1 - @__accum / @dt/@timeScale) / 1000

create = (properties) ->
  return new GameLoop properties

module.exports = create
