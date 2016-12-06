angular.module('folioApp', ['ngRoute', 'ngCookies', 'ngResource', 'ngAnimate', 'folio.Controllers'])
.config ($routeProvider, $httpProvider) ->
  $routeProvider
  .when '/home',
    controller: 'FolioController'
    templateUrl: 'static/partials/folio.html'
  .otherwise
    redirectTo: '/home'
