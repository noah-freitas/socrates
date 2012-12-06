'use strict'

describe 'Service: sse', () ->

  # load the service's module
  beforeEach module 'socratesApp'

  # instantiate service
  sse = {}
  beforeEach inject (_sse_) ->
    sse = _sse_

  it 'should do something', () ->
    expect(!!sse).toBe true;
