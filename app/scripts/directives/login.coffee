'use strict';

angular.module('socratesApp')
  .directive 'login', () ->
    template: '<div></div>'
    restrict: 'E'
    link: (scope, element, attrs) ->
      element.text 'this is the login directive'
