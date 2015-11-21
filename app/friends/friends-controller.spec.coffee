require '../ionic/ionic.js'
require 'angular'
require 'angular-animate'
require 'angular-mocks'
require 'angular-sanitize'
require 'angular-ui-router'
require '../ionic/ionic-angular.js'
FriendsCtrl = require './friends-controller'

describe 'add friends controller', ->
  $ionicHistory = null
  ctrl = null
  scope = null
  $state = null

  beforeEach angular.mock.module('ionic')

  beforeEach angular.mock.module('ui.router')

  beforeEach inject(($injector) ->
    $controller = $injector.get '$controller'
    $ionicHistory = $injector.get '$ionicHistory'
    $state = $injector.get '$state'
    scope = $injector.get '$rootScope'

    ctrl = $controller FriendsCtrl,
      $scope: scope
  )

  describe 'tapping to add by username', ->

    beforeEach ->
      spyOn $state, 'go'

      ctrl.addByUsername()

    it 'should go to the add by username view', ->
      expect($state.go).toHaveBeenCalledWith 'friends.addByUsername'


  describe 'tapping to add by phone', ->

    beforeEach ->
      spyOn $state, 'go'

      ctrl.addByPhone()

    it 'should go to the add by phone view', ->
      expect($state.go).toHaveBeenCalledWith 'friends.addByPhone'


  describe 'tapping to add from address book', ->

    beforeEach ->
      spyOn $state, 'go'

      ctrl.addFromAddressBook()

    it 'should go to the add from address book view', ->
      expect($state.go).toHaveBeenCalledWith 'friends.addFromAddressBook'


  describe 'tapping to add from facebook', ->

    beforeEach ->
      spyOn $state, 'go'

      ctrl.addFromFacebook()

    it 'should go to the add from facebook view', ->
      expect($state.go).toHaveBeenCalledWith 'friends.addFromFacebook'


  describe 'tapping to view my friends', ->

    beforeEach ->
      spyOn $state, 'go'

      ctrl.showMyFriends()

    it 'should go to the my friends view', ->
      expect($state.go).toHaveBeenCalledWith 'friends.myFriends'


  describe 'tapping to view the people who added me', ->

    beforeEach ->
      spyOn $state, 'go'

      ctrl.showAddedMe()

    it 'should go to the added me view', ->
      expect($state.go).toHaveBeenCalledWith 'friends.addedMe'

