angular.module('mimasApp', ['ngRoute', 'ngCookies', 'ngResource', 'mimas.smsControllers', 'mimas.testController', 'mimas.services'])
.config ($routeProvider, $httpProvider) ->
  $routeProvider
  .when '/home',
    controller: 'RootController'
    templateUrl: 'static/partials/home.html'
  .when '/sms',
    controller: 'SmsController'
    templateUrl: 'static/partials/sms.html'
  .when '/test',
    controller: 'TestController'
    templateUrl: 'static/partials/test.html'
  .otherwise
    redirectTo: '/home'