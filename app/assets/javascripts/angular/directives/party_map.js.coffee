App.directive 'partyMap', ->
  (scope, element, attrs) ->
    map = {}
    markers = []

######## Map buidlers #######

    createStandartMap  =->
      map.myLatlng = new google.maps.LatLng(49.837204, 24.021555)
      myOptions =
        zoom: 13
        center: map.myLatlng
        mapTypeId: google.maps.MapTypeId.ROADMAP
      map.map = new google.maps.Map(jQuery( "[party-map]" ).get(0), myOptions)

    createStandartMarker =->
      partyLatlng = new google.maps.LatLng(49.837204, 24.021555)
      marker = new google.maps.Marker(
        position: partyLatlng
        map: map.map
        title: "Office"
      )
      markers.push(marker)


    setMarker = (party) ->
      partyLatlng = new google.maps.LatLng(party.latitude, party.longitude)
      marker = new google.maps.Marker(
        position: partyLatlng
        map: map.map
        title: party.title
      )
      markers.push(marker)
      infowindow = new google.maps.InfoWindow(content: party.short_description)

      google.maps.party.addListener marker, "mouseover", ((marker) ->
        ->
          infowindow.open map.map, marker
          )(marker)

      google.maps.party.addListener marker, "click", ((marker) ->
        ->
          scope.$apply ->
            scope.selectedMarker = party
          )(marker)

      google.maps.party.addListener marker, "mouseout", ((marker) ->
        ->
          infowindow.close map.map, marker
          )(marker)

    clearMarkers =->
      for marker in markers
        marker.setMap null

    geolocate = (party) ->
      geocoder = new google.maps.Geocoder()
      geocoder.geocode
        address: party
      , (results, status) ->
        if status is google.maps.GeocoderStatus.OK
          map.map.panTo results[0].geometry.location
          clearMarkers()
          marker = new google.maps.Marker(
            map: map.map
            position: results[0].geometry.location
          )
          markers.push(marker)
        else
          alert "Geocode was not successful for the following reason: " + status

####### Watchers #########

    scope.$watch 'monitoredLocation', (party) ->
      if party
        console.log('located')
        geolocate(party)

##### Initializers ###########
    createStandartMap()
    createStandartMarker()