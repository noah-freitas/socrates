angular.module('socratesApp').directive 'login', [
  '$resource'
  '$http'
  ($resource, $http) ->
    templateUrl: 'views/directives/login.html'
    restrict: 'E'
    replace: true
    controller: ($scope) ->
      $scope.auth = $resource '/api/auth/index.php', null,
        login:
          method: 'GET'
          params: {}
          isArray: false
          headers: null
      $scope.user = null
      $scope.login = -> if $scope.user? then navigator.id.request() else navigator.id.logout()
      $scope.userNotLoggedIn = -> $scope.user?
      navigator.id.watch
        loggedInUser: if $scope.user? then $scope.user.email else null
        onlogin: (assertion) ->
          $scope.user = 'noah.j.freitas@gmail.com'
          $scope.auth.login { assertion: assertion } , (data) ->
            console.log data
            if data.status is "okay"
              $scope.user = data.email
              _gaq.push ['_trackEvent', 'User', 'Login', data.email]
        onlogout: ->
          _gaq.push ['_trackEvent', 'User', 'Logout', $scope.user.email]
          $scope.$apply $scope.user = null
]
