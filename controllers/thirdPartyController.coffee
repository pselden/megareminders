thirdPartyProviders = require '../lib/thirdparty/providers'

exports.authorize = (req, res) ->
	provider = req.params.provider
	redirectUrl = req.query.redirectUrl
	thirdPartyProviders[provider].authorize req, res, redirectUrl

exports.test = (req, res) ->
	provider = req.params.provider
	api = thirdPartyProviders[provider]
	api.getAccessToken req, (err, token) ->
		api.getUser token, (err, user) ->
			res.send JSON.stringify user


exports.facebookCanvas = (req, res) ->
	console.log req.query
	console.log req.body
	signedRequest = req.body.signed_request.split('.')[1]
	data = new Buffer(signedRequest, 'base64').toString('ascii')
	console.log data

	res.redirect '/'