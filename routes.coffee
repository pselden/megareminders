controllers = require('./controllers')

exports.register = (app) ->
	# home
	app.get '/', controllers.home.homeSignedOut
	app.get '/', controllers.home.homeSignedIn

	# users
	app.post '/users', controllers.users.create

	# reminders
	app.post '/reminders', controllers.reminders.create

	# sessions
	app.post '/signin', controllers.sessions.create
	app.get '/signout', controllers.sessions.destroy

	# third party
	app.get '/thirdparty/:service/authorize', controllers.thirdParty.authorize
	app.get '/thirdparty/:service/authenticate', controllers.thirdParty.authenticate
	app.post '/thirdparty/facebook/canvas', controllers.thirdParty.facebookCanvas