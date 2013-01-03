angular.module('socratesApp').directive 'scheduleCarousel', ->
    template: '<div></div>'
    restrict: 'E'
    link: (scope, element, attrs) ->  element.text 'this is the scheduleCarousel directive'
