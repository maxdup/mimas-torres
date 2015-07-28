angular.module('skylar.services', ['ngResource'])
.factory 'Contact', ($resource) ->
  $resource('contact/:id',
    { id: '@_id'}, {update:{method:'PUT'}})

.factory 'Sms', ($resource) ->
  $resource('sms/:id',
    { id: '@_id'}, {update:{method:'PUT'}})