angular.module('skylar.smsControllers', [])

.controller 'RootController',
($scope, $location, $http, $route, $rootScope) ->
  console.log('okay!')

.controller 'SmsController',
($scope, $location, $http, $route, $rootScope) ->

  $scope.sms = ->
    console.log('patate')
    $http.post('/notify', "this is just a test")
      .success (data) ->
        console.log(data)
