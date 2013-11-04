window.App = angular.module('ArtyParty',  ['ngResource', 'ngCookies', 'ui.date'])




interceptor = ["$location", "$rootScope", "$q", ($location, $rootScope, $q) ->
  success = (response) ->
    response
  error = (response) ->
    if response.status is 401
      $rootScope.$broadcast "event:unauthorized"
      $location.path "/sign_in"
      $rootScope.error = response.data.error

      return response
    $q.reject response
  (promise) ->
    promise.then success, error
]




App.config ["$httpProvider", (provider) ->
  provider.responseInterceptors.push interceptor

]



App.config(['$routeProvider',  ($routeProvider) ->

  $routeProvider.when "/",
    templateUrl: "../assets/index.html.haml",
    controller: "IndexController"

  $routeProvider.when "/users",
    templateUrl: "../assets/user/index.html.haml",
    controller: "UsersController"

  $routeProvider.when "/new",
    templateUrl: "../assets/party/new_party.html.haml",
    controller: "PartyCreateController"

  $routeProvider.when "/edit/:id",
    templateUrl: "../assets/party/edit_party.html.haml",
    controller: "PartyEditController"

  $routeProvider.when "/parties",
    templateUrl: "../assets/party/index.html.haml",
    controller: "PartiesListController"

  $routeProvider.when "/sign_in",
    templateUrl: "../assets/user/sessions/new.html.haml",
    controller: "SessionsController"

  $routeProvider.when "/new_profile",
    templateUrl: "../assets/user/registrations/new.html.haml",
    controller: "SessionsController"

  $routeProvider.when "/edit_profile",
    templateUrl: "../assets/user/registrations/edit.html.haml",
    controller: "SessionsController"
  # Default
  $routeProvider.otherwise({ templateUrl: '../assets/index.html.haml', controller: 'IndexController' } )

])

