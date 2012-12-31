sessionsProviders = require '../lib/session/providers'

exports.signIn = (req, res) ->
  if req.isSignedIn
    res.redirect '/'
  else
    req.pageName = 'signin'
    res.render 'signin'

exports.create = (req, res) ->
  credentials = req.body
  signinType = req.query.type
  sessionsProviders.signin.signIn credentials, signinType, (err, account) ->
    if account
      sessionsProviders.sessions.createSession req, account.user_id

    res.redirect '/'

exports.destroy = (req, res) ->
  sessionsProviders.sessions.destroySession req
  res.redirect '/'