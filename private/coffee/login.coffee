request = require 'request'
FacebookStrategy = require('passport-facebook').Strategy
User = require './models/user'

# Get fb friends
getFriends = (accessToken, cb) ->
  friendsUrl = 'https://graph.facebook.com/me/friends?access_token=' + accessToken
  request friendsUrl, (err, response, body) ->
    cb JSON.parse(body).data

module.exports = (passport) ->

  #
  #    user ID is serialized to the session. When subsequent requests are
  #    received, this ID is used to find the user, which will be restored
  #    to req.user.
  #
  passport.serializeUser (user, done) ->
    console.log 'serializeUser: ' + user._id
    done null, user._id

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
    User.findOne
      $or: [
        fbId: profile.id
      ,
        email: profile.emails[0].value
      ]
    , (err, oldUser) ->
      if oldUser
        console.log 'old user detected'
        getFriends accessToken, (friends) ->
          User.update
            $or: [
              fbId: profile.id
            ,
              email: profile.emails[0].value
            ]
          ,
            friends: friends
          , (err) ->
            return done(err) if err
            oldUser.friends = friends
            return done null, oldUser
      else
        return done(err)  if err
        console.log 'new user found'
        getFriends accessToken, (friends) ->
          newUser = new User(
            fbId: profile.id
            accessToken: accessToken
            friends: friends
            email: profile.emails[0].value
            name: profile.displayName
            photo: 'http://graph.facebook.com/' + profile.id + '/picture?width=800'
            username: profile.emails[0].value.split('@')[0]
          ).save((err, newUser) ->
            return done(err) if err
            return done null, newUser
          )