DearyApp = angular.module 'DearyApp', []

DearyApp.config ['$httpProvider', ($httpProvider) ->
  unindempotentMethods = [
    'post'
    'patch'
    'put'
    'delete'
  ]
  $httpProvider.defaults.headers[httpMethod] = { 'X-From': window.location.origin } for httpMethod in unindempotentMethods
]

DearyApp.controller 'HubCtrl', ['$scope', ($scope) ->
  $scope.showNewEntry = false
]

DearyApp.controller 'SessionCtrl', ['$scope', '$http', ($scope, $http) ->
  $scope.logout = ->
    if confirm('Logout?')
      $http(
        method: 'DELETE'
        url: '/-/sessions'
      ).success -> window.location.pathname = '/'

  $scope.login = (user) ->
    $http(
      method: 'POST'
      url: '/-/sessions'
      data: user
      headers:
        'Content-Type' : 'application/json'
    ).success -> window.location.pathname = '/'
]

DearyApp.controller 'EditEntryCtrl', ['$scope', '$http', ($scope, $http) ->
  $scope.showEditor = false

  $scope.edit = (path) ->
    $http.get("#{path}.json").success (data) ->
      $scope.entry = data
      $scope.path = path
      $scope.showEditor = true

  $scope.save = (entry) ->
    $http(
      method: 'PATCH'
      url: $scope.path
      data: entry
      headers:
        'Content-Type': 'application/json'
    ).success -> window.location.reload()
]

DearyApp.controller 'NewEntryCtrl', ['$scope', '$http', ($scope, $http) ->
  $scope.$watch "$parent.showNewEntry", (val) ->
    $scope.showEditor = val
  $scope.$watch "showEditor", (val) ->
    $scope.$parent.showNewEntry = val

  $scope.showEditor = false
  $scope.path = '/-/entries'

  $scope.edit = () ->
    $scope.showEditor = true

  $scope.save = (entry) ->
    $http(
      method: 'POST'
      url: $scope.path
      data: entry
      headers:
        'Content-Type': 'application/json'
    ).success -> window.location.reload()
]
