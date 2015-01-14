window.IA ||= {}
App = IA.App = angular.module('App', [])

App.config ["$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common["Accept"] = "application/json"
  $httpProvider.defaults.headers.common["Content-Type"] = "application/json"
]
App = IA.App

App.controller "BatchesCtrl", ["$scope", ($scope) ->
]