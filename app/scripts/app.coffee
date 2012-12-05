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
socratesApp.factory 'cms', [
    '$resource'
    '$rootScope'
    ($resource, $rootScope) ->
        ### Init ###
        # Load cms from local storage.
        cms = JSON.parse window.localStorage.cms
        # If we have a network connection sync cms with the server.
        if navigator.onLine
            # The server takes an updated parameter (timestamp) which comes
            # from the cms object if present, a 0 otherwise.
            server = $resource 'data/cms.php', params: updated: cms.updated ? 0
            # Sync with the server.
            cmsUpdates = server.$get () ->
                # Merge in the cmsUpdates and update the updated property.
                for own key, value of cmsUpdates
                    cms[key] = value
                # Broadcast an update event.
                $rootScope.$broadcast 'cmsupdate'
                # Store the updated cms records.
                window.localStorage.cms = JSON.stringify cms

        ### Private ###
        create = (objectName) ->
            cms[objectName] = {}

        ### API ###
        get: (objectName, callBack) ->
            $rootScope.$on 'cmsupdate', (e) -> callback cms[objectName]
            cms[objectName] ? create(objectName)
]