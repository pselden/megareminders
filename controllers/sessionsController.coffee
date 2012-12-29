sessionsProviders = require '../lib/session/providers'

exports.create = (req, res) ->
	credentials = req.body
	signinType = req.query.type
	sessionsProviders.signin.signIn credentials, signinType, (err, account) ->
		if account
			sessionsProviders.sessions.createSession res, account.user_id
		else


		res.redirect '/'

exports.destroy = (req, res) ->
	sessionsProviders.sessions.destroySession res
	res.redirect '/'