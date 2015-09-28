require 'angular'


### @if BUILD_ENV='prod' ###
angular.module 'down.env', []
  ## Prod vars
  .constant 'skipIonicDeploy', false
  .constant 'meteorHost', 'down-meteor.herokuapp.com'
  .constant 'apiRoot', 'https://down-prod.herokuapp.com/api'
  .constant 'branchKey', 'key_live_fihEW5pE0wsUP6nUmKi5zgfluBaUyQiJ'
  .constant 'mixpanelToken', '14c9d01044b39cc2c5cfc2dc8efbe532'
  .constant 'ionicDeployChannel', 'staging'
### @endif ###

### @if BUILD_ENV='staging' ###
angular.module 'down.env', []
  ## Staging vars
  .constant 'skipIonicDeploy', true
  .constant 'meteorHost', 'down-meteor-staging.herokuapp.com'
  .constant 'apiRoot', 'http://down-staging.herokuapp.com/api'
  .constant 'branchKey', 'key_test_ogfq42bC7tuGVWdMjNm3sjflvDdOBJiv'
  .constant 'mixpanelToken', 'd4d37f58ce26f5e423cbc6fa937c621b'
  .constant 'ionicDeployChannel', 'dev'
### @endif ###

### @if BUILD_ENV='local' ###
angular.module 'down.env', []
  ## Dev vars
  .constant 'skipIonicDeploy', true
  .constant 'meteorHost', 'localhost:3500'
  .constant 'apiRoot', 'http://10.97.76.29:8000/api'
  .constant 'branchKey', 'key_test_ogfq42bC7tuGVWdMjNm3sjflvDdOBJiv'
  .constant 'mixpanelToken', 'd4d37f58ce26f5e423cbc6fa937c621b'
### @endif ###
