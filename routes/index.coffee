express = require 'express'
router = express.Router()
api = require '../private/coffee/api'

routes =
  # GET home page.
  index: router.get '/', (req, res) ->
    res.render 'index'

  # GET main photo page
  home: router.get '/home', (req, res) ->
    if req.user
      api.get.photos (body) ->
        res.render 'home',
          user: req.user
          selfies: body
    else
      res.redirect '/'

  # FB auth error
  authError: (req, res) ->
    res.send 'error'

  # FB auth success
  authSuccess: (req, res) ->
    res.redirect '/home'

module.exports = routes