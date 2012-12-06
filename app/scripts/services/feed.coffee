'use strict';

angular.module('socratesApp')
  .service 'feed', [
    '$resource'
    '$rootScope'
    'sse'
    ($resource, $rootScope, sse) ->
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
  ]
