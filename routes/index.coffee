express = require 'express'
router = express.Router()

obj =
  selfies: [
    img_url: "http://lorempixel.com/200/400"
    likes: 30
    timestamp: Date.now() - 5000
  ,
    img_url: "http://lorempixel.com/200/400"
    likes: 23
    timestamp: Date.now() - 2000
  ,
    img_url: "http://lorempixel.com/200/400"
    likes: 20
    timestamp: Date.now() - 1000
  ,
    img_url: "http://lorempixel.com/200/400"
    likes: 10
    timestamp: Date.now() - 100
  ]


routes =
  # GET home page.
  index: router.get '/', (req, res) ->
    res.render 'index'

  # GET main photo page
  home: router.get '/home', (req, res) ->
    res.render 'home', obj

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

module.exports = routes