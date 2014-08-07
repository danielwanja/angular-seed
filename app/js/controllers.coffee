"use strict"

# Controllers
controllers = angular.module("myApp.controllers", [])
controllers.controller("MyCtrl1", [
  "$scope"
  ($scope) ->
    # controller 1 code goes here
    $scope.name = "MyCtrl1"
    $scope.doIt = ->
      alert "Done! #{$scope.name}"
])

controllers.controller "MyCtrl2", [
  "$scope"
  ($scope) ->
    # controller 2 code goes here
    $scope.name = "MyCtrl2"
    $scope.doIt = ->
      alert "Done! #{$scope.name}"
]
