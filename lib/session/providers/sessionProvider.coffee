userProviders = require '../../user/providers'
USER_ID_COOKIE = 'user'
util = require 'util'

# gets the current user
exports.getCurrentUser = (req, res, callback) ->
	userId = req.cookies[USER_ID_COOKIE]
	if userId
		userProviders.user.getUserByUserId userId, callback
	else
		callback null, null

# signs the user in
exports.signIn = (res, userId) ->
	setCookie res, USER_ID_COOKIE, userId

# signs the user out
exports.signOut = (res) ->
	res.clearCookie USER_ID_COOKIE

setCookie = (res, cookieName, cookieValue) ->
	maxAge = 630720000000
	options = { path: '/', httpOnly: true, maxAge: maxAge }
	res.cookie cookieName, cookieValue, options