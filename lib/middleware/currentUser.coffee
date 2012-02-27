sessionsProviders = require '../session/providers'

module.exports = () ->
	return (req, res, next) ->
		sessionsProviders.sessions.getCurrentUser req, res, (err, user) ->
			if user
				req.isSignedIn = true
				req.currentUser = user
			else
				req.isSignedIn = false
			next()