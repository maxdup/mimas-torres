angular.module('skylar.testController', [])

.controller 'TestController',
($scope, $location, $http, $route, $rootScope, Contact, Sms) ->

  $scope.testaddto = ->
    Sms.update({id:''}, {})

  $scope.testsms = {
    'From': '+12323445678',
    'To': '+12323445678',

    'ToCountry': 'CA',
    'ToState': 'QC',
    'ToCity': 'Montr\xe9al',

    'FromZip': '',
    'FromCity': 'Montr\xe9al',
    'FromState': 'QC',
    'FromCountry': 'CA',

    'Body': 'okayss',
    'SmsStatus': 'received',
  }

  $scope.notify = ->
    $http({
      method: 'POST',
      url: '/notify',
      data: $.param($scope.testsms),
      headers: {'Content-Type': 'application/x-www-\
      form-urlencoded'}
    })