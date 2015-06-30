angular.module('skylar.smsControllers', [])

.controller 'RootController',
($scope, $location, $http, $route, $rootScope) ->
  console.log('okay!')

.controller 'SmsController',
($scope, $location, $http, $route, $rootScope) ->

  $scope.notify = ->
    console.log('patate')
    $http.post('/notify', "this is just a test")
      .success (data) ->
        console.log(data)

  $scope.message = ->
    request = {
      'message':$scope.msg,
      'number': $scope.number}
    $http.post('/message', request)
      .success (data) ->
        console.log('sent', request)