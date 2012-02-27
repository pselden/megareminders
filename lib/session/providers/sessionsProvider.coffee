usersProviders = require '../../users/providers'
USER_ID_COOKIE = 'user'
util = require 'util'
crypto = require 'crypto'
COOKIE_SECRET = "scooterIsth3bestDoginth3world"

# gets the current user
exports.getCurrentUser = (req, res, callback) ->
	userId = getCookie req, USER_ID_COOKIE, true
	if userId
		console.log "userId: #{userId}"
		usersProviders.users.getUserByUserId userId, callback
	else
		callback null, null

# signs the user in
exports.createSession = (res, userId) ->
	setCookie res, USER_ID_COOKIE, userId, true

# signs the user out
exports.destroySession = (res) ->
	res.clearCookie USER_ID_COOKIE

sign = (val, secret) ->
	sig = crypto.createHmac('sha1', secret).update(val.toString()).digest('base64')
	"#{val}.#{sig}"

getCookie = (req, name, isSigned) ->
	value = req.cookies[name] || null
	if value && isSigned
		temp = value.split('.')[0]
		value = if sign(temp, COOKIE_SECRET) == value then temp else null
	return value

setCookie = (res, name, value, isSigned) ->
	maxAge = 630720000000
	options = { path: '/', httpOnly: true, maxAge: maxAge }
	value = sign value, COOKIE_SECRET if isSigned
	res.cookie name, value, options