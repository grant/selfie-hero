express = require 'express'
router = express.Router()

# GET index page.
router.get '/', (req, res) ->
  res.render 'index'

# GET home page
router.get '/home', (req, res) ->
  res.render 'home'

module.exports = router