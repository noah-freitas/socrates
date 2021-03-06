'use strict'

angular.module('socratesApp')
  .controller 'MainCtrl', [
    '$scope'
    'cms'
    'feed'
    ($scope, cms, feed) ->
      ### Data Functions ###

      # Get the lessons from the CMS.
      $scope.lessons = cms.get 'lessons', (update) ->
        $scope.lessons = update

      # Get the submissions from the Feed.
      $scope.submissions = feed.get 'submissions', (allSubmissions, newSubmissions) ->
        if typeof $scope.submissions is 'undefined'
          $scope.submissions = []
        $scope.$apply $scope.submissions = $scope.submissions.concat newSubmissions


      ### UI Functions ###

      # Tracks active lesson based on current date.
      $scope.isActiveLesson = (ii) ->
        today = new Date
        lessonDay = new Date $scope.lessons[ii].pubDate
        difference = Math.abs(today.getTime() - lessonDay.getTime())
        # If difference is less than one week in milliseconds return true
        # otherwise return false.
        difference < 604800000
  ]
