usersProviders = require '../../users/providers'

# gets the current user
exports.getCurrentUser = (req, res, callback) ->
	userId = req.session && req.session.userId
	if userId
		usersProviders.users.getUserByUserId userId, callback
	else
		callback null, null

# signs the user in
exports.createSession = (req, userId) ->
  req.session =
    userId: userId

# signs the user out
exports.destroySession = (req) ->
	req.session = null
