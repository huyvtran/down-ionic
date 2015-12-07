FacebookSyncCtrl = require './facebook-sync-controller'

angular.module 'rallytap.facebookSync', [
    'ui.router'
    'ngCordova'
  ]
  .config ($stateProvider) ->
    $stateProvider.state 'facebookSync',
      url: '/fb-sync'
      templateUrl: 'app/facebook-sync/facebook-sync.html'
      controller: 'FacebookSyncCtrl as fbSync'
  .controller 'FacebookSyncCtrl', FacebookSyncCtrl
