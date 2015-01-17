request = require 'request'
apiPath = 'http://104.236.41.161/'

# A wrapper for `https://github.com/rcchen/sh-server`
module.exports =
  get:
    photos: (cb) ->
      url = apiPath + 'get/photos'
      request url, (err, res, body) ->
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
      url = apiPath + 'api/photos/' + photoId + '/heart'
      request.post
        uri: url
        form:
          photoId: photoId
          token: token
      , (err, res, body) ->
        # Return the current state of the heart
        cb JSON.parse body