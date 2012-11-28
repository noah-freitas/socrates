socratesApp = angular.module 'socratesApp', ['soc-db']
socratesApp.config [
  '$routeProvider'
  ($routeProvider) ->
    $routeProvider.when '/', { templateUrl: 'views/home.html', controller: 'HomeCtrl' }
    $routeProvider.otherwise redirectTo: '/'
]
socratesApp.controller 'HomeCtrl', [
  '$scope'
  ($scope) ->
]
