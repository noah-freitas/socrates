angular.module('socratesApp', ['ngResource'])
  .config([
    '$routeProvider'
    ($routeProvider) ->
      $routeProvider.when '/', { templateUrl: 'views/home.html', controller: 'HomeCtrl' }
      $routeProvider.otherwise redirectTo: '/'
  ])
  .controller('HomeCtrl', [
    '$scope'
    'cms'
    'feed'
    ($scope, cms, feed) ->
      ### Data Functions ###

      # Get the lessons from the CMS.
      $scope.lessons = cms.get 'lessons', (update) ->
        $scope.lessons = update

      # Get the submissions from the Feed.
      $scope.submissions = feed.get 'submissions', (newSubmissions) ->
        $scope.submissions.push newSubmissions


      ### UI Functions ###

      # Tracks active lesson based on current date.
      $scope.isActiveLesson = (ii) ->
        today = new Date
        lessonDay = new Date $scope.lessons[ii].pubDate
        difference = Math.abs(today.getTime() - lessonDay.getTime())
        # If difference is less than one week in milliseconds return true
        # otherwise return false.
        difference < 604800000
  ])