'use strict'

describe 'Directive: login', () ->
  beforeEach module 'socratesApp'

  element = {}

  it 'should make hidden element visible', inject ($rootScope, $compile) ->
    element = angular.element '<login></login>'
    element = $compile(element) $rootScope
    expect(element text()).toBe 'this is the login directive'
