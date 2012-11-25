socratesApp = angular.module 'socratesApp', []
socratesApp.config [
  '$routeProvider'
  ($routeProvider) ->
    $routeProvider.when '/', { templateUrl: 'views/main.html', controller: 'MainCtrl' }
    $routeProvider.otherwise redirectTo: '/'
]
window.socratesApp = socratesApp
