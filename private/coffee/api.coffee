request = require 'request'
moment = require 'moment'
apiPath = 'http://104.236.41.161/'
params =
  token: 'YreIoA-nX26yqbOrAz45CA'
  longitude: 75
  latitude: 39
  radius: 100

# A wrapper for `https://github.com/rcchen/sh-server`
module.exports =
  get:
    photos: (cb) ->
      url = apiPath + 'api/photos'
      request {url: url, qs: params}, (err, res, body) ->
        json = JSON.parse body
        for photo in json
          photo.created_at_text = moment(photo.created_at).fromNow()
        console.log json
        cb json
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