Event = ['$http', '$filter', '$meteor', '$q', '$resource',  \
         'apiRoot', 'User', \
         ($http, $filter, $meteor, $q, $resource, apiRoot, \
          User) ->
  listUrl = "#{apiRoot}/events"
  detailUrl = "#{listUrl}/:id"
  serializeEvent = (event) ->
    request =
      creator: event.creatorId
      title: event.title
    optionalFields =
      id: 'id'
      recommended_event: 'recommendedEvent'
    for serializedField, deserializedField of optionalFields
      if angular.isDefined event[deserializedField]
        request[serializedField] = event[deserializedField]
    if angular.isObject event.place
      request.place =
        name: event.place?.name
        geo:
          type: 'Point'
          coordinates: [event.place?.lat, event.place?.long]
    if angular.isDate event.datetime
      request.datetime = event.datetime.toISOString()
    if angular.isDefined event.friendsOnly
      request.friends_only = event.friendsOnly
    request
  deserializeEvent = (event) ->
    response =
      id: event.id
      creatorId: event.creator
      title: event.title
      friendsOnly: event.friends_only
      createdAt: new Date event.created_at
      updatedAt: new Date event.updated_at
    if angular.isDefined event.recommended_event
      response.recommendedEvent = event.recommended_event
    if angular.isString event.datetime
      response.datetime = new Date event.datetime
    if angular.isObject event.place
      response.place =
        name: event.place.name
        lat: event.place.geo.coordinates[0]
        long: event.place.geo.coordinates[1]
    new resource response

  resource = $resource detailUrl

  resource.listUrl = listUrl

  resource.serialize = serializeEvent
  resource.deserialize = deserializeEvent

  resource.save = (event) ->
    deferred = $q.defer()

    data = serializeEvent event
    $http.post listUrl, data
      .success (data, status) =>
        event = deserializeEvent data
        deferred.resolve event
      .error (data, status) =>
        deferred.reject()

    {$promise: deferred.promise}

  resource.interested = (eventId) ->
    deferred = $q.defer()

    url = "#{listUrl}/#{eventId}/interested"
    $http.get url
      .success (data, status) ->
        data = angular.fromJson data
        users = (User.deserialize(user) for user in data)
        deferred.resolve users
      .error (data, status) ->
        deferred.reject()

    {$promise: deferred.promise}

  resource::getPercentRemaining = ->
    currentDate = new Date()
    twentyFourHrsAgo = angular.copy currentDate
    twentyFourHrsAgo.setDate currentDate.getDate()-1
    oneDay = currentDate - twentyFourHrsAgo

    if @datetime?
      oneDayAfterEvent = @datetime.getTime() + oneDay
      eventDuration = oneDayAfterEvent - @createdAt.getTime()
      timeRemaining = oneDayAfterEvent - currentDate.getTime()
    else
      eventDuration = oneDay
      timeRemaining = @createdAt - twentyFourHrsAgo

    (timeRemaining / eventDuration) * 100

  resource::getEventMessage = ->
    if angular.isDefined @datetime
      date = $filter('date') @datetime, "EEE, MMM d 'at' h:mm a"
      dateString = " — #{date}"
    else
      dateString = ''

    if angular.isDefined @place
      placeString = " at #{@place.name}"
    else
      placeString = ''

    "#{@title}#{placeString}#{dateString}"

  resource::isExpired = ->
    twelveHours = 1000 * 60 * 60 * 12
    now = new Date()
    if angular.isDefined @datetime
      expiresAt = new Date @datetime.getTime() + twelveHours
      now > expiresAt
    else
      expiresAt = new Date @createdAt.getTime() + twelveHours
      now > expiresAt

  resource.titleHeightCache = {}
  # http://www.rgraph.net/blog/2013/january/measuring-text-height-with-html5-canvas.html
  resource::getTitleHeight = ->
    text = @getEventMessage()

    # This global variable is used to cache repeated 
    #   calls with the same arguments
    if resource.titleHeightCache[text]
      return resource.titleHeightCache[text]
    
    font = 'Open Sans'
    size = '20px'
    marginBottom = 1

    padding =
      ionItemPaddingLeft: 16
      ionItemPaddingRight: 16
      eventPaddingRight: 5
      eventPaddingLeft: 43
    totalPadding = 0
    for key, value of padding
      totalPadding += value
    width = document.body.clientWidth - totalPadding

    div = document.createElement 'DIV'
    div.innerHTML = text
    div.style.position = 'absolute'
    div.style.top = '-9999px'
    div.style.left = '-9999px'
    div.style.fontFamily = font
    div.style.fontWeight = 'normal'
    div.style.fontSize = size
    div.style.lineHeight = '24px'
    div.style.width = "#{width}px"

    document.body.appendChild div
    height = div.offsetHeight
    height += marginBottom
    document.body.removeChild div

    # Add the sizes to the cache as adding DOM elements
    #   is costly and can cause slow downs
    resource.titleHeightCache[text] = height

    height

  resource
]

module.exports = Event
