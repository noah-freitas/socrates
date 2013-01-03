angular.module('socratesApp').directive 'lessonCarousel', ->
    template: '<div></div>'
    restrict: 'E'
    link: (scope, element, attrs) ->  element.text 'this is the lessonCarousel directive'
