controllers = require './controllers'
middleware = require './lib/middleware'

exports.register = (app) ->
  registerRoute = (method, path, middleware..., action) ->
    app[method] path, middleware, (req, res, next) ->
      res.local 'req', req
      action req, res, next

  # home
  registerRoute 'get', '/', middleware.routes.requireSignin(false), controllers.home.homeSignedOut
  registerRoute 'get', '/', middleware.routes.requireSignin(true), controllers.home.homeSignedIn

  # accounts
  registerRoute 'get', '/accounts', middleware.routes.requireSignin(true), controllers.accounts.index
  registerRoute 'post', '/accounts/:type', middleware.routes.requireSignin(true), controllers.accounts.create
  registerRoute 'delete', '/accounts/:type/:id', middleware.routes.requireSignin(true), controllers.accounts.destroy
  registerRoute 'get', '/accounts/email/:email/verify/:code', controllers.accounts.verifyEmailAccount
  registerRoute 'get', '/accounts/email/:email/deny/:code', controllers.accounts.denyEmailAccount

  # users
  registerRoute 'get', '/signup', controllers.users.signUp
  registerRoute 'post', '/signup', controllers.users.create

  # reminders
  registerRoute 'post', '/reminders', controllers.reminders.create

	# sessions
  registerRoute 'post', '/signin', controllers.sessions.create
  registerRoute 'get', '/signin', controllers.sessions.signIn
  registerRoute 'get', '/signout', controllers.sessions.destroy

  # third party
  registerRoute 'get', '/thirdparty/:service/authorize', controllers.thirdParty.authorize
  registerRoute 'get', '/thirdparty/:service/authenticate', controllers.thirdParty.authenticate
  registerRoute 'get', '/thirdparty/:service/connect', middleware.routes.requireSignin(true), controllers.thirdParty.connectAccount
  registerRoute 'post', '/thirdparty/facebook/canvas', controllers.thirdParty.facebookCanvas



