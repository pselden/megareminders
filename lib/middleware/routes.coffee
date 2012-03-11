# skips the route unless the current sign in status matches the signedIn parameter
# param signedIn (boolean) -- true to require that the user is signed in, false to require signed out
exports.requireSignin = (signedIn) ->
	(req, res, next) ->
		if req.isSignedIn == signedIn
			next()
		else
			next('route')