reminders = []

exports.homeSignedOut = (req, res, next) ->
	return next() if req.isSignedIn
	res.render 'home_signed_out', { req: req, reminders: reminders }

exports.homeSignedIn = (req, res, next) ->
	return next() if !req.isSignedIn
	res.render 'home_signed_in', { req: req, reminders: reminders }
