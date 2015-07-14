angular.module('skylar.services', ['ngResource'])
.factory 'Contact', ($resource) ->
  $resource('contact/:id',
    { id: '@_id'}, {update:{method:'PUT'}})