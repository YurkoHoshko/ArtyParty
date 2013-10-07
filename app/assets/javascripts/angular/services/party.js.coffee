App.factory 'Party', ['$resource', ($resource) ->
    $resource('/api/parties/:path/:id',
      {},
      query:
        method: 'GET'
        isArray: true
      create:
        method: 'POST'
      show:
        method: 'GET'
      next_party:
        method: 'GET'
        path: '@additional'
      update:
        method: 'PUT'
        params:
          id: '@id'
      delete:
        method: 'DELETE'
        params:
          id: '@id'
    )
]

