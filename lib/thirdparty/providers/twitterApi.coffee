url = require('url')
OAuth = require('oauth').OAuth
querystring = require('querystring')

module.exports = (consumerKey, consumerSecret) ->
	oauth = new OAuth 'https://twitter.com/oauth/request_token',
		'https://twitter.com/oauth/access_token',
		consumerKey,
		consumerSecret,
		'1.0',
		false,
		'HMAC-SHA1',
		null,
		{'Accept': '*/*', 'Connection': 'close'}

	rest_base = 'https://api.twitter.com/1'

	getRequestToken = (req, res, redirectUrl, callback) ->
		protocol = if req.socket.encrypted then 'https' else 'http'
		callbackUrl = "#{protocol}://#{req.header 'host'}#{redirectUrl}"

		oauth.getOAuthRequestToken { oauth_callback: callbackUrl }, (err, oauth_token) ->
			if err
				console.log err
				callback err, null
			else
				res.redirect "https://api.twitter.com/oauth/authenticate?oauth_token=#{oauth_token}"

	getAccessToken = (req, callback) ->
		getAccess req.param('oauth_token'), req.param('oauth_token_secret'), req.param('oauth_verifier'), callback

	getAccess = (oauth_token, oauth_token_secret, oauth_verifier, callback) ->
		oauth.getOAuthAccessToken oauth_token, oauth_token_secret, oauth_verifier, (err, oauth_token, oauth_token_secret, additionalParameters) ->
			if err
				console.log err
				callback err, null
			else
				callback null, { token: oauth_token, secret: oauth_token_secret }

	apiCall = (method, path, params, callback) ->
		token = oauth_token: params.token.token, oauth_token_secret: params.token.secret
		delete params.token

		requestCallback = (callback) ->
			return (err, data, response) ->
				if err
					callback err, null
				else
					callback null, JSON.parse(data)

		if method.toUpperCase() == 'GET'
			return oauth.get "#{rest_base}#{path}?#{querystring.stringify params}", token.oauth_token, token.oauth_token_secret, requestCallback(callback)
		else if method.toUpperCase() == 'POST'
			return oauth.post "#{rest_base}#{path}", token.oauth_token, token.oauth_token_secret, params, 'application/json; charset=UTF-8', requestCallback(callback)

	getUser = (token, callback) ->
		verifyCredentialsCallback = (err, profile) ->
			if !err
				user = normalizeUser profile
				callback null, user
			else
				callback err

		normalizeUser = (profile) ->
			getImage = () ->
				"http://api.twitter.com/1/users/profile_image?screen_name=#{profile.screen_name}&size=original"

			return {
				provider: 'Twitter'
				externalId: profile.id
				fullName: profile.name
				username: profile.screen_name
				image: getImage()
			}

		apiCall 'GET', '/account/verify_credentials.json', { token: token, skip_status: true }, verifyCredentialsCallback

	sendDirectMessage = (token, twitterUserId, text, callback) ->
		apiCall 'POST', '/direct_messages/new.json', { token: token , user_id: twitterUserId, text: text }, callback

	return {
		authorize : getRequestToken
		getAccessToken : getAccessToken
		getUser: getUser,
		sendDirectMessage: sendDirectMessage
	}