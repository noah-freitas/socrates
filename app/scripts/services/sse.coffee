'use strict';

angular.module('socratesApp')
  .service 'sse', [
    () ->
      listen: (url, callback) ->
        # Create the new event source.
        evtSource = new EventSource url
        # Listen for server updates and activate the callback wih the new data.
        evtSource.addEventListener "serverUpdate", (e) ->
          callback JSON.parse e.data

        # Don't return the evtSource - it exposes too much.
        # Create an interface if necessary.
        true
  ]