express = require 'express'
router = express.Router()
request = require 'request'
api = require '../private/coffee/api'

routes =
  # GET home page.
  index: router.get '/', (req, res) ->
    res.render 'index'

  # GET main photo page
  home: router.get '/home', (req, res) ->
    api.get.photos (body) ->
      res.render 'home',
        user: req.user
        selfies: body

  # FB auth error
  authError: (req, res) ->
    res.send 'error'

  # FB auth success
  authSuccess: (req, res) ->
    res.redirect '/home'

module.exports = routes