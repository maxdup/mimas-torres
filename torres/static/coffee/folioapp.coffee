angular.module('folioApp', ['ngRoute', 'ngCookies', 'ngResource', 'ngAnimate', 'folio.Controllers'])
.config ($routeProvider, $httpProvider) ->
  $routeProvider
  .when '/home',
    controller: 'FolioController'
    templateUrl: 'static/partials/folio.html'
  .when '/commercial',
    controller: 'FolioController'
    templateUrl: 'static/partials/commercial.html'
  .when '/hobby',
    controller: 'FolioController'
    templateUrl: 'static/partials/hobby.html'
  .when '/code',
    controller: 'FolioController'
    templateUrl: 'static/partials/code.html'
  .when '/contact',
    controller: 'FolioController'
    templateUrl: 'static/partials/contact.html'
  .otherwise
    redirectTo: '/home'
