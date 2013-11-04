App.controller 'HeaderController', ["$rootScope", '$scope', '$location', '$routeParams', 'User',  ($rootScope, $scope, $location, $routeParams, User) ->


  $rootScope.user = User.current_user(
    {additional: 'current_user'}
    ,->
      $scope.current_user = true
    ,->
      $scope.current_user = false
      )

  $scope.$on 'SignedIn',  ->
    $scope.current_user = true

  $scope.$on 'SignedOut',  ->
    $scope.current_user = false





  $scope.index =->
    $location.path("/")

  $scope.signIn = ->
    $location.path("/sign_in")

  $scope.signUp = ->
    $location.path("/new_profile")

  $scope.signOut = ->
    $rootScope.$emit 'signOut', {}


]
