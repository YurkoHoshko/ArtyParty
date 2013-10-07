App.controller 'UsersController', ['$scope', 'User', '$location', '$routeParams', ($scope, User, $location, $routeParams) ->


  $scope.partyTitle = null
  $scope.users = User.query()



]