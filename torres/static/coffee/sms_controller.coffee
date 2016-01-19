angular.module('mimas.smsControllers', [])

.controller 'RootController',
($scope, $location, $http, $route, $rootScope) ->
  console.log('okay!')

.controller 'SmsController',
($scope, $location, $http, $route, $rootScope, Contact, Sms) ->

  $scope.messages = []
  Contact.query().$promise.then (value) ->
    $scope.contacts = value

  $scope.getsms = ->
    $http.get('/sms')
      .success (data) ->
        console.log(data)
        $scope.messages = data
      .error (data) ->
        console.log(data)

  $scope.message = ->
    request = {
      'message':$scope.msg,
      'number': $scope.number}
    $http.post('/message', request)
      .success (data) ->
        console.log('sent', request)

  $scope.add_contact = ->
    Contact.save({name:$scope.newname, number:$scope.newnmb})
      .$promise.then (value) ->
        $scope.contacts.push(value)
        $scope.add = false

  $scope.edit_contact = (contact) ->
    contact.backup = _.clone(contact)

  $scope.cancel_contact = (contact) ->
    _.extend(contact, contact.backup)
    delete contact['backup']

  $scope.save_contact = (contact) ->
    Contact.update({id:contact._id.$oid},
      _.omit(contact, 'backup')).$promise.then (value) ->
        delete contact['backup']

  $scope.del_contact = (contact) ->
    Contact.delete({id:contact._id.$oid}).$promise.then (value) ->
      $scope.contacts = _.without($scope.contacts, contact)
