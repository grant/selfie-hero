request = require 'request'
moment = require 'moment'
apiPath = 'http://104.236.41.161/'
DEFAULT_TOKEN = 'YreIoA-nX26yqbOrAz45CA'


# A wrapper for `https://github.com/rcchen/sh-server`
module.exports =
  get:
    photos: (cb, sort="recency") ->
      url = apiPath + 'api/photos'
      params =
        token: DEFAULT_TOKEN
        longitude: 75
        latitude: 39
        radius: 100
        sort: sort
      console.log("sorting by "+sort)
      request {url: url, qs: params}, (err, res, body) ->
        json = JSON.parse body
        for photo in json
          photo.created_at_text = moment(photo.created_at).fromNow()
        cb json
  post:
    users: (email, cb) ->
      url = apiPath + 'api/users'
      request
        uri: url
        method: 'POST'
        form:
          email: email
      , (err, res, body) ->
        # Return user object
        cb JSON.parse body
    photos: (photo, token, lat, lng, cb) ->
      # TODO
      cb()
    heart: (photoId, token, cb) ->
      console.log photoId
      console.log token
      url = apiPath + 'api/photos/' + photoId + '/heart'
      request.post
        uri: url
        qs =
          photoId: photoId
          token: DEFAULT_TOKEN
      , (err, res, body) ->
        # Return the current state of the heart
        cb JSON.parse body