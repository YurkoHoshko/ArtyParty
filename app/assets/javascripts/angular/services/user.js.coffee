App.factory 'User', ['$resource', ($resource) ->


    $resource('/api/users/:additional',
      {},
      query:
        method: 'GET'
        isArray: true
      next_birthday:
        method: 'GET'
        additional: '@additional'
      current_user:
        method: 'GET'
        additional: '@additional'
    )
]
