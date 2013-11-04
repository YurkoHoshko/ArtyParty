App.controller 'IndexController', ['$scope', '$location', '$routeParams', 'User', 'Party', ($scope, $location, $routeParams, User, Party ) ->



  date = new Date
  $scope.user = User.next_birthday(additional: 'next_birthday')


  $scope.next_party = Party.next_party
    path: 'next_party',
    ->
      $scope.monitoredLocation = $scope.next_party.location



  $scope.users =->
    $location.path("/users")

  $scope.parties = ->
    $location.path("/parties")





]
