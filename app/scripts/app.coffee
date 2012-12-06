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
      $scope.lessons = cms.get 'lessons', (lessons) ->
        $scope.lessons = lessons
      $scope.submissions = feed.get 'submissions', (newSubmissions) ->
        $scope.submissions.push newSubmissions
  ])