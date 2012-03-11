controllers = require('./controllers')
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
	registerRoute 'get', '/accounts', middleware.routes.requireSignin(true), controllers.accounts.show

	# users
	registerRoute 'post', '/signup', controllers.users.create

	# reminders
	registerRoute 'post', '/reminders', controllers.reminders.create

	# sessions
	registerRoute 'post', '/signin', controllers.sessions.create
	registerRoute 'get', '/signout', controllers.sessions.destroy

	# third party
	registerRoute 'get', '/thirdparty/:service/authorize', controllers.thirdParty.authorize
	registerRoute 'get', '/thirdparty/:service/authenticate', controllers.thirdParty.authenticate
	registerRoute 'post', '/thirdparty/facebook/canvas', controllers.thirdParty.facebookCanvas



