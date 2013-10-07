App.controller 'SessionsController', [ '$scope', '$http', '$location', '$routeParams', 'User', '$rootScope', ( $scope, $http, $location, $routeParams, User,  $rootScope) ->

  $scope.revealDatepicker = false
  $rootScope.current_user = User.current_user({additional: 'current_user'})

  $scope.showDatepicker =->
    $scope.revealDatepicker = if $scope.revealDatepicker is true then false else true

  $scope.dateOptions =
    changeYear: true
    changeMonth: true
    yearRange: '1900:-0'


  $scope.login_user =
    email: null
    password: null

  $scope.login_error =
    message: null
    errors: {}

  $scope.register_user =
    email: null
    password: null
    name: null
    password_confirmation: null
    date_of_birth: 'Monday, 14 October 1974'
    phone: null


  $scope.register_error =
    message: null
    errors: {}


  $scope.set_current_user =->
   $rootScope.current_user.user = true


  $scope.unset_current_user =->
    $rootScope.current_user.user = null

  $scope.login = ->
    $scope.submit
      method: "POST"
      url: "../users/sign_in.json"
      data:
        user:
          email: $scope.login_user.email
          password: $scope.login_user.password
      success_message: "You have been logged in."
      error_entity: $scope.login_error
      success_path: '/'
      success_action: $scope.set_current_user()


  $scope.logout = ->
    $scope.submit
      method: "DELETE"
      url: "../users/sign_out.json"
      success_message: "You have been logged out."
      error_entity: $scope.login_error
      success_path: '/'
      success_action: $scope.unset_current_user()





  $scope.password_reset = ->
    $scope.submit
      method: "POST"
      url: "../users/password.json"
      data:
        user:
          email: $scope.login_user.email

      success_message: "Reset instructions have been sent to your e-mail address"
      error_entity: $scope.login_error


  $scope.unlock = ->
    $scope.submit
      method: "POST"
      url: "../users/unlock.json"
      data:
        user:
          email: $scope.login_user.email

      success_message: "An unlock e-mail has been sent to your e-mail address."
      error_entity: $scope.login_error


  $scope.confirm = ->
    $scope.submit
      method: "POST"
      url: "../users/confirmation.json"
      data:
        user:
          email: $scope.login_user.email

      success_message: "A new confirmation link has been sent to your e-mail address."
      error_entity: $scope.login_error


  $scope.register = ->
    $scope.submit
      method: "POST"
      url: "../users.json"
      data:
        user:
          email: $scope.register_user.email
          name: $scope.register_user.name
          date_of_birth: $scope.register_user.date_of_birth
          password: $scope.register_user.password
          password_confirmation: $scope.register_user.password_confirmation
          phone: $scope.register_user.phone

      success_message: "You have been registered and logged in.  A confirmation e-mail has been sent to your e-mail address, your access will terminate in 2 days if you do not use the link in that e-mail."
      error_entity: $scope.register_error
      success_path: '/index'
      error_path: '/new_profile'




  $scope.change_password = ->
    $scope.submit
      method: "PUT"
      url: "../users/password.json"
      data:
        user:
          email: $scope.register_user.email
          password: $scope.register_user.password
          password_confirmation: $scope.register_user.password_confirmation

      success_message: "Your password has been updated."
      error_entity: $scope.register_error


  $scope.submit = (parameters) ->
    $scope.reset_messages()
    $http(
      method: parameters.method
      url: parameters.url
      data: parameters.data
    ).success((data, status) ->
      if status is 201 or status is 204
        parameters.error_entity.message = parameters.success_message
        $scope.reset_users()
      else
        parameters.error_entity.message = data.error
      if parameters.success_path
        $location.path(parameters.success_path)
      if parameters.success_action
        success_action
    ).error (data, status) ->
      if status is 422
        parameters.error_entity.errors = data.errors
      else
        parameters.error_entity.message = data.error
      if parameters.error_path
        $location.path(parameters.error_path)


  $scope.reset_messages = ->
    $scope.login_error.message = null
    $scope.login_error.errors = {}
    $scope.register_error.message = null
    $scope.register_error.errors = {}

  $scope.reset_users = ->
    $scope.login_user.email = null
    $scope.login_user.password = null
    $scope.register_user.email = null
    $scope.register_user.password = null
    $scope.register_user.password_confirmation = null
    $scope.register_user.date_of_birth = null

    $scope.$on 'signedIn', ->
      console.log 'wth'







]