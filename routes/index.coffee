express = require 'express'
router = express.Router()
request = require 'request'
api = require '../private/coffee/api'

routes =
  # GET home page.
  index: router.get '/', (req, res) ->
    console.log '/ ' + req.user
    res.render 'index'

  # GET main photo page
  home: router.get '/home', (req, res) ->
    sort = req.body.sortType
    console.log(sort)
    api.get.photos (body, sort) ->
      # TODO: grab api token here and pass it inot the home page to render as a hidden token id.
      res.render 'home', {selfies: body}

  # List of images
  list: (req, res) ->
    console.log 'list'
    console.log req.user
    res.json req.user

  # FB auth error
  authError: (req, res) ->
    res.send 'error'

  # FB auth success
  authSuccess: (req, res) ->
    # res.json req.user
    res.redirect '/list'

  api:
    photos: (req, res) ->
      res.send 'server response'

module.exports = routes