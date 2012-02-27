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
	app.get '/thirdparty/:provider', controllers.thirdParty.authorize
	app.get '/thirdparty/:provider/test', controllers.thirdParty.test
	app.post '/thirdparty/facebook/canvas', controllers.thirdParty.facebookCanvas