signupProviders = require '../lib/signup/providers'
sessionProviders = require '../lib/session/providers'

exports.create = (req, res) ->
	signupType = req.query.type
	signupData = req.body
	signupProviders.signup.signup signupData, signupType, (err, newUser) ->
		if err
			console.log err
		else
			sessionProviders.sessions.createSession res, newUser.user_id
		res.redirect '/'
