'use strict';

angular.module('socratesApp')
  .service('cms', [
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
      get: (objectName, callback) ->
        # Pass the updated object to the callback when the cms is updated.
        $rootScope.$on 'cmsupdate', (e) -> callback cms[objectName]
        cms[objectName]
  ])
  .service('feed', [
    '$resource'
    '$rootScope'
    ($resource, $rootScope) ->
      ### Init ###  
      # If we have a network connection or this browser doesn't support network
      # connection detection, connect feed with the server.
      if navigator.onLine is true or navigator.onLine is undefined
        # Load feed from session storage or use an empty object.
        if window.sessionStorage?.feed?
          feed = JSON.parse window.sessionStorage.feed
        else
          feed = {}

        merge = (arr, obj, prop) ->
          arr[prop].push obj[prop]

        # Connect with the feed server.
        feedServer = sse.listen 'data/feed.php', (data) ->
          # Update feed.
          merge feed, data, prop for own prop of data
          # Broadcast any new feed data
          $rootScope.$broadcast 'feedData', data 
          # Store the new feed data in session storage.
          window.sessionStorage.feed = JSON.stringify feed
    
      ### API ###
      get: (objectName, callback) ->
        # Pass the updated object to the callback when the feed has new data.
        $rootScope.$on 'feedData', (update) -> callback feed[objectName], update
        feed[objectName]
  ])
  .service('sse', [
    () ->
      listen: (url, callback) ->
        # Create the new event source.
        evtSource = new EventSource url
        # Listen for server updates and activate the callback wih the new data.
        evtSource.addEventListener "serverUpdate", (e) =>
          callback JSON.parse e.data

        # Don't return the evtSource - it exposes too much.
        # Create an interface if necessary.
        true
  ])