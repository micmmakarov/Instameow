window.IA ||= {}
App = IA.App = angular.module('App', [])

App.config ["$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common["Accept"] = "application/json"
  $httpProvider.defaults.headers.common["Content-Type"] = "application/json"
]
App = IA.App

App.filter "relativeTimeFormat", ->
  (time) ->
    if time?
      moment(time).fromNow()

App.filter "timeDifference", ->
  (time1, time2) ->
    moment(time1).diff(moment(time2), 'days')

App.controller "MineCtrl", ["$scope", "$http", ($scope, $http) ->
  $scope.mine = ->
    selectedUsers = _.where $scope.followers, {selected: true}
    ids = _.map selectedUsers, (user) ->
      user.id
    $http
      method: 'POST'
      url: "/mine"
      data: {ids: ids}
    .success ->
      alert "success"
    .error ->
      alert "error"

]

App.controller "BatchesCtrl", ["$scope", "$http", ($scope, $http) ->
  $scope.init = ->
    $scope.totalFollowed = _.reduce($scope.batches, (memo, batch) ->
      memo + batch.users_count
    , 0
    )

    $scope.totalFollowedBack = _.reduce($scope.batches, (memo, batch) ->
      memo + batch.followed_back
    , 0
    )
  $scope.unfollowBatch = (batch) ->
    $http
      method: 'POST'
      url: "/batches/#{batch.id}/unfollow_not_followers"
    .success ->
      batch.unfollowed_not_followers = Date.now()
    .error ->
      alert "error"
  $scope.followNewBatch = ->
    $http
      method: 'POST'
      url: "/batches/"
    .success (data) ->
      console.log data
    .error ->
      alert "error"
]