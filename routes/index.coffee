express = require 'express'
router = express.Router()

routes =
  # GET home page.
  index: router.get '/', (req, res) ->
    res.render 'index'

  # FB auth error
  authError: (req, res) ->
    res.send 'error'

  # FB auth success
  authSuccess: (req, res) ->
    res.redirect '/list'

module.exports = routes