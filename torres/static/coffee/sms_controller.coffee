angular.module('skylar.smsControllers', [])

.controller 'RootController',
($scope, $location, $http, $route, $rootScope) ->
  console.log('okay!')

.controller 'SmsController',
($scope, $location, $http, $route, $rootScope) ->

  $scope.messages = []
  $http.get('/contact')
    .success (data) ->
      $scope.contacts = data
      console.log(data)

  $scope.getsms = ->
    $http.get('/sms')
      .success (data) ->
        console.log(data)
        $scope.messages = data
      .error (data) ->
        console.log(data)

  $scope.testsms = {
    'From': '+12323445678',
    'To': '+12323445678',

    'ToCountry': 'CA',
    'ToState': 'QC',
    'ToCity': 'Montr\xe9al',

    'FromZip': '',
    'FromCity': 'Montr\xe9al',
    'FromState': 'QC',
    'FromCountry': 'CA',

    'Body': 'okayss',

    'SmsStatus': 'received',
    }

  $scope.notify = ->
    console.log('patate')
    $http({
      method: 'POST',
      url: '/notify',
      data: $.param($scope.testsms),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'}
    })

  $scope.message = ->
    request = {
      'message':$scope.msg,
      'number': $scope.number}
    $http.post('/message', request)
      .success (data) ->
        console.log('sent', request)

  $scope.add_contact = ->
    $http.post('/contact', {'name':$scope.newname, 'number':$scope.newnmb})
      .success (data) ->
        $scope.contacts.push(data)
        $scope.add = null

  $scope.edit_contact = (contact) ->
    contact.backup = _.clone(contact)

  $scope.cancel_contact = (contact) ->
    _.extend(contact, contact.backup)
    delete contact['backup']

  $scope.save_contact = (contact) ->
    $http.put('/contact', _.omit(contact, 'backup'))
      .success (data) ->
        delete contact['backup']

  $scope.del_contact = (contact) ->
    $http.delete('/contact', _.omit(contact, 'backup'))
      .success (data) ->
        $scope.contacts = _.without($scope.contacts, contact)
