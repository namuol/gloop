tape = require 'tape'
gloop = require '../index'

describe = (item, cb) ->
  it = (capability, test) ->
    tape.test item + ' ' + capability, (t) ->
      test(t)

  cb it

describe 'a gloop', (it) ->
  it 'should have some tests written', (t) ->
    t.fail()
    t.end()
