request = require 'request'
apiPath = 'http://104.236.41.161/'
DEFAULT_TOKEN = 'YreIoA-nX26yqbOrAz45CA'
params =
  token: DEFAULT_TOKEN
  longitude: 75
  latitude: 39
  radius: 100

# A wrapper for `https://github.com/rcchen/sh-server`
module.exports =
  get:
    photos: (cb) ->
      url = apiPath + 'api/photos'
      request {url: url, qs: params}, (err, res, body) ->
        cb JSON.parse body
  post:
    users: (email, cb) ->
      url = apiPath + 'api/users'
      request.post
        uri: url
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
          token: token
      , (err, res, body) ->
        # Return the current state of the heart
        cb JSON.parse body