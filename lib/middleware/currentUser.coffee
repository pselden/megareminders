sessionProviders = require '../session/providers'

module.exports = () ->
	return (req, res, next) ->
		sessionProviders.session.getCurrentUser req, res, (err, user) ->
			if user
				req.isSignedIn = true
				req.currentUser = user
			else
				req.isSignedIn = false
		next()
		return