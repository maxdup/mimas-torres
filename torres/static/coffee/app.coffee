angular.module('skylarApp', ['ngRoute', 'ngCookies', 'ngResource', 'skylar.smsControllers'])
.config ($routeProvider, $httpProvider) ->
  $routeProvider
  .when '/home',
    controller: 'SmsController'
    templateUrl: 'static/partials/home.html'
  .when '/test',
    controller: 'SmsController'
    templateUrl: 'static/partials/test.html'
  .otherwise
    redirectTo: '/home'