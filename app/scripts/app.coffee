angular.module('socratesApp', ['ngResource'])
  .config([
    '$routeProvider'
    ($routeProvider) ->
      $routeProvider.when '/', { templateUrl: 'views/home.html', controller: 'HomeCtrl' }
      $routeProvider.otherwise redirectTo: '/'
  ])
  .controller('HomeCtrl', [
    '$scope'
    'cms'
    ($scope, cms) ->
      $scope.lessons = cms.get 'lessons', (lessons) -> $scope.lessons = lessons
  ])