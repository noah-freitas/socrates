'use strict'

describe 'Service: feed', () ->

  # load the service's module
  beforeEach module 'socratesApp'

  # instantiate service
  feed = {}
  beforeEach inject (_feed_) ->
    feed = _feed_

  it 'should do something', () ->
    expect(!!feed).toBe true;
