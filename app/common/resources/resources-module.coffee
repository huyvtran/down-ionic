require 'angular'
require 'angular-local-storage'
require 'angular-resource'
require '../asteroid/asteroid-module'
require '../auth/auth-module'
AllFriendsInvitation = require './allfriendsinvitation-service'
APNSDevice = require './apnsdevice-service'
Event = require './event-service'
Friendship = require './friendship-service'
Invitation = require './invitation-service'
LinkInvitation = require './linkinvitation-service'
User = require './user-service'
UserPhone = require './userphone-service'

angular.module 'down.resources', [
    'ngResource'
    'down.asteroid'
    'down.auth'
    'LocalStorageModule'
  ]
  .value 'apiRoot', 'http://down-staging.herokuapp.com/api'
  .factory 'APNSDevice', APNSDevice
  .factory 'Event', Event
  .factory 'Friendship', Friendship
  .factory 'Invitation', Invitation
  .factory 'AllFriendsInvitation', AllFriendsInvitation
  .factory 'LinkInvitation', LinkInvitation
  .factory 'User', User
  .factory 'UserPhone', UserPhone
