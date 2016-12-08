angular.module('folioApp', ['ngRoute', 'ngCookies', 'ngResource', 'ngAnimate', 'folio.Controllers'])
.config ($routeProvider, $httpProvider) ->
  $routeProvider
  .when '/home',
    controller: 'FolioController'
    templateUrl: 'static/partials/folio.html'
  .when '/commercial',
    controller: 'FolioController'
    templateUrl: 'static/partials/commercial.html'
  .otherwise
    redirectTo: '/home'
