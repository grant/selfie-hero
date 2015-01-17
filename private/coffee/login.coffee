FacebookStrategy = require('passport-facebook').Strategy
module.exports = (passport) ->

  #
  #    user ID is serialized to the session. When subsequent requests are
  #    received, this ID is used to find the user, which will be restored
  #    to req.user.
  #
  passport.serializeUser (user, done) ->
    console.log 'serializeUser: ' + user._id
    done null, user.id

  #
  #    intended to return the user profile based on the id that was serialized
  #    to the session.
  #
  passport.deserializeUser (id, done) ->
    User.findById id, (err, user) ->
      unless err
        done null, user
      else
        done err, null

  passport.use new FacebookStrategy
    clientID: process.env.FACEBOOK_APP_ID
    clientSecret: process.env.FACEBOOK_APP_SECRET
    callbackURL: process.env.FACEBOOK_CALLBACK_URL
    profileFields: [
      'id'
      'emails'
      'displayName'
      'photos'
    ]
  , (accessToken, refreshToken, profile, done) ->
    console.log 'success'
    done null, profile