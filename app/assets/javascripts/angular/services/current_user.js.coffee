App.service "CurrentUser", [ "$rootScope", 'User', ($rootScope, User) ->
  user = {}

  user.signedIn =->
    console.log 'signed in'

    $rootScope.current_user = User.current_user({additional: 'current_user'})


  user.signOut =->
    $rootScope.$broadcast "signOut"

  user.signedOut =->
    console.log 'boom'
    $rootScope.current_user.user = null



]