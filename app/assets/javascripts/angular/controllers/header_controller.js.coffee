App.controller 'HeaderController', ["$rootScope", '$scope', '$location', '$routeParams', 'User',  ($rootScope, $scope, $location, $routeParams, User) ->


  $rootScope.current_user = User.current_user(additional: 'current_user')





  $scope.index =->
    $location.path("/")

  $scope.signIn = ->
    $location.path("/sign_in")

  $scope.signUp = ->
    $location.path("/new_profile")

  $scope.signOut = ->
    $rootScope.$emit 'signOut', {}


]
