"use strict"

# jasmine specs for controllers go here
describe "controllers", ->
  beforeEach module("myApp.controllers")
  it "should ....", inject(($controller) ->
    #spec body
    myCtrl1 = $controller("MyCtrl1",
      $scope: {}
    )
    expect(myCtrl1).toBeDefined()
  )
  it "should ....", inject(($controller) ->
    #spec body
    myCtrl2 = $controller("MyCtrl2",
      $scope: {}
    )
    expect(myCtrl2).toBeDefined()
  )
