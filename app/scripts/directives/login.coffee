angular.module('socratesApp').directive 'login', [
  '$resource'
  '$http'
  ($resource, $http) ->
    templateUrl: 'views/directives/login.html'
    restrict: 'E'
    replace: true
    controller: [
      '$scope'
      ($scope) ->
        # Set up our server-side persona verify service.
        $scope.auth = $resource '/api/auth/index.php', null,
          login:
            method: 'GET'
            params: {}
            isArray: false
            headers: null

        # Start with user set to null
        $scope.user = null

        # Simple login toggle function.
        $scope.login = ->
          if not $scope.user?
            navigator.id.request()
          else
            navigator.id.logout()

        # Returns true if there is a logged in user.
        $scope.userNotLoggedIn = -> $scope.user?

        # Set up our Persona event listeners.
        navigator.id.watch
          # loggedInUser is the user's email or null
          loggedInUser: if $scope.user? then $scope.user.email else null

          # Login event handler.
          onlogin: (assertion) ->
            # Make a request to our persona verify service with the assertion.
            $scope.auth.login { assertion: assertion }, (data) ->
              # If the assertion is valid.
              if data.status is 'okay'
                # Set the user equal to the verified email.
                $scope.user = data.email
                # Track the login event.
                _gaq.push ['_trackEvent', 'User', 'Login', data.email]

          # Logout event handler.
          onlogout: ->
            # Track the logout event.
            _gaq.push ['_trackEvent', 'User', 'Logout', $scope.user.email]
            # Set the user equal to null.
            $scope.$apply $scope.user = null
    ]
]
