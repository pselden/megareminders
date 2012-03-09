thirdPartyProviders = require '../lib/thirdparty/providers'
signupProviders = require '../lib/signup/providers'
sessionProviders = require '../lib/session/providers'

exports.authorize = (req, res) ->
	service = req.params.service
	redirectUrl = req.query.redirectUrl
	thirdPartyProviders[service].authorize req, res, redirectUrl

exports.authenticate = (req, res) ->
	service = req.params.service
	api = thirdPartyProviders[service]
	api.getAccessToken req, (err, token) ->
		authenticate service, token, (err, account) ->
			if account # sign them in!
				sessionProviders.sessions.createSession res, account.user_id
				res.redirect '/'
			else # TODO: prompt if they want to make a new account or connect it to another account
				signup service, token, (err, account) ->
					sessionProviders.sessions.createSession res, account.user_id
					res.redirect '/'


exports.facebookCanvas = (req, res) ->
	console.log req.query
	console.log req.body
	signedRequest = req.body.signed_request.split('.')[1]
	data = new Buffer(signedRequest, 'base64').toString('ascii')
	console.log data

	res.redirect '/'

# authenticates the user with the third party service and returns the account if it exists
authenticate = (service, token, callback) ->
	credentials =
		token: token
	sessionProviders.signin.signIn credentials, service, callback

signup = (service, token, callback) ->
	signupData =
		token: token
	signupProviders.signup.signup signupData, service, callback
