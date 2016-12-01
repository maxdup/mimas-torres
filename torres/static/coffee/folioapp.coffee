angular.module('folioApp', ['ngRoute', 'ngCookies', 'ngResource', 'folio.Controllers'])
.config ($routeProvider, $httpProvider) ->
  $routeProvider
  .when '/home',
    controller: 'FolioController'
    templateUrl: '/static/partials/folio.html'
  .otherwise
    redirectTo: '/home'
