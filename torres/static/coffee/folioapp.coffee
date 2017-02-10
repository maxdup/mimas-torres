app = angular.module('folioApp', ['ngRoute', 'ngCookies', 'ngResource', 'ngAnimate', 'folio.rootController', 'folio.Controllers', 'folio.Locale', 'ui.bootstrap'])
app.config ($routeProvider, $httpProvider, $locationProvider) ->
  $routeProvider
  .when '/',
    controller: 'FolioController'
    templateUrl: 'static/partials/folio.html'
  .when '/commercial',
    controller: 'FolioController'
    templateUrl: 'static/partials/commercial.html'
  .when '/hobby/:map?',
    controller: 'FolioController'
    templateUrl: 'static/partials/hobby.html'
  .when '/code',
    controller: 'FolioController'
    templateUrl: 'static/partials/code.html'
  .when '/contact',
    controller: 'FolioController'
    templateUrl: 'static/partials/contact.html'
  .otherwise
    redirectTo: '/'

  $locationProvider
  .html5Mode(true)
