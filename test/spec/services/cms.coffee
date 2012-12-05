'use strict'

describe 'Service: cms', () ->

  # load the service's module
  beforeEach module 'socratesApp'

  # instantiate service
  cms = {}
  beforeEach inject (_cms_) ->
    cms = _cms_

  it 'should do something', () ->
    expect(!!cms).toBe true;
