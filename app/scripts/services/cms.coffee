'use strict';

angular.module('socratesApp')
  .service 'cms', [
    '$resource'
    '$rootScope'
    ($resource, $rootScope) ->
      ### Init ###
      # Load cms from local storage or use an empty object.
      if window.localStorage?.cms?
        cms = JSON.parse window.localStorage.cms
      else
        cms = {}
  
      # If we have a network connection or this browser doesn't support network
      # connection detection, sync cms with the server.
      if navigator.onLine is true or navigator.onLine is undefined
        # The server takes an updated parameter (timestamp) which comes
        # from the cms object if present, a 0 otherwise.
        server = $resource 'data/cms.json', updated: cms.updated ? 0
        # Sync with the server.
        cmsUpdates = server.get () ->
          # Merge in the cmsUpdates and update the updated property.
          ## This doesn't work yet. ##
          for own name, data of cmsUpdates
            cms[name] = data
          # Broadcast an update event.
          $rootScope.$broadcast 'cmsupdate', cms
          # Store the updated cms records.
          window.localStorage.cms = JSON.stringify cms
    
      ### API ###
      get: (objectName, callback) ->
        # Pass the updated object to the callback when the cms is updated.
        $rootScope.$on 'cmsupdate', (e) -> callback cms[objectName]
        cms[objectName]
  ]