App.controller 'PartiesListController', ['$scope', 'Party', '$location', '$routeParams', ($scope, Party, $location, $routeParams) ->


  $scope.partyTitle = null
  $scope.parties = Party.query()

  $scope.deleteParty = (partyId) ->
    Party.delete({id: partyId})
    $scope.parties = Party.query()

  $scope.editParty = (partyId) ->
    $location.path("/edit/"+partyId)

  $scope.createNewParty = ->
    $location.path("/new")

  $scope.signIn = ->
    $location.path("/sign_in")


]

App.controller 'PartyEditController',  ['$scope', 'Party', '$location', '$routeParams', ($scope, Party, $location, $routeParams) ->
  $scope.revealDatepicker = false

  $scope.showDatepicker =->
    $scope.revealDatepicker = if $scope.revealDatepicker is true then false else true

  $scope.dateOptions =
    changeYear: true
    changeMonth: true
    yearRange: '1900:-0'

  $scope.updateParty =->
    Party.update($scope.party)
    $location.path('/index')

  $scope.cancel =->
    $location.path('/index')

  $scope.party = Party.show({id: $routeParams.id});


]

App.controller 'PartyCreateController',  ['$scope', 'Party', '$location', '$routeParams', ($scope, Party, $location, $routeParams) ->

  $scope.revealDatepicker = false
  $scope.party = {};
  $scope.party.location = "Львів, Дорошенка 50"
  $scope.party.date = "Tuesday, 1 October, 2013"

  $scope.showDatepicker =->
    $scope.revealDatepicker = if $scope.revealDatepicker is true then false else true

  $scope.dateOptions =
    changeYear: true
    changeMonth: true
    yearRange: '1900:-0'

  $scope.createNewParty =->
    Party.create($scope.party)
    $location.path('/index')

  $scope.cancel =->
    $location.path('/index')

  $scope.updatePosition =->
    $scope.monitoredLocation = $scope.party.location



]